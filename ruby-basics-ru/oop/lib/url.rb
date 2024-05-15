# frozen_string_literal: true

# BEGIN
require 'uri'
require 'forwardable'

class Url
  extend Forwardable
  include Comparable

  def initialize(url_string)
    @uri = URI.parse(url_string)
  end

  def_delegators :@uri, :scheme, :host, :port

  def query_params
    URI.decode_www_form(@uri.query || '').to_h.transform_keys(&:to_sym)
  end

  def query_param(key, default_value = nil)
    query_params[key] || default_value
  end

  def ==(other)
    scheme == other.scheme &&
      host == other.host &&
      port == other.port &&
      normalized_query_params == other.normalized_query_params
  end

  protected

  def normalized_query_params
    URI.decode_www_form(@uri.query || '').sort
  end
end
# END
