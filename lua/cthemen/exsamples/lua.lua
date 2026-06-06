#!/usr/bin/env lua

--- Example Lua file for syntax highlighting
-- @license MIT

local M = {}

local insert = table.insert
local fmt = string.format

local APP_NAME = "example-lua"
local counter = 0

local EventEmitter = {}
EventEmitter.__index = EventEmitter

function EventEmitter.new()
	return setmetatable({ listeners = {} }, EventEmitter)
end

function EventEmitter:on(event, fn)
	if not self.listeners[event] then
		self.listeners[event] = {}
	end
	insert(self.listeners[event], fn)
	return self
end

function EventEmitter:emit(event, ...)
	local listeners = self.listeners[event]
	if listeners then
		for _, fn in ipairs(listeners) do
			fn(...)
		end
	end
end

local function debounce(fn, delay)
	delay = delay or 300
	local timer = nil
	return function(...)
		if timer then
			timer:cancel()
		end
		timer = vim.defer_fn(function()
			fn(...)
			timer = nil
		end, delay)
	end
end

local function fetch_data(url)
	local ok, result = pcall(function()
		local handle = io.popen("curl -s " .. url)
		local data = handle:read("*a")
		handle:close()
		return data
	end)
	if not ok then
		error("request failed: " .. tostring(result))
	end
	return result
end

local function compute(x, y)
	-- block comment
	--[[
		multi-line
		comment block
	]]
	local result = x ^ y + math.pi
	return math.floor(result)
end

local config = {
	host = "localhost",
	port = 3000,
	debug = false,
	rate = 0.95,
	tags = { "dev", "staging" },
	limits = { max = 100, min = 0 },
}

local function handle_request(method, path)
	counter = counter + 1

	if path == "/" then
		return 200, "<h1>hello world</h1>"
	elseif path == "/api" then
		return 200, fmt('{"ok": true, "count": %d}', counter)
	else
		return 404, "not found"
	end
end

-- single line comment
vim.keymap.set("n", "<M-j>", ":m .+1<CR>==")
local numbers = { 1, 2, 3, 4, 5 }
local doubled = vim.tbl_map(function(n)
	return n * 2
end, numbers)
local odds = vim.tbl_filter(function(n)
	return n % 2 ~= 0
end, numbers)

local sum = 0
for _, n in ipairs(numbers) do
	sum = sum + n
end

for i = 1, 5 do
	if i % 2 == 0 then
		print(fmt("even: %d", i))
	else
		print(fmt("odd: %d", i))
	end
end

local n = 42
local pi = 3.14159
local hex = 0xdeadbeef
local sci = 1.5e10
local huge = math.huge
local neg = -273
local flag = true
local empty = nil
local str = "hello world"
local str2 = "single quotes"
local mline = [[
line one
line two
line three
]]

local pattern = "^[A-Za-z0-9_-]+$"
local msg = fmt("hello %s, you have %d messages", "world", 5)

local ok, err = pcall(handle_request, "GET", "/api")
assert(ok, err)

M.EventEmitter = EventEmitter
M.debounce = debounce
M.fetch_data = fetch_data
M.compute = compute
M.config = config

return M
