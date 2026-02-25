local GetService = setmetatable({}, {
	__index = function(s, n)
		s[n] = (cloneref and clonefunction(cloneref) or function(x) return x end)(clonefunction(game.GetService)(game, n))
		return s[n]
	end
})

if getgenv().fast_buy and GetService.ReplicatedStorage:WaitForChild("Events"):WaitForChild("GameEvents"):FindFirstChild("ShopEvent") then
	GetService.RunService.PreSimulation:Connect(function()
		for i, v in getgenv().fast_buy do
			GetService.ReplicatedStorage:WaitForChild("Events"):WaitForChild("GameEvents"):WaitForChild("ShopEvent"):FireServer("BuyCrate", {crateName = v .. "Crate"})
			GetService.ReplicatedStorage:WaitForChild("Events"):WaitForChild("GameEvents"):WaitForChild("ShopEvent"):FireServer("ClaimReward")
		end
	end)
end
