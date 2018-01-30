module Greenenvy
  class NameValidator
    def initialize(name_checker)
      @name_checker = name_checker
    end

    def validate!(name)
      unless @name_checker.valid?(name)
        raise Exceptions::InvalidKey, "Invalid key, #{name}."
      end
    end
  end
end
