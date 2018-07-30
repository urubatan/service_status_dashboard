# Preview all emails at http://localhost:3000/rails/mailers/service_status_mailer
class ServiceStatusMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/service_status_mailer/failed
  def failed
    ServiceStatusMailer.failed
  end

  # Preview this email at http://localhost:3000/rails/mailers/service_status_mailer/recovered
  def recovered
    ServiceStatusMailer.recovered
  end

end
