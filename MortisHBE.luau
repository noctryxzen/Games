loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/FilterGC/refs/heads/main/isGC.luau"))()

local GetService = setmetatable({}, {
	__index = function(s, n)
		s[n] = (cloneref and clonefunction(cloneref) or function(x) return x end)(clonefunction(game.GetService)(game, n))
		return s[n]
	end
})

--// Settings
if getgenv().make_me_mortis == nil then getgenv().make_me_mortis = false end
if getgenv().anti_ragdoll == nil then getgenv().anti_ragdoll = false end
if getgenv().esp == nil then getgenv().esp = true end

--// ESP
local _ = {}

for i,v in next, GetService.Players:GetPlayers() do
	if v == GetService.Players.LocalPlayer or _[v] then continue end
	local Box = Drawing.new("Square")
	Box.Thickness = 2 Box.Transparency = 1 Box.Filled = false Box.Visible = false
	local Label = Drawing.new("Text")
	Label.Size = 14 Label.Center = true Label.Outline = true Label.Transparency = 1 Label.Visible = false
	_[v] = {Box, Label}
end

GetService.Players.PlayerAdded:Connect(newcclosure(function(v)
	if v == GetService.Players.LocalPlayer or _[v] then return end
	local Box = Drawing.new("Square")
	Box.Thickness = 2 Box.Transparency = 1 Box.Filled = false Box.Visible = false
	local Label = Drawing.new("Text")
	Label.Size = 14 Label.Center = true Label.Outline = true Label.Transparency = 1 Label.Visible = false
	_[v] = {Box, Label}
end))

GetService.Players.PlayerRemoving:Connect(newcclosure(function(v)
	if not _[v] then return end
	for i,v2 in next, _[v] do v2:Remove() end _[v] = nil
end))

GetService.RunService.PreSimulation:Connect(newcclosure(function()
	for i,v in next, GetService.Players:GetPlayers() do
		if not _[v] then continue end
		local Box, Label = _[v][1], _[v][2]
		local RootPart = v.Character and v.Character:FindFirstChild("HumanoidRootPart")
		local Humanoid = v.Character and v.Character:FindFirstChildWhichIsA("Humanoid")
		if getgenv().esp and RootPart and Humanoid and Humanoid.Health > 0 then
			local Position, Visible = GetService.Workspace.CurrentCamera:WorldToViewportPoint(RootPart.Position)
			if Visible then
				local Color = v.Team == GetService.Teams:FindFirstChild("Mortis") and Color3.fromRGB(255,50,50)
					or (v.Team == GetService.Teams:FindFirstChild("Spectators") and v:GetAttribute("IsGhost")) and Color3.fromRGB(100,150,255)
					or v.Team == GetService.Teams:FindFirstChild("Spectators") and Color3.fromRGB(180,180,180)
					or Color3.fromRGB(50,255,50)
				local Size,X,Y = 1000/Position.Z, Position.X-500/Position.Z, Position.Y-1000/Position.Z
				Box.Size = Vector2.new(Size, Size*2)
				Box.Position = Vector2.new(X, Y)
				Box.Color = Color Box.Visible = true
				Label.Text = v.DisplayName ~= v.Name and v.DisplayName.." @"..v.Name or v.Name
				Label.Position = Vector2.new(Position.X, Y-16) Label.Color = Color Label.Visible = true
			else Box.Visible = false Label.Visible = false end
		else Box.Visible = false Label.Visible = false end
	end
end))

--// Anti Ragdoll
if getgenv().anti_ragdoll then
	GetService.ReplicatedStorage.RagdollRemote.OnClientEvent:Connect(newcclosure(function(P)
		if P:find("Enable") then firesignal(GetService.ReplicatedStorage.RagdollRemote.OnClientEvent, "Disable") end
	end))
end

--// Make Me Mortis
GetService.ReplicatedStorage.Events.GameEvents.MortisChanceEvent:FireServer(getgenv().make_me_mortis and "PurchaseComplete")
GetService.ReplicatedStorage.Events.GameEvents.RoundStart.OnClientEvent:Connect(newcclosure(function()
	GetService.ReplicatedStorage.Events.GameEvents.MortisChanceEvent:FireServer(getgenv().make_me_mortis and "PurchaseComplete")
end))

--// HBE (Hit-Box Expander
GetService.Players.LocalPlayer.CharacterAdded:Connect(newcclosure(function()
	repeat task.wait(.5) until filtergc("function", {Name = "isInHitbox"}, true)
	for i,v in next, filtergc("function", {Name = "isInHitbox"}) do
		if isfunctionhooked(v) then restorefunction(v) end
		hookfunction(v, newcclosure(function() return true end))
	end
end))
