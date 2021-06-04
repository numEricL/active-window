# ActiveWindow
Uses line numbers, foldcolumns, and statusline to indicate the active/current
window

## Customization
ActiveWindow does not alter the number option if `g:ActiveWindow_number` is set
to `0`.

To change the left or right foldcolumn size, set `g:ActiveWindow_left_foldcolumn`
or `g:ActiveWindow_right_foldcolumn`

ActiveWindow uses the following highlight groups: `StatusLine` `StatusLineNC`
`LineNr` and `FoldColumn`. Use the corresponding 
`g:ActiveWindow_[highlight group]` variable to change appearance.

## Variable Defaults
```
g:ActiveWindow_enabled          (=1 default)
g:ActiveWindow_number           (=1 default)
g:ActiveWindow_left_foldcolumn  (=0 default)
g:ActiveWindow_right_foldcolumn (=1 default)

g:ActiveWindow_StatusLineNC     (= cterm=underline ctermfg=8 ctermbg=black gui=none' default)
g:ActiveWindow_StatusLine       (no default)
g:ActiveWindow_LineNr           (no default)
g:ActiveWindow_FoldColumn       (no default)
```
