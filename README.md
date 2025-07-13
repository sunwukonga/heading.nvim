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

> [!Note]
> TODO: Alphabetise this list. And the associated data structure.

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

### HASKELL
```haskell
{-------

-------}
```

### SHELL
> [!Note]
> sh, bash, zsh, fish, ps1, asm, fortran, vb, fsharp, julia
> perl, ruby
```sh
##########
#        #
##########
```

### LATEX
> [!Note]
> tex, latex, erlang
```sh
%%%%%%%%%%
%        %
%%%%%%%%%%
```

### PASCAL
```pascal
{*********

*********}
```

### MATLAB
```mat
%{%%%%%%%%

%%%%%%%%%}
```

### ROXYGEN2
```roxygen2
#'''''''''
#'      #'
#'''''''''
```

### VIM
```vim
""""""""""
"        "
""""""""""
```

### CLOJURE
```clj
(comment ...........

...................)
```

### APL
```apl
⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝        ⍝
⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
```
