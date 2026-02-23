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
if getgenv().auto_buy == nil then getgenv().auto_buy = isfile("wantedcrate.json") and readfile("wantedcrate.json") or false end
local _ = false
local __ = not getgenv().auto_buy
if getgenv().auto_buy then
	GetService.ReplicatedStorage.Events.GameEvents.ShopEvent.OnClientEvent:Connect(function(got, data)
		if got == "CrateResult" then
			__ = true
			writefile("wantedcrate.json", data.crateName:gsub("Crate", ""))
		end
	end)
	GetService.ReplicatedStorage.Events.GameEvents.ShopEvent:FireServer("BuyCrate", {crateName = getgenv().auto_buy .. "Crate"})
	GetService.ReplicatedStorage.Events.GameEvents.ShopEvent:FireServer("ClaimReward")
	task.delay(2, function() __ = true end)
end

--// Teleporter
local Auto = {}
local Game, Job = game.PlaceId, game.JobId
function Auto.Teleport(Game, Job, NextServer)
	GetService.TeleportService:TeleportToPlaceInstance(Game, NextServer or Job)
end

--// Block Players & Teleport to Block Others.. sorry for leaking
if getgenv().create_new_server == nil then getgenv().create_new_server = true end
if getgenv().create_new_server then
	local ___ = isfile("autotp.json") and GetService.HttpService:JSONDecode(readfile("autotp.json")) or {}
	local ____ = GetService.Players:GetPlayers()
	local _____ = #____ == 1 and ____[1] == GetService.Players.LocalPlayer

	if not _____ then
		local ______ = {}
		local _______ = 0
		for i, v in ____ do
			if v ~= GetService.Players.LocalPlayer and _______ < 2 then
				GetService.StarterGui:SetCore("PromptBlockPlayer", v)
				GetService.CoreGui:WaitForChild("BlockingModalScreen")
				task.wait(.5)
				local ________ = GetService.CoreGui.BlockingModalScreen.BlockingModalContainer.BlockingModalContainerWrapper.BlockingModal.AlertModal.AlertContents.Footer.Buttons["3"]
				GetService.VirtualInputManager:SendMouseButtonEvent(________.AbsolutePosition.X + ________.AbsoluteSize.X / 2, ________.AbsolutePosition.Y + ________.AbsoluteSize.Y / 2 + 42, 0, true, game, 0)
				GetService.VirtualInputManager:SendMouseButtonEvent(________.AbsolutePosition.X + ________.AbsoluteSize.X / 2, ________.AbsolutePosition.Y + ________.AbsoluteSize.Y / 2 + 42, 0, false, game, 0)
				task.wait(.5)
				table.insert(______, v.Name)
				_______ += 1
			end
		end
		___[Job] = table.concat(______, ",")
		writefile("autotp.json", GetService.HttpService:JSONEncode(___))
	end

	local Server1 = GetService.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. Game .. "/servers/Public?sortOrder=Asc&limit=100&excludeFullGames=true"))
	local Server2 = GetService.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. Game .. "/servers/Public?sortOrder=Asc&limit=100&excludeFullGames=true&cursor=" .. (Server1.nextPageCursor or "")))
	local _________ = {}
	for i, v2 in Server1.data do table.insert(_________, v2) end
	for i, v2 in Server2.data do table.insert(_________, v2) end

	local __________ = nil
	for i, v2 in _________ do
		if not ___[v2.id] then
			__________ = v2.id
			break
		end
	end

	Auto.Teleport(Game, Job, __________)
end

--// Main
GetService.ReplicatedStorage.Events.GameEvents.StudPopupEvent.OnClientEvent:Connect(function(got)
	if got then
		_ = true
		if getgenv().create_new_server then
			local ___ = isfile("autotp.json") and GetService.HttpService:JSONDecode(readfile("autotp.json")) or {}
			local ____ = GetService.Players:GetPlayers()
			local _____ = #____ == 1 and ____[1] == GetService.Players.LocalPlayer
			if not _____ then
				local ______ = {}
				local _______ = 0
				for i, v in ____ do
					if v ~= GetService.Players.LocalPlayer and _______ < 2 then
						GetService.StarterGui:SetCore("PromptBlockPlayer", v)
						GetService.CoreGui:WaitForChild("BlockingModalScreen")
						task.wait(.5)
						local ________ = GetService.CoreGui.BlockingModalScreen.BlockingModalContainer.BlockingModalContainerWrapper.BlockingModal.AlertModal.AlertContents.Footer.Buttons["3"]
						GetService.VirtualInputManager:SendMouseButtonEvent(________.AbsolutePosition.X + ________.AbsoluteSize.X / 2, ________.AbsolutePosition.Y + ________.AbsoluteSize.Y / 2 + 42, 0, true, game, 0)
						GetService.VirtualInputManager:SendMouseButtonEvent(________.AbsolutePosition.X + ________.AbsoluteSize.X / 2, ________.AbsolutePosition.Y + ________.AbsoluteSize.Y / 2 + 42, 0, false, game, 0)
						task.wait(.5)
						table.insert(______, v.Name)
						_______ += 1
					end
				end
				___[Job] = table.concat(______, ",")
				writefile("autotp.json", GetService.HttpService:JSONEncode(___))
			end
		end
		Auto.Teleport(Game, Job)
	end
end)
task.delay(1, function()
	if not _ then Auto.Teleport(Game, Job) end
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
