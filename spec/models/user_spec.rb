require 'spec_helper'

describe User do
  it "sets the avatar" do
    VCR.use_cassette 'avatar_upload' do
      u = User.create :username => "Testy McUserton", :email => "example@example.com",
        :password => "changeme", :password_confirmation => "changeme", :role => "dj"
      u.avatar = File.new "./spec/fixtures/test.png"
      u.save!
      u.reload
      u.avatar.url.should match(/test\.png/)
    end
  end
  it "assigns roles" do
    u = User.create :username => "Testy McUserton", :email => "example@example.com",
      :password => "changeme", :password_confirmation => "changeme", :role => "dj"
    u.role_ids=["blogger","dj"]
    u.has_role?('blogger').should == true
    u.has_role?('dj').should == true
  end
  it "#role?" do
    u = User.create :username => "Testy McUserton", :email => "example@example.com",
      :password => "changeme", :password_confirmation => "changeme", :role => "dj blogger"
    u.blogger?.should == true
    u.dj?.should == true
    u.admin?.should == false
  end
end
