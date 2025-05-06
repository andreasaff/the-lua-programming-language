-- Code from the # Table slides
-- Array
local array = {"first", 2, false, function() print("Fourth!") end }
print("Oh-yeah 1-based indexes!:", array[1])
print("Fourth is:", array[4]())

-- Map
local map = {
  literal_key = "a string",
  ["an expression"] = "also works"
}
print("literal_key :", map.literal_key)
print("an expression", map["an expression"])

-- Stack (a object)
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