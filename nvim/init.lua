-- before plugin load --
require "config.base"
require "config.lazy"

-- plugin load --
require "config.mini"
require "config.git"
require "config.telescope"

-- after plugin load --
vim.schedule(function()
  require "config.mappings"
end)
