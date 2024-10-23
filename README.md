# zellij.vim

Seamlessly navigate through Vim / Neovim and Zellij using this Vim plugin ( zellij.vim ) paired with the Zellij plugin [**zellij-autolock**](https://github.com/fresh2dev/zellij-autolock).

It works by using the same mapping -- `Ctrl + h/j/k/l` by default -- to navigate through Vim windows and Zellij panes. When already at the edge of a Vim instance, focus is moved to the neighboring Zellij pane.

In addition to providing the commands and mappings, this plugin will defines autocmds to put ZelliJ into "locked" mode on `VimEnter` and "normal" mode on `VimLeave`. This Vim plugin relies on the Zellij plugin [zellij-autolock](https://github.com/fresh2dev/zellij-autolock) to provide a seamless experience. With both of these plugins installed, Zellij will toggle its "locked" mode depending on whether the focused pane is running [neo]vim. When in "locked" mode, Zellij keybindings will not interfere with Vim keybindings.

## Demo

Here is a demonstration of how you can seamlessly navigate through Zellij panes running Vim, Neovim, and even other commands like FZF.

<video autoplay="false" controls="controls" style="width: 800px;">
  <source src="https://img.fresh2.dev/1716528665751_11894996682.webm" type="video/webm"/>
  <p><i>This page does not support webm video playback.</i></p>
  <p><i><a href="https://img.fresh2.dev/1716528665751_11894996682.webm" target="_blank">Click here to watch the demo recording.</a></i></p>
</video>
<p><b><i><a href="https://img.fresh2.dev/1716528665751_11894996682.webm" target="_blank">Open full screen demo recording.</a></i></b></p>

Notice how the Zellij mode ( "Normal" or "Locked" in the top-right corner ) automatically toggles depending which process is running within the focused Zellij pane. This allows you to use the same mappings (`Ctrl+h/j/k/l`) to navigate between Zellij panes, Vim windows, and even FZF results.

## Install

### vim-plug

```vim
Plug 'https://github.com/fresh2dev/zellij.vim.git'
```

### lazy.nvim

```lua
{
  'https://github.com/fresh2dev/zellij.vim.git',
  lazy = false,
}
```

## Use

### Commands

This plugin creates the following commands for navigation:

* `:ZellijNavigateUp`    - Move ***up*** one Vim window or Zellij pane.
* `:ZellijNavigateDown`  - Move ***down*** one Vim window or Zellij pane.
* `:ZellijNavigateLeft`  - Move ***left*** one Vim window or Zellij pane.
* `:ZellijNavigateRight` - Move ***right*** one Vim window or Zellij pane.

Add a bang (!) to move to neighboring ZelliJ panes *or tabs*.

* `:ZellijNavigateLeft!`  - Move ***left*** one Vim window or Zellij pane *or move to left Zellij tab*.
* `:ZellijNavigateRight!` - Move ***right*** one Vim window or Zellij pane *or move to right Zellij tab*.

Additional commands are included to allow opening a new Zellij pane *while preserving Vim's working directory*:

* `:ZellijNewPane`       - Open a ***floating*** Zellij pane.
* `:ZellijNewPaneSplit`  - Open a Zellij pane ***below***.
* `:ZellijNewPaneVSplit` - Open a Zellij pane to the ***right***.

The `ZellijNewPane...` commands can also invoke a command in the new pane, e.g.:

```vim
:ZellijNewPaneVSplit git log --graph --oneline
```

### Mappings

This plugin maps Ctrl + h/j/k/l for navigation.

You can modify the default mappings to move panes *or tabs* with:

```vim
let g:zelli_navigator_move_focus_or_tab = 1
```

Or, disable the default mappings with:

```vim
let g:zellij_navigator_no_default_mappings = 1
```

For reference, these are the default mappings:

```vim
nnoremap <silent> <C-h> :ZellijNavigateLeft<CR>
nnoremap <silent> <C-j> :ZellijNavigateDown<CR>
nnoremap <silent> <C-k> :ZellijNavigateUp<CR>
nnoremap <silent> <C-l> :ZellijNavigateRight<CR>
```

There are no default mappings for the `ZellijNewPane...` commands. If desired, define these yourself. This is what I use:

```vim
" Open ZelliJ floating pane.
nnoremap <leader>zjf :ZellijNewPane<CR>
" Open ZelliJ pane below.
nnoremap <leader>zjo :ZellijNewPaneSplit<CR>
" Open ZelliJ pane to the right.
nnoremap <leader>zjv :ZellijNewPaneVSplit<CR>

" Run command in new ZelliJ floating pane.
nnoremap <leader>zjrf :execute 'ZellijNewPane ' . input('Command: ')<CR>
" Run command in new ZelliJ pane below.
nnoremap <leader>zjro :execute 'ZellijNewPaneSplit ' . input('Command: ')<CR>
" Run command in new ZelliJ pane to the right.
nnoremap <leader>zjrv :execute 'ZellijNewPaneVSplit ' . input('Command: ')<CR>
```

### Autocommands

This plugin was built to be paired with the Zellij plugin [**zellij-autolock**](https://github.com/fresh2dev/zellij-autolock). By design, this plugin will define autocommands to lock Zellij on *VimEnter* and unlock on *VimLeave*. If you don't desire this behavior, define this variable to disable autolocking:

```vim
let g:zellij_navigator_disable_autolock = 1
```

Even without this plugin, you can control Zellij by calling the Zellij CLI from within Vim. For example, here's a Vim autocommand which names the current Zellij tab after Vim's current working directory (an excerpt from [my dotfiles](https://github.com/fresh2dev/dotfiles)):

```vim
autocmd DirChanged,BufEnter *
    \ if &buftype == '' |
    \ call system('zellij action rename-tab "' . fnamemodify(getcwd(), ':t') . '"') |
    \ endif
```

## Shoutouts

- [zellij-org/zellij](https://github.com/zellij-org/zellij)
- [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)
