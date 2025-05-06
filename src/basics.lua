-- Code from the # Basics slide

-- Definitions & Types
local number = 5

local string = "hello world!"
local single = 'also a valid string'

local truth, lies = true, false

local table = {}

local emptiness = nil

-- Firstclass functions
function greet(name)
  print("Hello, " .. name .. "!")
end

local sayHello = greet
sayHello("Alice")