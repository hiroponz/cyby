module Cyby
  module Kintone
    class Relation
      attr_reader :condition, :order_by, :fields
      include Enumerable

      alias_method :all, :to_a

      def initialize(app)
        @app = app
        @condition = Query::Where.new
        @order_by = []
        @fields = nil
      end

      def each
        args = {}
        args[:query] = to_query
        args[:fields] = @fields if @fields
        records = @app.find(args)
        records.map do |record|
          yield record
        end
      end

      def where(cond, *params)
        case cond
        when String
          @condition = Query::Where.new(cond, *params)
        else
          @condition = cond.condition
        end
        self
      end

      def and(cond, *params)
        case cond
        when String
          @condition = Query::WhereAnd.new(@condition, Query::Where.new(cond, *params))
        else
          @condition = Query::WhereAnd.new(@condition, cond.condition)
        end
        self
      end

      def or(cond, *params)
        case cond
        when String
          @condition = Query::WhereOr.new(@condition, Query::Where.new(cond, *params))
        else
          @condition = Query::WhereOr.new(@condition, cond.condition)
        end
        self
      end

      def asc(field)
        @order_by << "#{field} asc"
        self
      end

      def desc(field)
        @order_by << "#{field} desc"
        self
      end

      def select(*fields)
        @fields = fields
        self
      end

      def to_query
        query = @condition.to_query
        if @order_by.any?
          query += " order by #{@order_by.join(',')}"
        end
        query
      end

      def inspect
        { app: @app.id, query: to_query, select: @fields }.inspect
      end
    end
  end
end
