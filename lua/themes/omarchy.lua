-- NvChad (base46) theme built from the active Omarchy theme.
--
-- Omarchy stages the selected theme at ~/.local/state/omarchy/current/theme,
-- and every theme there has a colors.toml (Omarchy generates one from
-- alacritty.toml for themes that only ship that). This file turns that palette
-- into base46's base_30/base_16 tables. lua/omarchy.lua recompiles the
-- highlights whenever the Omarchy theme changes.

local colors_path = vim.fn.expand "~/.local/state/omarchy/current/theme/colors.toml"

local function read_colors(path)
  local file = io.open(path, "r")
  if not file then
    return nil
  end

  local colors = {}
  for line in file:lines() do
    local key, value = line:match '^%s*([%w_]+)%s*=%s*"([^"]*)"'
    if key then
      colors[key] = value
    end
  end
  file:close()

  return next(colors) and colors or nil
end

local c = read_colors(colors_path)

-- No Omarchy theme staged (or unreadable): fall back to the previous theme.
if not c or not (c.background and c.foreground) then
  local M = vim.deepcopy(require "base46.themes.everblush")
  return M
end

local palette = require "base46.colors"
local lighten = palette.change_hex_lightness
local mix = palette.mix

local is_light = c.mode == "light"
local bg = c.background
local fg = c.foreground

-- Step away from the background: lighter on dark themes, darker on light ones.
local function shade(percent)
  return lighten(bg, is_light and -percent or percent)
end

local function pick(...)
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    if v and v ~= "" then
      return v
    end
  end
end

local red = pick(c.red, "#e57474")
local green = pick(c.green, "#8ccf7e")
local yellow = pick(c.yellow, "#e5c76b")
local blue = pick(c.blue, "#67b0e8")
local magenta = pick(c.magenta, "#c47fd5")
local cyan = pick(c.cyan, "#6cbfbf")
local orange = pick(c.orange, mix(red, yellow, 50))
local accent = pick(c.accent, blue)

local M = {}

M.base_30 = {
  white = fg,
  darker_black = shade(-3),
  black = bg, -- nvim bg
  black2 = shade(5),
  one_bg = shade(8),
  one_bg2 = shade(13),
  one_bg3 = shade(18),
  grey = shade(24),
  grey_fg = shade(30),
  grey_fg2 = shade(36),
  light_grey = shade(42),
  red = red,
  baby_pink = pick(c.bright_red, lighten(red, 8)),
  pink = pick(c.bright_magenta, magenta),
  line = shade(11), -- for lines like vertsplit
  green = green,
  vibrant_green = pick(c.bright_green, lighten(green, 6)),
  nord_blue = mix(blue, cyan, 30),
  blue = blue,
  yellow = yellow,
  sun = pick(c.bright_yellow, lighten(yellow, 6)),
  purple = magenta,
  dark_purple = lighten(magenta, is_light and 8 or -8),
  teal = mix(green, cyan, 50),
  orange = orange,
  cyan = cyan,
  statusline_bg = shade(4),
  lightbg = shade(11),
  lightbg2 = shade(7),
  pmenu_bg = accent,
  folder_bg = blue,
}

M.base_16 = {
  base00 = bg,
  base01 = shade(8),
  base02 = pick(c.selection_background, c.selection, shade(13)),
  base03 = shade(18),
  base04 = shade(28),
  base05 = fg,
  base06 = pick(c.bright_foreground, fg),
  base07 = fg,
  base08 = red,
  base09 = orange,
  base0A = yellow,
  base0B = green,
  base0C = cyan,
  base0D = blue,
  base0E = magenta,
  base0F = pick(c.brown, c.bright_red, red),
}

M.type = is_light and "light" or "dark"

M = require("base46").override_theme(M, "omarchy")

return M
