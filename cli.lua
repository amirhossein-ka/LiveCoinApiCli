#!/usr/bin/lua
local Lummender = require("lummander")
local LiveCoin = require("core")
local path = require("pl.path")
local file = require("pl.file")

local function getApiKey()
	local confDir = path.expanduser("~/.config/LiveCli/")
	return assert(
		file.read(path.join(confDir, "api-key")),
		"No Token Found ! Did you forgot to run cli token <token> ?"
	)
end

local cli = Lummender.new({
	title = "LiveCoinWatch api command line tool !",
	tag = "./cli.lua", -- define command to launch this script at terminal
	description = "A cli tool for LiveCoinWatch api !", -- <string> CLI description. Default: ""
	version = "0.0.1", -- define cli version
	author = "github.com/amirhossein-ka", -- <string> author. Default: ""
	root_path = "", -- <string> root_path. Default "". Concat this path to load commands of a subfolder
	theme = "default", -- Default = "default". "default" and "acid" are built-in themes
	flag_prevent_help = true, -- prevent show help when :parse() doesn't find a valid command to execute
})

-- cli
-- 	:command("bye [name]", "Say Bye to you")
-- 	:option({ long = "name", short = "n", "Bye Name", default = "you" })
-- 	:action(function(parsed, command, app)
-- 		print("Bye " .. parsed.name .. " !")
-- 	end)

-- cli
-- 	:command("hi [name]", "say hello to you or the name")
-- 	:option({ long = "name", short = "n", description = "this is name", default = "you" })
-- 	:action(function(parsed, command, app)
-- 		print("Hello " .. parsed.name .. " !")
-- 	end)

cli
	:command("token <token>", "Save your token from LiveCoinWatch,it will save in a file on your machine")
	:action(function(parsed, command, app)
		local token = parsed.token
		local confDir = path.expanduser("~/.config/LiveCli/")
		-- if not isdir("~/.config/LiveCli") then
		-- 	os.execute("mkdir" .. " ~/.config/LiveCli/") -- its hardcoded !
		-- end
		if not path.exists(confDir) then -- create confDir if not exists
			path.mkdir(confDir)
		end

		if path.isfile(path.join(confDir, "api-key")) then
			io.stdout:write("The api-key file already exists! do you want to overwrite it ? <y,n> :")
			local answer = io.stdin:read()
			if answer == "y" or answer == "Y" then
				local file = io.open(path.join(confDir, "api-key"), "w+")
				file:write(token)
				file:close()
				print("Token Saved successfully !")
			end
		else
			local file = io.open(path.join(confDir, "api-key"), "w+")
			file:write(token)
			file:close()
			print("Token Saved successfully !")
		end
	end)

cli:command("status", "See the status of api"):action(function(parsed, command, app)
	local stat = LiveCoin.status_ok()
	print(stat)
	if table.concat(stat) == "{}" then
		print("Server is Up And Ready To GO !")
	else
		print("SomeThing is Wrong !\nPlease check your internet conection and try again later !")
	end
end)

cli:command("credits", "See the remaining daily credits"):action(function(pares, command, app)
	local api_key = getApiKey()
	local credits = LiveCoin.remaining_credit(api_key)
	for i in pairs(credits) do
		print(i .. " : " .. credits[i])
	end
end)

cli
	:command("overview", "Get current aggregated data for all coins.")
	:option({ long = "currency", short = "c", description = "any valid coin or fiat code", default = "BTC" })
	:action(function(parsed, command, app)
		local api_key = getApiKey()
		local result = LiveCoin.overview(api_key, parsed.currency)
		for i in pairs(result) do
			print(i .. " : " .. result[i])
		end
	end)

cli:parse(arg)
