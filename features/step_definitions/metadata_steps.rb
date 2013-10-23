World(Rack::Test::Methods)

Given /^the radio server is up$/ do
  stub_request(:get, 'http://radio.datafruits.fm/currentsong').to_return(body: 'a cool song')
end

When /^I request the metadata$/ do
  get '/metadata.json'
end

Then /^I should get the metadata in a json response$/ do
  JSON.load(last_response.body).should ==  {"currentsong" => "a cool song"}
end
