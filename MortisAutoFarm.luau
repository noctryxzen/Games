local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer
local Mortis = Teams:FindFirstChild("Mortis")
local Survivors = Teams:FindFirstChild("Survivors")
local Spectators = Teams:FindFirstChild("Spectators")

--// Anti Ragdoll
ReplicatedStorage.RagdollRemote.OnClientEvent:Connect(function(p)
	if p:find("Enable") then firesignal(ReplicatedStorage.RagdollRemote.OnClientEvent, "Disable") end
end)

--// Lobby
task.spawn(function()
	local Part = workspace:WaitForChild("Lobby"):WaitForChild("FinishedPart")
	while true do
		task.wait(.1)
		if lp.Team ~= Spectators then continue end
		local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
		if not hrp then continue end
		pcall(firetouchinterest, hrp, Part, 0)
		task.wait()
		pcall(firetouchinterest, hrp, Part, 1)
	end
end)

--// Mortis
ReplicatedStorage.Events.GameEvents.MortisChanceEvent:FireServer("PurchaseComplete")
ReplicatedStorage.Events.GameEvents.RoundStart.OnClientEvent:Connect(function()
	ReplicatedStorage.Events.GameEvents.MortisChanceEvent:FireServer("PurchaseComplete")
end)

task.spawn(function()
	while true do
		task.wait(.2)
		if lp.Team ~= Mortis then continue end
		for i, v in next, Players:GetPlayers() do
			if v == lp or v.Team ~= Survivors then continue end
			local hum = v.Character and v.Character:FindFirstChildWhichIsA("Humanoid")
			if hum and hum.Health > 0 then ReplicatedStorage.Events.GameEvents.HammerSwingEvent:FireServer(v) break end
		end
	end
end)

--// Teleport
lp.CharacterAdded:Connect(function(char)
	char:WaitForChild("HumanoidRootPart")
	task.wait(1)
end)

RunService.Heartbeat:Connect(function()
	if lp.Team ~= Mortis then return end
	local char = lp.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChildWhichIsA("Humanoid")
	if not hrp or not hum or hum.Health <= 0 then return end
	for i, v in next, Players:GetPlayers() do
		if v == lp or v.Team ~= Survivors then continue end
		local vhrp = v.Character and v.Character:FindFirstChild("HumanoidRootPart")
		local vhum = v.Character and v.Character:FindFirstChildWhichIsA("Humanoid")
		if vhrp and vhum and vhum.Health > 0 then
			local Target = vhrp.CFrame * CFrame.new(0, -3, 0)
			hrp.CFrame = hrp.CFrame:Lerp(Target, .2)
			break
		end
	end
end)

warn("ok")
