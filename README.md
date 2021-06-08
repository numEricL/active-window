# ActiveWindow
ActiveWindow is a Vim plugin that uses line numbers, foldcolumns, and statusline
to indicate the active/current window.

## Customization
To change the left or right foldcolumn size, set `g:ActiveWindow_left_foldcolumn`
or `g:ActiveWindow_right_foldcolumn`

ActiveWindow does not alter the number option if `g:ActiveWindow_use_linenr` is
set to `0`.

The important highlight groups for Active window are `StatusLine` `StatusLineNC`
`LineNr` and `FoldColumn` if you are dissatisfied with your colorscheme, you can
change them directly. It is recommended to keep custom highlight groups under a
ColorScheme autocmd, for example:

```
autocmd ColorScheme * highlight StatusLine   cterm=underline ctermfg=darkblue ctermbg=none     gui=underline guifg=darkblue
autocmd ColorScheme * ighlight StatusLineNC cterm=underline ctermfg=darkgray ctermbg=none     gui=underline guifg=darkgray
autocmd ColorScheme * ighlight LineNr                       ctermfg=darkblue ctermbg=none                   guifg=darkblue
autocmd ColorScheme * ighlight FoldColumn                   ctermfg=darkred  ctermbg=darkblue               guifg=darkred  guibg=darkblue
```

## Variable Defaults
```
g:ActiveWindow_enabled          (=1 default)
g:ActiveWindow_use_linenr       (=1 default)
g:ActiveWindow_left_foldcolumn  (=0 default)
g:ActiveWindow_right_foldcolumn (=1 default)
```
