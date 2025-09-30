-- GeneratorManager.lua

local GeneratorManager = {}
GeneratorManager.__index = GeneratorManager

--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

--// Modules
local Utils = require(ReplicatedStorage.Modules.Utilities.General)
local TypeLib = require(ReplicatedStorage.Modules.Utilities.TypeLib)
local Generator = require(ReplicatedStorage.Classes.Generator)

--// Remotes
local GeneratorRemote = ReplicatedStorage.Remotes.GeneratorRemote

--// Constructor
function GeneratorManager.new(plr : Player, generators : {{Part : BasePart, Player : Player}}?)
	local self = setmetatable({}, GeneratorManager)
	
	-- Properties
	self.Owner = plr
	self.Generators = {}
	
	-- Add all given generators
	for _,v in pairs (generators) do
		self:Add(v)
	end
	
	-- RunService Connection
	self.Connection = RunService.Heartbeat:Connect(function(dt)
		self:UpdateAll(dt)
	end)
end

--// Public: Add a new generator to this manager
function GeneratorManager:Add(generator : {Part : BasePart, Player : Player})
	local newGenerator = Generator.new({Part = generator.Part, Player = generator.Player})
	table.insert(self.Generators, newGenerator)
end

--// Public: Update all generators
function GeneratorManager:UpdateAll(dt)
	for _, generator in pairs(self.Generators) do
		generator:Update(dt)
	end
end

--// Public: Disconnect RunService Connection
function GeneratorManager:Disconnect()
	-- Check if a connection exists
	if self.Connection then
		self.Connection:Disconnect()
		self.Connection = nil
	else
		warn("No connection to disconnect!")
	end
end

--// Public: Reconnect RunService Connection
function GeneratorManager:Reconnect()
	if not self.Connection then
		self.Connection = RunService.Heartbeat:Connect(function(dt)
			self:UpdateAll(dt)
		end)
	else
		warn("Connection already exists for this manager!")
	end
end

return GeneratorManager
