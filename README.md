# heading.nvim

Create a comment heading from a selection _not exceeding_ **64 characters** in
length.

Comment is inserted above selection without mutating selection.

Comment type is selected by the buffer filetype.

Default comment type (no filetype) is configurable with `opts.default_style = 'shell'`

> [!Note]
> Possible values of `default_style`:
> apl, clang, clojure, haskell, html, latex, lua, matlab, pascal, python, roxgen2, shell, vim

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

Plugins.opts = {
    default_style = 'shell'
}

return Plugin
```

## Supported Comment Types

> [!Note]
> Default is to use CLANG style

### APL
```apl
⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝        ⍝
⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
```

### CLANG
> [!Note]
> C, C++, C#, Java, JavaScript, TypeScript, PHP, Kotlin, Scala, Swift, Go, Rust, CSS, SQL, Objective-C, Dart, JSON5
```c
/******

******/
```

### CLOJURE
```clj
(comment ...........

...................)
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

### LATEX
> [!Note]
> tex, latex, erlang
```sh
%%%%%%%%%%
%        %
%%%%%%%%%%
```

### LUA
```lua
--[[======

========]]
```

### MATLAB
```mat
%{%%%%%%%%

%%%%%%%%%}
```

### PASCAL
```pascal
{*********

*********}
```

### PYTHON
```python
"""''''''

''''''"""
```

### ROXYGEN2
```roxygen2
#'''''''''
#'      #'
#'''''''''
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

### VIM
```vim
""""""""""
"        "
""""""""""
```
