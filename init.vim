set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
nnoremap <silent><leader>x :put =trim(execute(input(':', '', 'command')))<CR>
set number
set mouse=a
setlocal spell
set spelllang=en_us,cjk
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
set ignorecase
set autoindent
set tabstop=4
set shiftwidth=4
set history=1000
set clipboard=unnamedplus
" Pathogen load
filetype off
filetype plugin indent on
syntax on

noremap <silent> k gk
noremap <silent> j gj
noremap <silent> gj j
noremap <silent> gk k


let g:python3_host_prog='/Users/sam/opt/anaconda3/bin/python3'
""""""""""""""""""""""
    "Quickly Run
    """"""""""""""""""""""
    map <F5> :call CompileRunGcc()<CR>
    func! CompileRunGcc()
        exec "w"
        if &filetype == 'c'
            exec "!g++ % -o %<"
            exec "!time ./%<"
        elseif &filetype == 'cpp'
            exec "!g++ % -o %<"
            exec "!time ./%<"
        elseif &filetype == 'java'
            exec "!javac %"
            exec "!time java %<"
        elseif &filetype == 'sh'
            :!time bash %
        elseif &filetype == 'html'
            exec "!firefox % &"
        elseif &filetype == 'go'
    "        exec "!go build %<"
            exec "!time go run %"
        elseif &filetype == 'mkd'
            exec "!~/.vim/markdown.pl % > %.html &"
            exec "!firefox %.html &"
        endif
	endfunc
noremap <leader>b oimport ipdb; ipdb.set_trace()<esc>

inoremap vv <esc>
cnoremap vv <esc>

call plug#begin('/usr/local/Cellar/neovim/0.4.4/share/nvim/plugged')
Plug 'godlygeek/tabular' "Vim-markdown depend on this
Plug 'plasticboy/vim-markdown'
Plug 'tyru/open-browser.vim' 
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'mzlogin/vim-markdown-toc'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jpalardy/vim-slime'
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }
Plug 'lervag/vimtex'
Plug '907th/vim-auto-save'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-ultisnips'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'kien/ctrlp.vim'
Plug 'preservim/nerdtree'
Plug 'easymotion/vim-easymotion'
call plug#end()
nmap <leader>p :PymodeLintAuto<cr>
nmap ,v :nerdtreefind<cr>
nmap ,g :NERDTreeToggle<cr>
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
nnoremap <Leader>c :IPythonCellExecuteCellVerboseJump<CR>

" map <Leader>Q to restart ipython
nnoremap <Leader>Q :IPythonCellRestart<CR>

" map [c and ]c to jump to the previous and next cell header
nnoremap [c :IPythonCellPrevCell<CR>
nnoremap ]c :IPythonCellNextCell<CR>
"nmap <leader>N :IPythonCellInsertAbove<CR>a
"nmap <leader>n :IPythonCellInsertBelow<CR>a
"
noremap <leader>o  :IPythonCellInsertBelow<CR>o
let g:ipython_cell_tag = ['# %%', '#%%', '# <codecell>','# In[']

"=========ctrlp====
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'a'
"=========ctrlp====



"=========auto save=====
let g:auto_save = 1 
" enable AutoSave on Vim startup


" =====enable ncm2 for all buffers=====
autocmd BufEnter * call ncm2#enable_for_buffer()
" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=menu,noinsert,noselect
set shortmess+=c
" 延迟弹窗,这样提示更加流畅
let ncm2#popup_delay = 5
"输入几个字母开始提醒:[[最小优先级,最小长度]]
let g:ncm2_jedi#python_version = 3
"模糊匹配模式,详情请输入:help ncm2查看相关文档
let g:ncm2#matcher = 'substrfuzzy'

"===============ncm2====

""""""""""""
"  pymode  "
""""""""""""
let g:pymode_lint_ignore = ["E501","E402","W0611"]
let g:pymode_lint_on_write = 1
let g:pymode_rope = 1

let g:pymode_rope_goto_definition_bind = '<C-c>g'
let g:pymode_rope_goto_definition_cmd = 'vnew'
let g:pymode_rope_show_doc_bind = '<C-c>d'

function! Pyclean()
	echo "Clean python import"
	silent exec '!isort  %:p'
	silent exec '!autoflake --remove-all-unused-imports  -i %:p'
endfunc

command! Pyclean call Pyclean()

function! ChineseCount() range
	let save = @z
	silent exec 'normal! gv"zy'
	let text = @z
	let @z = save
	silent exec 'normal! gv'
	let cc = 0
	for char in split(text, '\zs')
		if char2nr(char) >= 0x2000
			let cc += 1
		endif
	endfor
	echo "Count of Chinese charasters is:"
	echo cc
endfunc
noremap <F2> :call ChineseCount()<cr>

"=======plug conifg=======
function! GetPlugNameFronCurrentLine(cmd)
    let plugin_name = getline(".")

    if plugin_name !~ "^Plug"
        execute(a:cmd . '!')
        return
    endif

	let plugin_name = split(split(plugin_name, "'")[1], '/')[-1]
	let plugin_name = substitute(plugin_name, '\.git$', '', 'g')
	execute(a:cmd .' '. plugin_name)
endfunction
nmap ,pi :w<cr>:call GetPlugNameFronCurrentLine('PlugInstall')<cr>
nmap ,pu :call GetPlugNameFronCurrentLine('PlugUpdate')<cr>
nmap ,pui :call GetPlugNameFronCurrentLine('PlugClean')<cr>
"=======plug conifg=======

"markdown preview config==
let g:vim_markdown_math = 1
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gs <Plug>(openbrowser-smart-search)
vmap gs <Plug>(openbrowser-smart-search)
let g:mkdp_auto_start = 1
let g:mkdp_browser = 'safari'
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
\ 'mkit': {},
\ 'katex': {},
\ 'uml': {},
\ 'maid': {},
\ 'disable_sync_scroll': 0,
\ 'sync_scroll_type': 'middle',
\ 'hide_yaml_meta': 1
\ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'
"""""""""""""""""
"  easy motion  "
"""""""""""""""""
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
" Move to word
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

"markdown preview config==
let g:vim_markdown_folding_disabled = 1
nmap gen :GenTocGFM
nmap dgen :RemoveToc
function RToc()
    exe "/-toc .* -->"
    let lstart=line('.')
    exe "/-toc -->"
    let lnum=line('.')
    execute lstart.",".lnum."g/           /d"
endfunction

"====snips config===

let g:UltiSnipsExpandTrigger="<tab>"
"设置文件目录
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
"设置打开配置文件时为垂直打开
let g:UltiSnipsEditSplit="vertical"

"====snips config===


" Vimtex 
let g:tex_flavor = "latex"
let g:vimtex_view_method='skim'
let g:vimtex_view_skim_sync = 1 
let g:vimtex_view_skim_activate = 1 
set conceallevel=1
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'
"vimtex
