" Install vim plug if not installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"
" Plugins for NeoVim (and Vim)  ... via vim plug.  Install them with :PlugInstall
"
call plug#begin()
    " Tab completion
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Helpful popup to show which key bindings are available
    Plug 'folke/which-key.nvim'
    " Seamless integration between tmux panes and vim splits
    Plug 'christoomey/vim-tmux-navigator'
    " Send lines from Vim to tmux using C-c
    Plug 'jpalardy/vim-slime'
    " Camel case
    Plug 'chaoren/vim-wordmotion'
    " Plug 'christoomey/vim-titlecase'
    Plug 'iggredible/totitle-vim'
call plug#end()

" totitle plugin: some extra (default) keyboard mappings
" give selections title case using "gt$" or "gt." where . is a movement.
nnoremap <expr> gz ToTitle()
xnoremap <expr> gz ToTitle()
nnoremap <expr> gzz ToTitle() .. '_'

" Coc tab completion extensions.  Load them with :CocInstall
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-calc', 'coc-clangd', 'coc-cmake', 'coc-css', 'coc-docker', 'coc-fzf-preview', 'coc-html', 'coc-texlab', 'coc-sh', 'coc-pyright', 'coc-snippets', 'coc-ltex']


" Use the ; key to get command line
noremap ; :

" When to show status bar.  0=never 2=always 1=sometimes (e.g. if more than 2 windows)
set laststatus=1

" Enable repeated indenting in visual mode
vmap < <gv
vmap > >gv

" Extended regex "very magic" search
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %smagic/
cnoremap >s/ >smagic/ 
nnoremap :g/ :g/\v
nnoremap :g// :g//

" Tab Next/Prev
nnoremap H :tabp<CR>
nnoremap L :tabn<CR>

" Window split shortcuts https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set mouse=a " Use mouse in all modes
" set mouse=i " Use mouse in insert mode only

" System Clipboard
let s:uname = system("echo -n \"$(uname)\"")
if !v:shell_error && s:uname == "Darwin"
  set clipboard=unnamed "this works on osx
else
  set clipboard=unnamedplus "Integration with system clipboard. + is copy and * is select
endif

" Emacs-like beginning and end of line
"inoremap <C-a> <Esc>^i
"nnoremap <C-a> ^
"inoremap <C-e> <Esc>$i
"nnoremap <C-e> $

" When opening a file in the command bar, tab completion behaves like bash
" autocomplete
set wildmode=longest,list,full
set wildmenu

" Line numbers
set number

" True colors (not just 256 color)
set termguicolors

"highlight everything past 80 chars
" highlight ColorColumn guibg=#2d2d2d ctermbg=246
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn=join(range(81,999),",")
"set cc=80

" The gq command to wrap long lines at 80 chars
" set textwidth=80  " this forces newlines every time its longer than 80 chars and is very annoying.
set formatoptions=tlcqn
set textwidth=80
" The gq command should also indent multi-line bulleted lists properly
" set autoindent

" Spell check
set spell
set spellfile=~/.vim_runtime/spell/en.utf-8.add
" grammar checking for latex and maybe markdown
let g:coc_filetype_map = {'tex': 'latex'}
nmap <leader>s :CocCommand ltex.checkCurrentDocument<CR>

" Wrapping and cursor movement:  When not wrapping long lines, use keys to move one display line at a time (rather than one physical line)
noremap <silent> <Leader>wr :call ToggleWrap()<CR>
function ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
    set virtualedit=all
    silent! nunmap <buffer> j
    silent! nunmap <buffer> k
    silent! nunmap <buffer> 0
    silent! nunmap <buffer> ^
    silent! nunmap <buffer> $
    silent! vunmap <buffer> j
    silent! vunmap <buffer> k
    silent! vunmap <buffer> 0
    silent! vunmap <buffer> ^
    silent! vunmap <buffer> $
  else
    echo "Wrap ON"
    setlocal wrap linebreak nolist
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> j   gj
    noremap  <buffer> <silent> k   gk
    noremap  <buffer> <silent> 0   g0
    noremap  <buffer> <silent> ^   g^
    noremap  <buffer> <silent> $   g$
    vnoremap  <buffer> <silent> j   gj
    vnoremap  <buffer> <silent> k   gk
    vnoremap  <buffer> <silent> 0   g0
    vnoremap  <buffer> <silent> ^   g^
    vnoremap  <buffer> <silent> $   g$
  endif
endfunction


" Latex
" LaTeX: Disable LaTeX-Box so I can use vimtex
let g:polyglot_disabled = ['latex']
" LaTeX: enable snippets by setting latex filetype
let g:tex_flavor = "latex"
" Build the latex file on save.
"CocCommand latex.Build


"
"
" COC Tab Completion Configuration
"
"
" 
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8
"
" TextEdit might fail if hidden is not set.
set hidden
"
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
"
" Give more space for displaying messages.
"set cmdheight=2
set cmdheight=1
"
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
"set updatetime=300
set updatetime=200
"
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
 
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

"
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"
" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>
"
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
"
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
"
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
"
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
"
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocActionAsync('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
"
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
"
" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)
"
" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)
"
" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
"
" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
"
" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
"
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')
"
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
"
" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"
" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"

" commentary extra bindings  (existing ones are gcc and gc<motion> and gcap)
nnoremap <C-c> :Commentary<CR>
vnoremap <C-c> :Commentary<CR>
inoremap <C-c> <Esc>:Commentary<CR>==gi
nnoremap <leader>/ <Esc>:Commentary<CR>

" Vim Slime   https://github.com/jpalardy/vim-slime
let g:slime_target = "tmux"
let g:slime_paste_file = "/tmp/${USER}.slime_paste"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
" let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": "{right-of}"}
let g:slime_dont_ask_default = 1
let g:slime_python_ipython = 1

" Disable the AutoPairs plugin that completes quotes.  It's annoying.
" It's added by ultimate vim.
let g:AutoPairs={}

