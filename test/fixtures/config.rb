env :test do
  set :var_string, "foo"
  set :var_number, 1
  set :var_symbol, :foo
  set :var_bool, true
  set :var_hash, {a: "b"}
  set :var_nil, nil
end

env "production" do
  set "var_string", "bar"
end

env :foo do
  this_is_lazy_loaded
end

env :invalid_key_name1 do
  set :__id__, "foo"
end

env :invalid_key_name2 do
  set :__id__, "foo"
end

# invalid env name
env :__id__ do
  set :__id__, "foo"
end
