module NextcallerClient
  # default values
  DEFAULT_REQUEST_TIMEOUT = 60
  JSON_RESPONSE_FORMAT = 'json'
  XML_RESPONSE_FORMAT = 'xml'
  RESPONSE_FORMATS = [JSON_RESPONSE_FORMAT, XML_RESPONSE_FORMAT]
  DEFAULT_PHONE_LENGTH = 10
  DEFAULT_USER_AGENT = 'nextcaller/ruby/%s' % VERSION
  JSON_CONTENT_TYPE = 'application/json; charset=utf-8'
  DEFAULT_REDIRECT_ATTEMPTS = 10

  # urls
  BASE_URL = 'api.nextcaller.com/v2/'
  FULL_URL = 'https://api.nextcaller.com/v2/'

end
