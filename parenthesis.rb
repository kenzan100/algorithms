require 'byebug'

def find_pairs(string)
  parenthesis = [
    { start: "{", end: "}" },
    { start: "(", end: ")" },
    { start: "[", end: "]" }
  ]
  startings = parenthesis.map { |h| h[:start] }
  endings   = parenthesis.map { |h| h[:end] }

  p_stack = []
  res = []
  string_a = string.split //
  i = 0
  while string_a.length > 0
    char = string_a.shift

    if startings.include? char
      p_stack.unshift( { char: char, start_i: i } )
    end

    if endings.include? char
      new_stack, matched = find_matched(char, p_stack)
      unless matched.nil?
        res << ({ start_i: matched[:start_i], end_i: i })
      end
    end
    
    i = i + 1
  end
  res
end

def find_matched(char, stack)
  found = false
  new_stack = []
  matched = nil
  
  stack.each do |s|
    s = stack.shift
    
    if found == true
      new_stack << s
    end

    if pair_match?(start_c: s[:char], end_c: char)
      matched = s
      found = true
    end
  end
  
  if found == false
    new_stack = stack
  end
  [new_stack, matched]
end

def pair_match?(start_c:, end_c:)
  parenthesis = {
    "{" => "}",
    "[" => "]",
    "(" => ")"
  }
  parenthesis[start_c] == end_c
end


puts find_pairs("(abc[e(aw])")
