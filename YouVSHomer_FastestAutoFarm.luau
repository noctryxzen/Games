loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Getter/refs/heads/main/GetFS.luau"))()
GetService.RunService.PreSimulation:Connect(function()
	for i, v in next, GetService.Workspace.lobby.Obby:GetDescendants() do
		if v.Name == "Winpad" then
			if next(v:GetAttributes()) then
				GetService.Players.LocalPlayer:Kick("You have been kicked for not exploiting 🤭")
				task.wait(.1)
				GetService.TeleportService:Teleport(game.PlaceId, GetService.Players.LocalPlayer)
			else
				firetouchinterest(GetService.Players.LocalPlayer.Character and GetService.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"), v, 0)
				firetouchinterest(GetService.Players.LocalPlayer.Character and GetService.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"), v, 1)
			end
		end
	end
	GetService.Players.LocalPlayer.leaderstats.Quidz.Changed:Connect(function()
		GetService.Players.LocalPlayer:Kick("You have been kicked for not exploiting 🤭")
		task.wait(.1)
		GetService.TeleportService:Teleport(game.PlaceId, GetService.Players.LocalPlayer)
	end)
	task.delay(.2, function()
		GetService.Players.LocalPlayer:Kick("You have been kicked for not exploiting 🤭")
		task.wait(.1)
		GetService.TeleportService:Teleport(game.PlaceId, GetService.Players.LocalPlayer)
	end)
end)
