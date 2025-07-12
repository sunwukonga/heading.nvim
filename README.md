# heading.nvim

Create a comment heading from a selection _not exceeding_ **64 characters** in
length.

Comment is inserted above selection without mutating selection.

Comment type is selected by the buffer filetype.

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

## Supported Comment Types

### CLANG
> [!Note]
> C, C++, C#, Java, JavaScript, TypeScript, PHP, Kotlin, Scala, Swift, Go, Rust, CSS, SQL, Objective-C, Dart, JSON5
```c
/******

******/
```

### PYTHON
```python
"""''''''

''''''"""
```

### HASKELL
```haskell
{-------

-------}
```

### HTML
> [!Note]
> HTML, XML, SGML, Markdown (embedded)
```html
<!-------

-------->
```

### LUA
```lua
--[[======

========]]
```

### SHELL
> [!Note]
> Shell/Bash/Sh, PowerShell, Assembly (most variants), Fortran 90+, VB.NET, F#, Julia
```sh
##########
#        #
##########
```
