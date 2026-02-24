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
local Auto = {}
local Game, Job = game.PlaceId, game.JobId
function Auto.Teleport(Game, Job, NextServer)
	if NextServer then GetService.TeleportService:TeleportToPlaceInstance(Game, NextServer)
	else GetService.TeleportService:Teleport(Game) end
end
function Auto.Servers()
	local _____ = {}
	pcall(function()
		local ____ = GetService.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. Game .. "/servers/Public?sortOrder=Asc&limit=100&excludeFullGames=true"))
		for i, v in next, ____.data do if v.playing < v.maxPlayers then table.insert(_____, v.id) end end
	end)
	return _____
end
loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Block.Run/refs/heads/main/Module.luau"))()

--// Auto-Buy
if getgenv().auto_buy then
	GetService.ReplicatedStorage.Events.GameEvents.ShopEvent.OnClientEvent:Connect(function(got, data)
		if got == "CrateResult" then writefile("wantedcrate.json", data.crateName:gsub("Crate", "")) end
	end)
	task.wait(.1)
	GetService.ReplicatedStorage.Events.GameEvents.ShopEvent:FireServer("BuyCrate", {crateName = getgenv().auto_buy .. "Crate"})
	GetService.ReplicatedStorage.Events.GameEvents.ShopEvent:FireServer("ClaimReward")
end

--// Block Players & Teleport to Block Others
do
	if getgenv().create_new_server then
		writefile("autotp.json", "[]")
	end
	local ___ = {}
	pcall(function()
		for i, v in next, GetService.HttpService:JSONDecode(readfile("autotp.json")) do
			___[v] = true
		end
	end)
	local ____ = GetService.Players:GetPlayers()
	if #____ > 1 or (____[1] and ____[1] ~= GetService.Players.LocalPlayer) then
		for i, v2 in next, ____ do
			if v2 ~= GetService.Players.LocalPlayer then
				Block.Run(v2)
				break
			end
		end
		if not ___[Job] then
			___[Job] = true
			local ________ = {}
			for i in next, ___ do table.insert(________, i) end
			writefile("autotp.json", GetService.HttpService:JSONEncode(________))
		end
		local _______ = Auto.Servers()
		local __________ = nil
		for i, v in next, _______ do if not ___[v] then __________ = v break end end
		if __________ then Auto.Teleport(Game, Job, __________) else Auto.Teleport(Game) end
	end
end

--// Main
local _ = false
local FinishedPart = GetService.Workspace:WaitForChild("Lobby"):WaitForChild("FinishedPart")
GetService.ReplicatedStorage.Events.GameEvents.StudPopupEvent.OnClientEvent:Connect(function(got)
	if got then
		_ = true
		for i, v2 in next, GetService.Players:GetPlayers() do
			if v2 ~= GetService.Players.LocalPlayer then
				Block.Run(v2)
				break
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
