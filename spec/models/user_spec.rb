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
end
