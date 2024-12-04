if exists("g:zellij_navigator_loaded") || (exists("g:zellij_navigator_enabled") && g:zellij_navigator_enabled != 1)
    finish
endif

let g:zellij_navigator_loaded = 1

command -nargs=0 -bang ZellijNavigateUp call zellij_navigator#ZellijNavigateUp(<bang>0)
command -nargs=0 -bang ZellijNavigateDown call zellij_navigator#ZellijNavigateDown(<bang>0)
command -nargs=0 -bang ZellijNavigateLeft call zellij_navigator#ZellijNavigateLeft(<bang>0)
command -nargs=0 -bang ZellijNavigateRight call zellij_navigator#ZellijNavigateRight(<bang>0)

command -nargs=? ZellijNewPane call zellij_navigator#ZellijNewPane('', <f-args>)
command -nargs=? ZellijNewPaneSplit call zellij_navigator#ZellijNewPane('down', <f-args>)
command -nargs=? ZellijNewPaneVSplit call zellij_navigator#ZellijNewPane('right', <f-args>)

if exists("g:zellij_navigator_no_default_mappings") && g:zellij_navigator_no_default_mappings == 1
    finish
endif

if exists("g:zelli_navigator_move_focus_or_tab") && g:zelli_navigator_move_focus_or_tab == 1
    nnoremap <silent> <C-h> :ZellijNavigateLeft!<CR>
    nnoremap <silent> <C-j> :ZellijNavigateDown!<CR>
    nnoremap <silent> <C-k> :ZellijNavigateUp!<CR>
    nnoremap <silent> <C-l> :ZellijNavigateRight!<CR>
else
    nnoremap <silent> <C-h> :ZellijNavigateLeft<CR>
    nnoremap <silent> <C-j> :ZellijNavigateDown<CR>
    nnoremap <silent> <C-k> :ZellijNavigateUp<CR>
    nnoremap <silent> <C-l> :ZellijNavigateRight<CR>
endif
