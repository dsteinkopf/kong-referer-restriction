package = "kong-referer-restriction"
version = "0.14.1-0"
source = {
    url = "git://github.com/dsteinkopf/kong-referer-restriction",
    branch = "master"
}
description = {
    summary = "A Kong plugin that allows restriction of request based on their referer header.",
    detailed = [[
      Check Referer header and return 403 if it does not match any given pattern.
    ]],
    homepage = "https://github.com/dsteinkopf/kong-referer-restriction",
    license = "MIT"
}
dependencies = {
}
build = {
    type = "builtin",
    modules = {
    ["kong.plugins.kong-referer-restriction.handler"] = "src/handler.lua",
    ["kong.plugins.kong-referer-restriction.schema"] = "src/schema.lua",
    ["kong.plugins.kong-referer-restriction.checks"] = "src/checks.lua",
    }
}
