if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

Plug 'nvim-lualine/lualine.nvim'

call plug#end()

