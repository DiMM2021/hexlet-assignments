# frozen_string_literal: true

# BEGIN
module Model
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def attribute(name, options = {})
      attr_accessor name

      default_value = options[:default]

      define_method("#{name}=") do |value|
      if value.nil?
        instance_variable_set("@#{name}", nil)
      else
        instance_variable_set("@#{name}", case options[:type]
          when :integer then value.to_i
          when :string then value.to_s
          when :datetime then DateTime.parse(value.to_s) rescue default_value
          when :boolean then !!value
          else value
          end)
        end
      end
      define_method(name) do
        instance_variable_get("@#{name}")
      end
      define_method("#{name}_default") do
        default_value
      end
    end
  end

  def initialize(attributes = {})
    self.class.instance_methods(false).each do |method|
      next unless method.to_s.end_with?('=')
      attr_name = method.to_s.chomp('=')
      default_value = send("#{attr_name}_default") if respond_to?("#{attr_name}_default")
      send("#{attr_name}=", default_value) if default_value
    end
    attributes.each do |key, value|
      send("#{key}=", value) if respond_to?("#{key}=")
    end
  end
  
  def attributes
    self.class.instance_methods(false).each_with_object({}) do |method, hash|
      next if method.to_s.end_with?('=')
      value = send(method)
      hash[method] = value.nil? ? send("#{method}_default") : value if respond_to?("#{method}_default")
    end
  end
end
#END