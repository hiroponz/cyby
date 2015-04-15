module Cyby
  module Kintone
    module Query
      class WhereOr
        def initialize(lhs, rhs)
          @lhs = lhs
          @rhs = rhs
        end

        def to_query
          "(#{@lhs.to_query} or #{@rhs.to_query})"
        end
      end
    end
  end
end

