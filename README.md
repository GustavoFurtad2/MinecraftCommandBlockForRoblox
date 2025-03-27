# MinecraftCommandBlockForRoblox

MCFR(Minecraft Command Block For Roblox) is a module script that adds and ports minecraft commands to roblox

# Example 1

```lua
local mcfr = game.ReplicatedStorage.MCFR -- require mcfr module

local commander = mcfr.new() -- create a new command block

commander:execute("/list")
```

# Example 2

```lua
local mcfr = require(game.ReplicatedStorage.MCFR)

local commandBlock = mcfr.new()

game.Players.PlayerAdded:Connect(function(player)
	
	player.Chatted:Connect(function(message)
		
		print(commandBlock:execute(message, "/-"))
	end)
end)
```

# Ported commands

```/list``` Show player onllines
