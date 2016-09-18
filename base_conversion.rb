require "pp"

bin='01'
oct='01234567'
dec='0123456789'
hex='0123456789abcdef'
allow='abcdefghijklmnopqrstuvwxyz'
allup='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
alpha='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
alphanum='0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

def convert(input, from, to)
  input_dec = convert_to_dec(input, from)
  each_digits = recur_convert(input_dec, to.size)
  each_digits.map { |digit| to.split(//)[digit] }.join
end

def convert_to_dec(input, from)
  input.split(//).reverse.map.with_index { |d,i| [d, i] }
       .reduce(0) { |sum, (digit, i)| sum += from.index(digit) * (from.size ** i) }
end

def recur_convert(input, to_size)
  return [input] if input < to_size
  rest, mod = input.divmod(to_size)
  recur_convert(rest, to_size) + [mod]
end

pp convert("15", dec, bin)
pp convert("1010", bin, hex) #should return "a"
pp convert("hello", allow, hex) #should return "320048"
