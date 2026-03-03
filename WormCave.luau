local GetService = setmetatable({}, {
	__index = function(s, n)
		s[n] = (cloneref and clonefunction(cloneref) or function(x) return x end)(clonefunction(game.GetService)(game, n))
		return s[n]
	end
})
loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/NUI/refs/heads/main/Notification.luau"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/FilterGC/refs/heads/main/isGC.luau"))()
for i, v in next, filtergc("table", {Keys = {"StaminaDrain"}}) do
	v.StaminaDrain = 0
end
SendNotification({Title = "Infinite Stamina!", Text = "I gave you infinite stamina!", Duration = 5})
GetService.Players.LocalPlayer.CharacterAdded:Connect(function()
	task.wait(1)
	for i, v in next, filtergc("table", {Keys = {"StaminaDrain"}}) do
		v.StaminaDrain = 0
	end
end)
GetService.Players.LocalPlayer.PlayerGui.ChildAdded:Connect(function(Child)
	if Child.Name ~= "FreeYourselfGui" then return end
	SendNotification({Title = "Worms Caught You!!", Text = "I'll save you dont worry!", Duration = 5})
end)
GetService.RunService.PreSimulation:Connect(function()
	if not GetService.Players.LocalPlayer.PlayerGui:FindFirstChild("FreeYourselfGui") then return end
	for i = 1, 5 do
		firesignal(GetService.Players.LocalPlayer.PlayerGui:FindFirstChild("FreeYourselfGui"):WaitForChild("FreeButton").MouseButton1Click)
	end
end)
