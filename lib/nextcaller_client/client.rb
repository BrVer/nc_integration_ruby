module NextcallerClient
  #The NextCaller API client
  class Client

    attr_accessor :auth

    def initialize(api_key, api_secret)
      auth = {username: api_key, password: api_secret}
      @transport = Transport.new(auth, DEFAULT_USER_AGENT)
    end

    # Get profiles by phone
    # arguments:
    #   phone           -- 10 digits phone, str ot int, required
    #   response_format -- response format [json|xml] (default json)
    #   debug           -- boolean (default false)
    #
    def get_by_phone(phone, response_format=JSON_RESPONSE_FORMAT, debug=false)

      method = 'GET'
      Utils.validate_format(response_format)
      Utils.validate_phone(phone)
      url_params = {
          phone: phone,
          format: response_format
      }
      url = Utils.prepare_url('records', url_params)
      response = @transport.make_http_request(url, method, debug)

      if block_given?
        yield response
      else
        Utils.default_handle_response(response, response_format)
      end
    end

    # Get profile by id
    # arguments:
    #   profile_id      -- Profile identifier, required
    #   response_format -- response format [json|xml] (default json)
    #   debug           -- boolean (default false)
    #
    def get_by_profile_id(profile_id, response_format=JSON_RESPONSE_FORMAT, debug=false)

      method = 'GET'
      Utils.validate_format(response_format)
      url_params = {
          format: response_format
      }
      url = Utils.prepare_url('users/%s/' % profile_id, url_params)
      response = @transport.make_http_request(url, method, debug)

      if block_given?
        yield response
      else
        Utils.default_handle_response(response, response_format)
      end
    end

    # Update profile by id
    # arguments:
    #   profile_id      -- Profile identifier, required
    #   data            -- dictionary with changed data, required
    #   debug           -- boolean (default false)
    #
    def update_by_profile_id(profile_id, data, debug=false)

      method = 'POST'
      url_params = {
          format: JSON_RESPONSE_FORMAT
      }
      url = Utils.prepare_url('users/%s/' % profile_id, url_params)
      data = Utils.prepare_json_data(data)
      response = @transport.make_http_request(url, method, debug, data)

      if block_given?
        yield response
      else
        response
      end
    end

  end

end

