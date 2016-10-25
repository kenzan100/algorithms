require 'pp'

class ListNode
  attr_accessor :val, :next
  def initialize(val)
    @val = val
    @next = nil
  end
end
class NullNode
  def val
    0
  end
  def next
    nil
  end
end

def add_two_recur(l1, l2, past_carry = 0)
  carry, new_val = (l1.val + l2.val + past_carry).divmod(10)
  new_node = ListNode.new(new_val)
  if [l1,l2].all?{ |ln| ln.next.nil? } && carry == 0
    return new_node
  end
  new_node.next = add_two((l1.next || NullNode.new),
                          (l2.next || NullNode.new), carry)
  new_node
end

def add_two(l1, l2)
  carry = 0
  past_sum_node = nil
  first_node = nil
  while l1&.next || l2&.next || carry > 0
    carry, sum = ((l1&.val || 0) + (l2&.val || 0) + carry).divmod(10)
    sum_node = ListNode.new(sum)
    first_node ||= sum_node
    if past_sum_node
      past_sum_node.next = sum_node
    end
    past_sum_node = sum_node
    l1 = l1&.next
    l2 = l2&.next
  end
  first_node
end

maker = -> (arr) { arr.map { |n| ListNode.new(n) } }
associator = -> (nodes) { nodes.each_with_index { |ln, i| ln.next = nodes[i+1] } }

nodes1 = maker.call [2,4,8]
associator.call nodes1
nodes2 = maker.call [5,6,4]
associator.call nodes2

pp add_two(nodes1.first, nodes2.first)
