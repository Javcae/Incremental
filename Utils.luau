local Utils = {}
local TypeLib = require(script.Parent.TypeLib)

function Utils.createStat(plr : Player, stat : TypeLib.Stat)
	local leaderstats = plr:FindFirstChild("leaderstats")
	
	if not leaderstats then
		local leaderstats = Instance.new("Folder")
		leaderstats.Name = "leaderstats"
		leaderstats.Parent = plr
		
		return Utils.createStat(plr, stat)
	end
	
	local checkStat = leaderstats:FindFirstChild(stat.Name)
	
	if checkStat then
		warn(stat.Name.." already exists for "..plr.Name.."!")
		return checkStat
	end
	
	local newStat = Instance.new("NumberValue")
	newStat.Name = stat.Name
	newStat.Value = stat.Value or 0
	newStat.Parent = leaderstats
	
	return newStat
end

return Utils
