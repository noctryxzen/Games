local GetService = setmetatable({}, {
	__index = function(s, n)
		s[n] = (cloneref and clonefunction(cloneref) or function(x) return x end)(clonefunction(game.GetService)(game, n))
		return s[n]
	end
})

if getgenv().auto_kill == nil then getgenv().auto_kill = true end
if getgenv().auto_obby == nil then getgenv().auto_obby = false end
local ok = false

--// Remove Annoying Screen
if GetService.Players.LocalPlayer.PlayerGui:WaitForChild("Transition"):FindFirstChild("Fade") then
	GetService.Players.LocalPlayer.PlayerGui.Transition.Fade:Destroy()
end

--// Anti Ragdoll
GetService.ReplicatedStorage.RagdollRemote.OnClientEvent:Connect(newcclosure(function(P)
	if P:find("Enable") then firesignal(GetService.ReplicatedStorage.RagdollRemote.OnClientEvent, "Disable") end
end))

--// Make Me Mortis
local GameEvents = GetService.ReplicatedStorage.Events.GameEvents
if getgenv().auto_kill then GameEvents.MortisChanceEvent:FireServer("PurchaseComplete") end
GameEvents.RoundStart.OnClientEvent:Connect(newcclosure(function()
	if getgenv().auto_kill then GameEvents.MortisChanceEvent:FireServer("PurchaseComplete") end
end))
GameEvents.RoundEnd.OnClientEvent:Connect(newcclosure(function() ok = false end))
GameEvents.VFXEvent.OnClientEvent:Connect(newcclosure(function(Type, Target)
	if Type == "TransformVFX" and Target == GetService.Players.LocalPlayer and GetService.Players.LocalPlayer.Team == GetService.Teams:FindFirstChild("Mortis") then ok = true end
end))

--// Obby / Teleport & Hit
local Part = GetService.Workspace:FindFirstChild("Lobby") and GetService.Workspace.Lobby:FindFirstChild("FinishedPart")
GetService.RunService.PreSimulation:Connect((function()
	local lh = 0
	return newcclosure(function()
		if not (GetService.Players.LocalPlayer.Character and GetService.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then return end
		if getgenv().auto_obby and GetService.Players.LocalPlayer.Team == GetService.Teams:FindFirstChild("Spectators") and not GetService.Players.LocalPlayer:GetAttribute("IsGhost") and Part then
			GetService.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(16, 36, 982)
			pcall(firetouchinterest, GetService.Players.LocalPlayer.Character.HumanoidRootPart, Part, 0)
			pcall(firetouchinterest, GetService.Players.LocalPlayer.Character.HumanoidRootPart, Part, 1)
			return
		end
		if not getgenv().auto_kill or not ok then return end
		if GetService.Players.LocalPlayer.Team == GetService.Teams:FindFirstChild("Spectators") then ok = false return end
		if not GetService.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then GetService.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = true end
		for i,v in next, GetService.Players:GetPlayers() do
			if v == GetService.Players.LocalPlayer or v.Team ~= GetService.Teams:FindFirstChild("Survivors") then continue end
			if not (v.Character and v.Character:FindFirstChild("HumanoidRootPart")) then continue end
			if v.Character:FindFirstChildWhichIsA("Humanoid").Health <= 0 then continue end
			GetService.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1.6, 0.4)
			if os.clock() - lh >= .1 then
				GameEvents.HammerSwingEvent:FireServer(v)
				lh = os.clock()
			end
			break
		end
	end)
end)())
warn("ok")
