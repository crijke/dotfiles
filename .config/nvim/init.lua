-- Neovim config, ported from ~/.vimrc
-- Plugins are managed by the built-in vim.pack (:h vim.pack).
-- Update plugins with :lua vim.pack.update()

vim.g.mapleader = ','
vim.g.loaded_netrw = 1 -- nvim-tree replaces netrw
vim.g.loaded_netrwPlugin = 1

---------------------------------------------------------------------------
-- Options (only those that differ from Neovim defaults)
---------------------------------------------------------------------------
local o = vim.opt

o.number = true
o.numberwidth = 5
o.modelines = 0
o.showmatch = true
o.scrolloff = 4
o.virtualedit = 'block'
o.autowrite = true
o.mouse = 'a'
o.clipboard = 'unnamedplus'
o.textwidth = 100
o.swapfile = false
o.signcolumn = 'yes'

-- whitespace
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true
o.list = true
o.listchars = { tab = '»·', trail = '·', nbsp = '·' }
o.fillchars = { eob = ' ' } -- hide ~ after end of buffer

-- search
o.gdefault = true
o.ignorecase = true
o.smartcase = true

-- wildmenu
o.wildmode = 'longest,full'
o.wildignore:append({
  '*.o', '*.out', '*.obj', '*.rbc', '*.rbo', '*.class', '*.gem', '*.so', '*.swp', '*~', '._*',
  '*.zip', '*.tar.gz', '*.tar.bz2', '*.tar.xz', '*.rar',
  '*/vendor/cache/*', '*/.bundle/*', '*/.sass-cache/*', '*/tmp/*',
})

vim.filetype.add({ extension = { ejs = 'html' } })

---------------------------------------------------------------------------
-- Plugins
---------------------------------------------------------------------------
local gh = function(repo) return 'https://github.com/' .. repo end

-- Rebuild treesitter parsers whenever nvim-treesitter is updated
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local d = ev.data
    if d.spec.name == 'nvim-treesitter' and d.kind ~= 'delete' then
      if not d.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end,
})

vim.pack.add({
  -- appearance
  gh('navarasu/onedark.nvim'),
  gh('nvim-lualine/lualine.nvim'),
  gh('nvim-tree/nvim-web-devicons'),

  -- navigation
  gh('ibhagwan/fzf-lua'),
  gh('nvim-tree/nvim-tree.lua'),

  -- git
  gh('tpope/vim-fugitive'),
  gh('lewis6991/gitsigns.nvim'),

  -- editing
  gh('echasnovski/mini.nvim'),
  gh('tpope/vim-surround'),
  gh('tpope/vim-repeat'),
  gh('tpope/vim-speeddating'),
  gh('windwp/nvim-ts-autotag'),

  -- syntax / LSP / completion
  { src = gh('nvim-treesitter/nvim-treesitter'), version = 'main' },
  gh('neovim/nvim-lspconfig'),
  gh('mason-org/mason.nvim'),
  gh('mason-org/mason-lspconfig.nvim'),
  { src = gh('saghen/blink.cmp'), version = vim.version.range('1.*') },
  gh('rafamadriz/friendly-snippets'),

  -- org
  gh('nvim-orgmode/orgmode'),
}, { confirm = false })

-- colorscheme
vim.o.background = 'dark'
require('onedark').setup {
    style = 'darker'
}
require('onedark').load()

-- statusline + buffer tabline (replaces airline)
require('lualine').setup({
  options = { section_separators = '', component_separators = '│' },
  tabline = { lualine_a = { 'buffers' } },
})

-- fuzzy finder (replaces ctrlp/selecta, gitgrep, buffergator)
require('fzf-lua').setup({})

-- file tree (replaces NERDTree)
require('nvim-tree').setup({
  hijack_netrw = true,
  sync_root_with_cwd = true,
  renderer = { root_folder_label = false },
  filters = { custom = { '\\.pyc$', '\\.rbc$' } },
})

require('gitsigns').setup({})

-- mini.nvim modules
require('mini.ai').setup({})        -- extra text objects
require('mini.pairs').setup({})     -- replaces auto-pairs
require('mini.bufremove').setup({}) -- replaces Kwbd
require('mini.move').setup({        -- replaces unimpaired [e / ]e bubbling
  mappings = {
    left = '', right = '', down = '<C-j>', up = '<C-k>',
    line_left = '', line_right = '', line_down = '<C-j>', line_up = '<C-k>',
  },
})

-- treesitter: highlighting + indentation (replaces language syntax plugins)
local ts_langs = {
  'bash', 'css', 'diff', 'git_config', 'gitcommit', 'html', 'javascript', 'json', 'jsdoc',
  'lua', 'markdown', 'markdown_inline', 'ruby', 'scss', 'tsx', 'typescript', 'vim', 'vimdoc',
  'yaml', 'embedded_template',
}
require('nvim-treesitter').install(ts_langs)
vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    if pcall(vim.treesitter.start, ev.buf) then
      vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
require('nvim-ts-autotag').setup({}) -- replaces ragtag tag closing

