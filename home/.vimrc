set mouse=a

" Allow saving of files as sudo when I forgot to start vim using sudo via w!!
" http://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work
cmap w!! w !sudo tee > /dev/null %
