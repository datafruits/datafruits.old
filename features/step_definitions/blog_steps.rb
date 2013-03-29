require_relative './util'

Given /^I am a visitor to the site$/ do
  visit '/users/sign_out'
end

When /^I visit the front page$/ do
  visit '/'
end

Given /^a blog post exists$/ do
  Post.create :title => "a blog post", :body => "doot doot doooo"
end

Given /^some blog posts exist$/ do
  Post.create :title => "a blog post", :body => "doot doot doooo"
  Post.create :title => "another post ", :body => "doot doot doooo deeeeee"
end

Then /^I should see some blog posts$/ do
  page.should have_content "a blog post"
  page.should have_content "doot doot doooo"
  page.should have_content "another post "
  page.should have_content "doot doot doooo deeeeee"
end

Given /^I am signed in as a user with the 'blogger' role$/ do
  create_visitor
  delete_user
  User.create @visitor.merge(:role => "blogger")
  sign_in
end

When /^I edit the post$/ do
  visit "/posts/#{Post.first.id}/edit"
  fill_in :post_title, with: "changed title"
  fill_in :post_body, with: "changed body"
  click_on "submit"
end

When /^I delete the post$/ do
  visit "/posts/#{Post.first.id}/edit"
  click_on 'Delete'
end

Then /^I should not see that blog post$/ do
  page.should_not have_content "a blog post"
  page.should_not have_content "doot doot doooo"
end

When /^I submit a new blog post$/ do
  visit '/posts/new'
  fill_in :post_title, with: "new title"
  fill_in :post_body, with: "new body"
  attach_file :post_image, File.expand_path("spec/fixtures/test.png")
  click_on "submit"
end

Then /^I should see my new blog post$/ do
  page.should have_content "new title"
  page.should have_content "new body"
end

Then /^I should see my changes to the post$/ do
  page.should have_content "changed title"
  page.should have_content "changed body"
end

