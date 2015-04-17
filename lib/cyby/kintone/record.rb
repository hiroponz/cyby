module Cyby
  module Kintone
    class Record
      def initialize(app, raw = {})
        @app = app
        @raw = raw
      end

      def [](key)
        if @raw.key?(key)
          convert(@raw[key])
        else
          fail "'#{key}' doesn't exist"
        end
      end

      def []=(key, value)
        @raw[key] ||= {}
        case key
        when "$id"
          @raw[key]["type"] = "__ID__"
        when "$revision"
          @raw[key]["type"] = "__REVISION__"
        end
        @raw[key]["value"] = value
      end

      def method_missing(method_name, *args)
        key = method_name.to_s
        if key[-1] == "="
          self.[]=(key[0..-2], args[0])
        else
          self.[](key)
        end
      end

      def inspect
        hash = {}
        @raw.each do |key, value|
          hash[key] = value["value"]
        end
        hash.inspect
      end

      def save
        @app.save(self)
      end

      def to_json_for_save
        record = @raw.select do |key, value|
          case value["type"]
          when "CREATOR", "CREATED_TIME", "MODIFIER", "UPDATED_TIME", "STATUS", "STATUS_ASSIGNEE", "RECORD_NUMBER", "__REVISION__", "__ID__"
            false
          else
            true
          end
        end
        if @raw["$id"]
          { id: @raw["$id"]["value"], record: record }
        else
          { record: record }
        end
      end

      private
      def convert(args)
        type = args['type']
        value = args['value']
        case type
        when 'CALC'
          value.to_f
        when 'NUMBER'
          value.to_f
        when 'RECORD_NUMBER'
          value.to_i
        else
          value
        end
      end
    end
  end
end
