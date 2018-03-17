# frozen_string_literal: true
require "test_helper"

describe Greenenvy::NameValidator do
  it "allows valid names" do
    checker = Greenenvy::NameValidator.new(Class.new)
    assert_equal(:prop, checker.validate!("prop"))
    assert_equal(:PROP, checker.validate!("PROP"))
    assert_equal(:PROP123, checker.validate!("PROP123"))
    assert_equal(:prop_123, checker.validate!("prop_123"))
  end

  it "disallows invalid names" do
    checker = Greenenvy::NameValidator.new(Class.new)
    assert_raises(Greenenvy::Exceptions::InvalidKey) { checker.validate!("prop 123") }
    assert_raises(Greenenvy::Exceptions::InvalidKey) { checker.validate!("prop-123") }
    assert_raises(Greenenvy::Exceptions::InvalidKey) { checker.validate!("123prop") }
    assert_raises(Greenenvy::Exceptions::InvalidKey) { checker.validate!("prop?") }
    assert_raises(Greenenvy::Exceptions::InvalidKey) { checker.validate!("prop!") }
  end

  it "raises an exception when using the name of a method" do
    klass = Class.new do
      def bar; end
    end
    checker = Greenenvy::NameValidator.new(klass)
    assert_raises(Greenenvy::Exceptions::InvalidKey) { checker.validate!("bar") }
  end
end
