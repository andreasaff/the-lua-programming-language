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
