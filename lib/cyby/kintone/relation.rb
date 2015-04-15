module Cyby
  module Kintone
    class Relation
      include Enumerable

      alias_method :all, :to_a

      def initialize(app)
        @app = app
        @where = Query::Where.new
        @order_by = []
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
        @where = Query::Where.new(cond, *params)
        self
      end

      def and(cond, *params)
        case cond
        when String
          @where = Query::WhereAnd.new(@where, Query::Where.new(cond, *params))
        else
          @where = Query::WhereAnd.new(@where, cond)
        end
        self
      end

      def or(cond, *params)
        case cond
        when String
          @where = Query::WhereOr.new(@where, Query::Where.new(cond, *params))
        else
          @where = Query::WhereOr.new(@where, cond)
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
        query = @where.to_query
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
