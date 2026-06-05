local function SessionExists()
  local f = io.open("./.nvim/sessions/default", "r")
  if f ~= nil then
    f:close()
    return true
  else
    return false
  end
end

if SessionExists() then
  pcall(function()
    vim.cmd("SessionsLoad")
  end)
end
