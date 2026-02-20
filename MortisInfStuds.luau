local GetService = setmetatable({}, {
	__index = function(s, n)
		s[n] = (cloneref and (clonefunction and clonefunction(cloneref) or cloneref) or function(x) return x end)((clonefunction and clonefunction(game.GetService) or game.GetService)(game, n))
		return s[n]
	end
})
loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Games/refs/heads/main/MortisInfStuds.luau"))()
queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Games/refs/heads/main/MortisInfStuds.luau"))()]])
local Team = GetService.Players.LocalPlayer.Team
if Team and (Team.Name == "Survivors" or Team.Name == "Mortis") then
	GetService.TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
end
local ok = false
GetService.ReplicatedStorage.Events.GameEvents.StudPopupEvent.OnClientEvent:Connect(function(got)
	if got == "Obby Complete: +15 Studs" then
		ok = true
		GetService.TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
	end
end)
GetService.RunService.PreSimulation:Connect(function()
	if ok then return end
	local Root = GetService.Players.LocalPlayer.Character and GetService.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not Root then return end
	pcall(firetouchinterest, Root, workspace:WaitForChild("Lobby"):WaitForChild("FinishedPart"), 0)
	pcall(firetouchinterest, Root, workspace:WaitForChild("Lobby"):WaitForChild("FinishedPart"), 1)
end)
