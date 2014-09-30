require 'nextcaller_client'
require 'webmock/minitest'
require 'minitest/autorun'

TEST_USERNAME = 'username'
TEST_PASSWORD = 'password'

def prepare_url_for_test(path)
  return Regexp.new 'https://%s:%s@%s%s*' %[TEST_USERNAME, TEST_PASSWORD, NextcallerClient::BASE_URL, path]
end

class BaseTestCase < Minitest::Test

  def initialize(name)
    @client = NextcallerClient::Client.new(TEST_USERNAME, TEST_PASSWORD)
    super(name)
  end

end

 