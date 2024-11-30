-- Strips a newline character from the end of a string.
-- @param s string The string to process.
-- @return string The string without the trailing newline.
local function strip_newline(s)
    return s:match("^(.-)\n?$")
end

-- Matches if the file name is '.git'.
-- @param name string The file name to check.
-- @return boolean True if the file name matches '.git'; otherwise, false.
local function matchGitFile(name)
    return name:match('^.git$')
end

-- Finds '.git' directories within a given scope.
-- @param args table Arguments for the `vim.fs.find` function.
-- @return table A list of paths containing '.git' directories.
local findGitFiles = function(args)
    return vim.fs.find(function(i) return matchGitFile(i) end, args)
end

-- Iterates through a list of plugin paths and extracts their directories.
-- @param plugins table A list of plugin paths.
-- @return table A table of plugin directories.
local iterPlugins = function(plugins)
    return vim.iter(plugins):enumerate():map(function(_, v)
        return vim.fs.dirname(v)
    end):totable()
end

--- Schedule a task to print information about a Git operation.
---
--- @param sysObject vim.SystemCompleted A system call to Git pull.
--- @param remote vim.SystemCompleted  A system call to Git remote.
local scheduleTask = function(sysObject, remote)
    vim.schedule(function()
        vim.api.nvim_out_write(string.format("%s: %s\n", strip_newline(sysObject.stdout), strip_newline(remote.stdout)))
    end)
end

--- Retrieves the remote URL of a Git repository and schedules a task.
---
--- @param callback vim.SystemObj The callback system object from a previous `vim.system` call.
--- @param directory fun(out: vim.SystemCompleted) The directory in which the Git command will run.
--- @return vim.SystemObj Object
local getRemote = function(callback, directory)
    vim.system(
        { 'git', 'config', '--get', 'remote.origin.url' },
        {
            text = true,
            cwd = directory
        }, function(onExit) scheduleTask(onExit, callback) end)
end

--- Pulls all changes from all remotes for a given Git repository.
---
--- @param path string The path of the Git repository.
--- @return vim.SystemCompleted Object
local writeDiff = function(path)
    return vim.system({ 'git', 'pull', '--all' }, { cwd = path }, function(i) getRemote(i, path) end)
end

--- Updates plugins by iterating over Git repositories in a specified directory and pulling changes.
---
--- @param dir string The root directory containing the plugins.
--- @return nil
function UpdatePlugins(dir)
    local gitFiles = findGitFiles({
        limit = math.huge,
        type = 'directory',
        path = dir
    })

    local filePaths = iterPlugins(gitFiles)

    for _, path in pairs(filePaths) do
        writeDiff(path)
    end
end

-- Registers the 'UpdatePlugins' command in Neovim to update plugins.
vim.api.nvim_create_user_command(
    'UpdatePlugins',
    function(_opts)
        local path = vim.fn.expand("~/.local/share/nvim/site/pack/plugins/start")
        if _opts.args ~= "" then
            path = _opts.args
        end
        UpdatePlugins(path)
    end,
    { nargs = "?", complete = "dir", desc = "Update all plugins in a given directory" }
)
