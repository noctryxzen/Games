local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")

local is_open, mod, crash = true, false, false
local selected_player, entry_map = nil, {}

local rand_str = {}
for i1,v1 in next, {} do end
for i1 = 1, math.random(10, 20) do rand_str[i1] = string.char(math.random(32, 126)) end
rand_str = table.concat(rand_str)

local L = {}

L[1] = Instance.new("ScreenGui")
L[1].Name = rand_str
L[1].ResetOnSpawn = false
L[1].DisplayOrder = 2147483647
L[1].Parent = (get_hidden_gui or gethui) and (get_hidden_gui or gethui)() or game:GetService("CoreGui")

L[2] = Instance.new("Frame", L[1])
L[2].BorderSizePixel = 0
L[2].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
L[2].Style = Enum.FrameStyle.DropShadow
L[2].Size = UDim2.new(0, 168, 0, 292)
L[2].Position = UDim2.new(0, 654, 0, -18)

L[3] = Instance.new("TextLabel", L[2])
L[3].TextWrapped = true
L[3].BorderSizePixel = 0
L[3].TextScaled = true
L[3].BackgroundTransparency = 1
L[3].FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold)
L[3].TextColor3 = Color3.fromRGB(194, 212, 232)
L[3].Size = UDim2.new(0, 162, 0, 26)
L[3].Text = "Admin Panel by Noctryx"
L[3].Position = UDim2.new(0, -6, 0, -8)

L[4] = Instance.new("TextLabel", L[2])
L[4].BorderSizePixel = 0
L[4].BackgroundColor3 = Color3.fromRGB(173, 173, 173)
L[4].Size = UDim2.new(0, 160, 0, 2)
L[4].Text = ""
L[4].Position = UDim2.new(0, -4, 0, 12)

L[5] = Instance.new("TextButton", L[2])
L[5].TextWrapped = true
L[5].BorderSizePixel = 0
L[5].TextScaled = true
L[5].TextColor3 = Color3.fromRGB(211, 186, 147)
L[5].BackgroundColor3 = Color3.fromRGB(83, 83, 83)
L[5].BackgroundTransparency = 0.5
L[5].Size = UDim2.new(0, 24, 0, 44)
L[5].Text = "<"
L[5].Position = UDim2.new(0, -26, 0, 110)
L[5].ZIndex = 5

L[6] = Instance.new("Frame", L[2])
L[6].BorderSizePixel = 0
L[6].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
L[6].Style = Enum.FrameStyle.DropShadow
L[6].Size = UDim2.new(0, 168, 0, 254)
L[6].Position = UDim2.new(0, -8, 0, 16)

L[7] = Instance.new("TextBox", L[6])
L[7].TextXAlignment = Enum.TextXAlignment.Left
L[7].BorderSizePixel = 0
L[7].TextTruncate = Enum.TextTruncate.SplitWord
L[7].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
L[7].FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold)
L[7].PlaceholderText = "Target username.."
L[7].ClearTextOnFocus = false
L[7].Size = UDim2.new(0, 156, 0, 12)
L[7].Position = UDim2.new(0, -2, -0, 15)
L[7].Text = ""

L[8] = Instance.new("TextBox", L[6])
L[8].TextXAlignment = Enum.TextXAlignment.Left
L[8].BorderSizePixel = 0
L[8].TextTruncate = Enum.TextTruncate.SplitWord
L[8].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
L[8].FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold)
L[8].PlaceholderText = "Enter reason here.."
L[8].ClearTextOnFocus = false
L[8].Size = UDim2.new(0, 156, 0, 12)
L[8].Position = UDim2.new(0, -2, -0, 0)
L[8].Text = ""

L[9] = Instance.new("TextButton", L[6])
L[9].TextWrapped = true
L[9].BorderSizePixel = 0
L[9].TextScaled = true
L[9].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
L[9].FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold)
L[9].Size = UDim2.new(0, 76, 0, 14)
L[9].Text = "Kick"
L[9].Position = UDim2.new(0, 78, 0, 32)

