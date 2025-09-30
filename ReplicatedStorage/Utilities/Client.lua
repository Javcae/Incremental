-- Client.lua

local Client = {}

--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Modules
local TypeLib = require(ReplicatedStorage.Modules.Utilities.TypeLib)

--// Remotes
local GeneratorRemote = ReplicatedStorage.Remotes.GeneratorRemote

--// Creates a new Proximity Prompt for the player
function Client.createProximityPrompt(plr : Player, part : BasePart, statDef : TypeLib.Stat, turnedOn : boolean)
	local proximityPrompt = Instance.new("ProximityPrompt")
	proximityPrompt.ObjectText = plr.Name.."'s "..statDef.Name.." Generator"
	
	-- Check if current generator is on
	if turnedOn then
		proximityPrompt.ActionText = "Turn Off"
	else
		proximityPrompt.ActionText = "Turn On"
	end
	
	proximityPrompt.Parent = part
	
	print("ProximityPrompt created for you!")
	
	-- Add connection to turn on and off generator
	proximityPrompt.Triggered:Connect(function(plr)
		GeneratorRemote:FireServer(part)
	end)
	
	return proximityPrompt
end


--// Updates action text for proximity prompt based on state of generator
function Client.updateProximityPrompt(plr : Player, part : BasePart, proximityPrompt : ProximityPrompt)
	local turnedOn = part:GetAttribute("TurnedOn")
	
	if turnedOn then
		proximityPrompt.ActionText = "Turn Off"
	else
		proximityPrompt.ActionText = "Turn On"
	end
end

return Client
