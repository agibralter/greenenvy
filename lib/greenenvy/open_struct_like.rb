module Greenenvy
  class OpenStructLike < BasicObject
    def initialize(hash)
      @method_missing_handler = MethodMissingHandler.new(hash)
    end

    def method_missing(name, *_)
      @method_missing_handler.call(name)
    end

    class MethodMissingHandler
      def initialize(hash)
        @hash = hash
      end

      def call(name)
        name, predicate = process_predicate(name.to_s)

        name = name.to_sym

        if @hash.key?(name)
          result_with_predicate(name, predicate)
        else
          raise Exceptions::MissingKey, "Unknown key, #{name}."
        end
      end

      private

      def process_predicate(name)
        if name[-1] == "?"
          [name[0..-2], true]
        else
          [name, false]
        end
      end

      def result_with_predicate(key, predicate)
        predicate ? !!@hash[key] : @hash[key]
      end
    end
  end
end
