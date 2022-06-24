let b:EditorConfig_disable = 1

setlocal tw=72
setlocal formatoptions+=t

let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
    " Additional settings
    setlocal spell

    " If no commit message, start with insert mode
    if a:info.vcs ==# 'git' && getline(1) ==# ''
        startinsert
    endif

    " Scroll the diff window from insert mode
    imap <buffer><M-j> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><M-k> <Plug>(committia-scroll-diff-up-half)
endfunction
