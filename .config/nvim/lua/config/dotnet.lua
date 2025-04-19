--helper functions specific to dotnet

local uv = vim.loop

local M = {}

local log_path = vim.fn.stdpath("log") .. "/dotnet.log"

local terminal_config = {
	width_ratio = 0.8,
	height_ratio = 0.6,
	row_ratio = 0.2,
	col_ratio = 0.1,
	border = 'rounded',
}

local function create_win(bufnr, options)
	local merged_options = vim.tbl_extend('force', terminal_config, options or {})
	local win = vim.api.nvim_open_win(bufnr, true, {
		relative = 'editor',
		width = math.floor(vim.o.columns * merged_options.width_ratio),
		height = math.floor(vim.o.lines * merged_options.height_ratio),
		row = math.floor(vim.o.lines * merged_options.row_ratio),
		col = math.floor(vim.o.columns * merged_options.col_ratio),
		style = 'minimal',
		border = merged_options.border,
	})
	return win
end

local function log_to_file(...)
	local msg = ""
	for i = 1, select("#", ...) do
		local arg = select(i, ...)
		msg = msg .. vim.inspect(arg) .. " "
	end
	msg = os.date("%Y-%m-%d %H:%M:%S") .. ": " .. msg .. "\n"

	local file = io.open(log_path, "a")
	if file then
		file:write(msg)
		file:close()
	else
		vim.notify("Failed to open log file: " .. log_path, vim.log.levels.ERROR)
	end
end

vim.api.nvim_create_user_command("DotnetLogs", function()
	--local log_path = vim.fn.stdpath("log") .. "/dotnet.log"
	-- Read the log file lines
	local lines = {}
	local file = io.open(log_path, "r")
	if file then
		for line in file:lines() do
			table.insert(lines, line)
		end
		file:close()
	else
		vim.notify("Log file not found: " .. log_path, vim.log.levels.WARN)
		return
	end

	-- Create a new scratch buffer
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].filetype = "log" 
	create_win(buf)

end,
	{
		desc = "Open the dotnet.log file in a new buffer",
	}
)


local function find_csproj_path(start_path)
	local function is_root(path)
		return uv.fs_realpath(path) == uv.fs_realpath(path .. "/..")
	end

	local function scandir(path)
		local handle = uv.fs_scandir(path)
		if not handle then return {} end
		local entries = {}
		while true do
			local name, type = uv.fs_scandir_next(handle)
			if not name then break end
			table.insert(entries, { name = name, type = type })
		end
		return entries
	end

	local dir = uv.fs_realpath(start_path)
	while dir do
		for _, entry in ipairs(scandir(dir)) do
			if entry.type == "file" and entry.name:match("%.csproj$") then
				return dir .. "/" .. entry.name
			end
		end
		if is_root(dir) then break end
		dir = uv.fs_realpath(dir .. "/..")
	end
	return nil
end

function M.get_dll_path()
	local buf_path = vim.api.nvim_buf_get_name(0)
	if buf_path == "" then
		vim.notify("Buffer is empty", vim.log.levels.ERROR)
		return
	end

	local start_dir = vim.fn.fnamemodify(buf_path, ":p:h")
	local csproj = find_csproj_path(start_dir)
	if not csproj then
		vim.notify("No .csproj found in parent directories", vim.log.levels.ERROR)
		return
	end

	local proj_dir = vim.fn.fnamemodify(csproj, ":h")
	local debug_dir = proj_dir .. "/bin/Debug"

	local frameworks = {}
	local handle = uv.fs_scandir(debug_dir)
	if handle then
		while true do
			local name, type = uv.fs_scandir_next(handle)
			if not name then break end
			if type == "directory" then
				table.insert(frameworks, name)
			end
		end
	end

	if #frameworks == 0 then
		vim.notify("No compiled frameworks found under bin/Debug", vim.log.levels.ERROR)
		return
	end

	local selected_framework = frameworks[1]
	if #frameworks > 1 then
		local choice = vim.fn.inputlist(vim.tbl_extend("force", { "Select target framework:" }, frameworks))
		if type(choice) ~= "number" or choice < 1 or choice > #frameworks then
			vim.notify("Invalid selection", vim.log.levels.ERROR)
			return
		end
		selected_framework = frameworks[choice]
	end

	local proj_name = vim.fn.fnamemodify(csproj, ":t:r")
	local dll_path = string.format("%s/bin/Debug/%s/%s.dll", proj_dir, selected_framework, proj_name)

	if uv.fs_stat(dll_path) then
		return dll_path
	else
		vim.notify("DLL not found: " .. dll_path, vim.log.levels.ERROR)
		return
	end
