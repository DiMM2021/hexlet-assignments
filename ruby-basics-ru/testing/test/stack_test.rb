# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'test_helper'
require_relative '../lib/stack'

class Stack
  def initialize
    @stack = []
  end
  
  def push!(element)
    @stack.push(element)
  end
  
  def pop!
    @stack.pop
  end
  
  def clear!
    @stack.clear
  end
  
  def empty?
    @stack.empty?
  end
  
  def to_a
    @stack.to_a
  end
  
  def size
    @stack.size
  end
end

class StackTest < Minitest::Test
  # BEGIN
  def setup
    @stack = Stack.new
  end
    
  def test_stack_push
    @stack.push!('ruby')
    @stack.push!('php')
    @stack.push!('java')
    assert { @stack.to_a == %w[ruby php java] }
    assert { @stack.size == 3 }
  end
    
  def test_stack_pop
    @stack.push!('ruby')
    @stack.push!('php')
    @stack.push!('java')
    @stack.pop!
    assert { @stack.to_a == %w[ruby php] }
    assert { @stack.size == 2 }
  end
    
  def test_stack_clear
    @stack.push!('ruby')
    @stack.push!('php')
    @stack.push!('java')
    @stack.clear!
    assert { @stack.to_a == [] }
    assert { @stack.empty? }
  end
    
  def test_stack_empty
    @stack.push!('ruby')
    @stack.push!('php')
    @stack.push!('java')
    assert { @stack.empty? == false }
    assert { @stack.size == 3 }
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
