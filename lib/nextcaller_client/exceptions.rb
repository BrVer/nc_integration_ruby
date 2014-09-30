module NextcallerClient

  class HttpException < StandardError

    attr_reader :content

    def initialize(message, content)
      super(message)
      @content = content            #contains actual response
    end
  end

end
