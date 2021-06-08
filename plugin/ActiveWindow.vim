if !exists('g:ActiveWindow_enabled')
    let g:ActiveWindow_enabled = 1
endif
if !exists('g:ActiveWindow_use_linenr')
    let s:true = 1 "for vim version 704
    let g:ActiveWindow_use_linenr = s:true
endif
if !exists('g:ActiveWindow_left_foldcolumn')
    let g:ActiveWindow_left_foldcolumn = 0
endif
if !exists('g:ActiveWindow_right_foldcolumn')
    let g:ActiveWindow_right_foldcolumn = 1
endif

if g:ActiveWindow_enabled
    augroup ActiveWindow
        if !&number && g:ActiveWindow_use_linenr
            autocmd VimEnter * set number
            autocmd WinEnter * set number
            autocmd BufEnter * set number
            autocmd WinLeave * set nonumber
            autocmd BufLeave * set nonumber
        endif

        autocmd VimEnter * if !&diff | call s:RedrawBorder() | endif
        autocmd WinEnter * if !&diff | call s:RedrawBorder() | endif
    augroup END
endif

let s:active_window = 0
let s:right_window = 0
function s:RedrawBorder() abort
    let l:eventignore = &eventignore
    set eventignore=all
    "to preserve state
    let l:current_window = winnr()
    let l:previous_window = winnr('#')

    call s:UnsetOldBorder()
    call s:SetNewBorder()

    execute l:previous_window."wincmd w"
    execute l:current_window."wincmd w"
    let &eventignore = l:eventignore
endfunction

function s:SetNewBorder() abort
    let &foldcolumn = g:ActiveWindow_left_foldcolumn
    let s:active_window = s:Win_getid(winnr())
    wincmd l
    let s:right_window = s:Win_getid(winnr())

    "if right window exists
    if s:active_window != s:right_window
        let &foldcolumn = g:ActiveWindow_right_foldcolumn
    endif
    call s:Win_gotoid(s:active_window)
endfunction

function s:UnsetOldBorder() abort
    let l:current = s:Win_getid(winnr())
    if s:Win_gotoid(s:active_window)
        setlocal foldcolumn=0
    endif
    if s:Win_gotoid(s:right_window)
        setlocal foldcolumn=0
    endif
    call s:Win_gotoid(l:current)
endfunction

function s:Win_getid(nr) abort
    if v:version >= 800
        return win_getid(a:nr)
    else
        return a:nr
    endif
endfunction

function s:Win_gotoid(id) abort
    if v:version >= 800
        return win_gotoid(a:id)
    else
        if 0 < a:id && a:id <= winnr('$')
            execute a:id."wincmd w"
            return 1
        else
            return 0
        endif
    endif
endfunction
