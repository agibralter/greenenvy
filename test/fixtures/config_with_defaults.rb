# frozen_string_literal: true
default do
  set :var_string, "baz"
end

env :test do
  set :var_number, 1
end

env :production do
  set :var_string, "bar"
  set :var_number, 2
end
