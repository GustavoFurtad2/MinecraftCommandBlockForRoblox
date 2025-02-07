local CommandBlock = {}
CommandBlock__index = CommandBlock

local StarterGui = game:GetService("StarterGui")

local function split(s, delimiter)

	local result = {}

	for match in (s..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match)
	end

	return result
end

local commands = {
	["list"] = {
		description = "/list - Exibe uma lista de jogadores online no servidor.",
		numberOfArguments = 0,
		
		execute = function(...)
			
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
	},
}

function CommandBlock.new()
	
	return setmetatable(CommandBlock, {})
end

function CommandBlock:execute(commandSourceCode)
	
	local charOffset = 2
	local command = commandSourceCode:match("^(%S+)"):sub(charOffset)
	
	local commandSize = command:len() + charOffset - 1
	local sourceCodeParameters
		
	if commandSize < commandSourceCode:len() then
		sourceCodeParameters = commandSourceCode:sub(command:len() + charOffset + 1, commandSourceCode:len())
	end
	
	local parameters = commandSize < commandSourceCode:len() and split(sourceCodeParameters, " ") or {}
		
	if commands[command] then
		
		if #parameters > commands[command].numberOfArguments then
			return "[MCFR]: Invalid command"
		end
				
		return "[MCFR]: " .. commands[command].execute(parameters)
	end
	
end

return CommandBlock
