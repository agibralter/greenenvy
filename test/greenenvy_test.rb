# frozen_string_literal: true
require "test_helper"

FIXTURE_DIR = File.expand_path("../fixtures", __FILE__)

describe Greenenvy do
  it "has a version number" do
    refute_nil ::Greenenvy::VERSION
  end

  describe "load_env" do
    it "loads values for the property name in the correct env" do
      settings = Greenenvy.load_env(:test, FIXTURE_DIR)
      assert_equal("foo", settings.config.var_string)
      assert_equal(1, settings.config.var_number)
      assert_equal(:foo, settings.config.var_symbol)
      assert_equal(true, settings.config.var_bool)
      assert_equal({a: "b"}, settings.config.var_hash)
      assert_nil(settings.config.var_nil)
    end

    it "coerces booleans" do
      settings = Greenenvy.load_env(:test, FIXTURE_DIR)
      assert_equal(true, settings.config.var_string?)
      assert_equal(true, settings.config.var_number?)
      assert_equal(true, settings.config.var_symbol?)
      assert_equal(true, settings.config.var_bool?)
      assert_equal(true, settings.config.var_hash?)
      assert_equal(false, settings.config.var_nil?)
    end

    it "raises an exception when passing an invalid key" do
      settings = Greenenvy.load_env(:test, FIXTURE_DIR)
      assert_raises(Greenenvy::Exceptions::MissingKey) { settings.invalid }
      assert_raises(Greenenvy::Exceptions::MissingKey) { settings.config.invalid }
    end

    it "loads when passed a string env name" do
      settings = Greenenvy.load_env("test", FIXTURE_DIR)
      assert_equal("foo", settings.config.var_string)
    end

    it "handles strings in DSL" do
      settings = Greenenvy.load_env("production", FIXTURE_DIR)
      assert_equal("bar", settings.config.var_string)
    end

    it "runs code for a specific environment lazily" do
      assert_raises(NameError) { Greenenvy.load_env("foo", FIXTURE_DIR) }
    end

    it "handles defaults when env value missing" do
      settings = Greenenvy.load_env(:test, FIXTURE_DIR)
      assert_equal(1, settings.config_with_defaults.var_number)
      assert_equal("baz", settings.config_with_defaults.var_string)
    end

    it "handles defaults when env value present" do
      settings = Greenenvy.load_env(:production, FIXTURE_DIR)
      assert_equal(2, settings.config_with_defaults.var_number)
      assert_equal("bar", settings.config_with_defaults.var_string)
    end

    it "does not allow users to use reserved name for env" do
      assert_raises(Greenenvy::Exceptions::InvalidKey) do
        Greenenvy.load_env(:__id__, FIXTURE_DIR)
      end
    end

    it "does not allow users to use reserved name for keys" do
      assert_raises(Greenenvy::Exceptions::InvalidKey) do
        Greenenvy.load_env(:invalid_key_name1, FIXTURE_DIR)
      end

      assert_raises(Greenenvy::Exceptions::InvalidKey) do
        Greenenvy.load_env(:invalid_key_name2, FIXTURE_DIR)
      end
    end
  end
end
