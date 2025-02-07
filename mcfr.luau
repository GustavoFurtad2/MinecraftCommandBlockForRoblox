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
	description = "/list - Exibe uma lista de jogadores online no servidor.",
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
	description = "/help - Exibe todos comandos",
	numberOfArguments = 0,
	
	execute = function()

		local message = "Comandos:\n"

		for _, command in next, commands do

			message = message .. command.description .. "\n"
		end

		return message
	end
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
			return "[MCFR]: Invalid number of arguments"
		end

		return "[MCFR]: " .. commands[command].execute(parameters)
	end
		
	return "[MCFR]: Unknown command"
end

return CommandBlock

