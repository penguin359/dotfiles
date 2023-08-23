" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2016 Apr 05
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/vundle/Vundle.vim
" vim +PluginInstall +qa
filetype off " Vundle requires nocompatible and filetype off before init
" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
set runtimepath+=~/.vim/vundle/Vundle.vim
call vundle#begin('~/.vim/vundle')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'increment.vim--Natter'
if v:version >= 720
  Plugin 'gnupg.vim'
endif
Plugin 'vcscommand.vim'
Plugin 'bufexplorer.zip'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-pathogen'
Plugin 'bjoernd/vim-syntax-simics'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'AnsiEsc.vim'
Plugin 'PProvost/vim-ps1'
"Plugin 'VimPdb'
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
Plugin 'neomake/neomake'
"Plugin 'vim-syntastic/syntastic'
Plugin 'rust-lang/rust.vim'
Plugin 'rust-lang/rls'
Plugin 'udalov/kotlin-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required

" Plugin settings:
"   Load Pathogen
execute pathogen#infect()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if exists("&undofile")
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  syntax on

  " Also switch on highlighting the last used search pattern.
  set hlsearch

  " I like highlighting strings inside C comments.
  let c_comment_strings=1
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif


" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
"packadd matchit

map _G :Idestart 
map _g :Ide 
map _p :Ide print <cword><CR>
map _b :exec 'Ide break ' .expand("%:t"). ':' .line(".")<CR>
map _u :exe 'Ide until ' .expand("%:t"). ':' .line(".")<CR>

"source ~/.vim/word_complete.vim

map _c :call DoWordComplete()<CR>
map _C :call EndWordComplete()<CR>

"source ~/.vim/ctx-1.17.vim

"source ~/.vim/tetris.vim
"source ~/.vim/taglist.vim

map <F8> :Tlist<CR>

let g:po_lang_team = 'Epsanol es@li.org'
let g:po_translator = 'Loren M. Lang <lorenl@alzatex.com>'

set mouse=a
set mousemodel=popup
set hidden
vnoremap <C-A> :Inc<CR>

map <F3> :SelectBuf<CR>
map <Leader>o :next <cWORD><CR>

"let g:netrw_uid = 'anonymous'
let b:nroff_is_groff = 1

set background=dark

if &term =~ "^xterm" || &term =~ "^screen" || &term =~ "^tmux" || &term =~ "^dtterm$"
        "let &t_SI = "\<Esc>]12;purple\x7"
        "let &t_EI = "\<Esc>]12;blue\x7"
	let &t_ts = "\<Esc>]0;"
	let &t_fs = "\<Esc>\\"
	set title
endif
if &term =~ "^xterm" || &term =~ "^screen" || &term =~ "^tmux"
	let &t_ti = "\<Esc>[?1049h"
	let &t_te = "\<Esc>[?1049l"
	let &t_Co = "256"
	colorscheme inkpot
	"colorscheme desert256
	"colorscheme desert
endif
if &term =~ "^xterm" || &term =~ "^tmux"
	highlight Comment cterm=italic
endif
if &term =~ "^screen" || &term =~ "^tmux"
	set ttymouse=xterm2
endif
if &term == "builtin_gui"
	colorscheme desert256
endif
if &term == "linux"
	" Reserve command-line for copying with GPM.
	set mouse=nvi
endif

set splitbelow
set splitright

let g:xml_syntax_folding = 1

"set timeout timeoutlen=3000 ttimeoutlen=100
set notimeout ttimeout ttimeoutlen=100

"set fileformats=unix,dos,mac
set fileencodings=ucs-bom,utf-8,default,cp1252

"if executable("cmd.exe")
"    map ,v :!cmd.exe /C start "" "%<.pdf"<CR><CR>
"elseif $OSTYPE =~ "darwin.*"
"    map ,v :!open '%<.pdf'<CR><CR>
"elseif executable("xterm")
"    map ,v :!xterm '%<.pdf'<CR><CR>
"endif

set modeline
au FocusGained * checktime

function! SwapMouse()
	if &mouse != ""
		set mouse=
	else
		set mouse=a
	endif
endfunction
map ,m :call SwapMouse()<CR>


"   GnuPG: (defaults commented out)
"let g:GPGExecutable = "gpg --trust-model always"
let g:GPGExecutable = "gpg2"
"let g:GPGUseAgent = 1
"let g:GPGPreferSymmetric = 0

let g:tmux_navigator_no_mappings=1
nnoremap <silent> <c-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <c-Up> :TmuxNavigateUp<cr>
nnoremap <silent> <c-Right> :TmuxNavigateRight<cr>
nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>


" Recommended defaults for Syntastic until manual is read
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"set list
"set listchars=tab:>-
