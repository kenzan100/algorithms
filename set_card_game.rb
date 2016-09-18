require 'pp'
require 'byebug'

Card = Struct.new(:count, :color, :shape, :filling)

def board
  [
      [Card.new(1, 1, 1, 1),
       Card.new(1, 2, 1, 2),
       Card.new(1, 1, 1, 3)],
      [Card.new(2, 1, 1, 1),
       Card.new(2, 2, 2, 2),
       Card.new(2, 1, 1, 3)],
      [Card.new(3, 1, 1, 1),
       Card.new(3, 1, 1, 2),
       Card.new(3, 1, 1, 3)],
      [Card.new(2, 2, 1, 1),
       Card.new(1, 2, 2, 2),
       Card.new(1, 2, 2, 3)]
   ]
end

raise "dup cards when setup" if ( board.flatten.uniq.length != board.flatten.length )

def cheat(board)
  # card as key, index as value
  hash = flatten_with_index(board)

  cards_in_board = hash.keys

  sets_with_dups = cards_in_board.combination(3).to_a.reduce([]) do |arr, maybe_set|
    arr << maybe_set if judge_set(maybe_set)
    arr
  end
  solutions = trim_dups(sets_with_dups)
  ret = solutions.map do |solution|
    solution.map { |c|
      hash[c]
    }
  end
  ret
end

def trim_dups(sets)
  set, rest = sets[0], sets[1..-1]
  one_down = [set] + rest.reject { |s| (set & s).any? }
  return one_down if rest.length == rest.reject { |s| (set & s).any? }.length
  dups = rest.select { |s| (set & s).any? }
  #dups.each { |dup|
  #  trim_dups( [dup] + rest.reject { |s| (dup & s).any? } )
  #} << trim_dups(one_down)
  trim_dups one_down
end

def judge_set(maybe_set)
  Card.members.each do |attr|
    attrs = maybe_set.map { |s| s.send(attr) }
    judge = ( attrs.uniq.length == 1 ) || ( attrs.uniq.length == 3 )
    return false unless judge
  end
  true
end

def flatten_with_index(board)
  hash = {}
  board.each_with_index do |col, x|
    col.each_with_index do |card, y|
      hash[card] = [x, y]
    end
  end
  hash
end

def ans
  cheat board
end
