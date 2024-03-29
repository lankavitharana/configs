so ~/.vim/plugins.vim
" below line is to make the fold method to indentation
set foldmethod=indent
set number
set rnu

" Git gutter related configs
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'
let g:gitgutter_override_sign_column_highlight = 1
set updatetime=1000
nmap gn <Plug>GitGutterNextHunk  " git next 
nmap gp <Plug>GitGutterPrevHunk  " git previous
nmap ga <Plug>GitGutterStageHunk  " git add (chunk)
nmap gu <Plug>GitGutterUndoHunk   " git undo (chunk)

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright
" make the cursor blink
set guicursor=a:blinkon100

" below parts are not needed for cursor shape change, as neovim by default
" support that
" if has("autocmd")
"   au VimEnter,InsertLeave * silent execute '!echo -ne "\e[1 q"' | redraw!
"   au InsertEnter,InsertChange *
"     \ if v:insertmode == 'i' |
"     \   silent execute '!echo -ne "\e[5 q"' | redraw! |
"     \ elseif v:insertmode == 'r' |
"     \   silent execute '!echo -ne "\e[3 q"' | redraw! |
"     \ endif
"   au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
" endif

" *************************************
" *** Plugin related configurations ***
" *************************************

" ------ NERDTREE plugin ------
" Open NERDTree automatically when vim starts up on opening a directory 
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" map a specific key or shortcut to open NERDTree
map <C-t> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ------ devicons plugin ------
" setting encoding for vim devicon plugin
set encoding=UTF-8

" ------ You complete me plugin ------
" setting rust source path 
let g:ycm_rust_src_path = '/mnt/office/wso2/dev/otherSources/rust'

" Key mapping to do grep search the word under the cursor 
map <C-f> :execute " grep -srnw --binary-files=without-match --exclude-dir=.git . -e " . expand("<cword>") . " " <bar> cwindow<CR>


