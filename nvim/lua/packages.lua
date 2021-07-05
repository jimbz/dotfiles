local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local compile_path = fn.stdpath('config')..'/plugin/packer_compiled.vim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

return require'packer'.startup({
  function(use)
    use {
      'wbthomason/packer.nvim',
      config = function()
        vim.cmd[[
          augroup packer_compile
          au!
          autocmd BufWritePost packages.lua PackerCompile
          augroup END
        ]]
      end
    }

    -- ASCII editing helpers
    use {
      'jbyuki/nabla.nvim',  -- Equations
      config = function()
        vim.cmd[[nnoremap <leader>$ :lua require("nabla").action()<cr>]]
      end
    }

    use {
      'jbyuki/venn.nvim',  -- Diagrams
    }

    -- Color Schemes
    use {
      'tjdevries/gruvbuddy.nvim',
      requires = 'tjdevries/colorbuddy.vim',
      config = function()
        -- require('colorbuddy').colorscheme('gruvbuddy')
      end
    }

    use {
      'bluz71/vim-moonfly-colors',
      config = function()
        vim.cmd[[colorscheme moonfly]]
      end
    }
    use {
      'bluz71/vim-nightfly-guicolors',
      config = function()
        -- vim.cmd[[colorscheme nightfly]]
      end
    }
    use {
      'sainnhe/sonokai',
      config = function()
        -- vim.cmd[[colorscheme sonokai]]
      end
    }
  end,
  config = {
    compile_path = compile_path,
  }
})
