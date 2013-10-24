require 'spec_helper'

describe User do
  it "sets the avatar" do
    VCR.use_cassette 'avatar_upload' do
      u = create :user
      u.avatar = File.new "./spec/fixtures/test.png"
      u.save!
      u.reload
      u.avatar.url.should match(/test\.png/)
    end
  end
  it "assigns roles" do
    u = create :user
    u.role_ids=["blogger","dj"]
    u.has_role?('blogger').should == true
    u.has_role?('dj').should == true
  end
  it "#role?" do
    u = create :user, role: 'dj blogger'
    u.blogger?.should == true
    u.dj?.should == true
    u.admin?.should == false
  end
  it "doesn't allow invalid timezones" do
    u = build :user, time_zone: "New Burgerdelphia"
    u.should_not be_valid
  end

  it "sets style" do
    u = build :user, style: "lovely"
    u.should be_valid
  end

  it "doesn't allow invalid style" do
    u = build :user, style: "curry pan"
    u.should_not be_valid
  end
end
