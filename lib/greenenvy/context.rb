# frozen_string_literal: true
module Greenenvy
  class Context
    def initialize(name_validator, env, code, container_class=OpenStructLike)
      @name_validator = name_validator
      @env = env
      @code = code
      @container_class = container_class
    end

    def load_settings
      default_settings = {}
      env_settings = {}

      outer_context = OuterContext.new(
          @name_validator,
          @env,
          default_settings,
          env_settings,
      )
      outer_context.instance_eval(@code)

      @container_class.new(default_settings.merge(env_settings))
    end
  end

  class OuterContext
    def initialize(name_validator, env, default_settings, env_settings)
      @name_validator = name_validator
      @env = env
      @default_settings = default_settings
      @env_settings = env_settings
    end

    def env(env_name, &block)
      if env_name.to_s == @env.to_s
        @name_validator.validate!(env_name)
        inner_context = InnerContext.new(@name_validator, @env_settings)
        inner_context.instance_eval(&block)
      end
    end

    def default(&block)
      inner_context = InnerContext.new(@name_validator, @default_settings)
      inner_context.instance_eval(&block)
    end
  end

  class InnerContext

    def initialize(name_validator, settings)
      @name_validator = name_validator
      @settings = settings
    end

    def set(name, value)
      @name_validator.validate!(name)
      @settings[name.to_sym] = value
    end
  end
end
