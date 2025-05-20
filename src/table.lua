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