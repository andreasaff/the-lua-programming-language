-- Beispiel 1: Operatorüberladung für Addition von Vektoren
local vec_add_mt = {}
vec_add_mt.__add = function(left, right)
  return setmetatable({
    left[1] + right[1],
    left[2] + right[2],
    left[3] + right[3],
  }, vec_add_mt)
end

local vc = setmetatable({1, 2, 4}, vec_add_mt)
local vd = setmetatable({2, 4, 3}, vec_add_mt)

local vr = vc + vd
print(vr[1], vr[2], vr[3]) -- Ausgabe: 3 6 7

-- Beispiel 2: Rekursive Fibonacci-Berechnung mit Caching
local fib_mt = {
  __index = function(self, key)
    if key <= 2 then return 1 end
    self[key] = self[key - 2] + self[key - 1]
    return self[key]
  end
}

local fib = setmetatable({}, fib_mt)

print(fib[5])   -- Ausgabe: 5
print(fib[100]) -- Ausgabe: 3736710778780434371