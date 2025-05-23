-- Funktion als Wert zuweisen (Bericht)
local f = function (x, y) return x + y end
print(f(2, 3)) -- prints 5

-- Anonyme Funktion (Lambda) direkt aufrufen (Bericht)
print((function(x, y) return x * y end)(3, 4)) -- prints 12

-- Closure, das eine Umgebung "einfängt" (Bericht)
function make_adder(x)
    return function(y)
      return x + y
    end
  end
  
local add5 = make_adder(5)
print(add5(10))  -- Ausgabe: 15