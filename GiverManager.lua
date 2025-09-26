-- GiverManager.lua

-- Handles all Givers

--// Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Modules
local Utils = require(ReplicatedStorage.Modules.Utilities.Utils)
local TypeLib = require(ReplicatedStorage.Modules.Utilities.TypeLib)

--// Classes
local GiverClass = require(ReplicatedStorage.Classes.Giver)

-- Testing rn
local giverParts = workspace.Givers:GetChildren()

for _, v in pairs(giverParts) do
	local newGiver = GiverClass.new(
		{
			Part = v,
			Stat = {Name = v:GetAttribute("StatName")},
			GivenAmount = v:GetAttribute("Amount")
		}
	)
end
