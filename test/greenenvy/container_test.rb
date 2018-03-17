# frozen_string_literal: true
require "test_helper"

describe Greenenvy::Container do
  MissingKey = Greenenvy::Exceptions::MissingKey

  it "allows access to hash symbol keys" do
    osl = Greenenvy::Container.new(foo: "bar")
    assert_equal("bar", osl.foo)
  end

  it "only allows access to symbols" do
    osl = Greenenvy::Container.new("foo" => "bar")
    assert_raises(MissingKey) { osl.foo }
  end

  it "raises exception for unknown key" do
    osl = Greenenvy::Container.new(foo: "bar")
    assert_raises(MissingKey) { osl.baz }
  end

  it "allows boolean coercion when truthy" do
    osl = Greenenvy::Container.new(foo: "bar")
    assert_equal(true, osl.foo?)
  end

  it "allows boolean coercion when false" do
    osl = Greenenvy::Container.new(foo: false)
    assert_equal(false, osl.foo?)
  end

  it "allows boolean coercion when nil" do
    osl = Greenenvy::Container.new(foo: nil)
    assert_equal(false, osl.foo?)
  end
end
