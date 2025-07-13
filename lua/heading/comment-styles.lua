local M = {}

local CommentStyle = {
  CLANG    = 'clang',
  PYTHON   = 'python',
  HTML     = 'html',
  LUA      = 'lua',
  HASKELL  = 'haskell',
  PASCAL   = 'pascal',
  -- PERL     = 'perl',  -- Such a trashy mechanism, may as well use single line re: SHELL
  MATLAB   = 'matlab',
  ROXYGEN2 = 'roxgen2',
  SHELL    = 'shell',
  LATEX    = 'latex',
  VIM      = 'vim',
  -- ERLANG   = 'erlang',  -- Same as LATEX
  CLOJURE  = 'clojure',
  APL      = 'apl',
}

local FiletypeStyles = {
  -- C-style block comments /* */
  c = CommentStyle.CLANG,
  cpp = CommentStyle.CLANG,
  cs = CommentStyle.CLANG,
  java = CommentStyle.CLANG,
  javascript = CommentStyle.CLANG,
  typescript = CommentStyle.CLANG,
  php = CommentStyle.CLANG,
  kotlin = CommentStyle.CLANG,
  scala = CommentStyle.CLANG,
  swift = CommentStyle.CLANG,
  go = CommentStyle.CLANG,
  rust = CommentStyle.CLANG,
  css = CommentStyle.CLANG,
  sql = CommentStyle.CLANG,
  objc = CommentStyle.CLANG,
  dart = CommentStyle.CLANG,
  json5 = CommentStyle.CLANG,

  -- Python docstrings """ """
  python = CommentStyle.PYTHON,

  -- HTML/XML comments <!-- -->
  html = CommentStyle.HTML,
  xml = CommentStyle.HTML,
  sgml = CommentStyle.HTML,
  markdown = CommentStyle.HTML,

  -- Lua long comments --[[ ]]
  lua = CommentStyle.LUA,

  -- Haskell nested comments {- -}
  haskell = CommentStyle.HASKELL,

  -- Pascal-style comments (* *)
  pascal = CommentStyle.PASCAL,
  delphi = CommentStyle.PASCAL,
  modula2 = CommentStyle.PASCAL,
  ocaml = CommentStyle.PASCAL,

  -- These SHOULD be hash block comments =begin =end, but it doesn't make for
  -- good bordering of the heading
  ruby = CommentStyle.SHELL,
  perl = CommentStyle.SHELL,

  -- MATLAB block comments %{ %}
  matlab = CommentStyle.MATLAB,

  -- R roxygen2 comments
  r = CommentStyle.ROXYGEN2,

  -- Single-line comment languages
  sh = CommentStyle.SHELL,
  bash = CommentStyle.SHELL,
  zsh = CommentStyle.SHELL,
  fish = CommentStyle.SHELL,
  ps1 = CommentStyle.SHELL,
  asm = CommentStyle.SHELL,
  fortran = CommentStyle.SHELL,
  vb = CommentStyle.SHELL,
  fsharp = CommentStyle.SHELL,
  julia = CommentStyle.SHELL,

  -- Special cases
  tex = CommentStyle.LATEX,
  latex = CommentStyle.LATEX,
  vim = CommentStyle.VIM,
  erlang = CommentStyle.LATEX,
  clojure = CommentStyle.CLOJURE,
  apl = CommentStyle.APL,
}

local commentBuilder = {
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

local function insertComment(base, comment, spaces)
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

function M.buildComment(selectStyle, comment)
  -- CLANG is the default value
  local style = selectStyle or CommentStyle.CLANG
  -- compute how many spaces to pad on the left
  local spaces = (64 - string.len(comment)) / 2
  local commentBase = shallow_copy(commentBuilder[style])

  return insertComment(commentBase, comment, spaces)
end

M.FiletypeStyles = FiletypeStyles

return M
