require 'test_helper'

class ServiceStatusMailerTest < ActionMailer::TestCase
  def setup
    @service = Service.create name: 'Test Service', check_type: :http_status, address: 'http://fake_address'
  end

  test "failed" do
    mail = ServiceStatusMailer.failed(@service.id)
    assert_equal "Test Service failed at Never", mail.subject
    assert_equal ['support@domain.test'], mail.to
    assert_equal ['support@domain.test'], mail.from
  end

  test "recovered" do
    mail = ServiceStatusMailer.recovered(@service.id)
    assert_equal "Test Service recovered", mail.subject
    assert_equal ['support@domain.test'], mail.to
    assert_equal ['support@domain.test'], mail.from
  end

end
