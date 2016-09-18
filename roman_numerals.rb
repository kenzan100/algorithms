require "pp"
class RomanNumerals
  class << self
    def to_roman(numeric)
      added = recur_to_roman(numeric, [])
      added.join
    end

    def from_roman(roman)
      added, subtracted = recur_from_roman(roman.split(//), [], [])
      added.reduce(:+) - subtracted.reduce(:+).to_i
    end

    private
    def recur_to_roman(num, added)
      look = nr.sort_by { |n, _v| -1 * n }.to_h
      max_key = look.keys.detect { |n| (num / n) > 0 }
      cnt, rest = num.divmod(max_key)
      cnt.times { added << look[max_key] }
      return added if rest.zero?
      recur_to_roman(rest, added)
    end

    def recur_from_roman(arr, added, subtracted)
      look = rn
      first, second, rest = look[arr[0]], look[arr[1]], arr[2..-1]
      (second.nil? || first >= second) ? added << first : subtracted << first
      return [added, subtracted] if second.nil?
      recur_from_roman([arr[1]] + rest, added, subtracted)
    end

    def rn
      { "I" => 1,"V" => 5, "X" => 10, "L" => 50, "C" => 100, "D" => 500, "M" => 1000 }
    end

    def nr
      rn.invert.merge({
        900 => "CM", 400 => "CD", 90 => "XC", 40 => "XL", 9 => "IX", 4 => "IV"
      })
    end
  end
end

pp RomanNumerals.to_roman(2008)
