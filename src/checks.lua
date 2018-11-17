local _M = {}

function _M.matches_one_of(str, patterns)
    if patterns == nil then
        return false
    end
    for _, pattern in ipairs(patterns) do
        if string.find(str, pattern) then
            return true
        end
    end
    return false
end

function _M.is_allowed_referer(referer, allowed_referer_patterns)
    if type(referer) == "table" then
        -- header was sent more than once - not specified -> not allowed
        return false
    end
    if allowed_referer_patterns == nil or next(allowed_referer_patterns) == nil then
        -- if no patterns is configured or table is empty then no check is done -> everything is allowed
        return true
    end
    if referer == nil then
        return false
    end
    local referer_lowercase = referer:lower()
    return _M.matches_one_of(referer_lowercase, allowed_referer_patterns)
end

return _M