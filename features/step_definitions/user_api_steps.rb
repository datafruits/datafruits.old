require_relative './util'

World(Rack::Test::Methods)

When /^I sign in with valid credentials via json$/ do
  post '/login.json', user: { login: @visitor[:username], password: @visitor[:password] }
end

Then /^I should get a 'signed in' json response$/ do
  JSON.load(last_response.body)["success"].should == true
end
