Services=setmetatable({},{__index=function(Self,Name)
	Self[Name]=game:GetService(Name)
	return Self[Name]
end})

Players=Services.Players
Workspace=Services.Workspace
ReplicatedStorage=Services.ReplicatedStorage
LocalPlayer=Players.LocalPlayer
Camera=Workspace.CurrentCamera

Target=nil
Priority=nil
RemoteEvent=ReplicatedStorage.Events.RemoteEvent

if TeamCheck and TeamCheck~="" then
	ExcludedTeams={}
	for TeamName in string.gmatch(TeamCheck,"[^,]+") do
		TeamExists=false
		for _,Team in Services.Teams:GetTeams() do
			if Team.Name==TeamName then
				TeamExists=true
				table.insert(ExcludedTeams,TeamName)
				break
			end
		end
		if not TeamExists then
			warn("This team doesn't exist: "..TeamName)
		end
	end
	AllTeams=Services.Teams:GetTeams()
	if #ExcludedTeams>=#AllTeams then
		error("You cannot exclude every teams in the game")
	end
end

o=nil;o=hookmetamethod(game,"__namecall",newcclosure(function(...)
	Arguments={...}
	Method=getnamecallmethod()
	if not checkcaller() and Arguments[1]==RemoteEvent and Method=="FireServer" and Arguments[2]==14 then
		FinalTarget=Priority or Target
		if FinalTarget and typeof(FinalTarget)=="Instance" then
			BulletTable=Arguments[4]
			if type(BulletTable)=="table" and BulletTable[1] then
				BulletData=BulletTable[1]
				if type(BulletData)=="table" and type(BulletData[4])=="userdata" then
					StartPosition=Camera.CFrame.Position
					TargetPosition=FinalTarget.Position
					Direction=(TargetPosition-StartPosition).Unit
					BulletData[1]=StartPosition
					BulletData[2]=StartPosition+(Direction*10)
					BulletData[3]=TargetPosition
					BulletData[4]=FinalTarget
					BulletData[5]=TargetPosition
					BulletData[6]=Vector3.new(0,0,0)
				end
			end
		end
	end
	return o(...)
end))

Services.RunService.RenderStepped:Connect(function()
	Character=LocalPlayer.Character
	if not Character then Target=nil Priority=nil return end
	Root=Character:FindFirstChild("HumanoidRootPart")
	if not Root then Target=nil Priority=nil return end
	Closest=nil
	Distance=math.huge
	Near=nil
	for _,Player in Players:GetPlayers() do
		if Player==LocalPlayer then continue end
		if Player.Team==LocalPlayer.Team then continue end
		TargetCharacter=Player.Character
		if not TargetCharacter then continue end
		TargetHumanoid=TargetCharacter:FindFirstChildOfClass("Humanoid")
		if not TargetHumanoid or TargetHumanoid.Health<=0 then continue end
		if TargetCharacter:FindFirstChildOfClass("ForceField") then continue end
		if TeamCheck and TeamCheck~="" then
			PlayerTeam=Player.Team and Player.Team.Name or ""
			Skip=false
			for TeamName in string.gmatch(TeamCheck,"[^,]+") do
				if PlayerTeam==TeamName then Skip=true break end
			end
			if Skip then continue end
		end
		TargetHead=TargetCharacter:FindFirstChild("Head")
		if not TargetHead then continue end
		Dist=(Root.Position-TargetHead.Position).Magnitude
		if Dist<50 and(not Near or Dist<(Root.Position-Near.Position).Magnitude)then Near=TargetHead end
		if Dist<Distance then Distance=Dist Closest=TargetHead end
	end
	Priority=Near
	Target=Closest
end)

warn("loaded")
