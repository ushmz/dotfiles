" filetype
autocmd BufReadPost *.kt setlocal filetype=kotlin
autocmd BufNewFile,BufRead *.jsx set filetype=javascriptreact
autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact
autocmd BufNewFile,BufRead *.tsx let b:tsx_ext_found = 1
autocmd FileType javascriptreact set tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType typescriptreact set tabstop=2 shiftwidth=2 softtabstop=2

" templates
autocmd BufNewFile *.sh 0r $HOME/.vim/templates/skeleton.sh

