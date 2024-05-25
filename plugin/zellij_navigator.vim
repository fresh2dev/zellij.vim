if exists("g:zellij_navigator_loaded") || (exists("g:zellij_navigator_enabled") && g:zellij_navigator_enabled != 1)
    finish
endif

let g:zellij_navigator_loaded = 1

autocmd VimEnter,WinEnter * call zellij_navigator#ZellijLock()
autocmd VimLeave * call zellij_navigator#ZellijUnlock()

command! -nargs=0 ZellijNavigateUp call zellij_navigator#ZellijNavigateUp()
command! -nargs=0 ZellijNavigateDown call zellij_navigator#ZellijNavigateDown()
command! -nargs=0 ZellijNavigateLeft call zellij_navigator#ZellijNavigateLeft()
command! -nargs=0 ZellijNavigateRight call zellij_navigator#ZellijNavigateRight()

command! -nargs=0 ZellijNewPane call zellij_navigator#ZellijNewPane()
command! -nargs=0 ZellijNewPaneSplit call zellij_navigator#ZellijNewPane('down')
command! -nargs=0 ZellijNewPaneVSplit call zellij_navigator#ZellijNewPane('right')

if exists("g:zellij_navigator_no_default_mappings") && g:zellij_navigator_no_default_mappings == 1
    finish
endif

noremap <C-h> :ZellijNavigateLeft<CR>
noremap <C-j> :ZellijNavigateDown<CR>
noremap <C-k> :ZellijNavigateUp<CR>
noremap <C-l> :ZellijNavigateRight<CR>
