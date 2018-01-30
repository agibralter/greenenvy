require "test_helper"

describe Greenenvy::NameChecker do
  it "delegates to the checker and rasises an exception" do
    name = "some name"
    name_checker = Minitest::Mock.new
    name_checker.expect(:valid?, false, [name])
    validator = Greenenvy::NameValidator.new(name_checker)
    assert_raises(Greenenvy::Exceptions::InvalidKey) do
      validator.validate!(name)
    end
  end
end
