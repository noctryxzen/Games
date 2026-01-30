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
local RunService = GetService.RunService
local UserInputService = GetService.UserInputService
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local CurrentTarget = nil
local MousePosition = nil

local FovCircle = Drawing.new("Circle")
FovCircle.Position = UserInputService:GetMouseLocation()
FovCircle.Radius = getgenv().hdjsjxjsjsjsksjsjhi.FovSize
FovCircle.Visible = true
FovCircle.Color = Color3.fromRGB(255, 0, 0)

local o;o = hookmetamethod(game, "__namecall", newcclosure(function(...)
	local Arguments = {...}
	local CalledMethod = getnamecallmethod()
	local CalledSelf = Arguments[1]
	if CalledSelf == workspace and not checkcaller() then
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
    FovCircle.Position = UserInputService:GetMouseLocation()
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
			local DistanceFromCenter = (ScreenVector - UserInputService:GetMouseLocation()).Magnitude
			if DistanceFromCenter <= getgenv().hdjsjxjsjsjsksjsjhi.FovSize and DistanceFromCenter < ClosestDistance then
				local DirectionToTarget = (HeadPosition - CameraPosition).Unit
				local DotProduct = CameraLookVector:Dot(DirectionToTarget)
				if DotProduct > 0 then
					local WallCheckRay = Ray.new(CameraPosition, HeadPosition - CameraPosition)
					local RayHit = workspace:FindPartOnRayWithIgnoreList(WallCheckRay, {PlayerCharacter})
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
