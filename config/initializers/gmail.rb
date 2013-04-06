ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'datafruits.fm',
  :user_name            => 'info@datafruits.fm', # full email address (user@your.host.name.com)
  :password             => ENV['GMAIL_PASSWORD'],
  :authentication       => 'plain',
  :enable_starttls_auto => true
}
