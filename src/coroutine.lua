-- Coroutine in Lua (Bericht)
-- Funktion, die von 1 bis n zählt und nach jedem Schritt pausiert 
function count_to_n(n)
  for i = 1, n do
    print("Counting: " .. i)
    coroutine.yield()  -- Pausiert die Coroutine nach jedem Schritt
  end
end

-- Eine neue Coroutine mit der Zählfunktion erzeugen
co = coroutine.create(function() count_to_n(3) end)

-- Die Coroutine schrittweise ausführen, bis sie abgeschlossen ist 
while coroutine.status(co) ~= "dead" do
  print("Resuming coroutine...")
  coroutine.resume(co)
end

print("Coroutine has finished.")

-- Clojure W02, Nr. 1 (Bericht)
-- a)
function filterEven(numbers)
  return coroutine.wrap(function()
    for _, n in ipairs(numbers) do
      if n % 2 == 0 then
        coroutine.yield(n)
      end
    end
  end)
end

for n in filterEven({1, 2, 3, 4, 5, 6}) do
  print(n) -- 1, 3, 5
end

-- b)
function filter(pred, collection)
  return coroutine.wrap(function()
    for _, item in ipairs(collection) do
      if pred(item) then
        coroutine.yield(item)
      end
    end
  end)
end

for n in filter(function(x) return x % 2 == 0 end, {1, 2, 3, 4, 5, 6}) do
  print(n) -- 2, 4, 6
end
