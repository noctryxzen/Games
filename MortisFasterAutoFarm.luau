local GetService = setmetatable({}, {
	__index = function(s, n)
		s[n] = (cloneref and clonefunction(cloneref) or function(x) return x end)(clonefunction(game.GetService)(game, n))
		return s[n]
	end
})

--// Execute the script for the next Teleport
if queue_on_teleport then
	queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Games/refs/heads/main/MortisFasterAutoFarm.luau"))()]])
else
	GetService.StarterGui:SetCore("SendNotification", {
		Title = "queue_on_teleport not supported",
		Text = "Please put the loadstring to your autoexec!",
		Duration = 5
	})
end

--// Auto-Buy
local _ = false
local __ = not (getgenv().auto_buy or isfile("wantedcrate.json"))
if getgenv().auto_buy or isfile("wantedcrate.json") then
	GetService.ReplicatedStorage.Events.GameEvents.ShopEvent.OnClientEvent:Connect(function(got, data)
		if got == "CrateResult" then
			__ = true
			writefile("wantedcrate.json", data.crateName:gsub("Crate", ""))
		end
	end)
	task.wait(1)
	GetService.ReplicatedStorage.Events.GameEvents.ShopEvent:FireServer("BuyCrate", {crateName = (getgenv().auto_buy or readfile("wantedcrate.json")) .. "Crate"})
	GetService.ReplicatedStorage.Events.GameEvents.ShopEvent:FireServer("ClaimReward")
	task.delay(2, function() __ = true end)
end

--// Teleporter & Blocker to avoid Reports
local Auto = {}
local Block = loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Block.Run/refs/heads/main/Module.luau"))()
local Game, Job = game.PlaceId, game.JobId
function Auto.Teleport(NextServer)
	if NextServer then
		GetService.TeleportService:TeleportToPlaceInstance(Game, NextServer)
	else
		GetService.TeleportService:Teleport(Game)
	end
end
function Auto.Block()
	if not (getgenv().create_new_server or isfile("autotp.txt")) then return end
	local ___ = {}
	if isfile("autotp.txt") then
		for i, v3 in readfile("autotp.txt"):gmatch("(.-)=(.+)") do ___[i] = v3 end
	end
	local ____ = GetService.Players:GetPlayers()
	if #____ == 1 and ____[1] == GetService.Players.LocalPlayer then
		if not ___[Job] then ___[Job] = "" end
		local ________ = {}
		for i, v3 in ___ do table.insert(________, i .. "=" .. v3) end
		writefile("autotp.txt", table.concat(________, "\n"))
		return ___
	end
	Block.Run()
	___[Job] = ___[Job] or ""
	local ________ = {}
	for i, v3 in ___ do table.insert(________, i .. "=" .. v3) end
	writefile("autotp.txt", table.concat(________, "\n"))
	return ___
end

--// Block Players & Teleport to Block Others
local ___ = Auto.Block()
if ___ then
	local Server1 = GetService.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. Game .. "/servers/Public?sortOrder=Asc&limit=100&excludeFullGames=true"))
	local Server2 = GetService.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. Game .. "/servers/Public?sortOrder=Asc&limit=100&excludeFullGames=true&cursor=" .. (Server1.nextPageCursor or "")))
	local _________ = {}
	for i, v2 in Server1.data do
		if v2.playing < v2.maxPlayers then table.insert(_________, v2) end
	end
	for i, v2 in Server2.data do
		if v2.playing < v2.maxPlayers then table.insert(_________, v2) end
	end

	local __________ = nil
	for i, v2 in _________ do
		if not ___[v2.id] then
			__________ = v2.id
			break
		end
	end

	Auto.Teleport(__________)
end

--// Main
GetService.ReplicatedStorage.Events.GameEvents.StudPopupEvent.OnClientEvent:Connect(function(got)
	if got then
		_ = true
		Auto.Block()
		Auto.Teleport(Job)
	end
end)
task.delay(1, function()
	if not _ then Auto.Teleport(Job) end
end)

local FinishedPart = GetService.Workspace:WaitForChild("Lobby"):WaitForChild("FinishedPart")
GetService.RunService.PreSimulation:Connect(function()
	if _ or not __ then return end
	local MyRoot = GetService.Players.LocalPlayer.Character and GetService.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not MyRoot then return end
	MyRoot.CFrame = CFrame.new(16, 36, 982)
	pcall(firetouchinterest, MyRoot, FinishedPart, 0)
	pcall(firetouchinterest, MyRoot, FinishedPart, 1)
end)
