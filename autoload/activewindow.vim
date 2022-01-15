function activewindow#Toggle() abort
    let g:ActiveWindow_enabled = !g:ActiveWindow_enabled
    if g:ActiveWindow_enabled
        augroup ActiveWindow
            autocmd!
            autocmd WinEnter * call activewindow#set()
        augroup END
        call activewindow#set()
        echo 'ActiveWindow enabled'
    else
        autocmd! ActiveWindow
        call activewindow#restore()
        echo 'ActiveWindow disabled'
    endif
endfunction

function activewindow#set() abort
    for l:nr in range(1, winnr('$'))
        if s:Skip(l:nr) | continue | endif
        if l:nr == winnr()
            call setwinvar(l:nr, '&number', &g:number)
            call setwinvar(l:nr, '&relativenumber', &g:relativenumber)
            call setwinvar(l:nr, '&foldcolumn', &g:foldcolumn)
            if g:ActiveWindow_cursorline
                call setwinvar(l:nr, '&cursorline', 1)
            endif
        else
            call setwinvar(l:nr, '&number', 0)
            call setwinvar(l:nr, '&relativenumber', 0)
            let l:pad = s:LineNumberWidth(l:nr)
            if getwinvar(l:nr, '&signcolumn') == 'number'
                let l:pad -= s:SignWidth(l:nr)
            endif
            call setwinvar(l:nr, '&foldcolumn', &g:foldcolumn + l:pad)
            if g:ActiveWindow_cursorline
                call setwinvar(l:nr, '&cursorline', 0)
            endif
        endif
    endfor
endfunction

function activewindow#restore() abort
    for l:nr in range(1, winnr('$'))
        call setwinvar(l:nr, '&number', &g:number)
        call setwinvar(l:nr, '&relativenumber', &g:relativenumber)
        call setwinvar(l:nr, '&foldcolumn', &g:foldcolumn)
        call setwinvar(l:nr, '&cursorline', &g:cursorline)
    endfor
endfunction

function s:LineNumberWidth(winnr) abort
    try
        let l:linenr=line('$', win_getid(a:winnr))
    catch
        let l:this_winnr = winnr()
        execute 'noautocmd keepalt keepjumps '.a:winnr.'wincmd w'
        let l:linenr = line('$')
        execute 'noautocmd keepalt keepjumps'.l:this_winnr.'wincmd w'
    endtry
    return max([&numberwidth, strlen(l:linenr)+1])
endfunction

function s:SignWidth(winnr) abort
    let l:signcolumn = getwinvar(a:winnr, '&signcolumn')
    if l:signcolumn == 'auto' || ( l:signcolumn == 'number' && a:winnr != winnr() )
        if exists('*sign_getplaced')
           let l:width = len(sign_getplaced(winbufnr(a:winnr),{'group':'*'})[0]['signs']) ? 2 : 0
        else
            let l:signlist = execute('sign place buffer='.winbufnr(a:winnr))
            let l:signlist = split(l:signlist, "\n")
            let l:width = len(l:signlist) > 2 ? 2 : 0
        endif
    elseif l:signcolumn == 'yes'
        let l:width = 2
    else
        let l:width = 0
    endif
    return l:width
endfunction

function s:Skip(winnr) abort
    return bufname(winbufnr(a:winnr)) =~ join(g:ActiveWindow_skip, '\|')
endfunction
