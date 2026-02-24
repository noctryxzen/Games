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
function Auto.Teleport(Game, Job)
	if Job then GetService.TeleportService:TeleportToPlaceInstance(Game, Job)
	else GetService.TeleportService:Teleport(Game) end
end
function Auto.Block()
	if getgenv().create_new_server or isfile("wanted_jobs.json") then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Block.Run/refs/heads/main/Module.luau"))()
		local ____ = GetService.Players:GetPlayers()
		if #____ > 1 then
			for i, v in next, ____ do
				if v ~= GetService.Players.LocalPlayer then Block.Run(v) break end
			end
			local ___ = isfile("wanted_jobs.json") and GetService.HttpService:JSONDecode(readfile("wanted_jobs.json")) or {}
			if not table.find(___, Job) then table.insert(___, Job) end
			writefile("wanted_jobs.json", GetService.HttpService:JSONEncode(___))
			Auto.Teleport(Game)
			return true
		end
	end
	return false
end

--// Main
local _ = false
local FinishedPart = GetService.Workspace:WaitForChild("Lobby"):WaitForChild("FinishedPart")
GetService.ReplicatedStorage.Events.GameEvents.StudPopupEvent.OnClientEvent:Connect(function(got)
	if got then
		_ = true
		if Auto.Block() then return end
		Auto.Teleport(Game, Job)
	else
		task.delay(.5, function()
			if _ then return end
			Auto.Teleport(Game, Job)
		end)
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
	local __ = false
	GetService.ReplicatedStorage.Events.GameEvents.ShopEvent.OnClientEvent:Connect(function(got, data)
		if got == "CrateResult" then
			__ = true
			writefile("wanted_crate.json", data.crateName:gsub("Crate", ""))
		end
	end)
	task.wait(.1)
	GetService.ReplicatedStorage.Events.GameEvents.ShopEvent:FireServer("BuyCrate", {crateName = getgenv().auto_buy .. "Crate"})
	GetService.ReplicatedStorage.Events.GameEvents.ShopEvent:FireServer("ClaimReward")
	task.delay(.5, function()
		if not __ then Auto.Teleport(Game, Job) end
	end)
end
