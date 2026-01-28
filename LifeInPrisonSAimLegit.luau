getgenv().hdjsjxjsjsjsksjsjhi = getgenv().hdjsjxjsjsjsksjsjhi or {
	FovSize = 126,
	HitChance = 73,
	IgnorePolice = false,
	IgnoreCriminals = false,
	IgnorePrisoners = false
}

local GetService = setmetatable({}, {
	__index = function(Table, Index)
		Table[Index] = game:GetService(Index)
		return Table[Index]
	end
})

local Players = GetService.Players
local Workspace = GetService.Workspace
local RunService = GetService.RunService
local UserInputService = GetService.UserInputService
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local CurrentTarget = nil
local MousePosition = nil

local ScreenGui = Instance.new("ScreenGui")
local FovCircle = Instance.new("Frame")
local CircleCorner = Instance.new("UICorner")
local CircleStroke = Instance.new("UIStroke")

ScreenGui.Parent = gethui and gethui() or GetService.CoreGui
ScreenGui.IgnoreGuiInset = true
FovCircle.Parent = ScreenGui
FovCircle.AnchorPoint = Vector2.new(0.5, 0.5)
FovCircle.BackgroundTransparency = 1
CircleCorner.CornerRadius = UDim.new(1, 0)
CircleCorner.Parent = FovCircle
CircleStroke.Color = Color3.fromRGB(255, 255, 255)
CircleStroke.Thickness = 1
CircleStroke.Transparency = 0.5
CircleStroke.Parent = FovCircle

UserInputService.InputChanged:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseMovement then
		MousePosition = Vector2.new(Input.Position.X, Input.Position.Y)
	end
end)

local o;o = hookmetamethod(game, "__namecall", newcclosure(function(...)
	local Arguments = {...}
	local CalledMethod = getnamecallmethod()
	local CalledSelf = Arguments[1]
	if CalledSelf == Workspace and not checkcaller() then
		if CurrentTarget then
			local HitRoll = math.random(1, 100)
			if HitRoll <= getgenv().hdjsjxjsjsjsksjsjhi.HitChance then
				if CalledMethod == "FindPartOnRayWithIgnoreList" or CalledMethod == "FindPartOnRayWithWhitelist" or CalledMethod == "FindPartOnRay" or CalledMethod == "findPartOnRay" then
					local RayOrigin = Arguments[2].Origin
					local TargetPosition = CurrentTarget.Position
					local RayDirection = TargetPosition - RayOrigin
					Arguments[2] = Ray.new(RayOrigin, RayDirection)
					return o(unpack(Arguments))
				elseif CalledMethod == "Raycast" then
					local RayOrigin = Arguments[2]
					local TargetPosition = CurrentTarget.Position
					Arguments[3] = TargetPosition - RayOrigin
					return o(unpack(Arguments))
				end
			end
		end
	end
	return o(...)
end))

RunService.RenderStepped:Connect(function()
	local PlayerCharacter = LocalPlayer.Character
	if not PlayerCharacter then
		CurrentTarget = nil
		return
	end
	local CharacterRoot = PlayerCharacter:FindFirstChild("HumanoidRootPart")
	if not CharacterRoot then
		CurrentTarget = nil
		return
	end
	local ScreenSize = Camera.ViewportSize
	local ScreenCenter = MousePosition or Vector2.new(ScreenSize.X / 2, ScreenSize.Y / 2)
	FovCircle.Position = UDim2.new(0, ScreenCenter.X, 0, ScreenCenter.Y)
	FovCircle.Size = UDim2.new(0, getgenv().hdjsjxjsjsjsksjsjhi.FovSize * 2, 0, getgenv().hdjsjxjsjsjsksjsjhi.FovSize * 2)
	local CameraPosition = Camera.CFrame.Position
	local CameraLookVector = Camera.CFrame.LookVector
	CurrentTarget = nil
	local ClosestDistance = math.huge
	for _, OtherPlayer in Players:GetPlayers() do
		if OtherPlayer == LocalPlayer then continue end
		if OtherPlayer.Team == LocalPlayer.Team then continue end
		if OtherPlayer.Team then
			if getgenv().hdjsjxjsjsjsksjsjhi.IgnorePolice and OtherPlayer.Team.Name == "Police" then continue end
			if getgenv().hdjsjxjsjsjsksjsjhi.IgnoreCriminals and OtherPlayer.Team.Name == "Criminals" then continue end
			if getgenv().hdjsjxjsjsjsksjsjhi.IgnorePrisoners and OtherPlayer.Team.Name == "Prisoners" then continue end
		end
		local TargetCharacter = OtherPlayer.Character
		if not TargetCharacter then continue end
		local TargetHumanoid = TargetCharacter:FindFirstChildOfClass("Humanoid")
		if not TargetHumanoid or TargetHumanoid.Health <= 0 then continue end
		if TargetCharacter:FindFirstChildOfClass("ForceField") then continue end
		local TargetHead = TargetCharacter:FindFirstChild("Head")
		if not TargetHead then continue end
		local HeadPosition = TargetHead.Position
		local ScreenPosition, IsOnScreen = Camera:WorldToViewportPoint(HeadPosition)
		if IsOnScreen then
			local ScreenVector = Vector2.new(ScreenPosition.X, ScreenPosition.Y)
			local DistanceFromCenter = (ScreenVector - ScreenCenter).Magnitude
			if DistanceFromCenter <= getgenv().hdjsjxjsjsjsksjsjhi.FovSize and DistanceFromCenter < ClosestDistance then
				local DirectionToTarget = (HeadPosition - CameraPosition).Unit
				local DotProduct = CameraLookVector:Dot(DirectionToTarget)
				if DotProduct > 0 then
					local WallCheckRay = Ray.new(CameraPosition, HeadPosition - CameraPosition)
					local RayHit = Workspace:FindPartOnRayWithIgnoreList(WallCheckRay, {PlayerCharacter})
					local IsVisible = false
					if RayHit then
						if RayHit.Parent == TargetCharacter or RayHit.Parent.Parent == TargetCharacter then
							IsVisible = true
						end
					else
						IsVisible = true
					end
					if IsVisible then
						ClosestDistance = DistanceFromCenter
						CurrentTarget = TargetHead
					end
				end
			end
		end
	end
end)
