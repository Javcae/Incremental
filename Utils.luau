-- Utils.lua

local Utils = {}

--// Modules
local TypeLib = require(script.Parent.TypeLib)

--// Creates a new stat for a player
function Utils.createStat(plr : Player, stat : TypeLib.Stat) : NumberValue
	local leaderstats = plr:FindFirstChild("leaderstats")
	
	-- Check if leaderstats exists
	if not leaderstats then
		local leaderstats = Instance.new("Folder")
		leaderstats.Name = "leaderstats"
		leaderstats.Parent = plr
		
		return Utils.createStat(plr, stat)
	end
	
	local checkStat = leaderstats:FindFirstChild(stat.Name)
	
	-- Check if given stat already exists
	if checkStat then
		warn(stat.Name.." already exists for "..plr.Name.."!")
		return checkStat
	end
	
	-- Create new stat
	local newStat = Instance.new("NumberValue")
	newStat.Name = stat.Name
	newStat.Value = stat.Value or 0
	newStat.Parent = leaderstats
	
	return newStat
end

return Utils
