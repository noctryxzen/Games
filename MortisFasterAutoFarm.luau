local GetService = setmetatable({}, {
	__index = function(s, n)
		s[n] = (cloneref and (clonefunction and clonefunction(cloneref) or cloneref) or function(x) return x end)((clonefunction and clonefunction(game.GetService) or game.GetService)(game, n))
		return s[n]
	end
})

--// Auto-Buy
if getgenv().autobuy == nil then getgenv().autobuy = isfile("wantedcrate.json") and readfile("wantedcrate.json") or false end

if queue_on_teleport then
	queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Games/refs/heads/main/MortisFasterAutoFarm.luau"))()]])
else
	GetService.StarterGui:SetCore("SendNotification", {Title = "queue_on_teleport not supported", Text = "Please put the loadstring to your autoexec!", Duration = 5})
end

local ok, crate = false, not getgenv().autobuy

local cratee, teleportig = false, false
--// Disable Log-Service
if getconnections then
	for i, v in next, getconnections(GetService.LogService.MessageOut) do v:Disable() end
end

GetService.ReplicatedStorage.Events.GameEvents.ShopEvent.OnClientEvent:Connect(function(got, data)
	if got == "CrateResult" then
		crate = true
		writefile("wantedcrate.json", data.crateName:gsub("Crate", ""))
	end
end)
GetService.ReplicatedStorage.Events.GameEvents.StudPopupEvent.OnClientEvent:Connect(function(got)
	if got then
		ok = true
		GetService.TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
	end
end)

--// Main
GetService.RunService.PreSimulation:Connect(function()
	if not cratee then
		cratee = true
		if getgenv().autobuy then
			GetService.ReplicatedStorage.Events.GameEvents.ShopEvent:FireServer("BuyCrate", {crateName = getgenv().autobuy .. "Crate"})
			GetService.ReplicatedStorage.Events.GameEvents.ShopEvent:FireServer("ClaimReward")
			task.delay(2, function() crate = true end)
		end
	end
	if not teleportig then
		teleportig = true
		task.delay(1, function()
			if not ok then GetService.TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId) end
		end)
	end
	if ok or not crate then return end
	local MyRoot = GetService.Players.LocalPlayer.Character and GetService.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not MyRoot then return end
	pcall(firetouchinterest, MyRoot, GetService.Workspace:WaitForChild("Lobby"):WaitForChild("FinishedPart"), 0)
	pcall(firetouchinterest, MyRoot, GetService.Workspace:WaitForChild("Lobby"):WaitForChild("FinishedPart"), 1)
end)
