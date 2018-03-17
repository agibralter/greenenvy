# frozen_string_literal: true
require "greenenvy/context"
require "greenenvy/exceptions"
require "greenenvy/loader"
require "greenenvy/name_validator"
require "greenenvy/container"
require "greenenvy/version"

module Greenenvy
  def self.load_env(env, dir)
    name_validator = NameValidator.new(Container)
    loader = Loader.new(Context, name_validator, env, dir).load
    Container.new(loader)
  end
end
