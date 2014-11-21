module Cyby
  module Kintone
    class App
      LIMIT = 100

      def initialize(id)
        @api = RestApi.new(id)
      end

      def find(params)
        result = []
        page = 0
        begin
          records = find_per_page(params, page)
          result.concat(records)
          page += 1
        end while records.count == LIMIT
        result
      end

      def find_per_page(params, page)
        params_per_page = params.dup
        queries = [params[:query]]
        if page > 0
          queries << "offset #{LIMIT * page}"
        end
        params_per_page[:query] = queries.join(" ")
        resp = @api.get('/records.json', params_per_page)
        resp['records'].map do |record|
          Record.new(record)
        end
      end
    end
  end
end
