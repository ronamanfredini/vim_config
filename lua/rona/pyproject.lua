local M = {}

function M.get_source_dirs()
    local root = vim.lsp.util.root_pattern('pyproject.toml')(vim.fn.getcwd())
    if not root then
        return {}
    end

    local pyproject_path = root .. '/pyproject.toml'
    local file = io.open(pyproject_path, 'r')
    if not file then
        return {}
    end

    local content = file:read('*a')
    file:close()

    local source_dirs = {}

    -- Try to parse Hatch configuration first
    local in_hatch_packages = false
    for line in content:gmatch('[^\n]+') do
        -- Check for Hatch build targets
        if line:match('^\[tool%.hatch%.build%.targets%.wheel%]') then
            in_hatch_packages = true
        elseif in_hatch_packages and line:match('^\[') then
            in_hatch_packages = false
        end

        if in_hatch_packages then
            -- Match patterns like: "training/src/train", "libs/src/libs"
            local package_path = line:match('^%s*"([^"]+)"')
            if package_path then
                -- Extract the src directory from paths like "training/src/train"
                local src_dir = package_path:match('(.*/src)/')
                if src_dir and not vim.tbl_contains(source_dirs, src_dir) then
                    table.insert(source_dirs, root .. '/' .. src_dir)
                end
            end
        end
    end

    -- If Hatch didn't work, try Poetry configuration
    if #source_dirs == 0 then
        local in_poetry_packages = false
        for line in content:gmatch('[^\n]+') do
            if line:match('^\[tool%.poetry%.packages%]') then
                in_poetry_packages = true
            elseif in_poetry_packages and line:match('^\[') then
                in_poetry_packages = false
            end

            if in_poetry_packages then
                local from_path = line:match('from%s*=%s*"(.-)"')
                if from_path then
                    table.insert(source_dirs, root .. '/' .. from_path)
                end
            end
        end
    end

    return source_dirs
end

return M
