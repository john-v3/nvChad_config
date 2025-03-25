require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

map("n", "<C-t>", function()
  require("nvchad.themes").open()
end, {})

map("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

map({ "n" }, "<leader>gd", function()
  require("vgit").project_diff_preview()
end, { desc = "View project differences" })

map({ "n" }, "<leader>gl", function()
  require("vgit").project_logs_preview()
end, { desc = "View project commit history" })

map({ "n" }, "<leader>gbh", function()
  require("vgit").buffer_history_preview()
end, { desc = "View history of current buffer" })

map({ "n" }, "<leader>o", "<cmd>Outline<CR>", { desc = "view outline of current buffer" })

map({ "n" }, "<leader>ft", "<cmd>OmniSharpFindType<CR>", { desc = "Find Type" })

map({ "n" }, "<leader>fr", "<cmd>Telescope resume<CR>", { desc = "Find Type" })

map({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { desc = "Flash" })

map({ "n", "x", "o" }, "S", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter" })

map({ "o" }, "r", function()
  require("flash").remote()
end, { desc = "Remote Flash" })

map({ "o", "x" }, "R", function()
  require("flash").treesitter_search()
end, { desc = "Treesitter Search" })

map({ "c" }, "<c-s>", function()
  require("flash").toggle()
end, { desc = "Toggle Flash Search" })

-- vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
