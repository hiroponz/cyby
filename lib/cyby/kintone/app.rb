module Cyby
  module Kintone
    class App
      def initialize(id)
        @api = RestApi.new(id)
      end

      def find(params)
        resp = @api.get('/records.json', params)
        resp['records'].map do |record|
          Record.new(record)
        end
      end
    end
  end
end
