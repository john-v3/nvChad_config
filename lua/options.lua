require "nvchad.options"

local os_name = vim.loop.os_uname().sysname

local o = vim.o

o.cursorlineopt = "both" -- to enable cursorline!

if os_name == "Windows_NT" then
  o.shell = "pwsh"
  o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
  o.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
  o.shellquote = '"'
else
  o.shell = "bash"
end

o.scrolloff = 10

