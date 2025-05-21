---
# You can also start simply with 'default'
theme: default
# random image from a curated Unsplash collection by Anthony
# like them? see https://unsplash.com/collections/94734566/slidev
#background: https://cover.sli.dev
background: ./images/lua.jpg
# some information about your slides (markdown enabled)
title: Introduction to Lua
info: |
  ## Slidev Starter Template
  Presentation slides for developers.

  Learn more at [Sli.dev](https://sli.dev)
# apply unocss classes to the current slide
class: text-center
# https://sli.dev/features/drawing
drawings:
  persist: false
# slide transition: https://sli.dev/guide/animations.html#slide-transitions
transition: slide-left
# enable MDC Syntax: https://sli.dev/features/mdc
mdc: true
# open graph
# seoMeta:
#  ogImage: https://cover.sli.dev
---

# Lua

Präsentation von Andreas Affentranger & Rafael Uttinger

<div class="abs-br m-6 text-xl">
  <button @click="$slidev.nav.openInEditor()" title="Open in Editor" class="slidev-icon-btn">
    <carbon:edit />
  </button>
  <a href="https://github.com/slidevjs/slidev" target="_blank" class="slidev-icon-btn">
    <carbon:logo-github />
  </a>
</div>

<style>
h1 {
  background-color: white;
  background-image: none;
}
</style>

---
transition: slide-left
---

# Lua

- „Mond“ auf Portugiesisch
- Entwickelt vom _Tecgraf Institut_ der PUC-Rio
- Veröffentlicht im Jahr 1993
- Neueste stabile Version: v5.4.7 – Juni 2024
- Kompiliert in Bytecode und läuft auf dem Lua-Interpreter
- Extrem leichtgewichtig (offizieller Tarball der Version 5.4.7 wiegt nur 1,3 MB!)
- Häufige Anwendungsgebiete: 
  - industrielle Anwendungen (Lightroom)
  - eingebettete Systeme
  - Addons für Spiele (WoW, Roblox, etc.)
  <br>
  <br>

<!-- Mehr auf [Lua Docs](https://www.lua.org/home.html) -->

<!--
- Lua Interpreter in ca. 31K Lines C geschrieben
- Für Performance kriterische Anwendungen auch unabhängige LuaJIT Implementation
- Anwendungsbeispiele: Gamdevelopment - WoW Modding, Embedded Systems - Router, Plugin Ecosystems - Adobe Illustrator, NeoVim
-->

---
transition: slide-left
---

# Sprachkonzepte
- Lua ist dynamisch typisiert.
- Lua ist multiparadigmatisch – prozedural, objektorientiert, funktional & daten gesteuert.
- Lua verwendet „Mechanismen statt Richtlinien“.
- In Lua ist der einzige komplexe Datentyp eine Tabelle – alles wird von dort abgeleitet.

<!--
Mechanismen statt Richtlinien -> Wenig Keywords (nur 22) aus welchem wir Strukturen zusammenbauen können, anstelle von dedizierten Keywords.
-->

---
transition: slide-left
---
# Grundlagen

Einfache Literale
```lua 
local number = 5

local string = "hello world!"
local single = 'also a valid string'

local truth, lies = true, false

local table = {}

local emptiness = nil
```

Funktionen sind von erster Klasse
```lua {monaco-run}
function greet(name)
  print("Hello, " .. name .. "!")
end

local sayHello = greet
sayHello("Alice")
```

---
transition: slide-left
---
# Tabelle
In Lua sind <span v-mark.red="1">Tabellen die einzigen komplexen Datenstrukturen</span>. Array, Map, Objekt, etc. in einem.

Array
```lua {monaco-run}
local array = {"first", 2, false, function() print("Fourth!") end }
print("Oh-yeah 1-based indexes!:", array[1])
print("Fourth is:")
array[4]()
```

Map
```lua {monaco-run}
local map = {
  literal_key = "a string",
  ["an expression"] = "also works"
}
print("literal_key :", map.literal_key)
print("an expression", map["an expression"])
```

---
transition: slide-left
---
Stack (Objekt)
```lua {monaco-run}{ editorOptions: { fontSize:9} }
local function Stack()
    return {
        s = {},
        push = function(self, v)
            table.insert(self.s, v)
        end,
        pop = function(self)
            return table.remove(self.s)
        end,
        top = function(self)
            return self.s[#self.s]
        end,
        isEmpty = function(self)
            return #self.s == 0
        end,
        size = function(self)
            return #self.s
        end,
        print = function(self)
            print(table.unpack(self.s))
        end
    }
end

stack = Stack()
-- add some stack operations here

print("isEmpty", stack:isEmpty())
print("top:", stack:top())
print("size:", stack:size())
```

<!--
print("size:", stack:size())
print("isEmpty", stack:isEmpty())
stack:print()
print("top:", stack:top())

stack:push(42)
stack:push(77)
stack:push(1)

print("size:", stack:size())
print("isEmpty", stack:isEmpty())
stack:print()
-->
---
transition: slide-left
---
# Metatabellen & Metamethoden
Metamethoden überschrieben das Standardverhalten von Tabellen.

Beispiel einer Vektor-Addition:

```lua {monaco-run}{ editorOptions: { fontSize:11} }
va = {1, 2}
vb = {2, 4}
local vr = va + vb
```

```lua {monaco-run}{ editorOptions: { fontSize:10} }
local vec_add_mt = {}
vec_add_mt.__add = function(left, right)
  return setmetatable({
    left[1] + right[1],
    left[2] + right[2],
  }, vec_add_mt)
end

local vc = setmetatable({ 1, 2}, vec_add_mt)
local vd = setmetatable({ 2, 4}, vec_add_mt)

local vr = vc + vd
print(vr[1], vr[2])
```

<!--
- Metamethoden ermöglichen Operator-Overloading für Tabellen (__add), Default-Methode bei fehlendem Indexing (__index)
- erstes Beispiel: Addition zweier Vektoren mittels __add metamethode, metatabelle wird auf tabelle geschrieben
- So können zwei Tabellen als Vektoren interpretiert und mit + addiert werden.
-->

---
transition: slide-left
---
Rekursive Fibbonaci-Berechnung mit Caching
```lua {monaco-run}
local fib_mt = {
  __index = function(self, key)
    if key <= 2 then return 1 end
    -- calculate new fib values from already cached ones
    self[key] = self[key -2] + self[key - 1]
    -- return current fib
    return self[key]
  end
}

local fib = setmetatable({}, fib_mt)

print(fib[5])
print(fib[90])
```

<!--
- Metatabelle mit __index, um Werte zu cachen (Memoization).
- self[key] noch nicht gesetzt? -> __index
- Das Caching vermeidet exponentielle Rekursion und sorgt für schnelle Zugriffe.
- Höhere Zahlen können nicht zuverlässig ausgegeben werden, da Lua-Nummern als 64-Bit-Gleitkommazahlen (double) intern gespeichert werden.
- Ab ca. Index 92 überschreiten Fibonacci-Zahlen die maximale präzise Ganzzahldarstellung von Lua, was zu Rundungsfehlern führt.
-->

---
transition: slide-left
---
# Koroutinen
Lua verwendet Koroutinen für kooperative Nebenläufigkeit – nicht für echte Parallelität. Alle Ausführungen laufen auf einem einzigen Thread.

Koroutinen können ihre Ausführung freiwillig unterbrechen (`yield`), als Form von kooperativem Multitasking. Dadurch entsteht die Illusion von echter Parallelität, obwohl alles sequentiell auf einem Thread läuft.

Koroutinen haben drei verschiedene Zustände:
- suspended
- running
- dead

<!--
- Koroutinen = unterbrechbare Funktionen
- laufen auf einem Thread (keine echte Parallelität)
- kooperatives Multitasking via `yield`
- explizites Pausieren und Fortsetzen mit `resume`
- praktisch für z. B. Animationen, Parser, asynchrone Abläufe
- Zustände:
  - suspended: pausiert oder bereit
  - running: aktiv (nur eine gleichzeitig)
  - dead: beendet, nicht wieder aufnehmbar
-->

---
transition: slide-left
---
Beispiel einer Koroutine
```lua {monaco-run} 
co = coroutine.create(function ()
  for i=1,2 do 
    print("co value", i)
    coroutine.yield()
  end
end)

print(co)
print(coroutine.status(co))
coroutine.resume(co)
print("123 from the main thread")
coroutine.resume(co)
coroutine.status(co)
```

<!--
- `coroutine.create` erzeugt eine neue Koroutine im Zustand "suspended"
- `coroutine.resume` startet oder setzt die Koroutine fort
- `coroutine.yield` unterbricht die Ausführung freiwillig
- Kontrolle wechselt zurück zum Hauptprogramm
- Beispiel zeigt wechselseitigen Ablauf zwischen Koroutine und Hauptthread
- `coroutine.status` zeigt aktuellen Zustand: "suspended", "running", "dead"
-->

---
transition: slide-left
---
# Zusammenfassung & Fazit
- Das Konzept „Alles ist eine Tabelle“ ist anfangs wenig intuitiv und braucht etwas Zeit, bis man es verinnerlicht.
- Lua ist eine solide, schlanke Sprache, die ihren Platz in ihrer Domäne verdient.
- Auch wenn die Anwedungsfälle rar sind, ist Lua in seinem Einsatzbereich sehr weit ausgebreitet (meist benutzte Skriptsprache in eingebetteten Systemen)

---
transition: slide-left
---
# Persönliches Fazit Rafael
- Die Sprache ist gut dokumentiert und wird aktiv gepflegt
- Die zentralen Konzepte sind leicht verständlich
- In ihrem Anwendungsbereich als schlanke Erweiterungssprache etabliert
- Erste Wahl für Scripting-Zwecke wie Add-ons oder Konfigurationen

---
transition: slide-left
---
# Persönliches Fazit Andreas
- Praktische Sprache mit einer recht einfachen Syntax
- Mit nur einer Datenstruktur zu arbeiten, die alles repräsentiert, ist durchaus interessant
- Werde sie definitiv wieder verwenden (z. B. für die Neovim-Konfiguration)
- Vielleicht probiere ich Lua auch beim nächsten Advent of Code aus
- Das Lua-Handbuch bringt einen schnell zum Laufen: https://www.lua.org/manual/5.4/

---
transition: slide-left
layout: center
class: text-center
---
# Danke fürs Dabeisein! :)

[GitHub](https://github.com/andreasaff/the-lua-programming-language)

<PoweredBySlidev mt-10 />

<style>
h1 {
  background-color: white;
  background-image: none;
}
</style>