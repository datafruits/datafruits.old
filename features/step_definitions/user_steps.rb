require_relative './util'

Given /^I exist as a user$/ do
  create_user
end

Given /^I am not logged in$/ do
  visit '/users/sign_out'
end

When /^I sign in with valid credentials$/ do
  create_visitor
  sign_in
end

When /^I return to the site$/ do
  visit '/'
end

When /^I sign in with a wrong email$/ do
  @visitor = @visitor.merge(:email => "wrong@example.com")
  sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrongpass")
  sign_in
end

Then /^I should be signed in$/ do
  page.should have_content "Signed in successfully."
end

Then /^I should not be signed in$/ do
  page.should have_content "Invalid email or password."
end

Given /^I am logged in$/ do
  create_user
  sign_in
end

When /^I sign out$/ do
  visit '/users/sign_out'
end

Then /^I should be signed out$/ do
  page.should have_content "Signed out successfully."
end

#######

Given /^I am logged in as an admin$/ do
  create_admin
  User.create @admin
  sign_in(@admin)
end

When /^I sign up with valid user data$/ do
  create_visitor
  sign_up
end

Then /^I should see a successful sign up message$/ do
  page.should have_content "User was successfully created."
end

When /^I sign up with an invalid email$/ do
  create_visitor
  @visitor = @visitor.merge(:email => "notanemail")
  sign_up
end

Then /^I should see an invalid email message$/ do
  page.should have_content "Email is invalid"
end

When /^I sign up without a password$/ do
  create_visitor
  @visitor = @visitor.merge(:password => "")
  sign_up
end

Then /^I should see a missing password message$/ do
  page.should have_content "Password can't be blank"
end

When /^I sign up without a password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "")
  sign_up
end

Then /^I should see a missing password confirmation message$/ do
  page.should have_content "Password doesn't match confirmation"
end

When /^I sign up with a mismatched password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "changeme123")
  sign_up
end

Then /^I should see a mismatched password message$/ do
  page.should have_content "Password doesn't match confirmation"
end

When /^I access the sign up page$/ do
    visit "/admin/users/new"
end

Then /^I should see be denied access$/ do
  page.should have_content "404"
  page.should have_content "Oops! We couldn't find what you are looking for."
end

Given /^I am logged in as a dj$/ do
  create_visitor
  delete_user
  User.create @visitor.merge(:role => "dj")
  sign_in
end

When /^I edit my account details$/ do
  visit "/users/edit"
  fill_in "user_username", :with => "newname"
  fill_in "user_current_password", :with => @visitor[:password]
  click_button "Update"
end

Then /^I should see an account edited message$/ do
  page.should have_content "You updated your account successfully."
end
