function s:zellij_nav(short_direction, direction, bang)
    " get window ID, try switching windows, and get ID again to see if it worked
    let cur_winnr = winnr()
    execute "wincmd " . a:short_direction

    " if the window ID didn't change, then we didn't switch
    if cur_winnr == winnr()
        let command = "zellij action move-focus" . (a:bang ? "-or-tab " : " ") . a:direction
        call system(command)
    endif
endfunction

function zellij_navigator#ZellijNavigateUp(bang)
    call s:zellij_nav("k", "up", a:bang)
endfunction

function zellij_navigator#ZellijNavigateDown(bang)
    call s:zellij_nav("j", "down", a:bang)
endfunction

function zellij_navigator#ZellijNavigateRight(bang)
    call s:zellij_nav("l", "right", a:bang)
endfunction

function zellij_navigator#ZellijNavigateLeft(bang)
    call s:zellij_nav("h", "left", a:bang)
endfunction

function zellij_navigator#ZellijLock()
    call system('zellij action switch-mode locked')
endfunction

function zellij_navigator#ZellijUnlock()
    call system('zellij action switch-mode normal')
endfunction

function zellij_navigator#ZellijNewPane(direction = '', cmd = '')
    call zellij_navigator#ZellijUnlock()
    " If no command given, call $SHELL.
    let l:cmd = len(a:cmd) > 0 ? a:cmd : $SHELL
    " If no command given, close on exit.
    let l:close_on_exit = len(a:cmd) > 0 ? '' : '--close-on-exit'
    " If no direction given, default to 'floating'
    let l:direction = len(a:direction) > 0 ? '--direction ' . a:direction : '--floating'
    " Must be called this way to preserve the cwd.
    call system('zellij action new-pane ' . l:direction . ' ' . l:close_on_exit . ' --cwd "' . getcwd() . '" -- ' . l:cmd)
endfunction

