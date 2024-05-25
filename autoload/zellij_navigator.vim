function! s:zellij_nav(short_direction, direction)
    " get window ID, try switching windows, and get ID again to see if it worked
    let cur_winnr = winnr()
    execute "wincmd " . a:short_direction

    " if the window ID didn't change, then we didn't switch
    if cur_winnr == winnr()
        call system("zellij action move-focus " . a:direction)
    endif
endfunction

function! zellij_navigator#ZellijNavigateUp()
    call s:zellij_nav("k", "up")
endfunction

function! zellij_navigator#ZellijNavigateDown()
    call s:zellij_nav("j", "down")
endfunction

function! zellij_navigator#ZellijNavigateRight()
    call s:zellij_nav("l", "right")
endfunction

function! zellij_navigator#ZellijNavigateLeft()
    call s:zellij_nav("h", "left")
endfunction

function! zellij_navigator#ZellijLock()
    call system('zellij action switch-mode locked')
endfunction

function! zellij_navigator#ZellijUnlock()
    call system('zellij action switch-mode normal')
endfunction

function! zellij_navigator#ZellijNewPane(direction = '')
    call zellij_navigator#ZellijUnlock()
    let l:direction = len(a:direction) > 0 ? ' --direction ' . a:direction : ' --floating'
    call system('zellij action new-pane ' . l:direction . ' --close-on-exit --cwd "' . getcwd() . '" -- ' . $SHELL)
endfunction
