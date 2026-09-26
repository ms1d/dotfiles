return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	event = "VeryLazy",
	ft = "markdown",
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
		legacy_commands = false,
		workspaces = {
			{
				name = "ArchNotes",
                path = "/home/mahad/ArchNotes/",
			},
			{
				name = "uni-notes",
				path = "/home/mahad/uni-notes/"
			}
		}
	}
}
