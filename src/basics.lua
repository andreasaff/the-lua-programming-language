-- Definitionen & Typen (Slides)
local number = 5

local string = "hello world!"
local single = 'also a valid string'

local truth, lies = true, false

local table = {}

local emptiness = nil

-- Funktionen erster Klasse (Slides)
function greet(name)
  print("Hello, " .. name .. "!")
end

local sayHello = greet
sayHello("Alice")