L[10] = Instance.new("TextButton", L[6])
L[10].TextWrapped = true
L[10].BorderSizePixel = 0
L[10].TextScaled = true
L[10].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
L[10].FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold)
L[10].Size = UDim2.new(0, 76, 0, 14)
L[10].Text = "Ban"
L[10].Position = UDim2.new(0, -2, 0, 32)

L[11] = Instance.new("TextButton", L[6])
L[11].TextWrapped = true
L[11].BorderSizePixel = 0
L[11].TextScaled = true
L[11].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
L[11].FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold)
L[11].Size = UDim2.new(0, 76, 0, 14)
L[11].Text = "Unban"
L[11].Position = UDim2.new(0, -2, 0, 48)

L[12] = Instance.new("TextButton", L[6])
L[12].TextWrapped = true
L[12].BorderSizePixel = 0
L[12].TextScaled = true
L[12].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
L[12].FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold)
L[12].Size = UDim2.new(0, 76, 0, 14)
L[12].Text = "ModTag"
L[12].Position = UDim2.new(0, 78, 0, 48)

L[13] = Instance.new("TextLabel", L[6])
L[13].BorderSizePixel = 0
L[13].BackgroundColor3 = Color3.fromRGB(173, 173, 173)
L[13].Size = UDim2.new(0, 156, 0, 2)
L[13].Text = ""
L[13].Position = UDim2.new(0, -2, 0, 64)

L[14] = Instance.new("ScrollingFrame", L[6])
L[14].BorderSizePixel = 0
L[14].BackgroundTransparency = 1
L[14].Size = UDim2.new(0, 156, 0, 182)
L[14].Position = UDim2.new(0, -2, 0, 68)
L[14].ScrollBarThickness = 3
L[14].ScrollBarImageColor3 = Color3.fromRGB(173, 173, 173)
L[14].CanvasSize = UDim2.new(0, 0, 0, 0)
L[14].AutomaticCanvasSize = Enum.AutomaticSize.Y

Instance.new("UIListLayout", L[14]).Padding = UDim.new(0, 2)

L[15] = Instance.new("TextButton", L[2])
L[15].TextWrapped = true
L[15].BorderSizePixel = 0
L[15].TextScaled = true
L[15].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
L[15].FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold)
L[15].Size = UDim2.new(0, 156, 0, 10)
L[15].Text = "Crash / Lag the Game"
L[15].Position = UDim2.new(0, -2, 0, 268)

for i1,p1 in next, Players:GetPlayers() do
	local e1 = Instance.new("TextButton", L[14])
	e1.BorderSizePixel = 0
	e1.TextScaled = true
	e1.TextXAlignment = Enum.TextXAlignment.Left
	e1.TextColor3 = Color3.fromRGB(80, 80, 80)
	e1.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
	e1.Size = UDim2.new(1, 0, 0, 18)
	e1.Text = "  " .. p1.DisplayName .. " @" .. p1.Name
	e1.TextTruncate = Enum.TextTruncate.SplitWord
	entry_map[p1] = e1
	e1.MouseButton1Click:Connect(function()
		for i2,v2 in next, entry_map do v2.BackgroundColor3 = Color3.fromRGB(240, 240, 240) end
		e1.BackgroundColor3 = Color3.fromRGB(200, 230, 210)
		selected_player = p1
		L[7].Text = p1.Name
	end)
end

Players.PlayerAdded:Connect(function(p2)
	local e2 = Instance.new("TextButton", L[14])
	e2.BorderSizePixel = 0
	e2.TextScaled = true
	e2.TextXAlignment = Enum.TextXAlignment.Left
	e2.TextColor3 = Color3.fromRGB(80, 80, 80)
	e2.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
	e2.Size = UDim2.new(1, 0, 0, 18)
	e2.Text = "  " .. p2.DisplayName .. " @" .. p2.Name
	e2.TextTruncate = Enum.TextTruncate.SplitWord
	entry_map[p2] = e2
	e2.MouseButton1Click:Connect(function()
		for i3,v3 in next, entry_map do v3.BackgroundColor3 = Color3.fromRGB(240, 240, 240) end
		e2.BackgroundColor3 = Color3.fromRGB(200, 230, 210)
		selected_player = p2
		L[7].Text = p2.Name
	end)
end)

