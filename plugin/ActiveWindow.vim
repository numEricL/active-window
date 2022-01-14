if !exists('g:ActiveWindow_enabled')
    let g:ActiveWindow_enabled = 1
endif
nnoremap <silent> <plug>(activewindow-Toggle) :<c-u>call activewindow#Toggle()<cr>
if !hasmapto('<plug>(activewindow-Toggle)')
    nmap <leader>- <plug>(activewindow-Toggle)
endif

if g:ActiveWindow_enabled
    augroup ActiveWindow
        autocmd VimEnter,WinEnter * call activewindow#set()
    augroup END
endif
