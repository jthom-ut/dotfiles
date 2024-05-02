-- Packer bootstrap
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Auto compile when there are changes in plugins.lua
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

-- Load plugins
require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Plugin list
  use 'nvim-lualine/lualine.nvim'
  use 'nvim-tree/nvim-web-devicons'
  use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end}
  use 'junegunn/fzf.vim'
  use 'nvim-lua/plenary.nvim'
  use 'yamatsum/nvim-nonicons'
  use 'neovim/nvim-lspconfig'
  use 'dense-analysis/ale'
  use 'github/copilot.vim'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'sheerun/vim-polyglot'
  use 'preservim/nerdtree'
  use 'Xuyuanp/nerdtree-git-plugin'
  use 'tyru/open-browser.vim'
  use 'tpope/vim-fugitive'
  use {'neoclide/coc.nvim', branch = 'release'}
  use 'ervandew/supertab'
  use 'jiangmiao/auto-pairs'
  use 'ryanoasis/vim-devicons'
  use 'tpope/vim-surround'
  use 'vim-scripts/ReplaceWithRegister'
  use {'dracula/vim', as = 'dracula'}
  use 'preservim/nerdcommenter'
  use 'tyru/open-browser-github.vim'

  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)
-- Basic options
vim.o.expandtab = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.autoread = true
vim.o.textwidth = 80
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.backspace = 'indent,eol,start'
vim.o.incsearch = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.updatetime = 300
vim.o.encoding = 'utf-8'
vim.cmd 'syntax enable'
vim.cmd 'filetype plugin indent on'

-- Set leader key
vim.g.mapleader = " "

-- NERDTree mappings
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', ',n', ':NERDTreeFind<CR>', {noremap = true, silent = true})
vim.g.NERDTreeWinSize = 60

vim.api.nvim_create_user_command(
  'Rg',
  function(opts)
    -- Construct the rg command with options
    local rg_command = string.format('rg --column --line-number --no-heading --color=always --smart-case --hidden --glob "!.git/*" %s', vim.fn.shellescape(opts.args))

    -- Call fzf.vim's grep function with rg_command
    vim.fn['fzf#vim#grep'](rg_command, 1, vim.fn['fzf#vim#with_preview'](), false)
  end,
  { nargs = '*', complete = 'file' }
)

-- FZF and related mappings
vim.api.nvim_set_keymap('n', '<c-p>', "fugitive#Head() != '' ? ':GFiles --cached --others --exclude-standard<CR>' : ':Files<CR>'", {expr = true, noremap = true})
vim.api.nvim_set_keymap('n', '<leader>s', ':Rg<space>', {noremap = true})

-- Custom insert mappings
vim.api.nvim_set_keymap('i', '"', '""<left>', {noremap = true})
vim.api.nvim_set_keymap('i', '\'', '\'\'<left>', {noremap = true})
vim.api.nvim_set_keymap('i', '(', '()<left>', {noremap = true})
vim.api.nvim_set_keymap('i', '[', '[]<left>', {noremap = true})
vim.api.nvim_set_keymap('i', '{', '{}<left>', {noremap = true})
vim.api.nvim_set_keymap('i', '{<CR>', '{<CR>}<ESC>O', {noremap = true})
vim.api.nvim_set_keymap('i', '{;<CR>', '{<CR>};<ESC>O', {noremap = true})

-- Custom command mappings
vim.api.nvim_set_keymap('n', '<leader>h', ':wincmd h<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>j', ':wincmd j<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>k', ':wincmd k<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>l', ':wincmd l<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>+', ':vertical resize +5<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>-', ':vertical resize -5<CR>', {silent = true})
vim.api.nvim_create_user_command("Cfpath", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
vim.api.nvim_create_user_command("Crpath", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
-- Copy to clipboard
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>Y', '"+yg_', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>yy', '"+yy', { noremap = true, silent = true })

-- Paste from clipboard
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>P', '"+P', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>p', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>P', '"+P', { noremap = true, silent = true })

-- Autocommands for handling various settings dynamically
vim.cmd [[
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
  augroup END
]]

-- Function to strip trailing whitespaces
vim.cmd [[
function! StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction
autocmd BufWritePre * :call StripTrailingWhitespaces()
]]

-- Lualine and Treesitter setup
require('lualine').setup {
  options = { theme = 'solarized_dark' }
}
require('nvim-treesitter.configs').setup {}

-- Additional mappings and settings can be added below
