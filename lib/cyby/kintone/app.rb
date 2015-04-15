module Cyby
  module Kintone
    class App
      attr_reader :last_response
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
        @last_response = @api.get('/records.json', params_per_page)
        unless @last_response.code == 200
          fail @last_response["message"]
        end
        @last_response['records'].map do |record|
          Record.new(record)
        end
      end

      def all
        Relation.new(self)
      end

      def where(cond, *params)
        all.where(cond, *params)
      end

      def asc(field)
        all.asc(field)
      end

      def desc(field)
        all.desc(field)
      end
    end
  end
end
