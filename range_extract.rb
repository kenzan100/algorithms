require "pp"
require "byebug"

def solution(list)
  recur_solution(list).compact
end

def recur_solution(list)
  f, s, t, rest = list[0], list[1], list[2], list[3..-1]
  return list if t.nil?
  each_entry, rest = if (f..t).to_a == [f, s, t]
                       partial_ent = "#{f}-"
                       next_n = rest.shift
                       if next_n.nil? || next_n != t.succ
                         partial_ent << "#{t}"
                         rest = [next_n] + rest
                       else
                         while rest.first == t.succ.succ && !next_n.nil?
                           next_n = rest.shift
                         end
                         partial_ent << "#{next_n}"
                       end
                       [partial_ent, rest]
                     else
                       [f, ([s, t] + rest)]
                     end
  [each_entry] + recur_solution(rest)
end

pp solution([-6, -3, -2, -1, 0, 1, 3, 4, 5, 7, 8, 9, 10, 11, 14, 15, 17, 18, 19, 20])
