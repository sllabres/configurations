syntax on
colorscheme molokai

if has('vim_starting')
   set nocompatible               " Be iMproved

   " Required:
   set runtimepath+=C:\Development\Tools\vim\vim74\bundle\neobundle.vim
 endif

 " Required:
 call neobundle#begin(expand('C:\Development\Tools\vim\vim74\bundle\'))

 " Let NeoBundle manage NeoBundle
 " Required:
 NeoBundleFetch 'Shougo/neobundle.vim'
 NeoBundle 'nosami/Omnisharp'
 NeoBundle 'tpope/vim-dispatch'
 NeoBundle 'kien/ctrlp.vim'
 NeoBundle 'scrooloose/syntastic'
 NeoBundle 'OrangeT/vim-csharp'
 NeoBundle 'ervandew/supertab'

 " My Bundles here:
 " Refer to |:NeoBundle-examples|.
 " Note: You don't set neobundle setting in .gvimrc!

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
set noswapfile
set lazyredraw
set ttyfast
set nocursorline
set nocursorcolumn

autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuildAsync<cr>
autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
autocmd BufWritePost *.cs call OmniSharp#AddToProject()
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")
autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck
let g:syntastic_cs_checkers = ['syntax', 'issues']
let g:OmniSharp_timeout = 1

nnoremap <leader>fi :OmniSharpFindImplementations<cr>
nnoremap <leader>ft :OmniSharpFindType<cr>
nnoremap <leader>fs :OmniSharpFindSymbol<cr>
nnoremap <leader>fu :OmniSharpFindUsages<cr>
nnoremap <leader>fm :OmniSharpFindMembersInBuffer<cr>
nnoremap <leader>x  :OmniSharpFixIssue<cr>
nnoremap <leader>fx :OmniSharpFixUsings<cr>
nnoremap <leader>tt :OmniSharpTypeLookup<cr>
nnoremap <leader>dc :OmniSharpDocumentation<cr>

nnoremap <leader>rt :OmniSharpRunTests<cr>
nnoremap <leader>rf :OmniSharpRunTestFixture<cr>
nnoremap <leader>ra :OmniSharpRunAllTests<cr>
nnoremap <leader>rl :OmniSharpRunLastTests<cr>

nnoremap <leader>nm :OmniSharpRename<cr>
nnoremap <F2> :OmniSharpRename<cr>      
nnoremap <leader>rl :OmniSharpReloadSolution<cr>
nnoremap <leader>cf :OmniSharpCodeFormat<cr>
nnoremap <leader>tp :OmniSharpAddToProject<cr>
nnoremap <leader>ss :OmniSharpStartServer<cr>
nnoremap <leader>sp :OmniSharpStopServer<cr>
nnoremap <leader>th :OmniSharpHighlightTypes<cr>


