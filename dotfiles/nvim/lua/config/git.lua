local wk = require "which-key"


-- vgit
--
local vgit = require "vgit"
vgit.setup()

-- global mappings
wk.add({
  {
    mode  = { "n" },

    { "<leader>tc", vgit.project_diff_preview, desc = "Commit" },

    -- toggle settings
    { "<leader>.g",                               desc = "Vgit" },
    { "<leader>.gd", vgit.toggle_diff_preference, desc = "Switch between 'split' and 'unified' diff" },
    { "<leader>.gg", vgit.toggle_live_gutter,     desc = "Toggle git gutter signs" },
    { "<leader>.gb", vgit.toggle_live_blame,      desc = "Toggle live git blame" },
  },

})
