require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :email => "Email",
      :username => "Username",
      :password_hash => "Password Hash",
      :password_salt => "Password Salt"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
    rendered.should match(/Username/)
    rendered.should match(/Password Hash/)
    rendered.should match(/Password Salt/)
  end
end
