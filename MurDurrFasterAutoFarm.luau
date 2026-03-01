loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/NUI/refs/heads/main/Notification.luau"))()

local GetService = setmetatable({}, {
	__index = function(s, n)
		s[n] = (cloneref and clonefunction(cloneref) or function(x) return x end)(clonefunction(game.GetService)(game, n))
		return s[n]
	end
})

if queue_on_teleport then
	queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Games/refs/heads/main/MurDurrFasterAutoFarm.luau"))()]])
else
	SendNotification({Title = "queue_on_teleport not supported", Text = "Please put the loadstring to your autoexec!", Duration = 15})
end

MurDurr = {}
function MurDurr:Auto()
	local _ = false
	pcall(function() GetService.Players.LocalPlayer.PlayerGui.LoadingUI:Destroy() end)
	GetService.RunService.PreSimulation:Connect(function()
		local MyRoot = GetService.Players.LocalPlayer.Character and GetService.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not MyRoot then return end
		pcall(firetouchinterest, MyRoot, GetService.Workspace.Obbies.AwardParts.Hardest, 0)
		pcall(firetouchinterest, MyRoot, GetService.Workspace.Obbies.AwardParts.Hardest, 1)
	end)
	GetService.Workspace.Obbies.AwardParts.Hardest.Touched:Connect(function()
		if _ then return end
		_ = true
		SendNotification({Title = "Processing", Text = "Got the Durr! Server-hopping as fast.", Duration = math.huge})
		task.delay(.3, function() GetService.TeleportService:Teleport(game.PlaceId) end)
	end)
end
if isfile("im_autofarming.json") and readfile("im_autofarming.json") == "yes im autofarming bro" then
	MurDurr:Auto()
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
				MurDurr:Auto()
			end
		end
	})
end
