module Cyby
  module Kintone
    class Record
      def initialize(app, raw = {})
        @app = app
        @raw = raw
        @changed = {}
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
        if @raw[key]["value"] != value
          changed(key)
        end
        @raw[key]["value"] = value
      end

      def changed(field)
        case field
        when "$id", "$revision"
          # Do nothing
        else
          @changed[field] = true
        end
      end

      def changed?
        @changed.any?
      end

      def unchanged
        @changed = {}
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

      def delete
        @app.delete(self)
      end

      def to_json_for_save
        record = @raw.select do |key, value|
          @changed[key]
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
