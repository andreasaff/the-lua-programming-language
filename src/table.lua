-- Array
-- 1. Beispiel: Array mit Konstruktor
local array = {"first", 2, false, function() print("Fourth!") end }
print("1-based indexes!:", array[1])
print("Fourth is:")
array[4]()

-- 2. Beispiel: Array mit 1000 Elementen (initiiert mit 0)
a = {}    -- new array
    for i=1, 1000 do
      a[i] = 0
    end

-- Dictionary
-- Beispiel: Mapping von Länder zu Städte
local capitals = {
    Germany = "Berlin",
    France = "Paris",
    Italy = "Rome"
  }
  
print("Capital of France is " .. capitals["France"])

-- Set
-- Beispiel: Mengen-Darstellung mit Tabelle
local fruits = {
    apple = true,
    banana = true,
    cherry = true
  }
  
  print("Is apple in the set?", fruits["apple"] ~= nil)   -- true
  print("Is orange in the set?", fruits["orange"] ~= nil) -- false

-- Map
local map = {
  literal_key = "a string",
  ["an expression"] = "also works"
}
print("literal_key :", map.literal_key)
print("an expression", map["an expression"])

-- Stack (an object)
Stack = {}

function Stack:init()
    local s = {}
    setmetatable(s, self)
    self.__index = self
    return s
end 

function Stack:push(v)
    table.insert(self, v)
end

function Stack:pop()
    return table.remove(self)
end

function Stack:top()
    return self[#self]
end

function Stack:isEmpty()
    return #self == 0
end

function Stack:size()
    return #self
end

function Stack:print()
    print(table.unpack(self))
end

s = Stack:init()
print("size:", s:size())
print("isEmpty", s:isEmpty())
s:print()
print("top:", s:top())

s:push(42)
s:push(77)
s:push(1)

print("size:", s:size())
print("isEmpty", s:isEmpty())
s:print()