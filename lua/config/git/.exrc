"let s:cpo_save=&cpo
"set cpo&vim
"cnoremap <silent> <Plug>(TelescopeFuzzyCommandSearch) e "lua require('telescope.builtin').command_history { default_text = [=[" . escape(getcmdline(), '"') . "]=] }"
"inoremap <C-W> u
"inoremap <C-U> u
"nnoremap  <Cmd>nohlsearch|diffupdate|normal! 
"nmap  d
"vnoremap  x :lua
"nnoremap  x :.lua
"nnoremap   x <Cmd>source %
"omap <silent> % <Plug>(MatchitOperationForward)
"xmap <silent> % <Plug>(MatchitVisualForward)
"nmap <silent> % <Plug>(MatchitNormalForward)
"nnoremap & :&&
"nnoremap - <Cmd>Oil
"xnoremap <silent> <expr> @ mode() ==# 'V' ? ':normal! @'.getcharstr().'' : '@'
"nnoremap M-k <Cmd>cprev
"nnoremap M-j <Cmd>cnext
"xnoremap <silent> <expr> Q mode() ==# 'V' ? ':normal! @=reg_recorded()' : 'Q'
"nnoremap Y y$
"omap <silent> [% <Plug>(MatchitOperationMultiBackward)
"xmap <silent> [% <Plug>(MatchitVisualMultiBackward)
"nmap <silent> [% <Plug>(MatchitNormalMultiBackward)
"omap <silent> ]% <Plug>(MatchitOperationMultiForward)
"xmap <silent> ]% <Plug>(MatchitVisualMultiForward)
"nmap <silent> ]% <Plug>(MatchitNormalMultiForward)
"xmap a% <Plug>(MatchitVisualTextObject)
"omap <silent> g% <Plug>(MatchitOperationBackward)
"xmap <silent> g% <Plug>(MatchitVisualBackward)
"nmap <silent> g% <Plug>(MatchitNormalBackward)
"xmap <silent> <Plug>(MatchitVisualTextObject) <Plug>(MatchitVisualMultiBackward)o<Plug>(MatchitVisualMultiForward)
"onoremap <silent> <Plug>(MatchitOperationMultiForward) :call matchit#MultiMatch("W",  "o")
"onoremap <silent> <Plug>(MatchitOperationMultiBackward) :call matchit#MultiMatch("bW", "o")
"xnoremap <silent> <Plug>(MatchitVisualMultiForward) :call matchit#MultiMatch("W",  "n")m'gv``
"xnoremap <silent> <Plug>(MatchitVisualMultiBackward) :call matchit#MultiMatch("bW", "n")m'gv``
"nnoremap <silent> <Plug>(MatchitNormalMultiForward) :call matchit#MultiMatch("W",  "n")
"nnoremap <silent> <Plug>(MatchitNormalMultiBackward) :call matchit#MultiMatch("bW", "n")
"onoremap <silent> <Plug>(MatchitOperationBackward) :call matchit#Match_wrapper('',0,'o')
"onoremap <silent> <Plug>(MatchitOperationForward) :call matchit#Match_wrapper('',1,'o')
"xnoremap <silent> <Plug>(MatchitVisualBackward) :call matchit#Match_wrapper('',0,'v')m'gv``
"xnoremap <silent> <Plug>(MatchitVisualForward) :call matchit#Match_wrapper('',1,'v'):if col("''") != col("$") | exe ":normal! m'" | endifgv``
"nnoremap <silent> <Plug>(MatchitNormalBackward) :call matchit#Match_wrapper('',0,'n')
"nnoremap <silent> <Plug>(MatchitNormalForward) :call matchit#Match_wrapper('',1,'n')
"nnoremap <Plug>PlenaryTestFile :lua require('plenary.test_harness').test_file(vim.fn.expand("%:p"))
"nmap <C-W><C-D> d
"nnoremap <C-L> <Cmd>nohlsearch|diffupdate|normal! 
"inoremap  u
"inoremap  u
"let &cpo=s:cpo_save
"unlet s:cpo_save
"set autochdir
"set clipboard=unnamedplus
"set grepformat=%f:%l:%c:%m
"set grepprg=rg\ --vimgrep\ -uu\ 
"set noloadplugins
"set operatorfunc=v:lua.require'vim._comment'.operator
"set packpath=/home/linuxbrew/.linuxbrew/Cellar/neovim/0.10.2_1/share/nvim/runtime
"set runtimepath=~/.config/nvim,~/.local/share/nvim/lazy/lazy.nvim,~/.local/share/nvim/lazy/lazydev.nvim,~/.local/share/nvim/lazy/nvim-lspconfig,~/.local/share/nvim/lazy/mini.icons,~/.local/share/nvim/lazy/oil.nvim,~/.local/share/nvim/lazy/nvim-treesitter,~/.local/share/nvim/lazy/friendly-snippets,~/.local/share/nvim/lazy/blink.cmp,~/.local/share/nvim/lazy/mini.nvim,~/.local/share/nvim/lazy/telescope-fzf-native.nvim,~/.local/share/nvim/lazy/plenary.nvim,~/.local/share/nvim/lazy/telescope.nvim,~/.local/share/nvim/lazy/catppuccin,/home/linuxbrew/.linuxbrew/Cellar/neovim/0.10.2_1/share/nvim/runtime,/home/linuxbrew/.linuxbrew/Cellar/neovim/0.10.2_1/share/nvim/runtime/pack/dist/opt/matchit,/home/linuxbrew/.linuxbrew/Cellar/neovim/0.10.2_1/lib/nvim,~/.local/share/nvim/lazy/catppuccin/after,~/.config/nvim/after,~/.local/state/nvim/lazy/readme
"set shiftwidth=2
"set statusline=%{%(nvim_get_current_win()==#g:actual_curwin\ ||\ &laststatus==3)\ ?\ v:lua.MiniStatusline.active()\ :\ v:lua.MiniStatusline.inactive()%}
"set termguicolors
"set window=48
"" vim: set ft=vim :
