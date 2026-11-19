-- Keeps NvChad's "omarchy" base46 theme (lua/themes/omarchy.lua) in step with
-- the Omarchy theme.
--
-- sync()  recompiles the base46 cache at startup when the Omarchy theme changed
--         while Neovim was closed.
-- watch() recolors running Neovim instances when `omarchy theme set` runs.
--
-- Both do nothing unless chadrc's base46.theme is "omarchy", so picking another
-- theme with NvChad's theme picker still works.

local M = {}

local state_dir = vim.fn.expand "~/.local/state/omarchy/current"
local generation_file = state_dir .. "/theme.generation"
local stamp_file = vim.g.base46_cache .. "omarchy-generation"

local function read(path)
  local file = io.open(path, "r")
  if not file then
    return nil
  end
  local content = file:read "*a"
  file:close()
  return vim.trim(content)
end

local function write(path, content)
  vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
  local file = io.open(path, "w")
  if file then
    file:write(content)
    file:close()
  end
end

local function enabled()
  local ok, chadrc = pcall(require, "chadrc")
  return ok and chadrc.base46 and chadrc.base46.theme == "omarchy"
end

-- A theme switch writes theme.name after theme.generation, so this fingerprint
-- changes once the new theme directory is fully in place.
local function fingerprint()
  return (read(generation_file) or "") .. ":" .. (read(state_dir .. "/theme.name") or "")
end

-- What this instance last applied. The stamp file is shared by every Neovim
-- instance, so it only answers "is the compiled cache current?" at startup.
local applied = nil

function M.reload()
  package.loaded["themes.omarchy"] = nil
  require("base46").load_all_highlights()
  applied = fingerprint()
  write(stamp_file, applied)
end

function M.sync()
  if not enabled() then
    return
  end
  if read(stamp_file) ~= fingerprint() then
    M.reload()
  else
    applied = fingerprint()
  end
end

function M.watch()
  if not enabled() or vim.fn.isdirectory(state_dir) == 0 then
    return
  end

  local handle = vim.uv.new_fs_event()
  local timer = vim.uv.new_timer()
  if not handle or not timer then
    return
  end

  handle:start(state_dir, {}, function(err, filename)
    if err or (filename ~= "theme.name" and filename ~= "theme.generation") then
      return
    end
    -- Debounce: a theme switch touches several files in quick succession.
    timer:stop()
    timer:start(
      150,
      0,
      vim.schedule_wrap(function()
        if applied ~= fingerprint() then
          M.reload()
        end
      end)
    )
  end)

  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
      handle:stop()
      timer:stop()
    end,
  })
end

return M
