-- Cycle the cursor between C/C++ `function_definition` nodes using
-- treesitter, independent of nvim-treesitter-textobjects' @function.outer
-- query (which can land on the function_declarator rather than the
-- definition start).
--
-- Scoping/behavior:
--  * Going backward: if the cursor is inside a function_definition but not
--    already at its name, the first press jumps to the name of that enclosing
--    function (standard "previous function" behavior).
--    Pressing again (cursor now at the start) searches for a previous
--    function_definition.
--  * That search - and the forward search - is first restricted to the
--    enclosing function's parent node, so cycling moves between sibling
--    functions at the same nesting level (e.g. lambdas in the same
--    block). Only if the parent contains no other function_definition
--    does the search widen to the whole buffer.
--
-- Efficiency notes:
--  * The query is compiled once and cached per-language, not rebuilt on
--    every keypress.
--  * We don't walk the whole syntax tree in Lua. `Query:iter_captures`
--    takes a byte/point range and treesitter uses that to prune whole
--    subtrees that fall outside it (this happens in C, not Lua), so
--    searching is effectively bounded by the range you pass in rather
--    than the size of the buffer.
--  * The parent-scoped search is bounded to the parent node's own range,
--    so it's cheap even when the fallback below it covers the full file.
--  * We only scan from the cursor to the relevant edge of the search
--    range (forward to its end, or backward from its start), and stop at
--    the first match found in that direction instead of collecting every
--    function_definition in range.

local M = {}

local query_cache = {}

local function get_query(lang)
    local cached = query_cache[lang]
    if cached ~= nil then
        return cached ~= false and cached or nil
    end
    local ok, query = pcall(vim.treesitter.query.parse, lang, "(function_definition) @fn")
    query_cache[lang] = ok and query or false
    return ok and query or nil
end

-- Prefer the function identifier over the definition node's start. In
-- qualified C++ names, the last identifier before parameter_list is the
-- function name rather than the namespace qualifier.
local function get_definition_target(node)
    local declarators = node:field("declarator")
    local declarator = declarators and declarators[1]
    if not declarator then
        local row, col = node:range()
        return { row, col }
    end

    local function find_identifier(current)
        if current:type() == "identifier" then
            return current
        end

        local result = nil
        for i = 0, current:named_child_count() - 1 do
            local child = current:named_child(i)
            if child:type() == "parameter_list" then
                break
            end
            local identifier = find_identifier(child)
            if identifier then
                result = identifier
            end
        end
        return result
    end

    local target = find_identifier(declarator) or declarator
    local row, col = target:range()
    return { row, col }
end

-- Searches for the next/previous function_definition target relative to
-- (crow, ccol), bounded to search_node's own range. Returns {row, col} or
-- nil if none found in that range in the requested direction.
local function search_in_node(query, search_node, bufnr, crow, ccol, direction)
    local nsrow, _, nerow, _ = search_node:range()
    local target = nil

    if direction > 0 then
        -- First match strictly after the cursor.
        for _, node in query:iter_captures(search_node, bufnr, crow, nerow + 1) do
            local target_position = get_definition_target(node)
            local srow, scol = target_position[1], target_position[2]
            if srow > crow or (srow == crow and scol > ccol) then
                target = { srow, scol }
                break
            end
        end
    else
        -- Last match strictly before the cursor (iter_captures yields in
        -- document order, so the final qualifying hit is the closest one).
        for _, node in query:iter_captures(search_node, bufnr, nsrow, crow + 1) do
            local target_position = get_definition_target(node)
            local srow, scol = target_position[1], target_position[2]
            if srow < crow or (srow == crow and scol < ccol) then
                target = { srow, scol }
            end
        end
    end

    return target
end

-- direction: 1 for next, -1 for previous
function M.goto_function_definition(direction)
    local bufnr = vim.api.nvim_get_current_buf()
    local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
    if not ok or not parser then
        return
    end

    local lang = parser:lang()
    local query = get_query(lang)
    if not query then
        vim.notify("No function_definition query available for " .. lang, vim.log.levels.WARN)
        return
    end

    local tree = parser:parse()[1]
    if not tree then
        return
    end
    local root = tree:root()

    local cursor = vim.api.nvim_win_get_cursor(0)
    local crow, ccol = cursor[1] - 1, cursor[2]

    -- Walk up from the node under the cursor to find the nearest enclosing
    -- function_definition (nil if the cursor isn't inside one).
    local enclosing = vim.treesitter.get_node({ bufnr = bufnr })
    while enclosing and enclosing:type() ~= "function_definition" do
        enclosing = enclosing:parent()
    end

    local target = nil

    -- Backward: first press jumps to the function name, if the cursor isn't
    -- already sitting there.
    if direction < 0 and enclosing then
        local enclosing_target = get_definition_target(enclosing)
        local esrow, escol = enclosing_target[1], enclosing_target[2]
        if esrow < crow or (esrow == crow and escol < ccol) then
            target = enclosing_target
        end
    end

    -- Search siblings within the enclosing function's own parent scope.
    if not target and enclosing then
        local parent = enclosing:parent()
        if parent then
            target = search_in_node(query, parent, bufnr, crow, ccol, direction)
        end
    end

    -- Fall back to the whole buffer if the parent scope had nothing else.
    if not target then
        target = search_in_node(query, root, bufnr, crow, ccol, direction)
    end

    if not target then
        vim.notify(
            direction > 0 and "No next function_definition" or "No previous function_definition",
            vim.log.levels.INFO
        )
        return
    end

    vim.cmd("normal! m'") -- add current position to jumplist
    vim.api.nvim_win_set_cursor(0, { target[1] + 1, target[2] })
end

return M
