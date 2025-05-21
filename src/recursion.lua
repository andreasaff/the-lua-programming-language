-- 1. Beispiel: Rekursion mit tail call (Bericht)
function fac(n, acc)
    acc = acc or 1
    if n == 0 then
      return acc
    else
      return fac(n - 1, n * acc)
    end
  end
  
print(fac(5)) -- Ausgabe: 120

-- 2. Beispiel: Rekursion mit vererbten property lookups (Bericht)
function create_nested_lookup(level)
    if level == 0 then
      return { value = "default" }
    end
  
    local parent = create_nested_lookup(level - 1)
    local child = {}
    setmetatable(child, { __index = parent })
    return child
  end
  
local obj = create_nested_lookup(3)
print(obj.value)  -- Ausgabe: default