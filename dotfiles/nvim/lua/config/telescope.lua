local wk = require "which-key"

wk.add({

  {
    mode = { "n" },

    { ";", "<cmd>Telescope command_history<cr><esc>", desc = "Command history" },

    { "<leader>ff", "<cmd>Telescope live_grep<cr><esc>",      desc = "Grep" },
    { "<leader>fe", "<cmd>Telescope find_files<cr><esc>",     desc = "Find files" },
    { "<leader>fm", "<cmd>Telescope man_pages<cr><esc>",      desc = "Find manpages" },
    { "<leader>fh", "<cmd>Telescope search_history<cr><esc>", desc = "Find in search history" },

    -- toggle settings
    { "<leader>.t",                                         desc = "Telescope" },
    { "<leader>.ts", "<cmd>Telescope colorscheme<cr><esc>", desc = "Colorscheme" }
  }

})
