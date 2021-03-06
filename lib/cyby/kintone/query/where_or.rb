module Cyby
  module Kintone
    module Query
      class WhereOr
        def initialize(lhs, rhs)
          @lhs = lhs
          @rhs = rhs
        end

        def to_query
          if @lhs.to_query.blank?
            @rhs.to_query
          elsif @rhs.to_query.blank?
            @lhs.to_query
          else
            "(#{@lhs.to_query} or #{@rhs.to_query})"
          end
        end
      end
    end
  end
end

