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
				name = "uni-notes",
				path = "/home/mahad/uni-notes/"
			}
		}
	}
}
