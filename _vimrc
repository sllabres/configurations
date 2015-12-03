syntax enable
set background=dark
colorscheme solarized
" colorscheme elmindreda 

if has('vim_starting')
   set nocompatible               " Be iMproved

   " Required:
   set runtimepath+=C:\devtools\vim\vim74\bundle\neobundle.vim
 endif

 " Required:
 call neobundle#begin(expand('C:/devtools/vim/vim74/bundle'))

 " Let NeoBundle manage NeoBundle
 " Required:
 NeoBundleFetch 'Shougo/neobundle.vim'
 NeoBundle 'nosami/Omnisharp'
 NeoBundle 'tpope/vim-dispatch'
 NeoBundle 'kien/ctrlp.vim'
 NeoBundle 'scrooloose/syntastic'
 NeoBundle 'OrangeT/vim-csharp'
 NeoBundle 'ervandew/supertab'
 NeoBundle 'scrooloose/nerdtree'
 NeoBundle 'altercation/vim-colors-solarized'

 NeoBundle 'fsharp/vim-fsharp', {
           \ 'description': 'F# support for Vim',
           \ 'lazy': 1,
           \ 'autoload': {'filetypes': 'fsharp'},
           \ 'build': {
           \   'unix':  'make fsautocomplete',
           \ },
           \ 'build_commands': ['curl', 'make', 'mozroots', 'touch', 'unzip'],
           \}

 " My Bundles here:
 " Refer to |:NeoBundle-examples|.
 " Note: You don't set neobundle setting in .gvimrc!

 "Super tab settings - uncomment the next 4 lines
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
let g:SuperTabClosePreviewOnPopupClose = 1

 call neobundle#end()

 " Required:
 filetype plugin on
 filetype indent on

 " If there are uninstalled bundles found on startup,
 " this will conveniently prompt you to install them.
 NeoBundleCheck

set noshowmatch
set completeopt=longest,menuone,preview
set splitbelow
set updatetime=500
set cmdheight=2
set shortmess=
set noswapfile
set lazyredraw
set ttyfast
set nocursorline
set nocursorcolumn

autocmd vimenter * NERDTree

autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck
map <C-n> :NERDTreeToggle<CR>:w


" let g:OmniSharp_server_type = 'v1'
" let g:OmniSharp_server_type = 'roslyn'

let g:syntastic_cs_checkers = ['syntax', 'issues']
" let g:syntastic_cs_checkers = ['code_checker']
" let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']


augroup fsharp_commands
	nnoremap <leader>fe :FsiEvalBuffer<cr>
augroup END




augroup omnisharp_commands
    autocmd!

    "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
    autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

    " Synchronous build (blocks Vim)
    "autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
    " Builds can also run asynchronously with vim-dispatch installed
    autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
    " automatic syntax check on events (TextChanged requires Vim 7.4)
    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Automatically add new cs files to the nearest project on save
    autocmd BufWritePost *.cs call OmniSharp#AddToProject()

    "show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    "The following commands are contextual, based on the current cursor position.

    autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
    autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
    autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
    autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
    autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
    "finds members in the current buffer
    autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
    " cursor can be anywhere on the line containing an issue
    autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
    autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
    autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
    autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
    "navigate up by method/property/field
    autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
    "navigate down by method/property/field
    autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>

    nnoremap <leader>rt :OmniSharpRunTests<cr>
    nnoremap <leader>rf :OmniSharpRunTestFixture<cr>
    nnoremap <leader>ra :OmniSharpRunAllTests<cr>
    nnoremap <leader>rl :OmniSharpRunLastTests<cr>

augroup END


" this setting controls how long to wait (in ms) before fetching type / symbol information.
set updatetime=500
" Remove 'Press Enter to continue' message when type information is longer than one line.
set cmdheight=2

" Contextual code actions (requires CtrlP or unite.vim)
nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

" rename with dialog
nnoremap <leader>nm :OmniSharpRename<cr>
nnoremap <F2> :OmniSharpRename<cr>
" rename without dialog - with cursor on the symbol to rename... ':Rename newname'
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

" Force OmniSharp to reload the solution. Useful when switching branches etc.
nnoremap <leader>rl :OmniSharpReloadSolution<cr>
nnoremap <leader>cf :OmniSharpCodeFormat<cr>
" Load the current .cs file to the nearest project
nnoremap <leader>tp :OmniSharpAddToProject<cr>

" (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
nnoremap <leader>ss :OmniSharpStartServer<cr>
nnoremap <leader>sp :OmniSharpStopServer<cr>

" Add syntax highlighting for types and interfaces
nnoremap <leader>th :OmniSharpHighlightTypes<cr>
"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden



