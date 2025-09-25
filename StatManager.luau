-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules
local Utils = require(ReplicatedStorage.Utils)

local baseStats = {
	["Coins"] = 0,
	["Gems"] = 0,
}

Players.PlayerAdded:Connect(function(plr)
	for i,v in pairs(baseStats) do
		Utils.createStat(plr, {Name = i, Value = v})
	end
end)
