zaten her şey pcall içinde, teleport hatası için sadece onu da pcall içine alalım:
local GetService = setmetatable({}, {
	__index = function(s, n)
		s[n] = (cloneref and (clonefunction and clonefunction(cloneref) or cloneref) or function(x) return x end)((clonefunction and clonefunction(game.GetService) or game.GetService)(game, n))
		return s[n]
	end
})
local ok = false
GetService.RunService.PreSimulation:Connect(function()
	if queue_on_teleport then
		queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Games/refs/heads/main/MortisInfStuds.luau"))()]])
	else
		GetService.StarterGui:SetCore("SendNotification", {
			Title = "queue_on_teleport not supported",
			Text = "Please put the loadstring to your autoexec!",
			Duration = 5
		})
	end
	GetService.ReplicatedStorage.Events.GameEvents.StudPopupEvent.OnClientEvent:Connect(function(got)
		if got == "Obby Complete: +15 Studs" then ok = true end
	end)
	local LocalPlayer = GetService.Players.LocalPlayer
	local MyRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not MyRoot then return end
	if ok and LocalPlayer.Team and LocalPlayer.Team.Name == "Spectators" then
		pcall(GetService.TeleportService.TeleportToPlaceInstance, GetService.TeleportService, game.PlaceId, game.JobId)
		return
	end
	pcall(firetouchinterest, MyRoot, workspace:WaitForChild("Lobby"):WaitForChild("FinishedPart"), 0)
	pcall(firetouchinterest, MyRoot, workspace:WaitForChild("Lobby"):WaitForChild("FinishedPart"), 1)
end)
