local GetService = setmetatable({}, {
	__index = function(s, n)
		s[n] = (cloneref and clonefunction(cloneref) or function(x) return x end)(clonefunction(game.GetService)(game, n))
		return s[n]
	end
})

local auto_give, auto_grab, is_open = false, false, true
local selected_player, entry_map = nil, {}
local name = ""
for i = 1, math.random(40, 80) do name ..= utf8.char(math.random(0x0600, 0x06FF)) end

local L = {}
L[1] = Instance.new("ScreenGui")
L[1].Name = name
L[1].ResetOnSpawn = false
L[1].DisplayOrder = 2147483647
L[1].Parent = (get_hidden_gui or gethui) and (get_hidden_gui or gethui)() or GetService.CoreGui

L[2] = Instance.new("Frame", L[1])
L[2].BorderSizePixel = 0
L[2].Style = Enum.FrameStyle.DropShadow
L[2].Size = UDim2.new(0, 174, 0, 268)
L[2].Position = UDim2.new(0, 650, 0, -6)

L[3] = Instance.new("TextLabel", L[2])
L[3].TextWrapped = true
L[3].BorderSizePixel = 0
L[3].TextSize = 13
L[3].TextXAlignment = Enum.TextXAlignment.Left
L[3].FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold)
L[3].TextColor3 = Color3.fromRGB(198, 216, 236)
L[3].BackgroundTransparency = 1
L[3].Size = UDim2.new(0, 338, 0, 44)
L[3].Text = "🔥🔥🔥beta demolisher🔥🔥🔥"
L[3].Position = UDim2.new(0, -4, 0, -18)

L[4] = Instance.new("Frame", L[2])
L[4].BorderSizePixel = 0
L[4].BackgroundColor3 = Color3.fromRGB(177, 177, 177)
L[4].Size = UDim2.new(0, 166, 0, 2)
L[4].Position = UDim2.new(0, -4, 0, 12)

L[5] = Instance.new("TextButton", L[2])
L[5].BorderSizePixel = 0
L[5].TextScaled = true
L[5].TextColor3 = Color3.fromRGB(215, 190, 151)
L[5].BackgroundColor3 = Color3.fromRGB(87, 87, 87)
L[5].ZIndex = 5
L[5].BackgroundTransparency = 0.5
L[5].Size = UDim2.new(0, 24, 0, 44)
L[5].Text = "<"
L[5].Position = UDim2.new(0, -26, 0, 110)

L[6] = Instance.new("TextButton", L[2])
L[6].BorderSizePixel = 0
L[6].TextScaled = true
L[6].FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold)
L[6].Size = UDim2.new(0, 162, 0, 10)
L[6].Text = "Auto Give Bomb"
L[6].Position = UDim2.new(0, -2, 0, 244)

L[7] = Instance.new("TextButton", L[2])
L[7].BorderSizePixel = 0
L[7].TextScaled = true
L[7].FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold)
L[7].Size = UDim2.new(0, 162, 0, 10)
L[7].Text = "Auto Grab Bomb"
L[7].Position = UDim2.new(0, -2, 0, 232)

L[8] = Instance.new("ScrollingFrame", L[2])
L[8].BorderSizePixel = 0
L[8].AutomaticCanvasSize = Enum.AutomaticSize.Y
L[8].Size = UDim2.new(0, 162, 0, 210)
L[8].ScrollBarImageColor3 = Color3.fromRGB(176, 176, 176)
L[8].Position = UDim2.new(0, -2, 0, 16)
L[8].ScrollBarThickness = 3
L[8].BackgroundTransparency = 0.9

Instance.new("UIListLayout", L[8]).Padding = UDim.new(0, 2)

L[9] = Instance.new("Frame", L[2])
L[9].BorderSizePixel = 0
L[9].BackgroundColor3 = Color3.fromRGB(177, 177, 177)
L[9].Size = UDim2.new(0, 166, 0, 2)
L[9].Position = UDim2.new(0, -4, 0, 228)

