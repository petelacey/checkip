require_relative 'checkip'
require 'minitest/autorun'
require 'rack/test'

class CheckIpTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_default_ip
    get '/'
    assert_match /127\.0\.0\.1/, last_response.body
  end

  def test_client_ip
    get '/', {}, 'Client-IP' => '1.1.1.1'
    assert_match /1\.1\.1\.1/, last_response.body
  end

  def test_forwarded_ip
    get '/', {}, 'HTTP_X_FORWARDED_FOR' => '1.1.1.1'
    assert_match /1\.1\.1\.1/, last_response.body
  end

  def test_precedence
    get '/', {}, 'HTTP_X_FORWARDED_FOR' => '1.1.1.1', 'Client-IP' => '2.2.2.2'
    assert_match /2\.2\.2\.2/, last_response.body
  end
end
