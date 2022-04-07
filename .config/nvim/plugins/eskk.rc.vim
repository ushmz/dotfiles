imap <C-j> <Plug>(eskk:toggle)
cmap <C-j> <Plug>(eskk:toggle)
let g:eskk#kakutei_when_unique_candidate = 1
let g:eskk#enable_completion = 0
let g:eskk#no_default_mappings = 1
let g:eskk#keep_state = 0
let g:eskk#egg_like_newline = 1

let g:eskk#directory = "~/.config/skkeleton"
let g:eskk#large_dictionary = {'path': "~/.config/skkeleton/SKK-JISYO.L", 'sorted': 1, 'encoding': 'euc-jp',}

autocmd User eskk-initialize-post call s:eskk_initial_pre()
function! s:eskk_initial_pre() abort
  EskkUnmap -type=sticky Q
  EskkMap -type=sticky <C-g>
endfunction

" call skkeleton#config({
" \ 'eggLikeNewline': v:true,
" \ 'globalJisyo': expand('~/.config/skkeleton/SKK-JISYO.L')
" \ })
" call skkeleton#register_kanatable('rom', {
" \ "jj": 'escape',
" \ "z\<Space>": ["\u3000", ''],
" \ })
