def two_sum_1(nums, target)
  nums.map.with_index{ |n, i| [n, i] }.combination(2).each do |pair|
    return pair.map { |p| p[1] } if pair.map{ |p| p[0] }.reduce(:+) == target
  end
end

def two_sum_2(nums, target)
  nums.length.times do |i|
    ((i+1)..(nums.length - 1)).each do |j|
      return [i,j] if [nums[i], nums[j]].reduce(:+) == target
    end
  end
  nil
end

def two_sum_3(nums, target)
  mem = {}
  nums.length.times do |i|
    mem[nums[i]] = i
  end
  nums.length.times do |i|
    complement = nums[i] - target
    if mem[complement] && mem[complement] != i
      return [mem[complement], i]
    end
  end
  nil
end

def two_sum(nums, target)
  mem = {}
  nums.length.times do |i|
    complement = target - nums[i]
    if mem[complement]
      return [mem[complement], i]
    end
    mem[nums[i]] = i
  end
  nil
end

p two_sum([2,7,11,15], 9)
p two_sum([0,4,3,0], 0)
