local http_server = require "http.server"
local http_headers = require "http.headers"

local server = http_server.listen {
  host = "localhost",
  port = 8080,
  onstream = function(_, stream)
    local req_headers = assert(stream:get_headers())
    local method = req_headers:get(":method")
    local path = req_headers:get(":path")

    if method == "POST" and path == "/run-lua" then
      local body = assert(stream:get_body_as_string())
      print("[INFO] Received code:\n" .. body)

      local output = {}
      local function capture_print(...)
        local args = {...}
        for i = 1, #args do args[i] = tostring(args[i]) end
        table.insert(output, table.concat(args, "\t"))
      end

      local original_print = print
      print = capture_print

      local chunk, err = load(body)

      if not chunk then
        table.insert(output, "Load error: " .. tostring(err))
      else
        local ok, fn_or_err = pcall(chunk)
        if not ok then
          table.insert(output, "Wrapper error: " .. tostring(fn_or_err))
        elseif type(fn_or_err) == "function" then
          local ok2, result = pcall(fn_or_err)
          if not ok2 then
            table.insert(output, "Runtime error: " .. tostring(result))
          elseif result ~= nil then
            table.insert(output, "Return: " .. tostring(result))
          end
        end
      end

      print = original_print
      local response = table.concat(output, "<br>")

      local res_headers = http_headers.new()
      res_headers:append(":status", "200")
      res_headers:append("access-control-allow-origin", "*")
      res_headers:append("content-type", "text/plain")
      res_headers:append("content-length", tostring(#response))

      assert(stream:write_headers(res_headers, false))
      assert(stream:write_body_from_string(response))
    else
      local res_headers = http_headers.new()
      res_headers:append(":status", "404")
      res_headers:append("access-control-allow-origin", "*")
      stream:write_headers(res_headers, true)
    end
  end
}

assert(server:listen())
print("[INFO] Lua HTTP server running at http://localhost:8080")
assert(server:loop())
