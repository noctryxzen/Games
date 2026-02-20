queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Games/refs/heads/main/MortisInfStuds.luau"))()]])
game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
	if State == Enum.TeleportState.Failed then
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
	end
end)

game:GetService("RunService").PreSimulation:Connect(function()
	local Char = game:GetService("Players").LocalPlayer.Character
	if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end
	pcall(firetouchinterest, Char.HumanoidRootPart, workspace:WaitForChild("Lobby"):WaitForChild("FinishedPart"), 0)
	pcall(firetouchinterest, Char.HumanoidRootPart, workspace:WaitForChild("Lobby"):WaitForChild("FinishedPart"), 1)
end)
