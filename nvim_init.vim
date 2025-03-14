set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

if has('nvim')
    tnoremap <Esc> <C-\><C-n>
end
