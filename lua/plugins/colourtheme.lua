return {
'Shatur/neovim-ayu',
lazy = false,
priority = 1000,
config = function()
	require('ayu').setup({
		mirage = false,
		terminal = false, -- false so terminal can manage it's own colours
		overrides = {
			LineNr = { fg = '#707070'},
			CursorLineNr = {fg = '#BDBDBD', bold = true}
		},


	})
	vim.cmd.colorscheme "ayu"
end,

}

