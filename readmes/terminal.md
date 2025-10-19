# avl.terminal

## Description
`avl.terminal` provides a better neovim terminal experience. It allows you to toggle a persistent terminal and allows you to go back to normal mode using <Esc> (if keybinds are enabled). By default it only exposes the usercommands `:ToggleTerm` and `:DiscardTerm`.

## Config
### Default config
```lua
local config = {
	height = 10,
	filetype = "avl-terminal",
	set_keymaps = false,
}
```

### Options
- `height`: the height of the terminal window in lines.
- `filetype`: the filetype which will be set for the terminal. This can be useful for disabling lualine etc.
- `set_keymaps`: whether or not to run the `set_keymaps` function. This function sets `<leader>tt` in normal mode to toggle the terminal, `<leader>tx` in normal mode to discard the terminal and `<Esc>` in terminal mode to exit back to normal mode.

#### Example
If you want the keymaps set for you:
```lua
local config = {
	set_keymaps = true,
}
```

## Usage
If keymaps are not enabled:
- `:ToggleTerm`: to toggle the terminal.
- `:DiscardTerm`: to discard the terminal.

If keymaps are enaabled:
- `<leader>tt`: to toggle the terminal.
- `<leader>tx`: to discard the terminal.
- `<Esc>`: to exit terminal mode back to normal mode.
