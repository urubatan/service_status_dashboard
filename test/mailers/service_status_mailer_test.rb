require 'test_helper'

class ServiceStatusMailerTest < ActionMailer::TestCase
  test "failed" do
    mail = ServiceStatusMailer.failed
    assert_equal "Failed", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "recovered" do
    mail = ServiceStatusMailer.recovered
    assert_equal "Recovered", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
