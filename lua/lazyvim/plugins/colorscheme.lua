return {
  "Mofiqul/vscode.nvim",
  opts = {
    transparent = false,
    italic_comments = true,
    disable_nvimtree_bg = true,
  },
  init = function()
    require("vscode").load()
  end,
}
