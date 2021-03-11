" File Name: formatters.vim
" Author: cissoid
" Created At: 2017-04-01T12:02:53+0800
" Last Modified: 2021-03-11T19:42:12+0800
scriptencoding utf-8
 
if exists('g:formatters_loaded')
    finish
endif
let g:formatters_loaded = 1

if !exists('g:formatters_program')
    let g:formatters_programs = {}
endif

let s:default_programs = {
    \ 'c': {'program': 'clang-format', 'args': '-style=file'},
    \ 'cpp': {'program': 'clang-format', 'args': '-style=file'},
    \ 'css': {'program': 'js-beautify', 'args': '--type css'},
    \ 'go': {'program': 'gofmt'},
    \ 'html': {'program': 'js-beautify', 'args': '--type html'},
    \ 'htmldjango': {'program': 'js-beautify', 'args': '--type html'},
    \ 'javascript': {'program': 'js-beautify'},
    \ 'json': {'program': 'prettier', 'args': '--parser json --tab-width 4'},
    \ 'markdown': {'program': 'prettier', 'args': '--parser markdown'},
    \ 'php': {'program': 'phpcbf', 'args': '--stdin-path --standard=PSR1,PSR2'},
    \ 'python': {'program': 'black', 'args': '-l 120 -q - 2>/dev/null'},
    \ 'rust': {'program': 'rustfmt'},
    \ 'scss': {'program': 'prettier', 'args': '--parser scss --tab-width 4'},
    \ 'yaml': {'program': 'prettier', 'args': '--parser yaml --tab-width 2'},
    \ 'proto': {'program': 'clang-format', 'args': '-style=file'},
    \ 'lua': {'program': 'lua-format'},
\ }

augroup formatters
    autocmd!

    let s:ft = ''
    for s:ft in keys(s:default_programs)
        if executable(s:default_programs[s:ft]['program'])
            let s:prog = escape(s:default_programs[s:ft]['program'] . ' ' . get(s:default_programs[s:ft], 'args', ''), ' "')
            execute('autocmd FileType ' . s:ft . ' setlocal formatprg=' . s:prog)
        endif
    endfor

    for s:ft in keys(g:formatters_programs)
        if executable(g:formatters_programs[s:ft]['program'])
            let l:prog = escape(g:formatters_programs[s:ft]['program'] . ' ' . get(g:formatters_programs[s:ft], 'args', ''), ' "')
            execute('autocmd FileType ' . s:ft . ' setlocal formatprg=' . s:prog)
        endif
    endfor
augroup END

nnoremap <Plug>Reformat :call formatters#Reformat()<CR>
