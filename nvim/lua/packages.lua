-- vim:foldmethod=marker

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
      config = function() vim.cmd[[
          augroup packer_compile
          au!
          autocmd BufWritePost packages.lua source <afile> | PackerCompile
          augroup END
      ]] end
    }

    -- {{{ Misc tpope plugins
    use 'tpope/vim-abolish'  -- Smart case handling for search and replace
    use 'tpope/vim-dispatch'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-obsession'
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use 'tpope/vim-unimpaired'
    use 'tpope/vim-rsi'
    -- use 'tpope/vim-sensible'  -- Included in polyglot
    -- use 'tpope/vim-sleuth'  -- Included in polyglot
    use 'tpope/vim-vinegar'

    use {
      'tpope/vim-commentary',
      config = function() vim.cmd[[
        nmap <Leader>; gc
        nmap <Leader>;; gcc
        nmap <Leader>;y yyPgccj
        nmap <Leader>;Y yypgcck
        vmap <Leader>; gc
        vmap <Leader>;Y yPgvgc'[
        vmap <Leader>;y yP`[v`]gc']j
      ]] end
    }
    -- }}}

    -- {{{ Misc editing
    use 'machakann/vim-highlightedyank'
    use 'tommcdo/vim-exchange'
    use {
      'tommcdo/vim-lion',
      setup = function() vim.cmd[[
        let g:lion_squeeze_spaces = 1
      ]] end
    }
    use 'wsdjeg/vim-fetch'
    -- }}}

    -- {{{ System
    use 'justinmk/vim-dirvish'
    -- }}}

    -- {{{ Git
    use { 'tpope/vim-fugitive',
      config = function() vim.cmd[[
        nmap <Leader>gg :Git<CR><C-w>H
        nmap <Leader>gc :Git commit -v<CR>
        nmap <Leader>gC :Git commit --amend -v<CR>
      ]] end
    }

    use {
      'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      },
      config = function()
        require('gitsigns').setup {
          on_attach = function(bufnr)
            local function map(mode, lhs, rhs, opts)
              opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
              vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
            end

            -- Navigation
            map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
            map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

            -- Actions
            map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
            map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
            map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
            map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
            map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
            map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
            map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
            map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
            map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
            map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
            map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
            map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
            map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')

            -- Text object
            map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
            map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
          end
        }
      end
    }

    use {
      'shumphrey/fugitive-gitlab.vim',
      requires = 'vim-fugitive',
      setup = function() vim.cmd[[
        let g:fugitive_gitlab_domains = ['https://gl.phiar.net']
      ]] end
    }

    use {
      'tpope/vim-rhubarb',
      requires = 'vim-fugitive'
    }
    -- }}}

    -- {{{ Appearance
    use {
      'folke/lsp-colors.nvim',
      opt = true,
      config = function() require'lsp-colors'.setup() end
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
    use {
      'feline-nvim/feline.nvim',
      config = function() require('feline').setup() end
    }
    -- }}}

    -- {{{ Text Objects
    use 'fvictorio/vim-textobj-backticks'
    use 'glts/vim-textobj-comment'
    use 'kana/vim-textobj-indent'
    use 'kana/vim-textobj-user'
    use 'PeterRincker/vim-argumentative'
    -- }}}

    -- {{{ Highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
          require'nvim-treesitter.configs'.setup {
            ensure_installed = "all",
            ignore_install = { "phpdoc" },
            highlight = {
              enable = true,
            },
            -- indent = {
            --   enable = true,
            -- },
            incremental_selection = {
              enable = true,
              keymaps = {
                init_selection = "gnn",
                node_incremental = "grn",
                scope_incremental = "grc",
                node_decremental = "grm",
              },
            },
          }
        end
    }

    use {
      'sheerun/vim-polyglot',
      setup = function()
        vim.cmd[[
          let g:polyglot_disabled = ['radiance']
        ]]
      end
    }
    -- }}}

    -- {{{ LSP
    use {
      'neovim/nvim-lspconfig',
      config = function()
        vim.cmd[[
          nnoremap <leader>A <cmd>ClangdSwitchSourceHeader<cr>
          nnoremap <leader>K <cmd>lua vim.lsp.buf.hover()<cr>
          nnoremap <leader>cr <cmd>lua vim.lsp.buf.rename()<CR>
          nnoremap <leader>cc <cmd>lua vim.lsp.buf.code_action()<CR>
          nnoremap <leader>cf <cmd>lua vim.lsp.buf.formatting()<CR>
          nnoremap <leader>e <cmd>lua vim.lsp.diagnostic.set_loclist()<cr>
          nnoremap [d <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
          nnoremap ]d <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
          inoremap <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
        ]]

        local lspconfig = require'lspconfig'
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        lspconfig.util.default_config = vim.tbl_extend(
          "force",
          lspconfig.util.default_config,
          {
            capabilities = capabilities
          }
        )
      end
    }

    use {
      'williamboman/nvim-lsp-installer',
      requires = { 'nvim-lspconfig', 'hrsh7th/cmp-nvim-lsp'},
      config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
        local lsp_installer = require("nvim-lsp-installer")

        -- Register a handler that will be called for all installed servers.
        -- Alternatively, you may also register handlers on specific server instances instead (see example below).
        lsp_installer.on_server_ready(function(server)
          local opts = {}
          opts.capabilities = capabilities

          if server.name == "clangd" then
            opts.cmd = { "clangd", "--background-index", "--completion-style=detailed", "--clang-tidy", "--cross-file-rename" }
          elseif server.name == "kotlin_language_server" then
            opts.capabilities = capabilities
            opts.settings = { kotlin = { compiler = { jvm = { target = "1.8" } } } }
          end
          server:setup(opts)
        end)
      end
    }

    use {
      "ray-x/lsp_signature.nvim",
      config = function() require "lsp_signature".setup() end
    }

    -- }}}

  -- {{{ Fuzzy Finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = function() vim.cmd[[
      nnoremap <leader>p <cmd>Telescope find_files<cr>
      nnoremap <leader>f <cmd>Telescope file_browser<cr>
      nnoremap <leader>r <cmd>Telescope oldfiles<cr>
      nnoremap <leader>q <cmd>Telescope quickfix<cr>
      nnoremap <leader>" <cmd>Telescope registers<cr>
      nnoremap <leader>/ <cmd>Telescope live_grep<cr>
      nnoremap <leader>* <cmd>Telescope grep_string<cr>
      nnoremap <leader>b <cmd>Telescope buffers<cr>
      nnoremap <leader>o <cmd>Telescope lsp_document_symbols<cr>
      nnoremap <leader>O <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
      nnoremap <leader>E <cmd>Telescope lsp_workspace_diagnostics<cr>
      nnoremap <leader>gd <cmd>Telescope lsp_definitions<cr>
      nnoremap <leader>gi <cmd>Telescope lsp_implementations<cr>
      nnoremap <leader>gr <cmd>Telescope lsp_references<cr>
      nnoremap <leader>ga <cmd>Telescope lsp_code_actions<cr>
    ]] end
  }
  -- }}}

  -- {{{ Autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip'
    },
    config = function()
      local cmp = require'cmp'
      local luasnip = require'luasnip'
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
            else
              fallback()
            end
          end, { "i", "s" }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
            else
              fallback()
            end
          end, { "i", "s" }),

        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end
  }
  -- }}}
  end,
  config = {
    compile_path = compile_path,
  }
})
