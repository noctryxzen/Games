loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/NUI/refs/heads/main/Notification.luau"))()
local GetService = setmetatable({}, {
	__index = function(s, n)
		s[n] = (cloneref and clonefunction(cloneref) or function(x) return x end)(clonefunction(game.GetService)(game, n))
		return s[n]
	end
})
if queue_on_teleport then
	queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Games/refs/heads/main/YouVSWallaceFastestAutoFarm.luau"))()]])
else
	SendNotification({Title = "queue_on_teleport not supported", Text = "Please put the loadstring to your autoexec!", Duration = 15})
end
Points = {}
function Points:Farm()
	local _ = false
	local Root = GetService.Players.LocalPlayer.Character and GetService.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	pcall(firetouchinterest, Root, GetService.Workspace.__Map.Lobby.BaseMap.Obby:FindFirstChild("HardObbyWin"), 0)
	pcall(firetouchinterest, Root, GetService.Workspace.__Map.Lobby.BaseMap.Obby:FindFirstChild("HardObbyWin"), 1)
	GetService.Players.LocalPlayer.leaderstats["Player Points"].Changed:Connect(function()
		if _ then return end
		_ = true
		SendNotification({Title = "Processing", Text = "Got Points! Server-hopping as fast.", Duration = math.huge})
		GetService.TeleportService:Teleport(game.PlaceId)
		task.delay(.7, function() GetService.TeleportService:Teleport(game.PlaceId) end)
	end)
	task.delay(.7, function()
		if _ then return end
		_ = true
		SendNotification({Title = "Processing", Text = "Timeout! Server-hopping as fast.", Duration = math.huge})
		GetService.TeleportService:Teleport(game.PlaceId)
		task.delay(.7, function() GetService.TeleportService:Teleport(game.PlaceId) end)
	end)
end
if isfile("im_autofarming.json") and readfile("im_autofarming.json") == "yes im autofarming bro" then
	Points:Farm()
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
				Points:Farm()
			end
		end
	})
end
