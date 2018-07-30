class ServiceStatusMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.service_status_mailer.failed.subject
  #
  def failed(service_id)
    @service = Service.find service_id

    mail to: Rails.application.config.notification_address, subject: "#{@service.name} failed at #{@service.last_failed}"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.service_status_mailer.recovered.subject
  #
  def recovered(service_id)
    @service = Service.find service_id

    mail to: Rails.application.config.notification_address, subject: "#{@service.name} recovered"
  end
end
