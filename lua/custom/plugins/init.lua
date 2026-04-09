-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
	require("custom.plugins.ayu"),
	require("custom.plugins.scissors"),
	require("custom.plugins.sessions"),
	require("custom.plugins.markdown-preview"),

	-- Config
	require("custom.plugins.config"),
}
