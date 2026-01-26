local Services=setmetatable({},{__index=function(Self,Name)
	Self[Name]=game:GetService(Name)
	return Self[Name]
end})

local Players=Services.Players
local ReplicatedStorage=Services.ReplicatedStorage
local LocalPlayer=Players.LocalPlayer
local Camera=Services.Workspace.CurrentCamera

local Target=nil
local Priority=nil
local RemoteEvent=ReplicatedStorage.Events.RemoteEvent

local o;o=hookmetamethod(game,"__namecall",newcclosure(function(...)
	local Arguments={...}
	local Method=getnamecallmethod()
	if not checkcaller() and Arguments[1]==RemoteEvent and Method=="FireServer" and Arguments[2]==14 then
		local FinalTarget=Priority or Target
		if FinalTarget then
			local BulletTable=Arguments[4]
			if BulletTable and BulletTable[1] then
				local BulletData=BulletTable[1]
				local StartPosition=Camera.CFrame.Position
				local TargetPosition=FinalTarget.Position
				local Direction=(TargetPosition-StartPosition).Unit
				BulletData[1]=StartPosition
				BulletData[2]=StartPosition+(Direction*10)
				BulletData[3]=TargetPosition
				BulletData[4]=FinalTarget
				BulletData[5]=TargetPosition
				BulletData[6]=Vector3.new(0,0,0)
			end
		end
	end
	return o(...)
end))

Services.RunService.RenderStepped:Connect(function()
	local Character=LocalPlayer.Character
	if not Character then Target=nil Priority=nil return end
	local Root=Character:FindFirstChild("HumanoidRootPart")
	if not Root then Target=nil Priority=nil return end
	local Closest=nil
	local Distance=math.huge
	local Near=nil
	for _,Player in Players:GetPlayers() do
		if Player==LocalPlayer then continue end
		if not TeamCheck and Player.Team==LocalPlayer.Team then continue end
		local TargetCharacter=Player.Character
		if not TargetCharacter then continue end
		local TargetHumanoid=TargetCharacter:FindFirstChildOfClass("Humanoid")
		if not TargetHumanoid or TargetHumanoid.Health<=0 then continue end
		if TargetCharacter:FindFirstChildOfClass("ForceField") then continue end
		local TargetHead=TargetCharacter:FindFirstChild("Head")
		if not TargetHead then continue end
		local Dist=(Root.Position-TargetHead.Position).Magnitude
		if Dist<50 and(not Near or Dist<(Root.Position-Near.Position).Magnitude)then Near=TargetHead end
		if Dist<Distance then Distance=Dist Closest=TargetHead end
	end
	Priority=Near
	Target=Closest
end)

warn("ok")
