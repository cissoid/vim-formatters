" File Name: formatters.vim
" Author: cissoid
" Created At: 2017-04-01T12:02:53+0800
" Last Modified: 2017-08-07T16:15:47+0800
scriptencoding utf-8
 
if exists('g:formatters_loaded')
    finish
endif
let g:formatters_loaded = 1

if !exists('g:formatters_program')
    let g:formatters_programs = {}
endif

let s:default_programs = {
    \ 'c': {'program': 'clang-format', 'args': '-style="{BasedOnStyle: Google, IndentWidth: 4}"'},
    \ 'cpp': {'program': 'clang-format', 'args': '-style="{BasedOnStyle: Google, IndentWidth: 4}"'},
    \ 'css': {'program': 'js-beautify', 'args': '--type css'},
    \ 'go': {'program': 'gofmt'},
    \ 'html': {'program': 'js-beautify', 'args': '--type html'},
    \ 'javascript': {'program': 'js-beautify'},
    \ 'php': {'program': 'phpcbf', 'args': '--stdin-path --standard=PSR1,PSR2'},
    \ 'python': {'program': 'autopep8', 'args': '-'},
    \ 'rust': {'program': 'rustfmt'},
    \ 'sass': {'program': 'sass-convert', 'args': '--indent 4 -F sass -T sass'},
    \ 'scss': {'program': 'sass-convert', 'args': '--indent 4 -F scss -T scss'},
\ }

augroup formatters
    autocmd!

    for l:ft in keys(s:default_programs)
        if executable(s:default_programs[l:ft]['program'])
            let l:prog = escape(s:default_programs[l:ft]['program'] . ' ' . get(s:default_programs[l:ft], 'args', ''), ' "')
            execute('autocmd FileType ' . l:ft . ' setlocal formatprg=' . l:prog)
        endif
    endfor

    for l:ft in keys(g:formatters_programs)
        if executable(g:formatters_programs[l:ft]['program'])
            let l:prog = escape(g:formatters_programs[l:ft]['program'] . ' ' . get(g:formatters_programs[l:ft], 'args', ''), ' "')
            execute('autocmd FileType ' . l:ft . ' setlocal formatprg=' . l:prog)
        endif
    endfor
augroup END

nnoremap <Plug>Reformat :call formatters#Reformat()<CR>
