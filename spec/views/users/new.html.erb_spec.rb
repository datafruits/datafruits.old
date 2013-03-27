require 'spec_helper'

describe "users/new" do
  before(:each) do
    assign(:user, stub_model(User,
      :email => "MyString",
      :username => "MyString",
      :password_hash => "MyString",
      :password_salt => "MyString"
    ).as_new_record)
  end

  it "renders new user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", users_path, "post" do
      assert_select "input#user_email[name=?]", "user[email]"
      assert_select "input#user_username[name=?]", "user[username]"
      assert_select "input#user_password_hash[name=?]", "user[password_hash]"
      assert_select "input#user_password_salt[name=?]", "user[password_salt]"
    end
  end
end
