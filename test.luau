local GetService = setmetatable({}, {
	__index = function(s, n)
		s[n] = (cloneref and clonefunction(cloneref) or function(x) return x end)(clonefunction(game.GetService)(game, n))
		return s[n]
	end
})

--// Re-Execute the Script for Next Teleport
if queue_on_teleport then
	queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Games/refs/heads/main/test.luau"))()]])
else
	GetService.StarterGui:SetCore("SendNotification", {Title = "queue_on_teleport not supported", Text = "Please put the loadstring to your autoexec!", Duration = 5})
end

--// Teleporter & Blocker to avoid Reports
local Auto = {}
local Game, Job = game.PlaceId, game.JobId
local IsTeleporting = false
function Auto.Teleport(Game, Job, NextServer)
	if IsTeleporting then return end
	IsTeleporting = true
	task.wait(.5)
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
function Auto.IsBlocked(v)
	game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Escape, false, game)
	task.wait(.5)
	for i, v2 in next, game:GetService("CoreGui").RobloxGui.SettingsClippingShield:GetDescendants() do
		if v2.Name == "PlayerLabel" .. v.Name then
			return not v2:FindFirstChild("FriendStatus", true)
		end
	end
end
function Auto.Block()
	if not getgenv().create_new_server and not isfile("autotp.json") then return nil end
	local ___ = {}
	if isfile("autotp.json") then
		pcall(function()
			local _______ = Auto.Servers()
			for i, v in next, GetService.HttpService:JSONDecode(readfile("autotp.json")) do
				for i2, v3 in next, _______ do if v3 == v then ___[v] = true end end
			end
			local ________ = {}
			for i in next, ___ do table.insert(________, i) end
			writefile("autotp.json", GetService.HttpService:JSONEncode(________))
		end)
	end
	local ____ = GetService.Players:GetPlayers()
	if #____ == 1 and ____[1] == GetService.Players.LocalPlayer then
		return nil
	end
	for i, v2 in next, ____ do
		if v2 ~= GetService.Players.LocalPlayer then
			local _____ = Auto.IsBlocked(v2)
			if _____ == true then
				if not ___[Job] then
					___[Job] = true
					local ________ = {}
					for i in next, ___ do table.insert(________, i) end
					writefile("autotp.json", GetService.HttpService:JSONEncode(________))
				end
				return ___
			elseif _____ == false then
				GetService.StarterGui:SetCore("PromptBlockPlayer", v2)
				task.wait(.2)
				local ______ = GetService.CoreGui:FindFirstChild("BlockingModalScreen")
				if ______ then
					______ = ______:FindFirstChild("3", true)
					if ______ then
						GetService.VirtualInputManager:SendMouseButtonEvent(______.AbsolutePosition.X + ______.AbsoluteSize.X / 2, ______.AbsolutePosition.Y + ______.AbsoluteSize.Y / 2 + 42, 0, true, game, 0)
						GetService.VirtualInputManager:SendMouseButtonEvent(______.AbsolutePosition.X + ______.AbsoluteSize.X / 2, ______.AbsolutePosition.Y + ______.AbsoluteSize.Y / 2 + 42, 0, false, game, 0)
						local _____ = 0
						repeat task.wait(.1) _____ += .1 until not GetService.CoreGui:FindFirstChild("BlockingModalScreen") or _____ >= 2
					end
				end
				if Auto.IsBlocked(v2) == true then
					___[Job] = true
					local ________ = {}
					for i in next, ___ do table.insert(________, i) end
					writefile("autotp.json", GetService.HttpService:JSONEncode(________))
					return ___
				end
				return nil
			end
		end
	end
	return nil
end

--// Block Players & Teleport to Block Others
local ___ = Auto.Block()
if ___ then
	local _______ = Auto.Servers()
	local __________ = nil
	for i, v in next, _______ do if not ___[v] then __________ = v break end end
	if __________ then Auto.Teleport(Game, Job, __________) else Auto.Teleport(Game) end
end

--// Auto-Buy
local _ = false
local __ = not (getgenv().auto_buy or isfile("wantedcrate.json"))
if getgenv().auto_buy or isfile("wantedcrate.json") then
	GetService.ReplicatedStorage.Events.GameEvents.ShopEvent.OnClientEvent:Connect(function(got, data)
		if got == "CrateResult" then __ = true writefile("wantedcrate.json", data.crateName:gsub("Crate", "")) end
	end)
	task.wait(.1)
	GetService.ReplicatedStorage.Events.GameEvents.ShopEvent:FireServer("BuyCrate", {crateName = (getgenv().auto_buy or readfile("wantedcrate.json")) .. "Crate"})
	GetService.ReplicatedStorage.Events.GameEvents.ShopEvent:FireServer("ClaimReward")
	task.delay(1, function() __ = true end)
end

--// Main
GetService.ReplicatedStorage.Events.GameEvents.StudPopupEvent.OnClientEvent:Connect(function(got)
	if got then
		_ = true
		local ___ = Auto.Block()
		if ___ then
			local _______ = Auto.Servers()
			local __________ = nil
			for i, v in next, _______ do if not ___[v] then __________ = v break end end
			if __________ then Auto.Teleport(Game, Job, __________) else Auto.Teleport(Game) end
		else
			Auto.Teleport(Game, Job, Job)
		end
	end
end)
task.delay(.5, function()
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
