# avl.cmaker

## Description
`avl.cmaker` provides the `:CMaker` usercommand which lets you build a cmake based project from within neovim.

## Config
### Default config
```lua
{
    build_tool = ""
}
```

### Options
- `build_tool`: specify which build tool cmake will use. By default it will the default tool. Right now the only other supported build tool is Ninja.

#### Example
If you want to use Ninja as a build tool you should configure `avl.cmaker` like this:
```lua
require("avl.cmaker").setup({
    build_tool = "Ninja" -- this is case insensitive so "ninja" also works.
})
```

## Usage
`:CMaker`
