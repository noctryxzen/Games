local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Teams = game:GetService("Teams")
local RunService = game:GetService("RunService")
if getgenv().auto_kill == nil then getgenv().auto_kill = true end
if getgenv().auto_obby == nil then getgenv().auto_obby = false end
local ok = false

--// Remove Annoying Screen
if LocalPlayer.PlayerGui:WaitForChild("Transition"):FindFirstChild("Fade") then
	LocalPlayer.PlayerGui.Transition.Fade:Destroy()
end

--// Anti Ragdoll
ReplicatedStorage.RagdollRemote.OnClientEvent:Connect(function(P)
	if P:find("Enable") then firesignal(ReplicatedStorage.RagdollRemote.OnClientEvent, "Disable") end
end)

--// Make Mortis
if getgenv().auto_kill then
	ReplicatedStorage.Events.GameEvents.MortisChanceEvent:FireServer("PurchaseComplete")
end
ReplicatedStorage.Events.GameEvents.RoundStart.OnClientEvent:Connect(function()
	if not getgenv().auto_kill then return end
	ReplicatedStorage.Events.GameEvents.MortisChanceEvent:FireServer("PurchaseComplete")
end)
ReplicatedStorage.Events.GameEvents.VFXEvent.OnClientEvent:Connect(function(Type, Target)
	if Type ~= "TransformVFX" or Target ~= LocalPlayer or LocalPlayer.Team ~= Teams:FindFirstChild("Mortis") then return end
	ok = true
end)

--// Obby / Teleport & Hit
local Part = workspace:FindFirstChild("Lobby") and workspace.Lobby:FindFirstChild("FinishedPart")
RunService.PreSimulation:Connect((function()
	local lh = 0
	return function()
		if not (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then return end
		if getgenv().auto_obby and LocalPlayer.Team == Teams:FindFirstChild("Spectators") and not LocalPlayer:GetAttribute("IsGhost") and Part then
			LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, -99, 0)
			pcall(firetouchinterest, LocalPlayer.Character.HumanoidRootPart, Part, 0)
			pcall(firetouchinterest, LocalPlayer.Character.HumanoidRootPart, Part, 1)
			return
		end
		if not getgenv().auto_kill or not ok then return end
		if LocalPlayer.Team == Teams:FindFirstChild("Spectators") then ok = false return end
		if not LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = true end
		for i,v in next, Players:GetPlayers() do
			if v == LocalPlayer or v.Team ~= Teams:FindFirstChild("Survivors") then continue end
			if not (v.Character and v.Character:FindFirstChild("HumanoidRootPart")) then continue end
			if v.Character:FindFirstChildWhichIsA("Humanoid").Health <= 0 then continue end
			LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1.6, 0.4)
			if os.clock() - lh >= .2 then
				ReplicatedStorage.Events.GameEvents.HammerSwingEvent:FireServer(v)
				lh = os.clock()
			end
			break
		end
	end
end)())

warn("ok")
