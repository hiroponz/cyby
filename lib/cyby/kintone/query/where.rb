module Cyby
  module Kintone
    module Query
      class Where
        def initialize(cond = "", *params)
          @cond = cond
          @params = params
        end

        def to_query
          if @params.empty?
            @cond
          else
            conds = @cond.split("?")
            unless conds.count == @params.count
              fail "Condition params count mismatch!"
            end
            i = 0
            cond = ""
            while i < conds.count
              cond += conds[i] + param_to_s(@params[i])
              i += 1
            end
            cond
          end
        end

        def param_to_s(param)
          case param
          when String, Date, DateTime
            '"' + param.to_s + '"'
          when Time
            '"' + param.strftime("%Y-%m-%dT%H:%M%:z") + '"'
          when Array
            '("' + param.join('","') + '")'
          else
            param.to_s
          end
        end
      end
    end
  end
end
