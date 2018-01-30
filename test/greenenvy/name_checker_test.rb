require "test_helper"

describe Greenenvy::NameChecker do
  it "allows valid names" do
    checker = Greenenvy::NameChecker.new
    assert_equal(true, checker.valid?("prop"))
    assert_equal(true, checker.valid?("PROP"))
    assert_equal(true, checker.valid?("PROP123"))
    assert_equal(true, checker.valid?("prop_123"))
  end

  it "disallows invalid names" do
    checker = Greenenvy::NameChecker.new
    assert_equal(false, checker.valid?("prop 123"))
    assert_equal(false, checker.valid?("prop-123"))
    assert_equal(false, checker.valid?("123prop"))
    assert_equal(false, checker.valid?("prop?"))
    assert_equal(false, checker.valid?("prop!"))
  end
end
