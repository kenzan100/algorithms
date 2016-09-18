require "pp"
require "byebug"

input = "berr".split //

class Dict
  attr_reader :words

  def initialize(words)
    @words = words
  end

  def did_you_mean(input)
    regexes = generate_regexes(input)
    words.reduce({}) do |hash, word|
      matched_regex_group = regexes.detect do |regex_group|
        regex_group.any? { |regex_obj| word.match(regex_obj.regex) }
      end
      matched_regexes = matched_regex_group.select do |regex_obj|
        m = regex_obj.regex.match(word)
        if m
          regex_obj.unmatched_chars = m.captures
          regex_obj.outside_hit = m.captures[0].length + m.captures[-1].length
          m.captures[1..-2]
        end
        m
      end
      hash[word] = matched_regexes
      hash
    end
  end

  private

  RegexWithMeta = Struct.new(:regex, :used_indices, :left_indices, :unmatched_chars, :outside_hit)
  def generate_regexes(input)
    (1..input.length).to_a.reverse.map do |i|
      (0..(input.length-1)).to_a.combination(i).map do |indices|
        partial_word = indices.sort.reduce([]) do |arr, index|
          arr << input[index] if input[index]
          arr
        end

        regex_arr = partial_word.reduce(['(.*)']) do |arr, char|
          arr << char
          arr << "(.*?)"
        end
        regex_arr[-1] = '(.*)'
        regex = /#{regex_arr.join}/
        RegexWithMeta.new(regex,
                          indices,
                          (0..(input.length - 1)).to_a - indices,
                          [],
                          0)
      end
    end
  end
end

words = %w(beer barrel)
pp Dict.new(words).did_you_mean("aberr")

# words = %w(bc)
# pp Dict.new(words).did_you_mean("cb")
