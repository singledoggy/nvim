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
nnoremap c "cc
" Pathogen load
filetype off
filetype plugin on
filetype plugin indent on
syntax on
if has("autocmd")                                                          
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif                                                        
endif

noremap <silent> k gk
noremap <silent> j gj
noremap <silent> gj j
noremap <silent> gk k


let g:python3_host_prog='/Users/sam/opt/anaconda3/envs/EnvML/bin/python3'
"""""""""""""""""""""""
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

inoremap vv <esc>
cnoremap vv <esc>

call plug#begin('/usr/local/Cellar/neovim/0.9.2/share/nvim/plugged')
Plug 'github/copilot.vim'
Plug 'kshenoy/vim-signature'
Plug 'godlygeek/tabular' "Vim-markdown depend on this
Plug 'plasticboy/vim-markdown'
Plug 'tyru/open-browser.vim' 
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'untitled-ai/jupyter_ascending.vim'
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
Plug 'psf/black', { 'branch': 'stable' }
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
"Plug 'mzlogin/vim-markdown-toc'
"Plug 'subnut/nvim-ghost.nvim'
"Plug 'preservim/nerdtree'
"Plug 'kenn7/vim-arsync'
"Plug 'prabirshrestha/async.vim' " vim-arsync depedencies
call plug#end()

"nmap ,v :NERDTreeFind<cr>
"nmap ,g :NERDTreeToggle<cr>
"------------------------------------------------------------------------------
" slime configuration 
"------------------------------------------------------------------------------
" always use tmux
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_python_ipython = 1
let g:slime_dont_ask_default = 1

"""""""""""""
"  gruvbox  "
"""""""""""""
autocmd vimenter * ++nested colorscheme gruvbox
set background=dark


"=========auto save=====
let g:auto_save = 1
"augroup ft_filetypes
"  au!
"  au FileType markdown,tex let b:auto_save = 1
"augroup END

" =====enable ncm2 for all buffers=====
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=menu,noinsert,noselect
set shortmess+=c
" 延迟弹窗,这样提示更加流畅
let ncm2#popup_delay = 3
"输入几个字母开始提醒:[[最小优先级,最小长度]]
let g:ncm2_jedi#python_version = 3
"模糊匹配模式,详情请输入:help ncm2查看相关文档
let g:ncm2#matcher = 'substrfuzzy'

" Use <TAB> to select the popup menu:
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

"===============ncm2====

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
let g:mkdp_auto_start = 0
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
let g:vim_markdown_folding_disabled = 1
"nmap gen :GenTocGFM
"nmap dgen :RemoveToc
"function RToc()
"    exe "/-toc .* -->"
"    let lstart=line('.')
"    exe "/-toc -->"
"    let lnum=line('.')
"    execute lstart.",".lnum."g/           /d"
"endfunction
"markdown preview config==


"""""""""""""""""
"  easy motion  "
"""""""""""""""""
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" s{char}{char} to move to {char}{char}
nmap <leader>s <Plug>(easymotion-overwin-f2)
nmap <leader>s <Plug>(easymotion-overwin-f2)
" Move to word
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

"====snips config===

let g:UltiSnipsExpandTrigger="<tab>"
"设置文件目录
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
"设置打开配置文件时为垂直打开
let g:UltiSnipsEditSplit="vertical"

"====snips config===


"====Vimtex ===
syntax enable

let g:vimtex_compiler_method = 'latexmk'
let g:tex_flavor = "latex"
let g:vimtex_view_method='skim'
let g:vimtex_view_skim_activate=1
"let g:vimtex_view_skim_reading_bar=1
"let g:vimtex_view_skim_sync = 1
"

let g:vimtex_quickfix_mode=0
"set conceallevel=2

let g:tex_fold_enabled = 0
let g:vimtex_fold_enabled = 1
let g:vimtex_fold_manual=1
let g:vimtex_fold_types = {
	\ 'preamble' : {'enabled': 1},
	\ 'sections': {'enabled' : 0},
	\ 'comments':  {'enabled': 1},
	\ 'envs' : {
	\	'whitelist': ['enumerate','itemize','figure','table'],
	\ },
\ }


let g:vimtex_compiler_latexmk = {
	\ 'aux_dir' : './latex_out',
	\ 'callback' : 0,
	\ 'continuous' : 1,
	\ 'executable' : 'latexmk',
	\ 'hooks' : [],
	\ 'options' : [
	\   '-verbose',
	\   '-file-line-error',
	\   '-synctex=1',
	\   '-interaction=nonstopmode',
	\ ],
	\}

let g:vimtex_quickfix_ignore_filters = [
      \ 'fontspec Warning',
      \ 'Overfull',
      \]

function! OpenLines(nrlines, dir)
  let nrlines = a:nrlines < 3 ? 3 : a:nrlines
  let start = line('.') + a:dir
  call append(start, repeat([''], nrlines))
  if a:dir < 0
    normal! 2k
  else
    normal! 2j
  endif
endfunction
" Mappings to open multiple lines and enter insert mode.
nnoremap <Leader>o :<C-u>call OpenLines(v:count, 0)<CR>i
nnoremap <Leader>O :<C-u>call OpenLines(v:count, -1)<CR>i
command! -nargs=0 PDF source ~/.vim/pack/pdf.vim

"====Vimtex ===

"""""""""""""
"  leaderf  "
"""""""""""""
" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

let g:Lf_ShortcutF = "<c-p>"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" search visually selected text literally
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR>

"""""""""""""
"  leaderf  "
"""""""""""""


"=Format JSON==
function! FormatJSON()
  %!python -c 'import sys,json; json.dump(json.load(sys.stdin), sys.stdout, ensure_ascii=False, indent=4)' %
endfunction

command FormatJSON :call FormatJSON()

"=Format JSON==

"==copilot==
let g:copilot_filetypes = {
    \ 'gitcommit': v:true,
    \ 'tex': v:false
    \ }
autocmd BufReadPre *
	 \ let f=getfsize(expand("<afile>"))
     \ | if f > 100000 || f == -2
     \ | let b:copilot_enabled = v:false
	 \ | endif


"==copilot==

""==nvim-ghost==
"augroup nvim_ghost_user_autocommands
"  au User www.reddit.com,www.stackoverflow.com setfiletype markdown
"  au User www.reddit.com,www.github.com setfiletype markdown
"  au User *github.com setfiletype markdown
"  au User localhost:8888 setfiletype python
"augroup END
""==nvim-ghost==
