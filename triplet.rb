def infer_word(triplets)
  rules = triplets.map do |triplet|
    -> (word) {
      triplet.each_car.reduce(-1) do |int, char|
        next_i = word.index(char)
        return false unless (int < next_i)
        next_i
      end
      true
    }
  end

  triplets.join.split(//).uniq.permutation do |possible_word|
    return possible_word if rules.all? { |rule| rule.call(possible_word) }
  end
end
