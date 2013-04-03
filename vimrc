" Modeline and Notes {
"  vim: set sw=4 ts=4 sts=4 tw=78 :
"" foldmarker={,} foldlevel=1 foldmethod=marker:
"
"                       .ed'''' '''$$$$be.                     
"                     -'           ^''**$$$e.                  
"                   .'                   '$$$c                 
"                  /                      '4$$b                
"                 d  3                     $$$$                
"                 $  *                   .$$$$$$               
"                .$  ^c           $$$$$e$$$$$$$$.              
"                d$L  4.         4$$$$$$$$$$$$$$b              
"                $$$$b ^ceeeee.  4$$ECL.F*$$$$$$$              
"    e$''=.      $$$$P d$$$$F $ $$$$$$$$$- $$$$$$              
"   z$$b. ^c     3$$$F '$$$$b   $'$$$$$$$  $$$$*'      .=''$c  
"  4$$$$L   \     $$P'  '$$b   .$ $$$$$...e$$        .=  e$$$. 
"  ^*$$$$$c  %..   *c    ..    $$ 3$$$$$$$$$$eF     zP  d$$$$$ 
"    '**$$$ec   '\   %ce''    $$$  $$$$$$$$$$*    .r' =$$$$P'' 
"          '*$b.  'c  *$e.    *** d$$$$$'L$$    .d'  e$$***'   
"            ^*$$c ^$c $$$      4J$$$$$% $$$ .e*'.eeP'         
"               '$$$$$$''$=e....$*$$**$cz$$' '..d$*'           
"                 '*$$$  *=%4.$ L L$ P3$$$F $$$P'              
"                    '$   '%*ebJLzb$e$$$$$b $P'                
"                      %..      4$$$$$$$$$$ '                  
"                       $$$e   z$$$$$$$$$$%                    
"                        '*$c  '$$$$$$$P'                      
"                         .'''*$$$$$$$$bc                      
"                      .-'    .$***$$$'''*e.                   
"                   .-'    .e$'     '*$c  ^*b.                 
"            .=*''''    .e$*'          '*bc  '*$e..            
"          .$'        .z*'               ^*$e.   '*****e.      
"          $$ee$c   .d'                     '*$.        3.     
"          ^*$E')$..$'                         *   .ee==d%     
"             $.d$$$*                           *  J$$$e*      
"              '''''                             '$$$'   
" 
" }

" Stuff to checkout
" rainbow parenthesis

"Experimential
" Fix indenting of html files
autocmd FileType html setlocal indentkeys-=*<Return>

" Environment {

    " Basics {
        set nocompatible        " Must be first line
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if has('win32') || has('win64')
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }

    " Setup Bundle Support {
        " The next three lines ensure that the ~/.vim/bundle/ system works
        filetype on
        filetype off
        set rtp+=~/.vim/bundle/vundle
        call vundle#rc()
    " }

" }

" Bundles {

    " Use bundles config {
        if filereadable(expand("~/.vimrc.bundles"))
            source ~/.vimrc.bundles
        endif
    " }

" }

