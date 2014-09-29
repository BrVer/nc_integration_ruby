module NextcallerClient

  class TooManyRedirects < StandardError
  end

  class HttpException < StandardError

    attr_reader :content

    def initialize(message, content)
      @message = message
      @content = content            #contains actual response
      super(message)
    end
  end

end
