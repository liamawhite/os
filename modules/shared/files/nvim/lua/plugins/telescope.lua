return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = function()
			local builtin = require("telescope.builtin")
			return {
				{
					"<leader>ff",
					function()
						builtin.find_files()
					end,
					desc = "Find files in project",
				},
				{
					"<leader>fg",
					function()
						builtin.live_grep()
					end,
					desc = "Grep in project",
				},
                {
                    "<leader>fb",
                    function()
                        builtin.buffers()
                    end,
                    desc = "Find open buffers",
                },
			}
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
