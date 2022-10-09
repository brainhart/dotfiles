-- Packer installation
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd [[
augroup Packer
  autocmd!
  autocmd BufWritePost plugins.lua PackerCompile
augroup end
]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'christoomey/vim-tmux-navigator'
  use 'bronson/vim-trailing-whitespace'
  use 'Yggdroot/indentLine'
  use 'EdenEast/nightfox.nvim'

	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
		config = function() require('configs.lualine') end,
	}

	use {
			'nvim-treesitter/nvim-treesitter',
			run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
			config = function() require('configs.treesitter') end,
	}

	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', -- optional, for file icons
		},
		tag = 'nightly' -- optional, updated every week. (see issue #1193)
	}

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		requires = { {'nvim-lua/plenary.nvim'} }
		config = function() require('configs.telescope') end,
	}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end

end)
