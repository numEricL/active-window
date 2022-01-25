# ActiveWindow
ActiveWindow is a Vim plugin that sets line numbers for only the active window.
The fold column is expanded to prevent text from shifting. ActiveWindow
respects the sign column and leaves the fold column at least as wide as it's
original value.

## Cursor Line
If you want the cursorline to be enabled for only the active window, set
`g:activewindow#cursorline = 1`

## Ignore Windows
Use a list of regex patterns for buffers you don't want affected by
ActiveWindow.

For example, use the following to ignore NERDTree windows and any buffer
containing "foo" in its name:
```
let g:activewindow#skip = ['^NERD_tree_*', 'foo']
```

## Defaults
```
g:activewindow#enable = 1
g:activewindow#cursorline = 0
g:activewindow#use_default_maps = 1
nmap <leader>a <plug>(activewindow-Toggle)
```

## Hints
To make the active window stand out even more, make use of the StatusLine and
StatusLineNC highlight groups.
