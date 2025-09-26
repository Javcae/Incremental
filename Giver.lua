-- Giver.lua

--[[
    Giver object:
    - Represents a clickable giver (part with ClickDetector).
    - When clicked, awards a stat to the player (creates it if missing).
]]

local Giver = {}
Giver.__index = Giver

--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Modules
local Utils = require(ReplicatedStorage.Modules.Utilities.Utils)
local TypeLib = require(ReplicatedStorage.Modules.Utilities.TypeLib)

--// Constructor
function Giver.new(giver: {Part : BasePart, Stat : TypeLib.Stat, GivenAmount : number})
	local self = setmetatable({}, Giver)

	-- Properties
	self.Part = giver.Part
	self.Amount = giver.GivenAmount
	self.Stat = giver.Stat  -- Note: This is a "definition" (Name, Value?)
	self.Connection = nil

	print("Creating Giver for stat:", self.Stat.Name)

	self:_setup()

	return self
end

--// Setup the ClickDetector and connection
function Giver:_setup()
	local clickDetector = Instance.new("ClickDetector")
	clickDetector.Parent = self.Part

	self.Connection = clickDetector.MouseClick:Connect(function(plr)
		self:_onClick(plr)
	end)
end

--// Handle click event
function Giver:_onClick(plr: Player)
	local leaderstats = plr:FindFirstChild("leaderstats")
	local statName = self.Stat.Name

	-- Check if stat exists
	local stat = leaderstats and leaderstats:FindFirstChild(statName)

	if stat and stat:IsA("NumberValue") then
		-- Use existing stat
		stat.Value += self.Amount
		self.Stat = stat
	else
		-- Create new stat if missing
		warn(("%s does not have %s! Creating new stat..."):format(plr.Name, statName))
		stat = Utils.createStat(plr, {Name = statName, Value = 0})
		stat.Value += self.Amount
		self.Stat = stat
	end
end

return Giver
