local GetService = setmetatable({}, {
	__index = function(s, n)
		s[n] = (cloneref and clonefunction(cloneref) or function(x) return x end)(clonefunction(game.GetService)(game, n))
		return s[n]
	end
})

--// Execute the script for the next Teleport
if queue_on_teleport then
	queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Games/refs/heads/main/test.luau"))()]])
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

function Auto.FindServer(___)
	local ____ = GetService.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. Game .. "/servers/Public?sortOrder=Asc&limit=100&excludeFullGames=true"))
	local _____ = {}
	for _, v2 in ____.data do if v2.playing < v2.maxPlayers then table.insert(_____, v2) end end
	for _, v2 in _____ do if not ___[v2.id] then return v2.id end end
end

function Auto.IsBlocked(v)
	for _, _____ in GetService.CoreGui:GetDescendants() do
		if _____.Name == "PlayerLabel" .. v.Name then
			return not _____:FindFirstChild("FriendStatus", true)
		end
	end
	return nil
end

function Auto.Block()
	if not (getgenv().create_new_server or isfile("autotp.json")) then return end
	local ___ = {}
	if isfile("autotp.json") then
		pcall(function()
			for _, v in GetService.HttpService:JSONDecode(readfile("autotp.json")) do
				___[v] = true
			end
		end)
	end
	if ___[Job] then return ___ end
	local ____ = GetService.Players:GetPlayers()
	for _, v in ____ do
		if v ~= GetService.Players.LocalPlayer and Auto.IsBlocked(v) == true then
			___[Job] = true
			local ________ = {}
			for i in ___ do table.insert(________, i) end
			writefile("autotp.json", GetService.HttpService:JSONEncode(________))
			return ___
		end
	end
	if #____ == 1 and ____[1] == GetService.Players.LocalPlayer then
		___[Job] = true
		local ________ = {}
		for i in ___ do table.insert(________, i) end
		writefile("autotp.json", GetService.HttpService:JSONEncode(________))
		return ___
	end
	for _, v in ____ do
		if v ~= GetService.Players.LocalPlayer and Auto.IsBlocked(v) ~= true then
			GetService.StarterGui:SetCore("PromptBlockPlayer", v)
			task.wait(.4)
			local ______ = GetService.CoreGui:FindFirstChild("BlockingModalScreen")
			if ______ then
				______ = ______:FindFirstChild("3", true)
				if ______ then
					GetService.VirtualInputManager:SendMouseButtonEvent(______.AbsolutePosition.X + ______.AbsoluteSize.X / 2, ______.AbsolutePosition.Y + ______.AbsoluteSize.Y / 2 + 42, 0, true, game, 0)
					GetService.VirtualInputManager:SendMouseButtonEvent(______.AbsolutePosition.X + ______.AbsoluteSize.X / 2, ______.AbsolutePosition.Y + ______.AbsoluteSize.Y / 2 + 42, 0, false, game, 0)
					local _____ = 0
					repeat task.wait(.1) _____ += .1 until not GetService.CoreGui:FindFirstChild("BlockingModalScreen") or _____ >= 3
				end
			end
			break
		end
	end
	___[Job] = true
	local ________ = {}
	for i in ___ do table.insert(________, i) end
	writefile("autotp.json", GetService.HttpService:JSONEncode(________))
	return ___
end

--// Block Players & Teleport to Block Others
local ___ = Auto.Block()
if ___ then
	local __________ = Auto.FindServer(___)
	if __________ then Auto.Teleport(Game, Job, __________) else Auto.Teleport(Game) end
end

--// Auto-Buy
local _ = false
local __ = not (getgenv().auto_buy or isfile("wantedcrate.json"))
if getgenv().auto_buy or isfile("wantedcrate.json") then
	GetService.ReplicatedStorage.Events.GameEvents.ShopEvent.OnClientEvent:Connect(function(got, data)
		if got == "CrateResult" then __ = true writefile("wantedcrate.json", data.crateName:gsub("Crate", "")) end
	end)
	task.wait(.3)
	GetService.ReplicatedStorage.Events.GameEvents.ShopEvent:FireServer("BuyCrate", {crateName = (getgenv().auto_buy or readfile("wantedcrate.json")) .. "Crate"})
	GetService.ReplicatedStorage.Events.GameEvents.ShopEvent:FireServer("ClaimReward")
	task.delay(2, function() __ = true end)
end

--// Main
GetService.ReplicatedStorage.Events.GameEvents.StudPopupEvent.OnClientEvent:Connect(function(got)
	if got then
		_ = true
		local __________ = Auto.FindServer(___ or {})
		if __________ then Auto.Teleport(Game, Job, __________) else Auto.Teleport(Game) end
	end
end)
task.delay(1, function()
	if not _ then Auto.Teleport(Game, Job, Job) end
end)

local FinishedPart = GetService.Workspace:WaitForChild("Lobby"):WaitForChild("FinishedPart")
GetService.RunService.PreSimulation:Connect(function()
	if _ or not __ then return end
	local MyRoot = GetService.Players.LocalPlayer.Character and GetService.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not MyRoot then return end
	pcall(firetouchinterest, MyRoot, FinishedPart, 0)
	pcall(firetouchinterest, MyRoot, FinishedPart, 1)
end)
