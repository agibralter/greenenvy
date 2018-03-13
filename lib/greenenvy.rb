# frozen_string_literal: true
require "greenenvy/context"
require "greenenvy/exceptions"
require "greenenvy/loader"
require "greenenvy/name_checker"
require "greenenvy/name_validator"
require "greenenvy/open_struct_like"
require "greenenvy/version"

module Greenenvy
  def self.load_env(env, dir)
    name_validator = NameValidator.new(NameChecker.new)
    loader = Loader.new(Context, name_validator, env, dir).load
    OpenStructLike.new(loader)
  end
end
