set mouse=a
set ignorecase
set clipboard=unnamedplus
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" Allow saving of files as sudo when I forgot to start vim using sudo via w!!
" http://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work
cmap w!! w !sudo tee > /dev/null %


" http://vim.wikia.com/wiki/Remove_unwanted_spaces
function TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

map <F1> : q!<CR>
map <F2> : w<CR>
" ' map! <F2> :call TrimWhiteSpace()<CR>

" set list lcs=tab:·⁖,trail:·  " trailing whitespace characters are set to be a dot ·
