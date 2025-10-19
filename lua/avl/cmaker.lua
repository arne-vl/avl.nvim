local M = {}

-- default config
local config = {
    build_tool = "", -- default build tool used system wide
}

local build = function(build_tool)
    local generate_cmd = { "cmake", "-B", "build", "-S", "." }

    if string.lower(build_tool) == "ninja" then
        vim.list_extend(generate_cmd, { "-G", "Ninja" })
    elseif build_tool ~= "" then
        vim.notify("CMaker: Build tool " .. build_tool .. " is not supported", vim.log.levels.ERROR)
        return
    end

    local build_cmd = { "cmake", "--build", "build", "-j" }

    vim.fn.jobstart(generate_cmd, {
        on_exit = function(_, exit_code, _)
            if exit_code == 0 then
                vim.fn.jobstart(build_cmd, {
                    on_exit = function(_, build_exit_code, _)
                        if build_exit_code == 0 then
                            vim.notify("CMaker: build finished successfully!")
                        else
                            vim.notify("CMaker: build failed.", vim.log.levels.ERROR)
                        end
                    end,
                })
            else
                vim.notify("CMaker: configuration failed.", vim.log.levels.ERROR)
            end
        end,
    })
end

M.setup = function(opts)
    config = vim.tbl_extend("force", config, opts or {})

    vim.api.nvim_create_user_command("CMaker", function()
        local cwd = vim.fn.getcwd()
        local files = vim.fn.readdir(cwd)
        local has_cmakelists = false
        local has_builddir = false

        for _, entry in ipairs(files) do
            if entry == "CMakeLists.txt" then
                has_cmakelists = true
            elseif entry == "build" and vim.fn.isdirectory(entry) then
                has_builddir = true
            end
        end

        if not has_cmakelists then
            vim.notify("CMaker: No CMakeLists.txt file found in directory", vim.log.levels.ERROR)
            return
        end

        if not has_builddir then
            vim.fn.mkdir("build", "-p")
        end

        build(config.build_tool)
    end, {})
end

return M
