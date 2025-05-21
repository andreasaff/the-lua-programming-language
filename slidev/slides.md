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

Presentation by Andreas Affentranger & Rafael Uttinger

<div @click="$slidev.nav.next" class="mt-12 py-1" hover:bg="white op-10">
  Press Space for next page <carbon:arrow-right />
</div>

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

# The Language

- Portuguese for moon
- Designed by members of the _Tecgraf_ department @ Pontifical Catholic University of Rio de Janeiro
- Initial Release: 1993
- Latest Stable Release: v5.4.7 - June 2024
- Compiles to bytecode & runs on the lua interpreter
- Extremly lightweight (offical v5.4.7 tarball weights in at just 1.3MB!)
- Common fields of application: Game Development, Embedded Systems, Plugin Ecosystems

  <br>
  <br>

Read more about [Lua Docs](https://www.lua.org/home.html)

<!--
- Lua Interpreter in ca. 31K Lines C geschrieben
- Für Performance kriterische Anwendungen auch unabhängige LuaJIT Implementation
- Anwendungsbeispiele: Gamdevelopment - WoW Modding, Embedded Systems - Router, Plugin Ecosystems - Adobe Illustrator, NeoVim
-->

---
transition: slide-left
---

# Language Concepts
- Lua is dynamically typed
- Lua is Multi-Paradigm - procedural, object-oriented, functional and data-driven
- Lua uses "Mechanisms over Policies" 
- In Lua the only complex datatype is a table - everything is derived from there
- Lua is cool 😄

<!--
Mechanisms over Policies -> Wenig Keywords (nur 22) aus welchem wir Strukturen zusammenbauen können, anstelle von dedizierten Keywords.
-->

---
transition: slide-left
---
# Basics

Simple Literals
```lua 
local number = 5

local string = "hello world!"
local single = 'also a valid string'

local truth, lies = true, false

local table = {}

local emptiness = nil
```

Functions are first class citizen
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
# Table
In Lua <span v-mark.red="1">tables are the only complex datatype</span>. Array, Dictionary & Object all in one.

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
Stack (Object)
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
# Metatables & Metamethods
Metamethods override the default behaviour of tables.

```lua {monaco-run}{ editorOptions: { fontSize:11} }
va = {1, 2}
vb = {2, 4}
local vr = va + vb
```

Vector Addition 
```lua {monaco-run}{ editorOptions: { fontSize:11} }
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
---
transition: slide-left
---
Recursive Fibonacci calculation with caching
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
print(fib[100])
```

---
transition: slide-left
---
# Coroutines
Lua uses Coroutines as it's concurrency model.
Everything is executed on a single Hardware Thread. 

Coroutines can `yield` (voluntarily pause) there execution (non-preemptive multithreading), giving the illusion of true parallelism.

Coroutines can be in one of three states:
- suspended
- running
- dead


---
transition: slide-left
---
Coroutine Example
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
---
transition: slide-left
---
# Summary & Conclusion
- The "everything is a table" concept takes time to get used to, not intuitive from the beginning
- Solid language which deserves it's place
- Typical Usecase scenario rather niche, but in it's domain Lua is very strong

---
transition: slide-left
---
# Personal Conclusion Rafael
- Language is well-documented and actively maintained
- Easy to understand core concepts
- Established within its domain as lightweight extension language
- Might use it again for scripting purposes like add-ons or configs
- Limitations are minor and understandable given its use case and minimalist philosophy

---
transition: slide-left
---
# Personal Conclusion Andreas
- Practical language that's quite simple 
- Working with one data structure that represents everything is quite interesting
- Will definitely use it again (Neovim config)
- Maybe also tinker around with Lua during next AoC
- Lua manual gets you up and running quite fast (https://www.lua.org/manual/5.4/)

---
transition: slide-left
layout: center
class: text-center
---
# Thanks for joining us along the ride!

[GitHub](https://github.com/andreasaff/the-lua-programming-language)

<PoweredBySlidev mt-10 />

<style>
h1 {
  background-color: white;
  background-image: none;
}
</style>