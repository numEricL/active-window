if !exists('g:activewindow#enabled')
    let g:activewindow#enabled = 1
endif
if !exists('g:activewindow#cursorline')
    let g:activewindow#cursorline = 0
endif
if !exists('g:activewindow#skip')
    let g:activewindow#skip = []
endif
nnoremap <silent> <plug>(activewindow-Toggle) :<c-u>call activewindow#Toggle()<cr>
if !hasmapto('<plug>(activewindow-Toggle)')
    nmap <leader>- <plug>(activewindow-Toggle)
endif

if g:activewindow#enabled
    augroup ActiveWindow
        autocmd VimEnter,WinEnter * call activewindow#set()
    augroup END
endif
