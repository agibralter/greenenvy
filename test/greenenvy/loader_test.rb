# frozen_string_literal: true
require "test_helper"

describe Greenenvy::Loader do
  it "leverages context load settings" do
    # Use tempfile to test parts of this class that interact with filesystem
    Tempfile.open(%w[property_name .rb]) do |f|

      context_class = Minitest::Mock.new
      context_instance = Minitest::Mock.new
      name_validator = Minitest::Mock.new

      env = "my-env"
      dir = File.dirname(f)
      file_contents = "some ruby code"
      property_name = File.basename(f, ".rb").to_sym

      f.write(file_contents)
      f.flush

      settings_for_file = {}
      settings_for_all_files = {}
      settings_for_all_files[property_name] = settings_for_file

      context_class.expect(
        :new,
        context_instance,
        [name_validator, env, file_contents],
      )
      context_instance.expect(:load_settings, settings_for_file)

      loader = Greenenvy::Loader.new(
        context_class,
        name_validator,
        env,
        dir,
      )

      assert_equal(settings_for_all_files, loader.load)

      assert_mock(context_class)
    end
  end
end
