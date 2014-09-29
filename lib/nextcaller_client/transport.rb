module NextcallerClient

  class Transport

    attr_accessor :auth, :user_agent, :log

    def initialize(auth, user_agent=DEFAULT_USER_AGENT)
      @auth = auth
      @user_agent = user_agent
      @log = Logger.new(STDOUT)
      @log.level = Logger::DEBUG
    end

    def make_http_request(url, method='GET', debug=false, data={}, redirect_attempts_left = DEFAULT_REDIRECT_ATTEMPTS)
      raise TooManyRedirects if redirect_attempts_left < 0
      uri = URI.parse(url)
      case method
        when 'GET'
          request = Net::HTTP::Get.new('%s?%s' % [uri.path, uri.query])
        when 'POST'
          request = Net::HTTP::Post.new('%s?%s' % [uri.path, uri.query])
          request['Content-Type'] = 'application/json'
          request.body = data
      end
      request.basic_auth(@auth[:username], @auth[:password])
      request['Connection'] = 'Keep-Alive'
      request['User-Agent'] = @user_agent if @user_agent

      https = Net::HTTP.new(uri.hostname, uri.port)
      https.read_timeout = DEFAULT_REQUEST_TIMEOUT
      https.use_ssl = true

      # https.set_debug_output($stderr) if debug              #deep debug
      @log.debug('Request url: %s' % url)
      @log.debug('Request body: %s' % data.to_s) if debug and method == 'POST'

      response = https.start { |http| http.request(request) }
      case response
        when Net::HTTPSuccess then
          response
        when Net::HTTPRedirection then
          location = response['location']
          @log.debug("redirected to: #{location}") if debug
          make_http_request(location, data, method, debug, redirect_attempts_left - 1)
          else
             if 400 <= response.code < 500
               raise HttpException('%s Client Error: %s' % [response.code, response.message], response)
            elsif 500 <= response.code < 600
               raise HttpException('%s Server Error: %s' % [response.code, response.message], response)
          end
      end
    end

  end

end