-- completion + snippets (replaces omnifunc + UltiSnips)
require('blink.cmp').setup({
  keymap = {
    preset = 'default',
    ['<C-j>'] = { 'snippet_forward', 'fallback' },
    ['<C-k>'] = { 'snippet_backward', 'fallback' },
  },
  signature = { enabled = true },
})

-- LSP (replaces syntastic). Servers are installed by mason and enabled automatically.
vim.lsp.config('lua_ls', {
  settings = { Lua = { diagnostics = { globals = { 'vim' } } } },
})
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'ts_ls', 'eslint', 'html', 'cssls', 'jsonls', 'yamlls', 'ruby_lsp', 'lua_ls',
  },
})

vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✗',
      [vim.diagnostic.severity.WARN] = '⚠',
    },
  },
})

require('orgmode').setup({
  org_agenda_files = '~/org/**/*',
  org_default_notes_file = '~/org/refile.org',
})

---------------------------------------------------------------------------
-- Keymaps
---------------------------------------------------------------------------
local map = vim.keymap.set

-- finding
map('n', '<C-p>', '<cmd>FzfLua files<CR>')
map('n', '<leader>ff', '<cmd>FzfLua live_grep<CR>')
map('n', '<space>', '<cmd>FzfLua buffers<CR>')
map('n', '<leader>rt', '<cmd>FzfLua lsp_document_symbols<CR>') -- was Tagbar

-- search and replace
map('n', '<leader>ss', ':%s/')
map('v', '<leader>ss', ':s/')
map('n', '<leader>sr', [[:%s/\<<C-r><C-w>\>/]])
map('n', '<leader>/', '<cmd>nohlsearch<CR>', { silent = true })

-- toggle quickfix / location list (replaces ListToggle)
local function toggle_list(kind)
  local open = kind == 'c' and vim.fn.getqflist({ winid = 0 }).winid
    or vim.fn.getloclist(0, { winid = 0 }).winid
  if open ~= 0 then
    vim.cmd(kind .. 'close')
  else
    pcall(vim.cmd, kind .. 'open')
  end
end
map('n', '<leader>l', function() toggle_list('l') end)
map('n', '<leader>c', function() toggle_list('c') end)

-- paste last yank (skipping deletions)
map('n', '<leader>p', '"0p')

-- git
map('n', '<leader>gb', '<cmd>Git blame<CR>')
map('n', '<leader>gr', '<cmd>Gread<CR>')
map('n', '<leader>gs', '<cmd>Git<CR>')
map('n', '<leader>gd', '<cmd>Gdiffsplit<CR>')
map('n', '<leader>gl', '<cmd>Git log<CR>')
map('n', '<leader>gc', '<cmd>Git commit<CR>')
map('n', '<leader>gp', '<cmd>Git push<CR>')
map('n', '<leader>st', '<cmd>silent !stree<CR>')

-- buffers and windows
map('n', '<leader>k', function() require('mini.bufremove').delete() end)
map('n', '<leader>w', '<C-w>w')
map('n', '<leader>q', '<cmd>close<CR>')
map('n', '<leader>=', '<C-w>=')

-- config
map('n', '<leader>ve', '<cmd>edit $MYVIMRC<CR>')
map('n', '<leader>vs', '<cmd>restart<CR>')

-- file tree
map('n', '<leader>n', '<cmd>NvimTreeToggle<CR>')

-- select all
map('n', '<leader>a', 'ggVG')

-- comments (built-in gc)
map('n', '\\', 'gcc', { remap = true })
map('v', '\\', 'gc', { remap = true })

-- disable F1
map({ 'n', 'i', 'v' }, '<F1>', '<nop>')

-- format file: LSP if available, otherwise reindent
map('n', '<leader>fo', function()
  if #vim.lsp.get_clients({ bufnr = 0, method = 'textDocument/formatting' }) > 0 then
    vim.lsp.buf.format()
  else
    vim.cmd('normal! gg=G``')
  end
end)

-- move by screen line
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- emacs style mappings in command line mode
map('c', '<C-a>', '<Home>')
map('c', '<C-e>', '<End>')

---------------------------------------------------------------------------
-- Autocommands
---------------------------------------------------------------------------
local group = vim.api.nvim_create_augroup('user', { clear = true })
local au = function(events, opts)
  opts.group = group
  vim.api.nvim_create_autocmd(events, opts)
end

-- remove trailing whitespace on save, keeping cursor and last search
au('BufWritePre', {
  callback = function()
    local view = vim.fn.winsaveview()
    local search = vim.fn.getreg('/')
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.setreg('/', search)
    vim.fn.winrestview(view)
  end,
})

-- resize splits when resizing window
au('VimResized', { command = 'wincmd =' })

-- save when losing focus
au('FocusLost', { command = 'silent! wall' })

-- only show cursorline in normal mode of active window
au({ 'WinLeave', 'InsertEnter' }, { command = 'set nocursorline' })
au({ 'WinEnter', 'InsertLeave', 'VimEnter' }, { command = 'set cursorline' })

-- colorcolumn only in insert mode
au('InsertEnter', { command = 'setlocal colorcolumn=+1' })
au('InsertLeave', { command = 'setlocal colorcolumn=0' })
