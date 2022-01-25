nnoremap <silent> <plug>(activewindow-Toggle) :<c-u>call activewindow#Toggle()<cr>

if !exists('g:activewindow#enable')
    let g:activewindow#enable = 1
endif
if !exists('g:activewindow#cursorline')
    let g:activewindow#cursorline = 0
endif
if !exists('g:activewindow#skip')
    let g:activewindow#skip = []
endif
if !exists('g:activewindow#use_default_maps')
    let g:activewindow#use_default_maps = 1
endif

if g:activewindow#use_default_maps
    if empty(maparg('<leader>a', 'n'))
        nmap <leader>a <plug>(activewindow-Toggle)
    else
        augroup AcitveWindow
            autocmd VimEnter * echohl WarningMsg | echomsg 'activewindow: Toggle default map is in use: <leader>a  '.maparg('<leader>a', 'n') | echohl None
        augroup END
    endif
endif

if g:activewindow#enable
    augroup ActiveWindow
        autocmd VimEnter,WinEnter * call activewindow#set()
    augroup END
endif
