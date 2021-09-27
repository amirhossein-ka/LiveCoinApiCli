local curl = require("cURL")
local json = require("lib.json")
-- local inspect = require("inspect")

local LiveCoin = {}

-- local function endOfFuncs(c) -- c is curl.easy
-- 	local dataTable = {}
-- 	c:setopt_writefunction(table.insert, dataTable)
-- 	c:perform()
-- 	return json.decode(table.concat(dataTable))
-- end

function LiveCoin.status_ok()
	local dataTable = {}
	local conn = curl.easy({
		url = "https://api.livecoinwatch.com/status/",
		post = true,
		httpheader = {
			["Content-Type"] = "application/json",
		},
		postfields = "{}",
	})
	conn:setopt_writefunction(table.insert, dataTable)
	conn:perform()

	-- if table.concat(t) == "{}" then
	-- 	return "OK\n"
	-- else
	-- 	return "SomeThing Is Wrong !\nPlease Try again later !" .. t
	-- end
	return dataTable
end

function LiveCoin.remaining_credit(api_key)
	local dataTable = {}
	local conn = curl.easy({
		url = "https://api.livecoinwatch.com/credits",
		post = true,
		httpheader = { "Content-Type: application/json", "x-api-key:" .. api_key },
		postfields = "{}",
	})
	conn:setopt_writefunction(table.insert, dataTable)
	conn:perform()
	local res = json.decode(table.concat(dataTable))
	return res
	-- return res
	-- local output = ""
	-- if not res["error"] then
	-- 	for index in pairs(res) do
	-- 		output = output .. index .. " : " .. res[index] .. "\n"
	-- 	end
	-- 	return output
	-- else
	-- 	return inspect(res)
	-- end
end

function LiveCoin.overview(api_key, corrency)
	local dataTable = {}
	local conn = curl.easy({
		url = "https://api.livecoinwatch.com/overview",
		post = true,
		httpheader = {
			"Content-Type: application/json",
			"x-api-key: " .. api_key,
		},
		postfields = string.format('{"currency":"%s"}', corrency),
	})
	conn:setopt_writefunction(table.insert, dataTable)
	conn:perform()
	local result = json.decode(table.concat(dataTable))
	-- for v in pairs(result) do
	-- 	output = output .. v .. " : " .. result[v] .. "\n"
	-- end
	return result
end

function LiveCoin.getCoin(api_key, currency, code, meta)
	local dataTable = {}
	local conn = curl.easy({
		url = "https://api.livecoinwatch.com/coins/single",
		post = true,
		httpheader = {
			"Content-Type: application/json",
			"x-api-key: " .. api_key,
		},
		postfields = string.format('{"currency":"%s", "code":"%s", "meta":"%s"}', currency, code, meta),
	})
	conn:setopt_writefunction(table.insert, dataTable)
	conn:perform()
	localresult = json.decode(table.concat(dataTable))
	return result
end

function LiveCoin.coinList(api_key, currency, sort, order, offset, limit, meta)
	local dataTable = {}
	local c = curl.easy({
		url = "https://api.livecoinwatch.com/coins/list",
		post = true,
		httpheader = {
			"Content-Type: application/json",
			"x-api-key: " .. api_key,
		},
		postfields = string.format(
			'{"currency" : "%s", "sort" : "%s", "order" : "%s", "offset" : %d, "limit" : %d, "meta" : %s}',
			currency,
			sort,
			order,
			offset,
			limit,
			meta
		),
	})
	c:setopt_writefunction(table.insert, dataTable)
	c:perform()
	return json.decode(table.concat(dataTable))
end

return LiveCoin
