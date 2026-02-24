local GetService = setmetatable({}, {
	__index = function(s, n)
		s[n] = (cloneref and clonefunction(cloneref) or function(x) return x end)(clonefunction(game.GetService)(game, n))
		return s[n]
	end
})

--// Re-Execute on Teleport
if queue_on_teleport then
	queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Games/refs/heads/main/MortisFasterAutoFarm.luau"))()]])
else
	GetService.StarterGui:SetCore("SendNotification", {Title = "queue_on_teleport not supported", Text = "Please put the loadstring to your autoexec!", Duration = 5})
end

--// Teleporter
Auto = {}
local Game, Job = game.PlaceId, game.JobId
function Auto.Teleport(Game, Job)
	if Job then GetService.TeleportService:TeleportToPlaceInstance(Game, Job)
	else GetService.TeleportService:Teleport(Game) end
end

--// Auto Farm
local FinishedPart = GetService.Workspace:WaitForChild("Lobby"):WaitForChild("FinishedPart")
GetService.ReplicatedStorage.Events.GameEvents.StudPopupEvent.OnClientEvent:Connect(function(got)
	if got then Auto.Teleport(Game, Job) end
	task.delay(.1, function() Auto.Teleport(Game, Job) end)

	--// Auto Buy
	if getgenv().auto_buy or isfile("wanted_crate.json") then
		if got == "CrateResult" then Auto.Teleport(Game, Job) end
		task.delay(.1, function() Auto.Teleport(Game, Job) end)
	end
end)
GetService.RunService.PreSimulation:Connect(function()
	local MyRoot = GetService.Players.LocalPlayer.Character and GetService.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not MyRoot then return end
	pcall(firetouchinterest, MyRoot, FinishedPart, 0)
	pcall(firetouchinterest, MyRoot, FinishedPart, 1)
end)
