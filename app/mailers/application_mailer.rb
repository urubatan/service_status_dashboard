class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.config.from_address
  layout 'mailer'
end
