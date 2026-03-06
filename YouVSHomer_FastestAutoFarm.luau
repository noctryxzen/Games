loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Getter/refs/heads/main/GetFS.luau"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/NUI/refs/heads/main/Notification.luau"))()
if queue_on_teleport then
	queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Games/refs/heads/main/YouVSHomer_FastestAutoFarm.luau"))()]])
else
	SendNotification({Title = "queue_on_teleport not supported", Text = "Please put the loadstring to your autoexec!", Duration = 15})
end
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
