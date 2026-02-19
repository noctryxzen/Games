loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/FilterGC/refs/heads/main/isGC.luau"))()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local lp = Players.LocalPlayer
local esp = {}
make_me_mortis = true

_add = function()
	ReplicatedStorage.RagdollRemote.OnClientEvent:Connect(function(p)
		if p:find("Enable") then firesignal(ReplicatedStorage.RagdollRemote.OnClientEvent, "Disable") end
	end)
	repeat task.wait(.5) until #filtergc("function", {Name = "isInHitbox"}) > 0
	for i, v in next, filtergc("function", {Name = "isInHitbox"}) do hookfunction(v, newcclosure(function() return true end)) end
end

ReplicatedStorage.Events.GameEvents.MortisChanceEvent:FireServer(make_me_mortis and "PurchaseComplete")
ReplicatedStorage.Events.GameEvents.RoundStart.OnClientEvent:Connect(function() ReplicatedStorage.Events.GameEvents.MortisChanceEvent:FireServer(make_me_mortis and "PurchaseComplete") end)
lp.CharacterAdded:Connect(_add)
_add()

Players.PlayerRemoving:Connect(function(v)
	if esp[v] then for i = 1, 5 do esp[v][i]:Remove() end esp[v] = nil end
end)

game:GetService("RunService").PreRender:Connect(function()
	for i, v in next, Players:GetPlayers() do
		if v == lp then continue end
		if not esp[v] then
			local n = Drawing.new("Text")
			n.Size = 14 n.Center = true n.Outline = true n.Transparency = 1 n.Visible = false
			local l1 = Drawing.new("Line") l1.Thickness = 2 l1.Transparency = 1 l1.Visible = false
			local l2 = Drawing.new("Line") l2.Thickness = 2 l2.Transparency = 1 l2.Visible = false
			local l3 = Drawing.new("Line") l3.Thickness = 2 l3.Transparency = 1 l3.Visible = false
			local l4 = Drawing.new("Line") l4.Thickness = 2 l4.Transparency = 1 l4.Visible = false
			esp[v] = {l1, l2, l3, l4, n}
		end
		local l1, l2, l3, l4, n = esp[v][1], esp[v][2], esp[v][3], esp[v][4], esp[v][5]
		local hrp = v.Character and v.Character:FindFirstChild("HumanoidRootPart")
		local hum = v.Character and v.Character:FindFirstChildWhichIsA("Humanoid")
		if hrp and hum and hum.Health > 0 then
			local pos, vis = game:GetService("Workspace").CurrentCamera:WorldToViewportPoint(hrp.Position)
			if vis then
				local c = v.Team == Teams:FindFirstChild("Mortis") and Color3.fromRGB(255, 50, 50)
					or (v.Team == Teams:FindFirstChild("Spectators") and v:GetAttribute("IsGhost")) and Color3.fromRGB(100, 150, 255)
					or v.Team == Teams:FindFirstChild("Spectators") and Color3.fromRGB(180, 180, 180)
					or Color3.fromRGB(50, 255, 50)
				local sz = 1000 / pos.Z
				local x, y, x2, y2 = pos.X - sz/2, pos.Y - sz, pos.X + sz/2, pos.Y + sz
				l1.From = Vector2.new(x, y)   l1.To = Vector2.new(x2, y)  l1.Color = c l1.Visible = true
				l2.From = Vector2.new(x2, y)  l2.To = Vector2.new(x2, y2) l2.Color = c l2.Visible = true
				l3.From = Vector2.new(x2, y2) l3.To = Vector2.new(x, y2)  l3.Color = c l3.Visible = true
				l4.From = Vector2.new(x, y2)  l4.To = Vector2.new(x, y)   l4.Color = c l4.Visible = true
				n.Text = v.DisplayName ~= v.Name and v.DisplayName .. " @" .. v.Name or v.Name
				n.Position = Vector2.new(pos.X, y - 16) n.Color = c n.Visible = true
			else l1.Visible = false l2.Visible = false l3.Visible = false l4.Visible = false n.Visible = false end
		else l1.Visible = false l2.Visible = false l3.Visible = false l4.Visible = false n.Visible = false end
	end
end)

warn("ok")
