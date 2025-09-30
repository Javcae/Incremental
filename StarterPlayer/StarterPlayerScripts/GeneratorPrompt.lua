-- GeneratorPrompt.lua

-- Handles all Givers

--// Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Classes
local GeneratorClass = require(ReplicatedStorage.Classes.Generator)

--// Modules
local ClientUtils = require(ReplicatedStorage.Modules.Utilities.Client)
local TypeLib = require(ReplicatedStorage.Modules.Utilities.TypeLib)

--// Remotes
local GeneratorRemote = ReplicatedStorage.Remotes.GeneratorRemote

local plr = game.Players.LocalPlayer

-- Testing rn
GeneratorRemote.OnClientEvent:Connect(function(partName : string, statDef : TypeLib.Stat, turnedOn : boolean)
	local part = workspace.Generators:WaitForChild(partName)
	local proximityPrompt = ClientUtils.createProximityPrompt(plr,part,statDef,turnedOn)
	part:GetAttributeChangedSignal("TurnedOn"):Connect(function()
		ClientUtils.updateProximityPrompt(plr, part, proximityPrompt)
	end)
end)


