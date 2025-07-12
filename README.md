# heading.nvim

Create a comment heading from a selection _not exceeding_ **64 characters** in
length. Comment is inserted above selection without mutating selection.

## Example
```ts
    /*//////////////////////////////////////////////////////////////
                           THIS IS AN EXAMPLE
    //////////////////////////////////////////////////////////////*/
```

## Install

> /lua/plugins/header.lua
```lua
local Plugin = { 'sunwukonga/heading.nvim' }

Plugin.keys = {
  {
    "<leader>ah",
    ":AddHeading<CR>",
    mode = "v",
    desc = "Use selected text to splat heading comment",
    silent = true,
    buffer = true
  },
}

return Plugin
```
