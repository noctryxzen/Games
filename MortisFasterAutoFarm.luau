local GetService = setmetatable({}, {
	__index = function(s, n)
		s[n] = (cloneref and clonefunction(cloneref) or function(x) return x end)(clonefunction(game.GetService)(game, n))
		return s[n]
	end
})

loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Block.Run/refs/heads/main/Module.luau"))()

-- // Re-Execute the Script for Next Teleport
if queue_on_teleport then
	queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Games/refs/heads/main/MortisFasterAutoFarm.luau"))()]])
else
	GetService.StarterGui:SetCore("SendNotification", {Title = "queue_on_teleport not supported", Text = "Please put the loadstring to your autoexec!", Duration = 5})
end

-- // Teleporter
Auto = {}
local Game, Job = game.PlaceId, game.JobId
local __ = false
function Auto.Teleport(Game, Job)
	if __ then return end
	__ = true
	if Job then GetService.TeleportService:TeleportToPlaceInstance(Game, Job)
	else GetService.TeleportService:Teleport(Game) end
end

-- // Auto Farm
local FinishedPart = GetService.Workspace:WaitForChild("Lobby"):WaitForChild("FinishedPart")
if not (getgenv().create_new_server or isfile("wanted_creator.json") and #GetService.Players:GetPlayers() > 1) then
	GetService.ReplicatedStorage.Events.GameEvents.StudPopupEvent.OnClientEvent:Connect(function(got)
		if got then Auto.Teleport(Game, Job) end
	end)
	task.delay(.3, function()
		Auto.Teleport(Game, Job)
	end)
	GetService.RunService.PreSimulation:Connect(function()
		local MyRoot = GetService.Players.LocalPlayer.Character and GetService.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not MyRoot then return end
		pcall(firetouchinterest, MyRoot, FinishedPart, 0)
		pcall(firetouchinterest, MyRoot, FinishedPart, 1)
	end)
end

-- // Auto Buy
if getgenv().auto_buy or isfile("wantedcrate.json") then
	GetService.ReplicatedStorage.Events.GameEvents.ShopEvent.OnClientEvent:Connect(function(got, data)
		if got == "CrateResult" then writefile("wantedcrate.json", data.crateName:gsub("Crate", "")) end
	end)
	task.wait(.2)
	GetService.ReplicatedStorage.Events.GameEvents.ShopEvent:FireServer("BuyCrate", {crateName = (getgenv().auto_buy or readfile("wantedcrate.json")) .. "Crate"})
	GetService.ReplicatedStorage.Events.GameEvents.ShopEvent:FireServer("ClaimReward")
end

-- // Block Players
if getgenv().create_new_server or isfile("wanted_creator.json") then
	if not isfile("wanted_creator.json") then
		writefile("wanted_creator.json", "yes")
	end
	for i, v in next, GetService.Players:GetPlayers() do
		if v ~= GetService.Players.LocalPlayer then
			if Block.IsBlocked(v) then
				Auto.Teleport(Game)
			else
				task.delay(.3, function()
					Block.Run(v)
					Auto.Teleport(Game)
				end)
			end
			break
		end
	end
end
