_G.TEST = true
local ApiErrors = require "groupbutler.api_errors"

local api_err = ApiErrors:new({
	i18n = function(s)
		return s
	end
})

describe("error translation", function()
	it("should return a generic message on unknown errors api errors", function()
		local expected = "An unknown error has ocurred"
		local retval = api_err:trans({
			description = "Gibberish"
		})
		assert.same(expected, retval)
	end)
	it("should return an expected message for markdown errors", function()
		local expected = [[This text breaks the markdown.
More info about a proper use of markdown [here](https://telegra.ph/markdown%E5%B8%B8%E7%94%A8%E8%AF%AD%E6%B3%95%E5%A4%A7%E5%85%A8-06-30).]] -- luacheck: ignore 631
		local retval = api_err:trans({
			description = "Bad Request: can't parse entities: Can't find end of the entity starting at byte offset 53" -- luacheck: ignore 631
		})
		assert.same(expected, retval)
	end)
end)
