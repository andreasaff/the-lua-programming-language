-- Simple object with method using 'self'
local Counter = {}
Counter.__index = Counter

function Counter:new()
  local instance = setmetatable({ count = 0 }, self)
  return instance
end

function Counter:increment()
  self.count = self.count + 1
end

function Counter:get()
  return self.count
end

-- Create object and use methods
local c = Counter:new()
c:increment()
c:increment()
print("Current count: " .. c:get())
