set foldmethod=indent
set shiftwidth=4
""""""""""""
"  pymode  "
""""""""""""
let g:pymode_lint_ignore = ["E501","E402","W0611","W0404"]
let g:pymode_lint_on_write = 1
let g:pymode_rope = 1
let g:pymode_run = 0

let g:pymode_rope_goto_definition_bind = '<C-c>g'
let g:pymode_rope_goto_definition_cmd = 'new'
let g:pymode_rope_show_doc_bind = '<C-c>d'


nmap <leader>p :PymodeLintAuto<cr>

"""""""""""""
"  ipython  "
"""""""""""""
"------------------------------------------------------------------------------
" slime configuration 
"------------------------------------------------------------------------------
" always use tmux
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_python_ipython = 1
let g:slime_dont_ask_default = 1

" map <Leader>s to start IPython
nnoremap <Leader>s :SlimeSend1 ipython --matplotlib<CR>

" map <Leader>r to run script and time the execution
nnoremap <Leader>r :IPythonCellRunTime<CR>

" map <Leader>C to execute the current cell and jump to the next cell
" nnoremap <Leader>c :IPythonCellExecuteCellJump<CR>
nnoremap <Leader>c :IPythonCellExecuteCellVerboseJump<CR>

" map <Leader>Q to restart ipython


let g:ipython_cell_shell_prev_cmd = '<C-p>'

nnoremap <Leader>Q :IPythonCellRestart<CR>
" map [c and ]c to jump to the previous and next cell header
nnoremap [c :IPythonCellPrevCell<CR>
nnoremap ]c :IPythonCellNextCell<CR>
"nmap <leader>N :IPythonCellInsertAbove<CR>a
"nmap <leader>n :IPythonCellInsertBelow<CR>a
"
noremap <leader>o  :IPythonCellInsertBelow<CR>o
let g:ipython_cell_tag = ['# %%', '#%%', '# <codecell>','# In[']
