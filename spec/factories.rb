require 'factory_girl'

FactoryGirl.define do
  factory :user do
    username "Testy McUserton"
    email "example@example.com"
    password "changeme" 
    password_confirmation "changeme" 
    role "dj"
    style "freestyle"
    time_zone "Pacific Time (US & Canada)"
  end

  factory :podcast do
    pub_date Date.current
  end
end

