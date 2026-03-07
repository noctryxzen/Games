loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Getter/refs/heads/main/GetFS.luau"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/NUI/refs/heads/main/Notification.luau"))()
if queue_on_teleport then
	queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Games/refs/heads/main/YouVSEveryone_FastestAutoFarm.luau"))()]])
else
	SendNotification({Title = "queue_on_teleport not supported", Text = "Please put the loadstring to your autoexec!", Duration = 15})
end
GetService.RunService.PreSimulation:Connect(function()
	firetouchinterest(GetService.Players.LocalPlayer.Character and GetService.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"), GetService.Workspace.TeleportParts.TeleportPart1.TeleportPart1, 0)
	firetouchinterest(GetService.Players.LocalPlayer.Character and GetService.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"), GetService.Workspace.TeleportParts.TeleportPart1.TeleportPart1, 1)
end)
GetService.Players.LocalPlayer.leaderstats.Cash.Changed:Connect(function()
	task.wait(.1)
	GetService.TeleportService:Teleport(game.PlaceId, GetService.Players.LocalPlayer)
end)
task.delay(.2, function()
	GetService.TeleportService:Teleport(game.PlaceId, GetService.Players.LocalPlayer)
end)
