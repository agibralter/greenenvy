# frozen_string_literal: true
module Greenenvy
  module Exceptions
    MissingKey = Class.new(StandardError)
    InvalidKey = Class.new(StandardError)
  end
end
