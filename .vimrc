set encoding=utf-8
set nocompatible

execute pathogen#infect()
syntax on  "Lets you see nice syntax highlighting

set runtimepath^=~/.vim/bundle/ctrlp.vim "Use ctrlp

set tabstop=4    "Makes the tab 4 columns
set shiftwidth=4  "controls how many columns text is indented with the reindent operations (<< and >>) and automatic C-style indentation
set softtabstop=4 "because expandtab is set, all tabs will be spaces instead of hard tabs.  there's a debate over which is better (just google soft tabs vs hard tabs), but rubenstein tech prefers soft tabs
set expandtab  "see above
set showmatch  "highlight matching braces, parantheses, etc

set hls " Highlight search options
set incsearch " Incremental search
set ic " Default to case-insensitive search
set smartcase " Allow case-sensitive search if there is one uppercase

set scrolloff=5  " There will always be 5 lines visible above cursor and 5 lines visible below cursor.  By default, scrolloff is 0

syntax enable   " allows you to override default syntax highlighting
set background=dark
colorscheme solarized

set cursorline " Highlight current line
hi CursorLine ctermbg=NONE cterm=underline "No color, just underline
set wildmode=longest,list " On tab filename complete, first tab produces longest. Second tab produces list.

set backspace=indent,eol,start " Allow backspacing over indent, eol, start
set laststatus=2 " Set status line as second-to-last line
set statusline=%F%m%r%w\ %=\ [%l,%c]\ \ \ %p%%

" Use 2 tab spaces in Ruby
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
" Use 2 tab spaces in SCSS
autocmd Filetype scss setlocal ts=2 sts=2 sw=2
autocmd Filetype css setlocal ts=2 sts=2 sw=2
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype json setlocal ts=2 sts=2 sw=2
" Use 2 tab spaces in Markdown
autocmd Filetype md setlocal ts=2 sts=2 sw=2
autocmd Filetype markdown setlocal ts=2 sts=2 sw=2

" Remap kj while in insert mode to ESC
inoremap kj <ESC>

" Improved up/down scrolling on wrapped lines
nnoremap j gj
nnoremap k gk

augroup AutoReloadVimRC
    au!
    " automatically reload vimrc when it's saved
    au BufWritePost $MYVIMRC so $MYVIMRC
augroup END

set autochdir " Automatically change current working directory to most recent file...comes in handy when using :e, :vsp, :Vex, :Ex commands
set number  "line numbers

hi Normal ctermbg=none

set smartindent


" Show tab characters, trailing whitespace
"set listchars=tab:>-,trail:~,extends:>,precedes:<
set list
" Instead, highlight trailing whitespace as syntax errors.
" Still mark off tab characters, since we want soft tabs.
match ErrorMsg '\s\+$'
set listchars=tab:>-,extends:>,precedes:<,nbsp:+



" Code from:
" http://stackoverflow.com/questions/5585129/pasting-code-into-terminal-window-into-vim-on-mac-os-x
" then https://coderwall.com/p/if9mda
" and then https://github.com/aaronjensen/vimfiles/blob/59a7019b1f2d08c70c28a41ef4e2612470ea0549/plugin/terminaltweaks.vim
" to fix the escape time problem with insert mode.
"
" Docs on bracketed paste mode:
" http://www.xfree86.org/current/ctlseqs.html
" Docs on mapping fast escape codes in vim
" http://vim.wikia.com/wiki/Mapping_fast_keycodes_in_terminal_Vim
if &term =~ "xterm.*" || &term =~ "screen*" || &term =~ "rxvt*"
function! WrapForTmux(s)
if !exists('$TMUX')
return a:s
endif
let tmux_start = "\<Esc>Ptmux;"
let tmux_end = "\<Esc>\\"
return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction
let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")
function! XTermPasteBegin(ret)
set pastetoggle=<f29>
set paste
return a:ret
endfunction
execute "set <f28>=\<Esc>[200~"
execute "set <f29>=\<Esc>[201~"
map <expr> <f28> XTermPasteBegin("i")
imap <expr> <f28> XTermPasteBegin("")
vmap <expr> <f28> XTermPasteBegin("c")
cmap <f28> <nop>
cmap <f29> <nop>
endif

au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

"au syntax javascript so /home/joe/.vim/syntax/javascript.vim
"au syntax javascript so /home/joe/.vim/syntax/jsx.vim
au BufNewFile,BufRead *.mas set ft=javascript
