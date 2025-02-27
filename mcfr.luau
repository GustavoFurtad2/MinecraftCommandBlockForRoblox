local CommandBlock = {}
CommandBlock__index = CommandBlock

local StarterGui = game:GetService("StarterGui")

local prefix = "//"

local function split(s, delimiter)

	local result = {}

	for match in (s..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match)
	end

	return result
end

local commands = {}

commands["list"] = {
	description = "/list - Displays a list of online players on the server.",
	numberOfArguments = 0,
		
	execute = function()
			
		local message = "Online players: "
			
		local players = game:GetService("Players"):GetChildren()
			
		for index, player in next, players do
				
			message = message .. player.Name
				
			if index ~= #players then
				message = message .. ","
			end
		end

		return message
	end,
}

commands["help"] = {
	description = "/help - Shows all available commands",
	numberOfArguments = 0,
	
	execute = function()

		local message = "Commands:\n"

		for _, command in next, commands do

			message = message .. command.description .. "\n"
		end

		return message
	end
}

commands["time"] = {
	description = "/time set - Coloca em um horário especifico",
	numberOfArguments = 2,
	
	execute = function(...)
				
		if (...)[1] ~= "set" or not (...)[2] then
			return "Unknown command"
		elseif tonumber((...)[2]) == nil then
			return "O hórario deve ser um número!"
		end
		
		game:GetService("Lighting").ClockTime = (...)[2] / 100
		
		return "The time was set to " .. (...)[2]
	end,
}

function CommandBlock.new()
	
	return setmetatable(CommandBlock, {})
end

function CommandBlock:execute(commandSourceCode)
	
	if commandSourceCode:sub(1, #prefix) ~= prefix then
		return
	end

	local trimmedCommand = commandSourceCode:sub(#prefix + 1)
	local parts = split(trimmedCommand, " ")
	local command = parts[1]
	local parameters = {}

	for i = 2, #parts do
		table.insert(parameters, parts[i])
	end

	if commands[command] then
		
		if #parameters > commands[command].numberOfArguments then
			return "\n[MCFR]: Invalid number of arguments"
		end

		return "\n[MCFR]: " .. commands[command].execute(parameters)
	end
		
	return "\n[MCFR]: Unknown command"
end

return CommandBlock
