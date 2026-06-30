require("render-markdown").setup({})

-- Inline image rendering via the kitty graphics protocol (Ghostty supports it).
-- The `magick` luarock is propagated by the nixpkgs image.nvim package, so the
-- default magick_rock processor works without extra setup.
require("image").setup({
	backend = "kitty",
	processor = "magick_rock",
	integrations = {
		markdown = {
			enabled = true,
			only_render_image_at_cursor = false,
			filetypes = { "markdown" },
		},
	},
	-- We live inside tmux (allow-passthrough is on); only draw in the active
	-- window to avoid stray images bleeding across panes/windows.
	tmux_show_only_in_active_window = true,
})

-- Render fenced ```mermaid blocks to images via mmdc (mermaid-cli) and hand the
-- result to image.nvim. Theme tuned to approximate Catppuccin Mocha.
require("diagram").setup({
	integrations = {
		require("diagram.integrations.markdown"),
	},
	renderer_options = {
		mermaid = {
			theme = "dark",
			background = "#1e1e2e", -- catppuccin mocha base
			scale = 3, -- higher scale = crisper diagrams on hidpi
		},
	},
})
