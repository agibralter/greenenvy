require "test_helper"

module Greenenvy
  describe Context do

    class HashLike < Hash
      def initialize(other_hash)
        merge!(other_hash)
      end
    end

    it "evaluates code" do
      name_validator = Minitest::Mock.new
      code = <<~CODE
      env :foo do
        set :bar, "baz"
      end

      default do
        set :qux, 1
      end
      CODE
      env = "foo"
      container_class = HashLike

      name_validator.expect(:validate!, nil, [:foo])
      name_validator.expect(:validate!, nil, [:bar])
      name_validator.expect(:validate!, nil, [:qux])

      code_context = Context.new(name_validator, env, code, container_class)

      assert_equal({bar: "baz", qux: 1}, code_context.load_settings)
      assert_mock(name_validator)
    end
  end
end
