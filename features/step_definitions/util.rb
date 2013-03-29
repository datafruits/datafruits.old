### UTILITY METHODS ###

def create_visitor
  @visitor ||= { :username => "Testy McUserton", :email => "example@example.com",
    :password => "changeme", :password_confirmation => "changeme", :role => "dj" }
end

def create_admin
  @admin ||= { :username => "admin", :email => "admin@example.com",
    :password => "changeme", :password_confirmation => "changeme", :role => "admin" }
end

def create_user
  create_visitor
  delete_user
  User.create @visitor
end

def delete_user
  @user ||= User.where(:email => @visitor[:email]).first
  @user.destroy unless @user.nil?
end

def sign_up
  delete_user
  visit '/admin/users/new'
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_username", :with => @visitor[:username]
  fill_in "user_password", :with => @visitor[:password]
  fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
  attach_file :user_avatar, File.expand_path("spec/fixtures/test.png")
  click_on "submit"
  find_user
end

def find_user
  @user ||= User.where(:email => @visitor[:email]).first
end

def sign_in(user=@visitor)
  visit '/users/sign_in'
  fill_in "user_login", :with => user[:email]
  fill_in "user_password", :with => user[:password]
  click_button "Sign in"
end

