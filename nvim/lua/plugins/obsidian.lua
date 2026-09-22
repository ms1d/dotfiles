return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
		workspaces = {
			{
				name = "ArchNotes",
                path = "/home/mahad/ArchNotes/",
			},
			{
				name = "UniNotes",
				path = "/home/mahad/UniNotes/"
			}
		}
	}
}
