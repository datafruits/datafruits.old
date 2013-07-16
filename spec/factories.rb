require 'factory_girl'

FactoryGirl.define do
  factory :user do
    username "Testy McUserton"
    email "example@example.com"
    password "changeme" 
    password_confirmation "changeme" 
    role "dj"
    time_zone "America/Los_Angeles"
  end
end
