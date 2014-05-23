module HTTParty
  class Response
    def body
      @body.force_encoding("UTF-8")
    end
  end
end
