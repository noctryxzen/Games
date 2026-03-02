loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/NUI/refs/heads/main/Notification.luau"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Block.Run/refs/heads/main/Module.luau"))()
local GetService = setmetatable({}, {
	__index = function(s, n)
		s[n] = (cloneref and clonefunction(cloneref) or function(x) return x end)(clonefunction(game.GetService)(game, n))
		return s[n]
	end
})
if queue_on_teleport then
	queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Games/refs/heads/main/YouVSFoodsFastestAutoFarm.luau"))()]])
else
	SendNotification({Title = "queue_on_teleport not supported", Text = "Please put the loadstring to your autoexec!", Duration = 15})
end
Foods = {}
function Foods:Farm(Timeout)
	local _ = false
	GetService.RunService.PreSimulation:Connect(function()
		local MyRoot = GetService.Players.LocalPlayer.Character and GetService.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not MyRoot then return end
		for i, v in next, GetService.Workspace.Map.Lobby.Obby:GetDescendants() do
			if v.Name == "RewardPart" and v:IsA("BasePart") then
				pcall(firetouchinterest, MyRoot, v, 0)
				pcall(firetouchinterest, MyRoot, v, 1)
			end
		end
	end)
	if Timeout then
		task.delay(2, function()
			if _ then return end
			_ = true
			SendNotification({Title = "Processing", Text = "Timeout! Server-hopping as fast.", Duration = math.huge})
			GetService.TeleportService:Teleport(game.PlaceId)
			task.delay(2, function() GetService.TeleportService:Teleport(game.PlaceId) end)
		end)
	end
	GetService.Players.LocalPlayer.leaderstats.EpicBucks.Changed:Connect(function()
		if _ then return end
		_ = true
		SendNotification({Title = "Processing", Text = "Got the Epic Bucks! Server-hopping as fast.", Duration = math.huge})
		GetService.TeleportService:Teleport(game.PlaceId)
		task.delay(2, function() GetService.TeleportService:Teleport(game.PlaceId) end)
	end)
end
function Foods:Block(Player)
	if Block.IsBlocked(Player) then
		Foods:Farm(true)
	else
		task.delay(.7, function()
			Block.Run(Player)
			Foods:Farm(true)
		end)
	end
end
function Foods:Start()
	if not (#GetService.Players:GetPlayers() > 1) then
		Foods:Farm(false)
		task.delay(2, function()
			for i, v in next, GetService.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&excludeFullGames=true&limit=100")).data do
				if v.id ~= game.JobId then
					SendNotification({Title = "Processing", Text = "Empty server! Joining server with players.", Duration = math.huge})
					GetService.TeleportService:TeleportToPlaceInstance(game.PlaceId, v.id)
					task.delay(2, function() GetService.TeleportService:Teleport(game.PlaceId) end)
					return
				end
			end
			GetService.TeleportService:Teleport(game.PlaceId)
		end)
	else
		for i, v in next, GetService.Players:GetPlayers() do
			if v ~= GetService.Players.LocalPlayer then
				Foods:Block(v)
				break
			end
		end
	end
end
if isfile("im_autofarming.json") and readfile("im_autofarming.json") == "yes im autofarming bro" then
	Foods:Start()
else
	SendNotification({
		Title = GetService.MarketplaceService:GetProductInfo(game.PlaceId).Name .. " • AutoFarm",
		Text = "Are you sure you'd like to start autofarming? You can exit by closing PedoBlox.",
		Duration = math.huge,
		Button1 = "Sure.",
		Button2 = "No.",
		Callback = function(Button)
			if Button == "Sure." then
				writefile("im_autofarming.json", "yes im autofarming bro")
				Foods:Start()
			end
		end
	})
end
