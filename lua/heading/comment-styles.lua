local M = {}

M.CommentStyle = {
  APL      = 'apl',
  CLANG    = 'clang',
  CLOJURE  = 'clojure',
  -- ERLANG   = 'erlang',  -- Same as LATEX
  HASKELL  = 'haskell',
  HTML     = 'html',
  LATEX    = 'latex',
  LUA      = 'lua',
  MATLAB   = 'matlab',
  PASCAL   = 'pascal',
  -- PERL     = 'perl',  -- Such a trashy mechanism, may as well use single line re: SHELL
  PYTHON   = 'python',
  ROXYGEN2 = 'roxgen2',
  SHELL    = 'shell',
  VIM      = 'vim',
}

local FiletypeStyles = {
  -- C-style block comments /* */
  c = M.CommentStyle.CLANG,
  cpp = M.CommentStyle.CLANG,
  cs = M.CommentStyle.CLANG,
  java = M.CommentStyle.CLANG,
  javascript = M.CommentStyle.CLANG,
  typescript = M.CommentStyle.CLANG,
  php = M.CommentStyle.CLANG,
  kotlin = M.CommentStyle.CLANG,
  scala = M.CommentStyle.CLANG,
  swift = M.CommentStyle.CLANG,
  go = M.CommentStyle.CLANG,
  rust = M.CommentStyle.CLANG,
  css = M.CommentStyle.CLANG,
  sql = M.CommentStyle.CLANG,
  objc = M.CommentStyle.CLANG,
  dart = M.CommentStyle.CLANG,
  json5 = M.CommentStyle.CLANG,

  -- Python docstrings """ """
  python = M.CommentStyle.PYTHON,

  -- HTML/XML comments <!-- -->
  html = M.CommentStyle.HTML,
  xml = M.CommentStyle.HTML,
  sgml = M.CommentStyle.HTML,
  markdown = M.CommentStyle.HTML,

  -- Lua long comments --[[ ]]
  lua = M.CommentStyle.LUA,

  -- Haskell nested comments {- -}
  haskell = M.CommentStyle.HASKELL,

  -- Pascal-style comments (* *)
  pascal = M.CommentStyle.PASCAL,
  delphi = M.CommentStyle.PASCAL,
  modula2 = M.CommentStyle.PASCAL,
  ocaml = M.CommentStyle.PASCAL,

  -- These SHOULD be hash block comments =begin =end, but it doesn't make for
  -- good bordering of the heading
  ruby = M.CommentStyle.SHELL,
  perl = M.CommentStyle.SHELL,

  -- MATLAB block comments %{ %}
  matlab = M.CommentStyle.MATLAB,

  -- R roxygen2 comments
  r = M.CommentStyle.ROXYGEN2,

  -- Single-line comment languages
  sh = M.CommentStyle.SHELL,
  bash = M.CommentStyle.SHELL,
  zsh = M.CommentStyle.SHELL,
  fish = M.CommentStyle.SHELL,
  ps1 = M.CommentStyle.SHELL,
  asm = M.CommentStyle.SHELL,
  fortran = M.CommentStyle.SHELL,
  vb = M.CommentStyle.SHELL,
  fsharp = M.CommentStyle.SHELL,
  julia = M.CommentStyle.SHELL,

  -- Special cases
  tex = M.CommentStyle.LATEX,
  latex = M.CommentStyle.LATEX,
  vim = M.CommentStyle.VIM,
  erlang = M.CommentStyle.LATEX,
  clojure = M.CommentStyle.CLOJURE,
  apl = M.CommentStyle.APL,
}

local CommentBuilder = {
  clang =
  {
    "    /*//////////////////////////////////////////////////////////////",
    "    ",
    "    //////////////////////////////////////////////////////////////*/",
    ""
  },
  python =
  {
    "    \"\"\"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''",
    "    ",
    "    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''\"\"\"",
    ""
  },
  html =
  {
    "    <!--------------------------------------------------------------",
    "    ",
    "    --------------------------------------------------------------->",
    ""
  },
  lua =
  {
    "    --[" .. "[============================================================",
    "    ",
    "    ==============================================================]" .. "]",
    ""
  },
  haskell =
  {
    "    {---------------------------------------------------------------",
    "    ",
    "    ---------------------------------------------------------------}",
    ""
  },
  shell =
  {
    "    ################################################################",
    "    ",
    "    ################################################################",
    "#"
  },
  latex =
  {
    "    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%",
    "    ",
    "    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%",
    "%"
  },
  pascal =
  {
    "    {***************************************************************",
    "    ",
    "    ***************************************************************}",
    ""
  },
  matlab =
  {
    "    %{%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%",
    "    ",
    "    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%}",
    ""
  },
  roxygen2 =
  {
    "    #'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''",
    "    ",
    "    #'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''",
    "#'"
  },
  vim =
  {
    "    \"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"",
    "    ",
    "    \"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"",
    "\""
  },
  -- clojure could use `;` single line comment style, but clojure has an
  -- informal meaning associated with repeated use i.e. `;;`, `;;;`, `;;;;`
  clojure =
  {
    "    (comment .......................................................",
    "    ",
    "    ...............................................................)",
    "%"
  },
  apl =
  {
    "    ⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝",
    "    ",
    "    ⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝",
    "⍝"
  },
}

local function shallow_copy(orig)
  local copy = {}
  for k, v in pairs(orig) do
    copy[k] = v
  end
  return copy
end

local function insert_comment(base, comment, spaces)
  local commentPreamble = base[2]
  local fixerLength = string.len(base[4])

  local fixer = base[4]
  table.remove(base, 4)
  local commentParity = string.len(comment) % 2
  if fixerLength > 0 then
    base[2] = commentPreamble ..
              fixer ..
              string.rep(" ", spaces - fixerLength) ..
              string.upper(comment) ..
              string.rep(" ", spaces - fixerLength + commentParity) ..
              fixer
  else
    base[2] = commentPreamble .. string.rep(" ", spaces) .. string.upper(comment)
  end
  return base
end

function M.build_comment_factory(default_style)
  return function(selectStyle, comment)
    local style = selectStyle or default_style
    local comment_base = shallow_copy(CommentBuilder[style])
    local comment_length = string.len(comment)
    local comment_max_length = 64 - 2 * string.len(comment_base[4])
    if comment_length > comment_max_length then
      vim.notify(
        string.format("Comment length (%d) exceeds maximum (%d) for style '%s'",
                  comment_length, comment_max_length, style))
      return nil
    end
    -- compute how many spaces to pad on the left
    local spaces = (64 - comment_length) / 2

    return insert_comment(comment_base, comment, spaces)
  end
end

M.FiletypeStyles = FiletypeStyles

return M
