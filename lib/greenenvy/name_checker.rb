module Greenenvy
  class NameChecker
    BASIC_OBJECT_METHODS = [
        :!,
        :!=,
        :==,
        :__id__,
        :__send__,
        :equal?,
        :instance_eval,
        :instance_exec,
        :method_missing,
        :singleton_method_added,
        :singleton_method_removed,
        :singleton_method_undefined,
        :initialize,
        :inspect,
    ].freeze

    REGEXP = %r{\A[A-Za-z]+\w+\z}.freeze

    def valid?(name)
      name = name.to_s
      !reserved_method?(name) && valid_pattern?(name)
    end

    private

    def reserved_method?(name)
      BASIC_OBJECT_METHODS.include?(name)
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
