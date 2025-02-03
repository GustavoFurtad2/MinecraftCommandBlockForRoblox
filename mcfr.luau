local CommandBlock = {}
CommandBlock__index = CommandBlock

local commands = {
	["list"] = {
		description = "/list - Exibe uma lista de jogadores online no servidor.",
		
		execute = function()
			
			local message = "Online players: "
			
			local players = game:GetService("Players"):GetChildren()
			
			for index, player in next, players do
				
				message = message .. player.Name
				
				if index ~= #players then
					message = message .. ","
				end
			end
			
			print(message)
		end,
	}
}

function CommandBlock.new()
	
	return setmetatable(CommandBlock, {})
end

function CommandBlock:execute(commandSourceCode)
	
	local command = commandSourceCode:match("^(%S+)"):sub(2)
	
	if commands[command] then
		
		commands[command].execute()
	end
end

return CommandBlock
