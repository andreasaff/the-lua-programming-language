## Geschichte

Lua portugiesisch für Mond ist eine dynamisch typisierte Skriptsprache, welche 1993 an der Pontifical Catholic University of Rio de Janeiro veröffentlicht und seither kontinuierlich weiterentwicklet wurde. Aktuell rangiert Lua auf Platz 33 des TIOBE Index. Bekannt wurde die Sprache für ihre extensibility und portability.

## Konzepte & Paradigmen

Lua Source Code wird mittels dem `luac` Compiler in Bytecode kompiliert und durch den `lua` Interpreter interpretiert. Für Applikationen mit erhöhtem Perfomance Bedarf existiert ein unabhängiger LuaJIT Compiler.

Lua ist eine Multiparadigmen Sprache, welche sowohl Konzepte aus der prozeduralen, der imperativen, objektorientierten als auch funktionalen Welt vereinigt.

Leichtgewichtigkeit, Embedding & Anwendungsbereich
Lua ist extrem leichtegewichtigt. So gibt es in Lua 5.4 gibt es insgesamt nur 20 reservierte Keywords.

```lua
and	break	do	else	elseif	end
false	for	goto 	if	in	local
nil	not	repeat	or	return	then
true	until	while	function
```

Die Philosophie der Sprache besagt dabei, dass nur elementare Bausteine als Keywords angeboten werden sollen. Komplexere Konstrukte können aus diesen Bausteinen kombinatorisch erzeugt werden. Die Leichtgewichtigkeit zeigt sich auch im Source Code von Lua. Insgesamt besteht dieser aus rund 31’000 Linien C. Der gesamte Lua 5.4.7 tarball wiegt unkomprimiert 1.3 MB.  
Lua ist eine embedded Sprache sie verfügt über eine gut dokumentierte C API, integriert aber auch mit C++, Java C# und vielen weiteren Sprachen. All dies macht Lua zu perfekten Sprache für die Einbettung und Erweiterung von bestehender Software.
Einige bekannte Applikationen, welche Lua für ihr Plugin-Management integrieren sind:

- Adobe Light Room
- World of Warcraft (Game Mods)
- Neovim

## Luarocks – Package Manager

`luarocks` ist der Paketmanger von Lua. Analog zu Paketmanager wie `pip` oder `npm` erlaubt er die Installation von Lua Modulen (auch rocks genannt) dritter. Ein zentraler Index für rocks findet sich unter: https://luarocks.org/

## Datenstrukturen

Lua kennt eine einzige komplexe Datenstruktur, die Tabelle. Ein Tabelle kann in ihrem Verhalten verschiede weitere Datenstrukturen wie zum Beispiel eine Liste, ein Map ein Set, aber auch Objekte verkörpern. Anbei ein Lua Tabelle als Liste

```lua
local array = {“apple”,”banana”, 4}
print(“Oh-yeah 1-based indexes!:” , array[1])
print(array[3])
```

Oder als Set

```lua
-- Create a set
local set = { "apple", "banana", "orange" }

-- Convert to set semantics
local function to_set(t)
  local s = {}
  for _, v in ipairs(t) do
    s[v] = true
  end
  return s
end

local fruits = to_set(set)

-- Membership test
print(fruits["banana"])  -- true
print(fruits["grape"])   -- nil (false)

-- Add element
fruits["grape"] = true

-- Remove element
fruits["apple"] = nil
```

## Objekorientierte Komponenten

Lua unterstützt Objektorientierte Konzepte. Wie wir es auch von Objekten in Sprachen wie Java kennen, haben Tabellen in Lua ein State und können mit `self` Bezug auf sich selber nehmen.

```
TODO: Example
```

## Funktionale Komponenten

In Lua sind Funktionen first-class values, dass heisst sie können in Variablen gespeichert, als Argumente mitgegeben oder als Rückgabewert zurückgegeben werden. Dies erlaubt die Konstruktion von Funktionen höherer Ordnung.

```lua
local f = function (x, y) return x + y end
print(f(2, 3))
-- prints 5
```

Ebenso unterstützt Lua die Verwendung von Lambas:

```lua
print((function(x, y) return x * y end)(3, 4))
-- prints 12
```

Closures erlauben das “einfangen” von Werten aus der Umgebung:

```lua
function make_adder(x)
	return  function(y)
		return x + y
	end
end

add5 = make_adder(5)
print(add5(10))
-- prints 15
```

## Rekursion & Tailrekursion

Rekursion kann in Lua sowohl im Kontext von Funktionen, als auch innerhalb von Metatabellen verwendet werden. TODO EXAMPLE
Tailrekursion wird ohne Zuhilfenahme von Keywords erkannt & führt zu einer Optimierung des Call-Stacks

```lua
function fact(n, acc)
	if n == 0 then
		return acc
	else
		return fact(n -1 * acc)
	end
end

print(fact(5, 1))
-- outputs 120
```

## Nebenläufigkeit

Lua Code wird auf einem einzelnen Thread ausgeführt. Parallele Ausführung auf mehreren Threads wird nicht unterstützt. Allerdings kennt Lua das Konzept von Coroutinen. Coroutinen sind Funktionen, welche in einem speziellen Kontext ausgeführt werden. Sie sind non-preemtive, können also nicht von aussen durch den Scheduler unterbrochen werden. Coroutinen können jedoch an geeigneten Stellen ihren aktuellen Status speichern & die Ausführung unterbrechen, um einer anderen Coroutine die Möglichkeit zu geben ihre Brechnungen weiterzuführen. Durch dieses Wechselspiel zwischen Coroutinen entsteht der Anschein echter Parallelität.

```lua
function count_to_n(n)
  for i = 1, n do
    print("Counting: " .. i)
    coroutine.yield()  -- pause execution here
  end
end

-- Create a coroutine
co = coroutine.create(function() count_to_n(3) end)

-- Resume the coroutine in steps
while coroutine.status(co) ~= "dead" do
  print("Resuming coroutine...")
  coroutine.resume(co)
end

print("Coroutine has finished.")
-- ouput
-- Resuming coroutine...
-- Counting: 1
-- Resuming coroutine...
-- Counting: 2
-- Resuming coroutine...
-- Counting: 3
-- Coroutine has finished.
```
