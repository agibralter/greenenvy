# frozen_string_literal: true
module Greenenvy
  class Container
    def initialize(hash)
      @hash = hash
      @method_missing_handler = MethodMissingHandler.new(hash)
    end

    def method_missing(name, *_)
      @method_missing_handler.call(name)
    end

    def respond_to?(name, _=false)
      @method_missing_handler.respond?(name) || super
    end

    class MethodMissingHandler
      def initialize(hash)
        @hash = hash
      end

      def call(name)
        processed_name, predicate = process_predicate(name)

        if @hash.key?(processed_name)
          result_with_predicate(processed_name, predicate)
        else
          raise Exceptions::MissingKey, missing_key_message(processed_name)
        end
      end

      def respond?(name)
        processed_name, _ = process_predicate(name)
        @hash.key?(processed_name)
      end

      private

      def process_predicate(name)
        if name[-1] == "?"
          [name[0..-2].to_sym, true]
        else
          [name.to_sym, false]
        end
      end

      def result_with_predicate(key, predicate)
        predicate ? !!@hash[key] : @hash[key]
      end

      def missing_key_message(name)
        "Unknown key: #{name}. Valid keys: #{@hash.keys.join(", ")}."
      end
    end
  end
end
