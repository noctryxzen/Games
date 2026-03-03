loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/NUI/refs/heads/main/Notification.luau"))()
local GetService=setmetatable({},{
	__index=function(s,n)
		s[n]=(cloneref and clonefunction(cloneref) or function(x)
			return x
		end)(clonefunction(game.GetService)(game,n))
		return s[n]
	end
})
Floor={}
Floor.Loop=function()
	if not GetService.Players.LocalPlayer.Character then return end
	local MyRoot=GetService.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not MyRoot then return end
	for i,v in next,GetService.Players.LocalPlayer.Backpack:GetChildren() do
		if v.Name:find("Ore") then GetService.Players.LocalPlayer.Character.Humanoid:EquipTool(v) end
	end
	for i,v in next,GetService.Workspace.ProcGenGenerated:GetDescendants() do
		if not v.Name:find("Ore") and not v.Name:find("Shard") then continue end
		local Handle=v:FindFirstChildWhichIsA("BasePart")
		if not Handle or not Handle:FindFirstChildWhichIsA("ProximityPrompt") then continue end
		MyRoot.CFrame=Handle.CFrame
		fireproximityprompt(Handle:FindFirstChildWhichIsA("ProximityPrompt"))
	end
	for i,v in next,GetService.Players.LocalPlayer.Character:GetChildren() do
		if not v.Name:find("Ore") then continue end
		if not GetService.Workspace.PlacedTiles.SellStation.SellingSpot:FindFirstChildWhichIsA("ProximityPrompt") then return end
		MyRoot.CFrame=GetService.Workspace.PlacedTiles.SellStation.SellingSpot.CFrame
		fireproximityprompt(GetService.Workspace.PlacedTiles.SellStation.SellingSpot:FindFirstChildWhichIsA("ProximityPrompt"))
		return
	end
end
Floor.Notify=function()
	SendNotification({
		Title=GetService.MarketplaceService:GetProductInfo(game.PlaceId).Name.." • Auto Farm",
		Text="Auto Farm has been successfully started and is now running!",
		Duration=math.huge,
		Button1="Pause Auto Farming",
		Callback=function()
			Floor._Connection:Disconnect()
			Floor._Connection=nil
			SendNotification({
				Title=GetService.MarketplaceService:GetProductInfo(game.PlaceId).Name.." • Auto Farm",
				Text="Auto Farm has been paused! Click continue to resume.",
				Duration=math.huge,
				Button1="Continue Auto Farming",
				Callback=function()
					Floor._Connection=GetService.RunService.PreSimulation:Connect(Floor.Loop)
					Floor.Notify()
				end
			})
		end
	})
end
Floor._Connection=GetService.RunService.PreSimulation:Connect(Floor.Loop)
Floor.Notify()
