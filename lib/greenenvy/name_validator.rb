# frozen_string_literal: true
module Greenenvy
  class NameValidator
    REGEXP = %r{\A[A-Za-z]+\w+\z}.freeze

    def initialize(klass)
      @klass = klass
    end

    def validate!(name)
      name = name.to_sym
      if reserved_method?(name) || !valid_pattern?(name)
        raise Exceptions::InvalidKey, "Invalid key, #{name}."
      end
      name
    end

    private

    def reserved_method?(name)
      @klass.instance_methods.include?(name)
    end

    if String.instance_methods.include?(:match?)
      def valid_pattern?(name)
        REGEXP.match?(name)
      end
    else
      def valid_pattern?(name)
        name =~ REGEXP ? true : false
      end
    end
  end
end
