local GetService = setmetatable({}, {
	__index = function(Self, Name)
		Self[Name] = game:GetService(Name)
		return Self[Name]
	end
})

local Players = GetService.Players
local ReplicatedStorage = GetService.ReplicatedStorage
local RunService = GetService.RunService
local Workspace = GetService.Workspace
local LocalPlayer = Players.LocalPlayer
local RemoteEvent = ReplicatedStorage.Events.RemoteEvent
local Pickups = Workspace.pickups

RunService.Heartbeat:Connect(function()
	local MyChar = LocalPlayer.Character
	if not MyChar then return end
	
	local Humanoid = MyChar:FindFirstChildOfClass("Humanoid")
	if Humanoid and Humanoid.Sit then Humanoid.Sit = false end
	
	local Backpack = LocalPlayer:FindFirstChild("Backpack")
	local HasKnife = (MyChar:FindFirstChild("Knife")) or (Backpack and Backpack:FindFirstChild("Knife"))
	
	if not HasKnife then
		for _, Pickup in Pickups:GetChildren() do
			if Pickup.Name == "Knife" then
				local MeshPart = Pickup:FindFirstChild("Meshes/knife1")
				if MeshPart and MeshPart:IsA("BasePart") and MeshPart.Parent then
					local Root = MyChar:FindFirstChild("HumanoidRootPart")
					if Root then
						Root.CFrame = CFrame.new(MeshPart.Position)
						task.wait(.2)
						RemoteEvent:FireServer(12, Pickup)
						task.wait(.2)
						break
					end
				end
			end
		end
		return
	end
	
	local Root = MyChar:FindFirstChild("HumanoidRootPart")
	local Knife = MyChar:FindFirstChild("Knife") or (Backpack and Backpack:FindFirstChild("Knife"))
	if not Root or not Knife or not Humanoid then return end
	
	if Root.Anchored then Root.Anchored = false end
	if Knife.Parent == Backpack then Humanoid:EquipTool(Knife) end
	
	local FoundTarget = false
	for _, Player in Players:GetPlayers() do
		if Player ~= LocalPlayer then
			local TargetChar = Player.Character
			if TargetChar then
				local TargetRoot = TargetChar:FindFirstChild("HumanoidRootPart")
				local TargetHead = TargetChar:FindFirstChild("Head")
				local TargetHumanoid = TargetChar:FindFirstChildOfClass("Humanoid")
				local ForceField = TargetChar:FindFirstChildOfClass("ForceField")
				if TargetRoot and TargetHead and TargetHumanoid and TargetHumanoid.Health > 0 and not ForceField then
					FoundTarget = true
					Root.CFrame = TargetRoot.CFrame * CFrame.new(0, -5, 0)
					if (Root.Position - TargetRoot.Position).Magnitude <= 17 then
						local Direction = (TargetHead.Position - Root.Position).Unit
						RemoteEvent:FireServer(16, Knife, TargetHead, Direction)
					end
				end
			end
		end
	end
	if not FoundTarget then Root.CFrame = CFrame.new(99999, 99999, 99999) end
end)

warn("ok")
