local checks = require "src.checks"
local helper = require "test.helper"

-- luarocks install luaunit
luaunit = require('luaunit')


TestChecks = {} -- class


function TestChecks:test_matches_one_of()

    local uri_patterns_empty = {}
    local uri_patterns_one = { "bc" }
    local uri_patterns_many = { "abc", "%.html$" }

    local uri1 = "blabla"
    local uri2 = "test.html"
    local uri3 = "abc"

    luaunit.assertFalse(checks.matches_one_of(uri1, uri_patterns_empty))
    luaunit.assertFalse(checks.matches_one_of(uri1, uri_patterns_one))
    luaunit.assertFalse(checks.matches_one_of(uri1, uri_patterns_many))

    luaunit.assertFalse(checks.matches_one_of(uri2, uri_patterns_empty))
    luaunit.assertFalse(checks.matches_one_of(uri2, uri_patterns_one))
    luaunit.assertTrue(checks.matches_one_of(uri2, uri_patterns_many))

    luaunit.assertFalse(checks.matches_one_of(uri3, uri_patterns_empty))
    luaunit.assertTrue(checks.matches_one_of(uri3, uri_patterns_one))
    luaunit.assertTrue(checks.matches_one_of(uri3, uri_patterns_many))

    luaunit.assertFalse(checks.matches_one_of(uri1, nil))
    luaunit.assertFalse(checks.matches_one_of(nil, nil))
end

function test_is_allowed_referer()

    local allowed_referer_patterns = { "abc", "xyz$" }

    luaunit.assertTrue(checks.is_allowed_referer("somereferer", nil))
    luaunit.assertTrue(checks.is_allowed_referer("somereferer", {}))
    luaunit.assertTrue(checks.is_allowed_referer("", nil))
    luaunit.assertTrue(checks.is_allowed_referer("", {}))
    luaunit.assertTrue(checks.is_allowed_referer(nil, nil))
    luaunit.assertTrue(checks.is_allowed_referer(nil, {}))

    luaunit.assertFalse(checks.is_allowed_referer("", allowed_referer_patterns))
    luaunit.assertFalse(checks.is_allowed_referer(nil, allowed_referer_patterns))
    luaunit.assertFalse(checks.is_allowed_referer("other", allowed_referer_patterns))

    luaunit.assertTrue(checks.is_allowed_referer("aaXYZ", allowed_referer_patterns))
    luaunit.assertFalse(checks.is_allowed_referer("aaxyz00", allowed_referer_patterns))
    luaunit.assertTrue(checks.is_allowed_referer("00abcde", allowed_referer_patterns))

    -- header was sent more than once:
    luaunit.assertFalse(checks.is_allowed_referer({ "00abcde", "xyz" }, allowed_referer_patterns))
end


os.exit( luaunit.LuaUnit.run() )
