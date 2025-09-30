-- GeneratorManager.lua

-- Handles all Givers

--// Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Modules
local Utils = require(ReplicatedStorage.Modules.Utilities.General)
local TypeLib = require(ReplicatedStorage.Modules.Utilities.TypeLib)

--// Classes
local GeneratorClass = require(ReplicatedStorage.Classes.Generator)
local GeneratorManager = require(ReplicatedStorage.Classes.GeneratorManager)

-- Testing rn
local generatorParts = workspace.Generators:GetChildren()
local generators =  {}

for _, v in pairs(generatorParts) do
	table.insert(generators, {Part = v, Player = game.Players:WaitForChild("Javcae")})
end

local newManager = GeneratorManager.new(game.Players:WaitForChild("Javcae"), generators)
