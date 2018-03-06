ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  domain: 'gmail.com',
  user_name: ENV['mabj90s@gmail.com'],
  password: ENV['040790Mabj!'],
  authentication: :login,
  enable_starttls_auto: true
}
