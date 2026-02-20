local GetService = setmetatable({}, {
	__index = function(s, n)
		s[n] = (cloneref and (clonefunction and clonefunction(cloneref) or cloneref) or function(x) return x end)((clonefunction and clonefunction(game.GetService) or game.GetService)(game, n))
		return s[n]
	end
})
if queue_on_teleport then
	queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Games/refs/heads/main/MortisFasterAutoFarm.luau"))()]])
else
	GetService.StarterGui:SetCore("SendNotification", {
		Title = "queue_on_teleport not supported",
		Text = "Please put the loadstring to your autoexec!",
		Duration = 5
	})
end
local ok = false
GetService.ReplicatedStorage.Events.GameEvents.StudPopupEvent.OnClientEvent:Connect(function(got)
	local LocalPlayer = GetService.Players.LocalPlayer
	if got == "Obby Complete: +15 Studs" then ok = true end
	if ok and (not LocalPlayer.Team or LocalPlayer.Team.Name ~= "Spectators") then
		GetService.TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
	end
end)
GetService.RunService.PreSimulation:Connect(function()
	local LocalPlayer = GetService.Players.LocalPlayer
	local MyRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not MyRoot then return end
	pcall(firetouchinterest, MyRoot, workspace:WaitForChild("Lobby"):WaitForChild("FinishedPart"), 0)
	pcall(firetouchinterest, MyRoot, workspace:WaitForChild("Lobby"):WaitForChild("FinishedPart"), 1)
end)