for _, p in next, GetService.Players:GetPlayers() do
	local e = Instance.new("TextButton", L[8])
	e.TextWrapped = true
	e.TextTruncate = Enum.TextTruncate.SplitWord
	e.BorderSizePixel = 0
	e.TextXAlignment = Enum.TextXAlignment.Left
	e.TextScaled = true
	e.TextColor3 = Color3.fromRGB(83, 83, 83)
	e.BackgroundColor3 = Color3.fromRGB(242, 242, 242)
	e.Size = UDim2.new(1, 0, 0, 18)
	e.Text = "  " .. p.DisplayName .. " @" .. p.Name
	entry_map[p] = e
	e.MouseButton1Click:Connect(function()
		for _, v in next, entry_map do v.BackgroundColor3 = Color3.fromRGB(242, 242, 242) end
		e.BackgroundColor3 = Color3.fromRGB(201, 231, 211)
		selected_player = p
	end)
end
GetService.Players.PlayerAdded:Connect(function(p)
	local e = Instance.new("TextButton", L[8])
	e.TextWrapped = true
	e.TextTruncate = Enum.TextTruncate.SplitWord
	e.BorderSizePixel = 0
	e.TextXAlignment = Enum.TextXAlignment.Left
	e.TextScaled = true
	e.TextColor3 = Color3.fromRGB(83, 83, 83)
	e.BackgroundColor3 = Color3.fromRGB(242, 242, 242)
	e.Size = UDim2.new(1, 0, 0, 18)
	e.Text = "  " .. p.DisplayName .. " @" .. p.Name
	entry_map[p] = e
	e.MouseButton1Click:Connect(function()
		for _, v in next, entry_map do v.BackgroundColor3 = Color3.fromRGB(242, 242, 242) end
		e.BackgroundColor3 = Color3.fromRGB(201, 231, 211)
		selected_player = p
	end)
end)
GetService.Players.PlayerRemoving:Connect(function(p)
	if entry_map[p] then entry_map[p]:Destroy() entry_map[p] = nil end
	if selected_player == p then selected_player = nil end
end)
L[5].MouseButton1Click:Connect(function()
	is_open = not is_open
	L[5].Text = is_open and "<" or ">"
	GetService.TweenService:Create(L[2], TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Position = is_open and UDim2.new(0, 650, 0, -6) or UDim2.new(1, -2, 0, -6)
	}):Play()
end)
L[6].MouseButton1Click:Connect(function()
	auto_give = not auto_give
	L[6].BackgroundColor3 = auto_give and Color3.fromRGB(201, 231, 211) or Color3.fromRGB(255, 255, 255)
end)
L[7].MouseButton1Click:Connect(function()
	auto_grab = not auto_grab
	L[7].BackgroundColor3 = auto_grab and Color3.fromRGB(201, 231, 211) or Color3.fromRGB(255, 255, 255)
end)

GetService.RunService.PreSimulation:Connect(function()
	local my_char = GetService.Players.LocalPlayer.Character
	if not my_char then return end
	local my_hrp = my_char:FindFirstChild("HumanoidRootPart")
	if not my_hrp then return end
	if auto_give then
		for _, v in next, my_char:GetChildren() do
			if not v:IsA("Tool") then continue end
			local hitbox = v:FindFirstChild("TransferHitbox")
			if not hitbox then continue end
			local head = my_char:FindFirstChild("Head")
			local timer_gui = head and head:FindFirstChild("TimerGui")
			local t = timer_gui and tonumber(timer_gui.TextLabel.Text:match("%d+"))
			if t ~= 1 then continue end
			if selected_player then
				local target_char = selected_player.Character
				if not target_char then continue end
				local target_hrp = target_char:FindFirstChild("HumanoidRootPart")
				if not target_hrp then continue end
				firetouchinterest(hitbox, target_hrp, 0)
				firetouchinterest(hitbox, target_hrp, 1)
			else
				for _, v2 in next, GetService.Players:GetPlayers() do
					if v2 == GetService.Players.LocalPlayer then continue end
					local char = v2.Character
					if not char then continue end
					local hrp = char:FindFirstChild("HumanoidRootPart")
					if not hrp then continue end
					firetouchinterest(hitbox, hrp, 0)
					firetouchinterest(hitbox, hrp, 1)
					break
				end
			end
		end
    end
	if auto_grab then
		for _, v3 in next, GetService.Players:GetPlayers() do
			if v3 == GetService.Players.LocalPlayer then continue end
			local char = v3.Character
			if not char then continue end
			for _, v4 in next, char:GetChildren() do
				if not v4:IsA("Tool") then continue end
				local hitbox = v4:FindFirstChild("TransferHitbox")
				if not hitbox then continue end
				firetouchinterest(hitbox, my_hrp, 0)
				firetouchinterest(hitbox, my_hrp, 1)
			end
		end
	end
end)
