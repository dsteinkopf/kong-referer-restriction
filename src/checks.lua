local _M = {}

function _M.matches_one_of(str, patterns)
    for _, pattern in ipairs(patterns) do
        if string.find(str, pattern) then
            return true
        end
    end
    return false
end

return _M