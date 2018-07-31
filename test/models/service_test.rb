require 'test_helper'

class ServiceTest < ActiveSupport::TestCase
  test 'require name' do
    @service = Service.create
    assert_not_empty @service.errors[:name]
  end
  test 'require address' do
    @service = Service.create name: 'a name'
    assert_not_empty @service.errors[:address]
  end
  test 'require check_type' do
    @service = Service.create name: 'a name'
    assert_not_empty @service.errors[:check_type]
  end
  test 'require check_script' do
    @service = Service.create name: 'a name', address: 'http://fake.com', check_type: :match_string
    assert_not_empty @service.errors[:check_script]
    assert_empty @service.errors[:name]
    assert_empty @service.errors[:address]
    assert_empty @service.errors[:check_type]
  end

  test 'should save history only one status when successful' do
    @service = Service.create name: 'a name', address: 'http://fake.com', check_type: :http_status, current_status: true
    assert_difference 'ServiceHistory.count' do
      @service.save_history
    end
    assert_no_difference 'ServiceHistory.count' do
      @service.save_history
    end
  end

  test 'should save history every time when failed' do
    @service = Service.create name: 'a name', address: 'http://fake.com', check_type: :http_status, current_status: false
    assert_difference 'ServiceHistory.count' do
      @service.save_history
    end
    assert_difference 'ServiceHistory.count' do
      @service.save_history
    end
  end

  test 'should fail if http request is not successful' do
    stub_request(:get, "http://fake.com/").
    to_return(status: 400, body: "", headers: {})

    @service = Service.create name: 'a name', address: 'http://fake.com', check_type: :http_status
    assert_not @service.execute
  end

  test 'should suceed if http request is successful' do
    stub_request(:get, "http://fake.com/").
    to_return(status: 200, body: "", headers: {})

    @service = Service.create name: 'a name', address: 'http://fake.com', check_type: :http_status
    assert @service.execute
  end

  test 'should fail if body is not the expected' do
    stub_request(:get, "http://fake.com/").
    to_return(status: 200, body: "expected not", headers: {})

    @service = Service.create name: 'a name', address: 'http://fake.com', check_type: :match_string, check_script: 'expected'
    assert_not @service.execute
  end

  test 'should fail if body is the expected but http status is not OK' do
    stub_request(:get, "http://fake.com/").
    to_return(status: 400, body: "expected", headers: {})

    @service = Service.create name: 'a name', address: 'http://fake.com', check_type: :match_string, check_script: 'expected'
    assert_not @service.execute
  end

  test 'should suceed if body is the expected' do
    stub_request(:get, "http://fake.com/").
    to_return(status: 200, body: "expected", headers: {})

    @service = Service.create name: 'a name', address: 'http://fake.com', check_type: :match_string, check_script: 'expected'
    assert @service.execute
  end



  test 'should fail if json is not the expected' do
    stub_request(:get, "http://fake.com/").
    to_return(status: 200, body: "{\"status\":\"success\",\"failed\":true}", headers: {})

    @service = Service.create name: 'a name', address: 'http://fake.com', check_type: :json, check_script: "{\"status\":\"success\",\"failed\":false}"
    assert_not @service.execute
  end

  test 'should fail if json is the expected but http status is not OK' do
    stub_request(:get, "http://fake.com/").
    to_return(status: 400, body: "{\"status\":\"success\",\"failed\":false}", headers: {})

    @service = Service.create name: 'a name', address: 'http://fake.com', check_type: :json, check_script: "{\"status\":\"success\",\"failed\":false}"
    assert_not @service.execute
  end

  test 'should suceed if json is the expected' do
    stub_request(:get, "http://fake.com/").
    to_return(status: 200, body: "{\"status\":\"success\",\"failed\":false}", headers: {})

    @service = Service.create name: 'a name', address: 'http://fake.com', check_type: :json, check_script: "{\"status\":\"success\",\"failed\":false}"
    assert @service.execute
  end

  test 'should fail if raise error during request' do
    stub_request(:get, "http://fake.com/").
    to_raise(StandardError)

    @service = Service.create name: 'a name', address: 'http://fake.com', check_type: :json, check_script: "{\"status\":\"success\",\"failed\":false}"
    assert_not @service.execute
  end
end
