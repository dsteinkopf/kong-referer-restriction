# kong-response-string-replace

A Kong plugin that allows restriction of request based on their referer header.
This could be useful e.g. to prevent "hotlinked" images.

## Installation

Run:
```
luarocks install *.rockspec
```

Then in the kong.yml add 

```
custom_plugins:
  - kong-referer-restriction
```

Run kong reload or start and add the plugin as normal.

### Docker installation

Derive your kong images `FROM kong` and add something like
```
FROM kong

RUN apk update && apk add git
RUN git clone https://github.com/dsteinkopf/kong-referer-restriction
RUN cd kong-referer-restriction && luarocks install *.rockspec
```

Then put `KONG_CUSTOM_PLUGINS: kong-referer-restriction` into your environment when starting the kong container.

## Info

This plugin's priority is set to 1300.
So it is handled after ip-restriction, bot-detection, cors and after [kong-http-to-https-redirect](https://github.com/dsteinkopf/kong-http-to-https-redirect/) - but before jwt and other authentication plugins
(see last paragraph in [Kongo Plugin Documentation - Custom Logic](https://docs.konghq.com/0.14.x/plugin-development/custom-logic/)).



## Configuration

* `allowed_referer_patterns`: 
    * _type_: list of strings
    * _default value_: empty
    * _example_: `^https?://my.nice.site.tld/`
    * List of patterns of allowed referer headers (`Referer: http://example.org/referring_page`).
      Referer is converted to lower case before matching.
      Any incoming request must match at least one of the patterns.
      If no pattern is configured / list is empty then everything is allowed.
        
## Misc

Thanks to the creator of https://github.com/HappyValleyIO/kong-http-to-https-redirect.
