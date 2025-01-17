if exists("g:zellij_navigator_loaded") || (exists("g:zellij_navigator_enabled") && g:zellij_navigator_enabled != 1)
    finish
endif

let g:zellij_navigator_loaded = 1

" If not within Zellij...
if !exists('$ZELLIJ')
    if !exists("g:zellij_navigator_no_default_mappings") || g:zellij_navigator_no_default_mappings != 1
        " Map C-h/j/k/l movements to navigate Vim windows.
        noremap <silent> <C-h> :wincmd h<CR>
        noremap <silent> <C-j> :wincmd j<CR>
        noremap <silent> <C-k> :wincmd k<CR>
        noremap <silent> <C-l> :wincmd l<CR>
    endif

    finish
endif

" Define commands to open and navigate Zellij panes.

command -nargs=? ZellijNewTab call zellij_navigator#ZellijNewTab(<f-args>)
command -nargs=? ZellijNewPane call zellij_navigator#ZellijNewPane('', <f-args>)
command -nargs=? ZellijNewPaneSplit call zellij_navigator#ZellijNewPane('down', <f-args>)
command -nargs=? ZellijNewPaneVSplit call zellij_navigator#ZellijNewPane('right', <f-args>)

command -nargs=0 -bang ZellijNavigateUp call zellij_navigator#ZellijNavigateUp(<bang>0)
command -nargs=0 -bang ZellijNavigateDown call zellij_navigator#ZellijNavigateDown(<bang>0)
command -nargs=0 -bang ZellijNavigateLeft call zellij_navigator#ZellijNavigateLeft(<bang>0)
command -nargs=0 -bang ZellijNavigateRight call zellij_navigator#ZellijNavigateRight(<bang>0)

" Map C-h/j/k/l movements to navigate across Vim windows and Zellij panes.
if !exists("g:zellij_navigator_no_default_mappings") || g:zellij_navigator_no_default_mappings != 1
    if !exists("g:zelli_navigator_move_focus_or_tab") || g:zelli_navigator_move_focus_or_tab != 1
        noremap <silent> <C-h> :ZellijNavigateLeft<CR>
        noremap <silent> <C-j> :ZellijNavigateDown<CR>
        noremap <silent> <C-k> :ZellijNavigateUp<CR>
        noremap <silent> <C-l> :ZellijNavigateRight<CR>
    else
        noremap <silent> <C-h> :ZellijNavigateLeft!<CR>
        noremap <silent> <C-j> :ZellijNavigateDown!<CR>
        noremap <silent> <C-k> :ZellijNavigateUp!<CR>
        noremap <silent> <C-l> :ZellijNavigateRight!<CR>
    endif
endif

