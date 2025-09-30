-- Generator.lua

local Generator = {}
Generator.__index = Generator

--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Modules
local Utils = require(ReplicatedStorage.Modules.Utilities.General)
local TypeLib = require(ReplicatedStorage.Modules.Utilities.TypeLib)
local Client = require(ReplicatedStorage.Modules.Utilities.Client)

--// Remotes
local GeneratorRemote = ReplicatedStorage.Remotes.GeneratorRemote

--// Constructor
function Generator.new(generator: {Part : BasePart, Player : Player})
	local self = setmetatable({}, Generator)

	-- Configuration
	self.Part = generator.Part
	self.Amount = self.Part:GetAttribute("Amount")
	self.Cooldown = self.Part:GetAttribute("Cooldown")
	self.TurnedOn = generator.Part:GetAttribute("TurnedOn") or false
	
	-- Stat Definition
	self.StatDef = {Name = self.Part:GetAttribute("StatName")}
	self._stat = nil
	
	-- Owner
	self.Owner = generator.Player
	self.Connection = nil
	
	-- Private Properties
	self.TimeLeft = 0 -- Time left on cooldown when generator is shut off

	print("Creating generator for stat:", self.StatDef.Name)

	self:_setup()

	return self
end

--// Private: Setup the ProximityPrompt and connection
function Generator:_setup()
	-- Set up proximity prompt on client side
	GeneratorRemote:FireClient(self.Owner, self.Part.Name, self.StatDef, self.TurnedOn)
	
	-- Connect when generator is turned on by player locally
	self.Connection = GeneratorRemote.OnServerEvent:Connect(function(plr, part)
		if plr == self.Owner and part == self.Part then
			print("Correct Owner Swapped States For This Generator")
			self:SwitchStates()
		end
	end)
end

--// Private: Award stat
function Generator:_reward()
	local plr = self.Owner
	
	local leaderstats = plr:FindFirstChild("leaderstats")
	local statName = self.StatDef.Name

	-- Check if stat exists
	-- W script <-- what is the point of ts
	local stat = leaderstats and leaderstats:FindFirstChild(statName)

	if not stat or not stat:IsA("NumberValue") then
		-- Create new stat if missing
		warn(("%s does not have %s! Creating new stat..."):format(plr.Name, statName))
		stat = Utils.createStat(plr, {Name = statName, Value = 0})
	end
	
	-- Update reference
	self._stat = stat
	self._stat.Value += self.Amount
end

--// Public: Switch generator states
function Generator:SwitchStates()
	self.TurnedOn = not self.TurnedOn
	self.Part:SetAttribute("TurnedOn", self.TurnedOn)
end

--// Public: Update the generator
function Generator:Update(dt : number)
	if not self.TurnedOn then return end
	
	-- Reduce time left every frame tick
	self.TimeLeft -= dt
	if self.TimeLeft <= 0 then
		self:_reward()
		self.TimeLeft = self.Cooldown
	end
end

return Generator
