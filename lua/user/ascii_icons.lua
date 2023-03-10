local M = {}

M.kind = {
  Array = "",
  Boolean = "",
  Class = "",
  Color = "",
  Constant = "",
  Constructor = "",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "",
  File = "",
  Folder = "",
  Function = "",
  Interface = "",
  Key = "",
  Keyword = "",
  Method = "",
  Module = "",
  Namespace = "",
  Null = "ﳠ",
  Number = "",
  Object = "",
  Operator = "",
  Package = "",
  Property = "",
  Reference = "",
  Snippet = "",
  String = "",
  Struct = "",
  Text = "",
  TypeParameter = "",
  Unit = "",
  Value = "",
  Variable = "",
}

M.git = {
  LineAdded = "",
  LineModified = "",
  LineRemoved = "",
  FileDeleted = "",
  FileIgnored = "◌",
  FileRenamed = "",
  FileStaged = "S",
  FileUnmerged = "",
  FileUnstaged = "",
  FileUntracked = "U",
  Diff = "",
  Repo = "",
  Octoface = "",
  Branch = "",
}

M.ui = {
  ArrowCircleDown = "",
  ArrowCircleLeft = "",
  ArrowCircleRight = "",
  ArrowCircleUp = "",
  BoldArrowDown = "",
  BoldArrowLeft = "",
  BoldArrowRight = "",
  BoldArrowUp = "",
  BoldClose = "",
  BoldDividerLeft = "",
  BoldDividerRight = "",
  BoldLineLeft = "▎",
  BookMark = "",
  BoxChecked = "",
  Bug = "",
  Stacks = "",
  Scopes = "",
  Watches = "",
  DebugConsole = "",
  Calendar = "",
  Check = "",
  ChevronRight = ">",
  ChevronShortDown = "",
  ChevronShortLeft = "",
  ChevronShortRight = "",
  ChevronShortUp = "",
  Circle = "",
  Close = "",
  CloudDownload = "",
  Code = "",
  Comment = "",
  Dashboard = "",
  DividerLeft = "",
  DividerRight = "",
  DoubleChevronRight = "»",
  Ellipsis = "",
  EmptyFolder = "",
  EmptyFolderOpen = "",
  File = "",
  FileSymlink = "",
  Files = "",
  FindFile = "",
  FindText = "",
  Fire = "",
  Folder = "",
  FolderOpen = "",
  FolderSymlink = "",
  Forward = "",
  Gear = "",
  History = "",
  Lightbulb = "",
  LineLeft = "▏",
  LineMiddle = "│",
  List = "",
  Lock = "",
  NewFile = "",
  Note = "",
  Package = "",
  Pencil = "",
  Plus = "",
  Project = "",
  Search = "",
  SignIn = "",
  SignOut = "",
  Tab = "",
  Table = "",
  Target = "",
  Telescope = "",
  Text = "",
  Tree = "",
  Triangle = "契",
  TriangleShortArrowDown = "",
  TriangleShortArrowLeft = "",
  TriangleShortArrowRight = "",
  TriangleShortArrowUp = "",
}

M.diagnostics = {
  BoldError = "",
  Error = "",
  BoldWarning = "",
  Warning = "",
  BoldInformation = "",
  Information = "",
  BoldQuestion = "",
  Question = "",
  BoldHint = "",
  Hint = "",
  Debug = "",
  Trace = "✎",
}

M.misc = {
  Robot = "ﮧ",
  Squirrel = "",
  Tag = "",
  Watch = "",
  Smiley = "",
  Package = "",
  CircuitBoard = "",
}

M.mason = {
  package_pending = " ",
  package_installed = " ",
  package_uninstalled = " ﮊ",
}

M.cmp_kind = {
  Class = " ",
  Color = " ",
  Constant = "",
  Constructor = " ",
  Default = " ",
  Enum = "練",
  EnumMember = " ",
  Event = " ",
  Field = "ﰠ ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = " ",
  Keyword = " ",
  Method = "",
  Module = "",
  Operator = " ",
  Property = " ",
  Reference = "",
  Snippet = "", -- ""," "," "
  Struct = "פּ ",
  Text = " ",
  TypeParameter = "  ",
  Unit = "塞",
  Value = " ",
  Variable = "",
}

M.icons = {
  error = " ",
  warn = " ",
  info = "",
  hint = " ",
  code_action = "",
  code_lens_action = "",
  test = "",
  docs = "",
  clock = " ",
  calendar = " ",
  buffer = " ",
  settings = " ",
  ls_inactive = "轢",
  ls_active = "歷",
  question = " ",
  screen = "冷",
  dart = " ",
  config = " ",
  git = " ",
  magic = " ",
  exit = " ",
  repo = "",
  term = " ",
}

M.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unmerged = "",
    added = "",
    deleted = "",
    modified = "",
    renamed = "",
    untracked = "",
    ignored = "",
    unstaged = "",
    staged = "",
    conflict = "",
  },
  folder = {
    arrow_closed = "",
    arrow_open = "",
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
    symlink_open = "",
  },
}

M.symbols_outline = {
  File = "",
  Module = "",
  Namespace = "",
  Package = "",
  Class = "",
  Method = "ƒ",
  Property = "",
  Field = "",
  Constructor = "",
  Enum = "練",
  Interface = "ﰮ",
  Function = "",
  Variable = "",
  Constant = "",
  String = "𝓐",
  Number = "#",
  Boolean = "⊨",
  Array = "",
  Object = "⦿",
  Key = "",
  Null = "NULL",
  EnumMember = "",
  Struct = "פּ",
  Event = "",
  Operator = "",
  TypeParameter = "𝙏",
}

M.todo_comments = {
  FIX = "律",
  TODO = "璘",
  HACK = " ",
  WARN = "裂",
  PERF = "龍",
  NOTE = " ",
  ERROR = " ",
  REFS = "",
  SHIELD = "",
}

M.numbers = {
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
}

M.file_icons = {
  Brown = { "" },
  Aqua = { "" },
  LightBlue = { "", "" },
  Blue = { "", "", "", "", "", "", "", "", "", "", "", "", "" },
  DarkBlue = { "", "" },
  Purple = { "", "", "", "", "" },
  Red = { "", "", "", "", "", "" },
  Beige = { "", "", "" },
  Yellow = { "", "", "λ", "", "" },
  Orange = { "", "" },
  DarkOrange = { "", "", "", "", "" },
  Pink = { "", "" },
  Salmon = { "" },
  Green = { "", "", "", "", "", "" },
  LightGreen = { "", "", "", "﵂" },
  White = { "", "", "", "", "", "" },
}

M.dashboard = {
  FindFile = " ",
  NewFile = " ",
  FindProject = " ",
  RecentFiles = " ",
  FindText = " ",
  Config = " ",
  Quit = " ",
}

return M
