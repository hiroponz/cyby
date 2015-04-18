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
        response = @api.get('/records.json', params_per_page)
        response['records'].map do |record|
          Record.new(self, record)
        end
      end

      def save(record)
        if record.changed?
          json = record.to_json_for_save
          if json[:id]
            resp = @api.put("/record.json", json)
          else
            resp = @api.post("/record.json", json)
            record["$id"] = resp["id"]
          end
          record["$revision"] = resp["revision"]
          record.unchanged
          true
        else
          false
        end
      end

      def delete(record)
        json = { ids: [record["$id"]] }
        @api.delete("/records.json", json)
        true
      end

      def new_record
        Record.new(self)
      end

      def relation
        Relation.new(self)
      end

      def all
        relation.all
      end

      def where(cond, *params)
        relation.where(cond, *params)
      end

      def asc(field)
        relation.asc(field)
      end

      def desc(field)
        relation.desc(field)
      end

      def select(*fields)
        relation.select(*fields)
      end

      def id
        @api.app
      end

      def inspect
        { id: id }.inspect
      end
    end
  end
end
