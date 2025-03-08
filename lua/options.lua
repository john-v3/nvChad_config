require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!
o.shell = 'pwsh'
o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
o.shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
o.shellquote = '"'
o.scrolloff=10

