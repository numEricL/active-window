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
        call activewindow#unset()
        echo 'ActiveWindow disabled'
    endif
endfunction

function activewindow#set() abort
    for l:nr in range(1, winnr('$'))
        if l:nr == winnr()
            call setwinvar(l:nr, '&number', 1)
            call setwinvar(l:nr, '&foldcolumn', 0)
        else
            call setwinvar(l:nr, '&number', 0)

            let l:n = s:Line(l:nr)
            let l:num_digits = 0
            while l:n > 0
                let l:num_digits += 1
                let l:n = l:n / 10
            endwhile
            call setwinvar(l:nr, '&foldcolumn', max([4,l:num_digits+1]))
        endif
    endfor
endfunction

function activewindow#unset() abort
    for l:nr in range(1, winnr('$'))
        call setwinvar(l:nr, '&number', &g:number)
        call setwinvar(l:nr, '&foldcolumn', &g:foldcolumn)
    endfor
endfunction

function s:Line(winnr) abort
    if exists('*win_getid')
        return line('$', win_getid(a:winnr))
    else
        let l:this_winnr = winnr()
        execute 'noautocmd keepalt keepjumps '.a:winnr.'wincmd w'
        let l:line = line('$')
        execute 'noautocmd keepalt keepjumps'.l:this_winnr.'wincmd w'
        return l:line
    endif
endfunction
