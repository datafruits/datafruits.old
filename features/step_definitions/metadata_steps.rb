World(Rack::Test::Methods)

Given /^metadata is set in redis$/ do
  $redis.set("currentsong", "a cool song")
end

When /^I request the metadata$/ do
  get '/metadata.json'
end

Then /^I should get the metadata in a json response$/ do
  JSON.load(last_response.body).should ==  {"currentsong" => "a cool song"}
end
