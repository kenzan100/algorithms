require "pp"

class PlainClass
  include Enumerable

  def each
    yield "hoge"
  end
end

class MyArray
  include Enumerable
  def initialize(a, b)
    @arr = [a, b]
  end

  def each
    for i in @arr
      yield i
    end
  end
end

pp MyArray.new(1,3).map.to_a
