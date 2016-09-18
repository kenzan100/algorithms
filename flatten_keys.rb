require "pp"

class Hash
  def flatten_keys
    arr_keys = recur([])
    arr_keys.reduce({}) do |h, (k,v)|
      key = k.join('_')
      key = key.to_sym if k.all? { |p_k| p_k.is_a? Symbol }
      h.merge( key => v )
    end
  end

  def recur(keys)
    self.reduce({}) do |hash, (k, v)|
      if !v.is_a?(Hash)
        hash.merge({ (keys + [k]) => v })
      else
        hash.merge(v.recur(keys + [k]))
      end
    end
  end
end

pp ({ id: 1, info: { name: "ex" } }.flatten_keys)
pp ({ a: 1, 'b' => 2, info: {id: 1, 'name' => 'example'}}).flatten_keys

pp ({
  a: { b: { c: 1 } },
  f: 2,
  g: { h: "h" }
}).flatten_keys