end


local function get_nearest_test_name()
	local bufnr = vim.api.nvim_get_current_buf()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local row = cursor[1] - 1
	local col = cursor[2]

	local parser = vim.treesitter.get_parser(bufnr, "c_sharp")
	local tree = parser:parse()[1]
	local root = tree:root()

	-- Get the node directly under the cursor
	local function get_node_at_pos(node, row, col)
		if not node then return nil end
		if not node:range() then return nil end

		if node:child_count() == 0 then
			return node
		end

		for child in node:iter_children() do
			local start_row, start_col, end_row, end_col = child:range()
			if (row > start_row or (row == start_row and col >= start_col)) and
				(row < end_row or (row == end_row and col <= end_col)) then
				return get_node_at_pos(child, row, col) or child
			end
		end

		return node
	end

	local node = get_node_at_pos(root, row, col)
	local method_node, class_node, namespace_node

	while node do
		if not method_node and (node:type() == "method_declaration" or node:type() == "function_declaration") then
			method_node = node
		elseif not class_node and node:type() == "class_declaration" then
			class_node = node
		end
		if method_node and class_node then break end
		node = node:parent()
	end

	if not method_node or not class_node then
		vim.notify("Could not find enclosing method/class with Tree-sitter", vim.log.levels.WARN)
		return nil
	end

	local function get_identifier(node)
		for i = 0, node:named_child_count() - 1 do
			local child = node:named_child(i)
			if child:type() == "identifier" then
				return vim.treesitter.get_node_text(child, bufnr)
			end
		end
		return nil
	end

	local function get_namespace()
		-- Get the entire file contents as a string
		local file_content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
		-- Join the lines into a single string (because the buffer is a list of lines)
		local content = table.concat(file_content, "\n")

		--local namespace_regex = "namespace%s+(.-)%;"
		local namespace_regex = "namespace%s+(.-)[%s;{]"

		local namespace = string.match(content, namespace_regex)

		-- Return the namespace if found, or nil if not found
		if namespace and namespace ~= '' then
			return namespace
		else
			return nil
		end
	end


	local method_name = get_identifier(method_node)
	local class_name = get_identifier(class_node)
	local namespace = get_namespace()

	if method_name and class_name and namespace then
		return namespace .. "." .. class_name .. "." .. method_name
	end

	return nil
end

-- Floating terminal runner
local function run_in_terminal(cmd)
	local bufnr = vim.api.nvim_create_buf(false, true)
	local win = create_win(bufnr)
	vim.fn.termopen(cmd, {
		on_exit = function(_, exit_code, _)
			vim.notify("exit code", exit_code)
			vim.schedule(function()
				if exit_code == 0 then
					if vim.api.nvim_win_is_valid(win) then
						vim.api.nvim_win_close(win, true)
					end
					if vim.api.nvim_buf_is_valid(bufnr) then
						vim.api.nvim_buf_delete(bufnr, { force = true })
					end
				else
					vim.notify("Command failed: " .. cmd, vim.log.levels.ERROR)
				end
			end)
		end	})
end

function M.build_no_restore()
	run_in_terminal("dotnet build --no-restore")
end

function M.test_nearest()
	local test_name = get_nearest_test_name()
	if not test_name then
		vim.notify("Could not determine nearest test method.", vim.log.levels.WARN)
		return
	end
	local cmd = "dotnet test --no-restore --filter FullyQualifiedName~" .. test_name
	run_in_terminal(cmd)
end

return M

