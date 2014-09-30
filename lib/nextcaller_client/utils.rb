module NextcallerClient

  module Utils

    def self.prepare_json_data(data)
      unless data.is_a? Hash
        raise ArgumentError, 'Data should be a hash.'
      end
      data.to_json
    end

    def self.default_handle_response(resp, response_format='json')
      return JSON.parse(resp.body) if response_format == 'json'
      return Nokogiri::XML(resp.body) if response_format == 'xml'
    end

    #Validate phone format
    def self.validate_phone(value, length=DEFAULT_PHONE_LENGTH)
      value = value.to_s
      unless value =~ /^[0-9]{10}$/
        raise ArgumentError, 'Invalid phone number: %s. Phone should consists of 10 digits.' % value
      end
    end

    #Validate response format
    def self.validate_format(response_format)
      unless RESPONSE_FORMATS.include? response_format
        raise ArgumentError, 'Unsupported format: %s. Supported formats are: %s' % [response_format, RESPONSE_FORMATS]
      end
    end

    #Prepare url from path and params
    def self.prepare_url(path, url_params={})
      url = '%s%s' % [FULL_URL, path]
      unless url.end_with?('/')
        url += '/'
      end
      unless url_params.empty?
        url_params_str = url_params.collect { |k, v| "#{CGI::escape(k.to_s)}=#{CGI::escape(v.to_s)}" }.join('&')
        url += "?#{url_params_str}"
      end
      url
    end

  end

end
