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
    ].freeze

    def valid?(name)
      name = name.to_s
      !reserved_method?(name) && valid_pattern?(name)
    end

    private

    def reserved_method?(name)
      BASIC_OBJECT_METHODS.include?(name)
    end

    def valid_pattern?(name)
      %r{\A[A-Za-z]+\w+\z}.match?(name)
    end
  end
end
