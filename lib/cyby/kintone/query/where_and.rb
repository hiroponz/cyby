module Cyby
  module Kintone
    module Query
      class WhereAnd
        def initialize(lhs, rhs)
          @lhs = lhs
          @rhs = rhs
        end

        def to_query
          "(#{@lhs.to_query} and #{@rhs.to_query})"
        end
      end
    end
  end
end
