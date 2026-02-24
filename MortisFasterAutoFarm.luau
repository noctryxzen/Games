local GetService = setmetatable({}, {
	__index = function(s, n)
		s[n] = (cloneref and clonefunction(cloneref) or function(x) return x end)(clonefunction(game.GetService)(game, n))
		return s[n]
	end
})

--// Re-Execute the Script for Next Teleport
if queue_on_teleport then
	queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Games/refs/heads/main/MortisFasterAutoFarm.luau"))()]])
else
	GetService.StarterGui:SetCore("SendNotification", {Title = "queue_on_teleport not supported", Text = "Please put the loadstring to your autoexec!", Duration = 5})
end

--// Teleporter & Blocker to avoid Reports
Auto = {}
local Game, Job = game.PlaceId, game.JobId
function Auto.Teleport(Game, Job, NextServer)
	if NextServer then GetService.TeleportService:TeleportToPlaceInstance(Game, NextServer)
	else GetService.TeleportService:Teleport(Game) end
end
function Auto.Servers()
	local _ = {}
	pcall(function()
		for i, v in next, GetService.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. Game .. "/servers/Public?sortOrder=Asc&limit=100&excludeFullGames=true")).data do
			if v.playing < v.maxPlayers then table.insert(_, v.id) end
		end
	end)
	return _
end
loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Block.Run/refs/heads/main/Module.luau"))()

--// Main
local _ = false
local FinishedPart = GetService.Workspace:WaitForChild("Lobby"):WaitForChild("FinishedPart")
GetService.ReplicatedStorage.Events.GameEvents.StudPopupEvent.OnClientEvent:Connect(function(got)
	if got then
		_ = true
		if getgenv().create_new_server then
			for i, v in next, GetService.Players:GetPlayers() do
				if v ~= GetService.Players.LocalPlayer then Block.Run(v) break end
			end
		end
		Auto.Teleport(Game, Job, Job)
	end
end)
GetService.RunService.PreSimulation:Connect(function()
	if _ then return end
	if getgenv().create_new_server then
		local ____ = GetService.Players:GetPlayers()
		if #____ ~= 1 or ____[1] ~= GetService.Players.LocalPlayer then return end
	end
	local MyRoot = GetService.Players.LocalPlayer.Character and GetService.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not MyRoot then return end
	pcall(firetouchinterest, MyRoot, FinishedPart, 0)
	pcall(firetouchinterest, MyRoot, FinishedPart, 1)
end)

--// Auto-Buy
if getgenv().auto_buy then
	GetService.ReplicatedStorage.Events.GameEvents.ShopEvent.OnClientEvent:Connect(function(got, data)
		if got == "CrateResult" then writefile("wanted_crate.json", data.crateName:gsub("Crate", "")) end
	end)
	task.wait(.1)
	GetService.ReplicatedStorage.Events.GameEvents.ShopEvent:FireServer("BuyCrate", {crateName = getgenv().auto_buy .. "Crate"})
	GetService.ReplicatedStorage.Events.GameEvents.ShopEvent:FireServer("ClaimReward")
end

--// Block Players & Teleport to Block Others
if getgenv().create_new_server then
	local ___ = isfile("wanted_jobs.json") and GetService.HttpService:JSONDecode(readfile("wanted_jobs.json")) or {}
	if #GetService.Players:GetPlayers() > 1 then
		for i, v in next, GetService.Players:GetPlayers() do
			if v ~= GetService.Players.LocalPlayer then Block.Run(v) break end
		end
		if not table.find(___, Job) then table.insert(___, Job) end
		writefile("wanted_jobs.json", GetService.HttpService:JSONEncode(___))
		local __ = nil
		for i, v in next, Auto.Servers() do if not table.find(___, v) then __ = v break end end
		if __ then Auto.Teleport(Game, Job, __) else Auto.Teleport(Game) end
	end
end
