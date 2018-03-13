# frozen_string_literal: true
module Greenenvy
  class Loader
    def initialize(context_class, name_validator, env, dir)
      @context_class = context_class
      @name_validator = name_validator
      @env = env
      @dir = dir
    end

    def load
      settings = {}

      each_file do |property_name, file_contents|
        context = @context_class.new(@name_validator, @env, file_contents)
        settings[property_name] = context.load_settings
      end

      settings
    end

    private

    def each_file
      Dir.glob(File.join(@dir, "*.rb")) do |file_path|
        property_name = File.basename(file_path, ".rb").to_sym
        file_contents = File.read(file_path)
        yield(property_name, file_contents)
      end
    end
  end
end