Players.PlayerRemoving:Connect(function(p3)
	if entry_map[p3] then entry_map[p3]:Destroy() entry_map[p3] = nil end
	if selected_player == p3 then selected_player = nil L[7].Text = "" end
end)

L[5].MouseButton1Click:Connect(function()
	is_open = not is_open
	L[5].Text = is_open and "<" or ">"
	game:GetService("TweenService"):Create(L[2], TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Position = is_open and UDim2.new(0, 654, 0, -18) or UDim2.new(0, 830, 0, -18)
	}):Play()
end)

L[9].MouseButton1Click:Connect(function()
	local t1 = Players:FindFirstChild(L[7].Text)
	local r1 = L[8].Text ~= "" and L[8].Text or "No reason provided"
	local prev1 = L[7].Text
	if t1 then
		RS.RemoteEvents.KickPlayer:FireServer(t1, r1)
		L[7].Text = "" L[7].PlaceholderText = t1.Name .. " was successfully kicked!" L[7].BackgroundColor3 = Color3.fromRGB(0, 255, 0) L[8].Text = ""
		task.wait(1.75) L[7].PlaceholderText = "Target username.." L[7].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	else
		L[7].Text = "" L[7].PlaceholderText = prev1 .. " could not be kicked..." L[7].BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		task.wait(1.75) L[7].PlaceholderText = "Target username.." L[7].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	end
end)

L[10].MouseButton1Click:Connect(function()
	local t2 = Players:FindFirstChild(L[7].Text)
	local r2 = L[8].Text ~= "" and L[8].Text or "No reason provided"
	local prev2 = L[7].Text
	if t2 == Players.LocalPlayer then
		L[7].Text = "" L[7].PlaceholderText = "Why would you want to ban yourself?" L[7].BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		task.wait(1.75) L[7].PlaceholderText = "Target username.." L[7].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	elseif t2 then
		RS.RemoteEvents.BanPlayer:FireServer(t2, r2)
		L[7].Text = "" L[7].PlaceholderText = t2.Name .. " was successfully banned!" L[7].BackgroundColor3 = Color3.fromRGB(0, 255, 0) L[8].Text = ""
		task.wait(1.75) L[7].PlaceholderText = "Target username.." L[7].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	else
		L[7].Text = "" L[7].PlaceholderText = prev2 .. " could not be banned..." L[7].BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		task.wait(1.75) L[7].PlaceholderText = "Target username.." L[7].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	end
end)

L[11].MouseButton1Click:Connect(function()
	local prev3 = L[7].Text
	if prev3 == "" then
		L[7].PlaceholderText = "Enter a username to unban..." L[7].BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		task.wait(1.75) L[7].PlaceholderText = "Target username.." L[7].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		return
	end
	RS.RemoteEvents.UnbanPlayer:FireServer(prev3)
	L[7].Text = "" L[7].PlaceholderText = prev3 .. " was successfully unbanned!" L[7].BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	task.wait(1.75) L[7].PlaceholderText = "Target username.." L[7].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
end)

L[12].MouseButton1Click:Connect(function()
	mod = not mod
	L[12].BackgroundColor3 = mod and Color3.fromRGB(200, 230, 210) or Color3.fromRGB(255, 255, 255)
	RS.RemoteEvents.ToggleModTag:FireServer(mod)
end)

Players.LocalPlayer.CharacterAdded:Connect(function()
	if mod then
		task.wait()
		RS.RemoteEvents.ToggleModTag:FireServer(true)
	end
end)

L[15].MouseButton1Click:Connect(function()
	crash = not crash
	L[15].BackgroundColor3 = crash and Color3.fromRGB(200, 230, 210) or Color3.fromRGB(255, 255, 255)
	if crash then
		for i4 = 1, 5 do
			task.spawn(function()
				while crash do RS.AnkleBreaks:FireServer() task.wait() end
			end)
		end
	end
end)
