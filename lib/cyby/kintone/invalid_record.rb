module Cyby
  module Kintone
    class InvalidRecord < StandardError
      attr_reader :response, :message, :id, :errors, :code, :response_code

      def initialize(response)
        @response = response
        @message = @response["message"]
        @id = @response["id"]
        @code = @response["code"]
        @response_code = @response.code
        set_errors
      end

      def inspect
        {
          message: @message,
          id: @id,
          code: @code,
          response_code: @response_code,
          errors: @errors
        }.inspect
      end

      def to_s
        "InvalidRecord: #{inspect}"
      end

      private

      def set_errors
        @errors = {}
        @response["errors"].each do |key, value|
          match = key.match(/record\.([^.]+)\.value/)
          if match
            @errors[match[1]] = value["messages"]
          end
        end
      end
    end
  end
end
