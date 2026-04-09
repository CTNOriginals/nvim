function SessionExists()
	local f = io.open("./.nvim/sessions/default", "r")
	if f ~= nil then
		return true
	else
		return false
	end
end
-- vim.cmd("echo '" .. FileExists() .. "'")

-- print("Default session: " .. tostring(SessionExists()))
if SessionExists() then
	vim.cmd("SessionsLoad")
end
