--helper functions specific to dotnet

local uv = vim.loop

local M = {}

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

return M

