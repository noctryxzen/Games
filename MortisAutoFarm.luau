local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Teams = game:GetService("Teams")
local RunService = game:GetService("RunService")
getgenv().auto_kill = getgenv().auto_kill or true
getgenv().auto_obby = getgenv().auto_obby or false
local ok = false

--// Remove Annoying Screen
if LocalPlayer.PlayerGui:WaitForChild("Transition"):FindFirstChild("Fade") then
	LocalPlayer.PlayerGui.Transition.Fade:Destroy()
end

--// Anti Ragdoll
ReplicatedStorage.RagdollRemote.OnClientEvent:Connect(function(P)
	if P:find("Enable") then firesignal(ReplicatedStorage.RagdollRemote.OnClientEvent, "Disable") end
end)

--// Lobby
local Part = workspace:FindFirstChild("Lobby") and workspace.Lobby:FindFirstChild("FinishedPart")
RunService.PreSimulation:Connect(function()
	if not getgenv().auto_obby or LocalPlayer.Team ~= Teams:FindFirstChild("Spectators") then return end
	if not (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then return end
	if not Part then return end
	LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, -99, 0)
	pcall(firetouchinterest, LocalPlayer.Character.HumanoidRootPart, Part, 0)
	pcall(firetouchinterest, LocalPlayer.Character.HumanoidRootPart, Part, 1)
end)

--// Make Mortis
ReplicatedStorage.Events.GameEvents.MortisChanceEvent:FireServer("PurchaseComplete")
ReplicatedStorage.Events.GameEvents.RoundStart.OnClientEvent:Connect(function()
	ReplicatedStorage.Events.GameEvents.MortisChanceEvent:FireServer("PurchaseComplete")
end)
ReplicatedStorage.Events.GameEvents.VFXEvent.OnClientEvent:Connect(function(Type, Target)
	if Type ~= "TransformVFX" or Target ~= LocalPlayer or LocalPlayer.Team ~= Teams:FindFirstChild("Mortis") then return end
	ok = true
end)

--// Teleport & Hit
task.spawn(function()
	while true do
		task.wait(.2)
		if not getgenv().auto_kill or not ok then continue end
		for i,v in next, Players:GetPlayers() do
			if v == LocalPlayer or v.Team ~= Teams:FindFirstChild("Survivors") then continue end
			if v.Character and v.Character:FindFirstChildWhichIsA("Humanoid") and v.Character:FindFirstChildWhichIsA("Humanoid").Health > 0 then
				ReplicatedStorage.Events.GameEvents.HammerSwingEvent:FireServer(v) break
			end
		end
	end
end)
RunService.PreSimulation:Connect(function()
	if not getgenv().auto_kill or not ok then return end
	if not (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then return end
	if LocalPlayer.Team == Teams:FindFirstChild("Spectators") then ok = false return end
	if not LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = true end
	for i,v in next, Players:GetPlayers() do
		if v == LocalPlayer or v.Team ~= Teams:FindFirstChild("Survivors") then continue end
		if not (v.Character and v.Character:FindFirstChild("HumanoidRootPart")) then continue end
		if v.Character:FindFirstChildWhichIsA("Humanoid").Health <= 0 then continue end
		LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1.6, 0.4)
		break
	end
end)

warn("ok")
