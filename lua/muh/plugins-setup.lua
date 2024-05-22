-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

return packer.startup(function(use)
  -- Useful extensions
  use("wbthomason/packer.nvim") -- packer
  use("nvim-lua/plenary.nvim") -- lua functions that many plugins use  
  use("nvim-tree/nvim-tree.lua") -- Tree navigation
  use("ellisonleao/gruvbox.nvim") -- colorscheme 
  use("christoomey/vim-tmux-navigator") -- tmux & split win navigator 
  use("szw/vim-maximizer") -- maximizes and restores current win
  use("tpope/vim-surround") -- ys, ds, cs 
  use("numToStr/Comment.nvim") -- commenting with gc
  use("kyazdani42/nvim-web-devicons") -- icons
  use("nvim-lualine/lualine.nvim") -- status line
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- fuzzy finding 
  use({ "nvim-telescope/telescope.nvim", brance = "0.1x"})
  -- autocompletion
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  -- snippets
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")
  
  -- managing & install lsp servers
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  
  -- configuring lsp servers
  use("neovim/nvim-lspconfig")
  use("hrsh7th/cmp-nvim-lsp")
  use({ "glepnir/lspsaga.nvim", brance = "main" })
  use("jose-elias-alvarez/typescript.nvim")
  use("onsails/lspkind.nvim")

  if packer_bootstrap then
    require("packer").sync()
  end
end)
