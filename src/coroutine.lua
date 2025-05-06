-- Code from the # Coroutine slide
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