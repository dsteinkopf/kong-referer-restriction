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

end


os.exit( luaunit.LuaUnit.run() )
