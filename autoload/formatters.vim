" File Name: formatters.vim
" Author: cissoid
" Created At: 2017-04-01T12:06:08+0800
" Last Modified: 2017-04-01T12:06:36+0800
scriptencoding utf-8

function! formatters#Reformat()
    if (&formatprg !=# '')
        " mark current location
        " silent! normal! mm
        silent! execute 'mkview'
        " format all
        silent! normal! gggqG
        " move cursor back
        " silent! normal! 'm
        silent! execute 'loadview'
        " clear mark
        " silent! execute 'delmarks m'
        " center current line
        " silent! normal! zz
    endif
endfunction
