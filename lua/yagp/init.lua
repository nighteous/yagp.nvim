local M = {}

M.setup = function ()
	vim.api.nvim_create_user_command("AskGemini", "lua use_gemini()", {})
end

local function append_to_buffer(bufnr, text_split)
	for i, sentence in pairs(text_split) do
		vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, { text_split[i] })
	end
end

function use_gemini()
	local google_gemini = require("yagp.google_gemini_request")
	local ask_gemini = google_gemini.ask_gemini

	-- Get buffer
	local chat_buffer_name = "yagpchat"
	local bufnr = vim.fn.bufnr(chat_buffer_name)

	if bufnr == -1 then
		-- Buffer doesn't exist, create it
		vim.cmd(string.format("vsplit " .. "%s", chat_buffer_name))
		bufnr = vim.fn.bufnr(chat_buffer_name)
	end

	local vstart = vim.fn.getpos("'<")
	local vend = vim.fn.getpos("'>")

	local line_start = vstart[2]
	local line_end = vend[2]

	local text = vim.fn.getline(line_start, line_end)
	local user_input = table.concat(text, "\r")

	-- Appending to buffer
	vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, { "USER: " })
	user_input_split = vim.split(user_input, "\r")
	append_to_buffer(bufnr, user_input_split)

	local response = ask_gemini(user_input)
	print(response)

	-- Appending output to buffer
	vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, { "BOT: " })
	local response_split = vim.split(response, "\n")
	append_to_buffer(bufnr, response_split)

	vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, { "\r" })

end

return M
