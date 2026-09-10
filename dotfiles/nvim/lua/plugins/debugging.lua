local dap = require("dap")
local dapui = require("dapui")

dapui.setup()
require("nvim-dap-virtual-text").setup()
require("dap-go").setup()
require("dap-python").setup("python3")

vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>gb", dap.run_to_cursor, { desc = "Debug to cursor" })
vim.keymap.set("n", "<leader>?", function()
	dapui.eval(nil, { enter = true })
end, { desc = "Debug expression" })
vim.keymap.set("n", "<F1>", dap.continue, { desc = "Debug continue" })
vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug step over" })
vim.keymap.set("n", "<F3>", dap.step_back, { desc = "Debug step back" })
vim.keymap.set("n", "<F4>", dap.terminate, { desc = "Debug terminate" })
vim.keymap.set("n", "<F5>", dap.restart, { desc = "Debug restart" })
vim.keymap.set("n", "<F6>", dap.step_into, { desc = "Debug step into" })
vim.keymap.set("n", "<F7>", dap.step_out, { desc = "Debug step out" })

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end