" General {

    "Setup Shell {
        " custom shell options
        set shell=/usr/local/bin/bash\ --rcfile\ ~/.pirate-vim/vim-bashrc\ -i
    " }


    set background=dark         " Assume a dark background
    if !has('gui')
        "set term=$TERM          " Make arrow and other keys work
    endif
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8

    if has("autocmd")
		" Source the vimrc file after saving it
		autocmd bufwritepost .vimrc source $MYVIMRC
		autocmd bufwritepost vimrc sourc $MYVIMRC
		au BufReadPost quickfix setlocal modifiable
		" Map ✠ (U+2720) to <Esc> as <S-CR> is mapped to ✠ in iTerm2.
		autocmd CmdwinEnter * map <buffer> ☠ <CR>q:
		au BufReadPost quickfix :noremap <buffer> ☠ :execute 'cc '.line(".") <Bar> cclose <Bar> copen<CR>
		au BufReadPost quickfix :noremap <buffer> <S-CR> :execute 'cc '.line(".") <Bar> cclose <Bar> copen<CR>
		autocmd CmdwinEnter * map <buffer> <S-CR> <CR>q:
    endif

    if has ('x') && has ('gui') " On Linux use + register for copy-paste
        set clipboard=unnamedplus
    elseif has ('gui')          " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif

    " Most prefer to automatically switch to the current file directory when
    " a new buffer is opened; to prevent this behavior, add the following to
    " your .vimrc.bundles.local file:
    "   let g:spf13_no_autochdir = 1
    "if !exists('g:spf13_no_autochdir')
    "    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
    "    " Always switch to the current file directory
    "endif

    "set autowrite                       " Automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    "set virtualedit=block
    set history=1000                    " Store a ton of history (default is 20)
    "set spell                           " Spell checking on
    set hidden                          " Allow buffer switching without saving

    " Setup Paths{
        set path=~/workrepos/vito-funtime/**/src/**
        set path+=~/workrepos/farmville2-main/Client/**/src/**
        set path+=~/workrepos/farmville2-main/shared/**
        set path+=~/workrepos/farm-mobile/**
    " }
    " Setting up the directories {
        set backup                  " Backups are nice ...
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif

        " To disable views add the following to your .vimrc.bundles.local file:
        "  let g:spf13_no_views = 1
        if !exists('g:spf13_no_views')
            " Add exclusions to mkview and loadview
            " eg: *.*, svn-commit.tmp
            let g:skipview_files = [
                \ '\[example pattern\]'
                \ ]
        endif
    " }

" }

" Custom Functions {
    " TODO: automatically open quickfix window cscope, make etc, vimgrep
    " TODO: also shift enter in full command mode would be cool
    " TODO: get make functionality for c# unity project
    " TODO: install pyclewn and get functionality working
    " TODO: command line tab should complete and control space should list
	" TODO: get vim hearders searchable via tags
	" TODO: <F5> needs to force refresh tags and cscope
	" TODO: Fugitve doesn't do it's thing
	
	command! -nargs=1 -complete=command -bang Cdo call ArgPopAndRestore( ListFileNames( 'quickfix' ), <f-args> )
	command! -nargs=1 -complete=command -bang Ldo exe ArgPopAndRestore( ListFileNames( 'loclist' ), <f-args> )
	"function! WrapList( listName, 

	function! ArgPopAndRestore( exelist, execommand )
		let current_arglist = argv()
		exe 'args ' . a:exelist . '| argdo! ' . a:execommand
		exe 'args ' . join(current_arglist)
	endfunc

	function! ListFileNames( listName )
	  " Building a hash ensures we get each buffer only once
	  let buffer_numbers = {}
	  if a:listName == 'quickfix' 
		  for quickfix_item in getqflist()
			let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
		  endfor
	  elseif a:listName == 'loclist'
		  for loclist_item in getloclist()
			let buffer_numbers[loclist_item['bufnr']] = bufname(loclist_item['bufnr'])
		  endfor
	  endif
	  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
	endfunction

	command! -nargs=0 -bar RefreshTags execute RefreshTagsInGitHooks()
	function! RefreshTagsInGitHooks()
		if filereadable(".git/hooks/ctags")
			:!.git/hooks/ctags
		else 
			echo "Failed to find tag generator"
		endif
	endfunction

	function! GetBufferList()
		redir =>buflist
		silent! ls
		redir END
		return buflist
	endfunction

	" TODO: if in COMMIT_EDITMSG should you save quit on toggle? or ZZ?
	function! ToggleBuffer(bufname, pfx)
		let buflist = GetBufferList()
		"let pat = '"'.a:bufname.'"' | echo filter(split('abc keep also def'), 'pat =~ v:val' )
		for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ a:bufname'), 'str2nr(matchstr(v:val, "\\d\\+"))')
			if bufwinnr(bufnum) != -1
				exec('bd '.bufnum)
				return
			endif
		endfor
		" Test Prefix and open your buffer here
		if a:pfx == 'g'
			:Gstatus
			return
		endif
	endfunction

	function! ToggleList(bufname, pfx)
		let buflist = GetBufferList()
		for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
			if bufwinnr(bufnum) != -1
				exec(a:pfx.'close')
				return
			endif
		endfor
		if a:pfx == 'l' && len(getloclist(0)) == 0
			echohl ErrorMsg
			echo "Location List is Empty."
			return
		endif
		let winnr = winnr()
		exec(a:pfx.'open')
		if winnr() != winnr
			wincmd p
		endif
	endfunction

    " Search for selected text, forwards or backwards.
    vnoremap <silent> * :<C-U>
                \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
                \gvy/<C-R><C-R>=substitute(
                \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
                \gV:call setreg('"', old_reg, old_regtype)<CR>
    vnoremap silent> # :<C-U>
                \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
                \gvy?<C-R><C-R>=substitute(
                \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
                \gV:call setreg('"', old_reg, old_regtype)<CR>

    function! NumberToggle()
        if(&nu == 1)
            set relativenumber
        else
            set number
        endif
    endfunc

    function! NumberOff()
        if(&nu == 1)
            set nonu
        elseif(&rnu)
            set nornu
        endif
    endfunc
"}

" Vim UI {

    color molokai                    " Load a colorscheme
    "color default "Load a colorscheme
    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode
    set cursorline                  " Highlight current line

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=%{fugitive#statusline()} " Git Hotness
        "set statusline+=\ [%{&ff}/%Y]            " Filetype
        "set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    "set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=999                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    "set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
    set listchars=tab:▸\ ,eol:¬

" }

" Formatting {

    set nowrap                      " Wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    "set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    "set matchpairs+=<:>             " Match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig

" }

" Key (re)Mappings {
    let mapleader = ' '
	
	noremap <F5> :call RefreshTags()<CR>

	"nmap <silent> <leader>o :call ToggleList("Location List", 'l')<CR>
	nmap <silent> <leader>o :call ToggleList("Quickfix List", 'c')<CR>
    nnoremap <leader>no :call NumberOff()<CR>
    nnoremap <leader>nn :call NumberToggle()<CR>
    nnoremap <leader>nr :set relativenumber<CR>
    nnoremap <leader>nu :set number<CR>

    noremap <leader><leader>l :set list!<CR>
    " Set marks correctly
    noremap ' `
    noremap ` '
	noremap g' g`
	noremap g` g'

    inoremap <C-E> <ESC>A
    inoremap <C-B> <ESC>I
	
	
    "inoremap <C-;> <ESC>mcA;<ESC>`ca
    map <leader>; mcA;<ESC>'c

    " Easier moving in tabs and windows
    " The lines conflict with the default digraph mapping of <C-K>
    " If you prefer that functionality, add let g:spf13_no_easyWindows = 1
    " in your .vimrc.bundles.local file

    map <C-J> <C-W>j
    map <C-K> <C-W>k
    map <C-L> <C-W>l
    map <C-H> <C-W>h
    map <leader>w= <C-W>=
    map <leader>w+ <C-W>+
    map <leader>w_ <C-W>_
    map <leader>w- <C-W>-
    map <leader>wc <C-W>c
    map <leader>wo <C-W>o
 
    " Wrapped lines goes down/up to next row, rather than next line in file.
    nnoremap j gj
    nnoremap k gk


    " The following two lines conflict with moving to top and
    " bottom of the screen
    " If you prefer that functionality, add the following to your
    " .vimrc.bundles.local file:
    "   let g:spf13_no_fastTabs = 1
    "if !exists('g:spf13_no_fastTabs')
    "    map <S-H> gT
    "    map <S-L> gt
    "endif

    " Stupid shift key fixes
    if !exists('g:spf13_no_keyfixes')
        if has("user_commands")
            command! -bang -nargs=* -complete=file E e<bang> <args>
            command! -bang -nargs=* -complete=file W w<bang> <args>
            command! -bang -nargs=* -complete=file Wq wq<bang> <args>
            command! -bang -nargs=* -complete=file WQ wq<bang> <args>
            command! -bang Wa wa<bang>
            command! -bang WA wa<bang>
            command! -bang Q q<bang>
            command! -bang QA qa<bang>
            command! -bang Qa qa<bang>
        endif
    endif

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv
    "nmap gV `[v`]

    " Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

    " Toggle search highlighting
    nmap <silent> <leader>/ :set invhlsearch<CR>

    " Shortcuts
    " Change Working Directory to that of the current file
    "cmap cwd lcd %:p:h
    "cmap cd. lcd %:p:h

    " Fix home and end keybindings for screen, particularly on mac
    " - for some reason this fixes the arrow keys too. huh.
    map [F $
    imap [F $
    map [H g0
    imap [H g0

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    cnoremap %% <C-R>=expand('%:h').'/'<cr>
    map <leader>ef :<C-U>find
    map <leader>ew :<C-U>e %%
    map <leader>es :<C-U>sp %%
    map <leader>ev :<C-U>vsp %%
    map <leader>et :<C-U>tabe %%
    map <leader>v :<C-U>tabedit $MYVIMRC<CR>

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Map <Leader>ff to display all lines with keyword under cursor
    " and ask which one to jump to
    "nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
    " Search for selected text, forwards or backwards.
    vnoremap <silent> * :<C-U>
                \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
                \gvy/<C-R><C-R>=substitute(
                \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
                \gV:call setreg('"', old_reg, old_regtype)<CR>

    vnoremap <leader>ff :<C-U>
                \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
                \gvy:vimgrep "<C-R><C-R>=substitute(
                \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR>" %<CR>
				\gV:call setreg('"', old_reg, old_regtype)<CR>
				\:copen<CR>

	nnoremap <leader>ff :vimgrep <C-R>=expand("<cword>")<CR> % <Bar> copen<CR>
	noremap <leader>fg :Ack <C-R>=expand("<cword>")<CR><CR>
	noremap <leader>fc :Ack --csharp <C-R>=expand("<cword>")<CR><CR>
	noremap <leader><leader>t :echo "<C-R>=expand("<cword>")<CR>"<CR>

    " Easier horizontal scrolling
    map zl zL
    map zh zH

" }

" Plugins {
    " CScope {
        if has("cscope")
            " add any cscope database in current directory
"            if filereadable("cscope.out")
"                cs add cscope.out  
"            " else add the database pointed to by environment variable 
"            elseif $CSCOPE_DB != ""
"                cs add $CSCOPE_DB
"            else
"                cs add ~/workrepos/farm-mobile/cscope.out
"            endif
			if !exists("cscope_test_loaded")
				let cscope_test_loaded = 1
				cs add /Users/vcutten/workrepos/farm-mobile/.git/cscope.out
			endif
            " show msg when any other cscope db added
            set cscopeverbose  
            set cscopequickfix=s-,c-,d-,i-,t-,e-,g-
            " search tag files first
            set csto=1
            nmap <leader>fs :execute 'cs find s <C-R>=expand("<cword>")<CR>' <Bar> copen<CR>
        endif
    " }

    " Buffalo {
        let buffalo_autoaccept=1
    " }

    " PIV {
        let g:DisableAutoPHPFolding = 0
        let g:PIVAutoClose = 0
    " }

    " Misc {
        let g:NERDShutUp=1
        let b:match_ignorecase = 1
    " }
	
	" Gist {
		let g:gist_detect_filetype = 1
	" }

    " OmniComplete {

    "    if has("autocmd") && exists("+omnifunc")
    "        autocmd Filetype *
    "            \if &omnifunc == "" |
    "            \setlocal omnifunc=syntaxcomplete#Complete |
    "            \endif
    "    endif

        hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
        hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
        hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

    "    " Some convenient mappings
    "    inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
    "    inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
    "    inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
    "    inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
    "    inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
    "    inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

    "    " Automatically open and close the popup menu / preview window
    "    au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
    "    set completeopt=menu,preview,longest
    " }

    " Ctags {
    "   set tags=./tags;/,~/.vimtags
    " }

    " AutoCloseTag {
        " Make it so AutoCloseTag works for xml and xhtml files as well
        au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
        nmap <Leader>ac <Plug>ToggleAutoCloseMappings
    " }

    " SnipMate {
        " Setting the author var
        " If forking, please overwrite in your .vimrc.local file
        let g:snips_author = 'Steve Francia <steve.francia@gmail.com>'
    " }


    " NerdTree {
    "    map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
    "    map <leader>e :NERDTreeFind<CR>
    "    nmap <leader>nt :NERDTreeFind<CR>
    "    let NERDTreeShowBookmarks=1
    "    let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
    "    let NERDTreeChDirMode=0
    "    let NERDTreeQuitOnOpen=1
    "    let NERDTreeMouseMode=2
    "    let NERDTreeShowHidden=1
    "    let NERDTreeKeepTreeInNewTab=1
    "    let g:nerdtree_tabs_open_on_gui_startup=0
    " }

    " Tabularize {
        nmap <Leader>a& :Tabularize /&<CR>
        vmap <Leader>a& :Tabularize /&<CR>
        nmap <Leader>a= :Tabularize /=<CR>
        vmap <Leader>a= :Tabularize /=<CR>
        nmap <Leader>a: :Tabularize /:<CR>
        vmap <Leader>a: :Tabularize /:<CR>
        nmap <Leader>a:: :Tabularize /:\zs<CR>
        vmap <Leader>a:: :Tabularize /:\zs<CR>
        nmap <Leader>a{ :Tabularize /{<CR>
        vmap <Leader>a{ :Tabularize /{<CR>
        nmap <Leader>a, :Tabularize /,<CR>
        vmap <Leader>a, :Tabularize /,<CR>
        nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    " }

    " Session List {
        set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
        nmap <leader>sl :SessionList<CR>
        nmap <leader>ss :SessionSave<CR>
    " }

    " JSON {
        nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
    " }

    " PyMode {
        let g:pymode_lint_checker = "pyflakes"
        let g:pymode_utils_whitespaces = 0
        let g:pymode_options = 0
    " }

    " ctrlp {
        let g:ctrlp_working_path_mode = 2
        nnoremap <silent> <D-t> :CtrlP<CR>
        nnoremap <silent> <D-r> :CtrlPMRU<CR>
		set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.meta,*.prefab,*.png,*.jpg,*~
		let g:ctrlp_custom_ignore = {
		  \ 'dir':  '\v[\/]\.(git|hg|svn|neocon|vimswap|vimundo|vimgolf)$',
		  \ 'file': '\v\.(exe|so|dll|meta|prefab|sln|jpg|png)$'
		  \ }

      "  let g:ctrlp_user_command = {
      "      \ 'types': {
      "          \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
      "          \ 2: ['.hg', 'hg --cwd %s locate -I .'],
      "      \ },
      "      \ 'fallback': 'find %s -type f'
      "  \ }
    "}

    " TagBar {
        "nnoremap <F1> :TagbarToggle<CR>
		" This is set in ~/.pirate-vim/vim/after/plugin/my_mappings.vim
        "nnoremap <silent> <leader>tt :TagbarToggle<CR>
        let g:tagbar_type_actionscript = {
                    \ 'ctagstype' : 'flex',
                    \ 'kinds' : [
                    \ 'f:functions',
                    \ 'c:classes',
                    \ 'm:methods',
                    \ 'p:properties',
                    \ 'v:global variables',
                    \ 'x:mxtags'
                    \ ]
                    \ }
        let g:tagbar_type_mxml = {
                    \ 'ctagstype' : 'flex',
                    \ 'kinds' : [
                    \ 'f:functions',
                    \ 'c:classes',
                    \ 'm:methods',
                    \ 'p:properties',
                    \ 'v:global variables',
                    \ 'x:mxtags'
                    \ ]
                    \ }
    "}

    " PythonMode {
		" Disable if python support not present
        if !has('python')
            let g:pymode = 1
        endif
    " }

    " Fugitive {
		function! PirateDiffRight()
			if ( match( bufname("%"), '//2' ) != -1 )
				" On TARGET Buffer
				echo "Pending"
			elseif ( match( bufname("%"), '//3' ) != -1 )
				" On REMOTE Buffer
				echo "No Where to Put"
			else
				" On LOCAL Buffer
				:diffget //3 | diffupdate
			endif
		endfunc
		function! PirateDiffLeft()
			if ( match( bufname("%"), '//2' ) != -1 )
				" On TARGET Buffer
				echo "Pending"
			elseif ( match( bufname("%"), '//3' ) != -1 )
				" On REMOTE Buffer
				echo "No Where to Put"
			else
				" On LOCAL Buffer
				:diffget //2  | diffupdate
			endif
		endfunc
		" Quick commands to run diff put/obtain
		" Obtain diff from left side
		nnoremap <leader>dh call :PirateDiffLeft()<CR>
		" Obtain diff from right side
		nnoremap <leader>dl call :PirateDiffRight()<CR>

		nnoremap <silent> <leader>gs :call ToggleBuffer('.git/index\\|.git/COMMIT_EDITMSG', 'g')<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
    "}

    " neocomplcache {
        let g:acp_enableAtStartup = 0
        let g:neocomplcache_enable_at_startup = 1
        let g:neocomplcache_enable_camel_case_completion = 1
        let g:neocomplcache_enable_smart_case = 1
        let g:neocomplcache_enable_underbar_completion = 1
        let g:neocomplcache_enable_auto_delimiter = 1
        let g:neocomplcache_max_list = 15
        let g:neocomplcache_force_overwrite_completefunc = 1

        " SuperTab like snippets behavior.
        imap <silent><expr><TAB> neosnippet#expandable() ?
                    \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
                    \ "\<C-e>" : "\<TAB>")
        smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

        " Define dictionary.
        let g:neocomplcache_dictionary_filetype_lists = {
                    \ 'default' : '',
                    \ 'vimshell' : $HOME.'/.vimshell_hist',
                    \ 'scheme' : $HOME.'/.gosh_completions'
                    \ }

        " Define keyword.
        if !exists('g:neocomplcache_keyword_patterns')
            let g:neocomplcache_keyword_patterns = {}
        endif
        let g:neocomplcache_keyword_patterns._ = '\h\w*'

        " Plugin key-mappings.

        " These two lines conflict with the default digraph mapping of <C-K>
        " If you prefer that functionality, add
        " let g:spf13_no_neosnippet_expand = 1
        " in your .vimrc.bundles.local file

        if !exists('g:spf13_no_neosnippet_expand')
            imap <C-k> <Plug>(neosnippet_expand_or_jump)
            smap <C-k> <Plug>(neosnippet_expand_or_jump)
        endif

        inoremap <expr><C-g> neocomplcache#undo_completion()
        inoremap <expr><C-l> neocomplcache#complete_common_string()
        inoremap <expr><CR> neocomplcache#complete_common_string()

        " <TAB>: completion.
        inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

        " <CR>: close popup
        " <s-CR>: close popup and save indent.
        inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup()"\<CR>" : "\<CR>"
        inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"

        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y> neocomplcache#close_popup()

        " Enable omni completion.
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
        autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

        " Enable heavy omni completion.
        if !exists('g:neocomplcache_omni_patterns')
            let g:neocomplcache_omni_patterns = {}
        endif
        let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
        let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
        let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
        let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
        let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

        " Use honza's snippets.
        let g:neosnippet#snippets_directory='~/.vim/bundle/snipmate-snippets/snippets'

        " Enable neosnippet snipmate compatibility mode
        let g:neosnippet#enable_snipmate_compatibility = 1        

        " For snippet_complete marker.
        if has('conceal')
            set conceallevel=2 concealcursor=i
        endif
    " }

    " UndoTree {
        nnoremap <Leader>u :UndotreeToggle<CR>
        " If undotree is opened, it is likely one wants to interact with it.
        let g:undotree_SetFocusWhenToggle=1
    " }

    " indent_guides {
        if !exists('g:spf13_no_indent_guides_autocolor')
            let g:indent_guides_auto_colors = 1
        else
            " For some colorschemes, autocolor will not work (eg: 'desert', 'ir_black')
            autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#212121 ctermbg=3
            autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#404040 ctermbg=4
        endif
        let g:indent_guides_start_level = 2
        let g:indent_guides_guide_size = 1
        let g:indent_guides_enable_on_vim_startup = 1
    " }

" }

" GUI Settings {

    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set guioptions-=T           " Remove the toolbar
        set lines=40                " 40 lines of text instead of 24
        if has("gui_gtk2")
            set guifont=Andale\ Mono\ Regular\ 16,Menlo\ Regular\ 15,Consolas\ Regular\ 16,Courier\ New\ Regular\ 18
        else
            set guifont=Andale\ Mono\ Regular:h16,Menlo\ Regular:h15,Consolas\ Regular:h16,Courier\ New\ Regular:h18
        endif
    else
        if &term == 'xterm' || &term == 'screen'
            set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        endif
        "set term=builtin_ansi       " Make arrow and other keys work
    endif

" }

" Functions {

    " UnBundle {
    function! UnBundle(arg, ...)
      let bundle = vundle#config#init_bundle(a:arg, a:000)
      call filter(g:bundles, 'v:val["name_spec"] != "' . a:arg . '"')
    endfunction

    com! -nargs=+         UnBundle
    \ call UnBundle(<args>)
    " }
    " Strip whitespace {
    function! StripTrailingWhitespace()
        " To disable the stripping of whitespace, add the following to your
        " .vimrc.local file:
        "   let g:spf13_keep_trailing_whitespace = 1
        if !exists('g:spf13_keep_trailing_whitespace')
            " Preparation: save last search, and cursor position.
            let _s=@/
            let l = line(".")
            let c = col(".")
            " do the business:
            %s/\s\+$//e
            " clean up: restore previous search history, and cursor position
            let @/=_s
            call cursor(l, c)
        endif
    endfunction
    " }

" }

" Use local gvimrc if available and gui is running {
    if has('gui_running')
        if filereadable(expand("~/.gvimrc.local"))
            source ~/.gvimrc.local
        endif
    endif
" }

