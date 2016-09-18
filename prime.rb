require "pp"

class Prime
  class << self
    def first(n)
      candid = 2
      @primes = []
      begin
        @primes << candid if is_prime?(candid)
        candid += 1
      end while (@primes.length < n)
      @primes
    end

    def is_prime?(n)
      2.upto(Math.sqrt(n).floor) do |i|
        if n % i == 0
          return false
        end
      end
      true
    end
  end
end

class PrimeMemo
  class << self
    def lookup
      return @table if @table
      max = 2_000_000
      table = 0.upto(max).map { |i| i }
      Math.sqrt(max).ceil.times do |i|
        next if i == 0 || i == 1
        (0..max).step(i).each_with_index do |n,i|
          next if i == 0 || i == 1
          table[n] = nil
        end
      end
      @table = table.compact[2..-1]
    end

    def first(n)
      lookup[0..n]
    end
  end
end

pp PrimeMemo.first(1000).last(3)
pp PrimeMemo.first(10)
pp PrimeMemo.first(100000).last(10)
pp PrimeMemo.first(10)
