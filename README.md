# NextcallerClient

A ruby wrapper around the Nextcaller API.

[![Build Status](https://travis-ci.org/BrVer/nc_integration_ruby.svg?branch=master)](https://travis-ci.org/BrVer/nc_integration_ruby)

## Installation

Add this line to your application's Gemfile:

    ruby gem 'nextcaller_client'


And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nextcaller_client
    
**Dependencies**:

    * nokogiri

## Usage

**Example**

    require 'nextcaller_client'
    api_key = "XXXXX"
    api_secret = "YYYYY"
    phone_number = "121212..."
    client = NextcallerClient::Client.new(api_key, api_secret)
    resp = client.get_by_phone(phone_number)
    print resp
    
**Initializing client**

    require 'nextcaller_client'
    api_key = "XXXXX"
    api_secret = "YYYYY"
    client = NextcallerClient::Client.new(api_key, api_secret)
    
**Get profile by phone**

    resp = client.get_by_phone(phone, response_format, debug)
    
    # arguments:
    #   phone           -- 10 digits phone, str ot int, required
    #   response_format -- response format [json|xml] (default json)
    #   debug           -- boolean (default false)

**Get profile by id**

    resp = client.get_by_profile_id(profile_id, response_format, debug)
    
    # arguments:
    #   profile_id      -- Profile identifier, required
    #   response_format -- response format [json|xml] (default json)
    #   debug           -- boolean (default false)

**Update profile by id**
    
    resp = client.update_by_profile_id(profile_id, data, debug)
    
    # arguments:
    #   profile_id      -- Profile identifier, required
    #   data            -- dictionary with changed data, required
    #   debug           -- boolean (default false)
    
    # Returns 204 response in the case of the succesfull request.
    
##Exceptions

**NextcallerClient::HttpException**

Thrown in the case of 4xx or 5xx response from server, 'content' attribute contains actual response

**NextcallerClient::TooManyRedirects**

Thrown when maximum redirects count (10) is reached 
    
##Notes

It is possible to override the default response handler 
by passing a block to get_by_phone/get_by_profile_id/update_by_profile_id function. 
For example:

    result = client.get_by_phone(number, 'json') { |resp| {body: JSON.parse(resp.body), code: resp.code} }

Default handler for get_by_* methods:
    
    def self.default_handle_response(resp, response_format='json')
      return JSON.parse(resp.body) if response_format == 'json'
      return Nokogiri::XML(resp.body) if response_format == 'xml'
      resp
    end
