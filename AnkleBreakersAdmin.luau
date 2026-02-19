local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")

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
L[14].Size = UDim2.new(0, 156, 0, 110)
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

L[16] = Instance.new("TextLabel", L[6])
L[16].BorderSizePixel = 0
L[16].BackgroundColor3 = Color3.fromRGB(173, 173, 173)
L[16].Size = UDim2.new(0, 156, 0, 2)
L[16].Text = ""
L[16].Position = UDim2.new(0, -2, 0, 182)

L[17] = Instance.new("ScrollingFrame", L[6])
L[17].BorderSizePixel = 0
L[17].BackgroundTransparency = 1
L[17].Size = UDim2.new(0, 156, 0, 62)
L[17].Position = UDim2.new(0, -2, 0, 186)
L[17].ScrollBarThickness = 3
L[17].ScrollBarImageColor3 = Color3.fromRGB(173, 173, 173)
L[17].CanvasSize = UDim2.new(0, 0, 0, 0)
L[17].AutomaticCanvasSize = Enum.AutomaticSize.Y

Instance.new("UIListLayout", L[17]).Padding = UDim.new(0, 2)

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
		setclipboard(p1.Name)
		toclipboard(p1.Name)
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
		setclipboard(p2.Name)
		toclipboard(p2.Name)
	end)
end)

Players.PlayerRemoving:Connect(function(p3)
	if entry_map[p3] then entry_map[p3]:Destroy() entry_map[p3] = nil end
	if selected_player == p3 then selected_player = nil L[7].Text = "" end
end)

L[5].MouseButton1Click:Connect(function()
	is_open = not is_open
	L[5].Text = is_open and "<" or ">"
	TS:Create(L[2], TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Position = is_open and UDim2.new(0, 654, 0, -18) or UDim2.new(0, 830, 0, -18)
	}):Play()
end)

L[9].MouseButton1Click:Connect(function()
	local t1 = Players:FindFirstChild(L[7].Text)
	local r1 = L[8].Text ~= "" and L[8].Text or "No reason provided"
	local prev1 = L[7].Text
	if t1 then
		RS.RemoteEvents.KickPlayer:FireServer(t1, r1)
		local r1a = Instance.new("Frame", L[17]) r1a.Size = UDim2.new(1, 0, 0, 22) r1a.BackgroundColor3 = Color3.fromRGB(200, 230, 210) r1a.BackgroundTransparency = 0 r1a.BorderSizePixel = 0
		local r1b = Instance.new("ImageLabel", r1a) r1b.Size = UDim2.new(0, 18, 0, 18) r1b.Position = UDim2.new(0, 0, 0, 2) r1b.BackgroundTransparency = 1 r1b.BorderSizePixel = 0
		local ok1, id1 = pcall(function() return Players:GetUserThumbnailAsync(t1.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48) end) if ok1 then r1b.Image = id1 end
		local r1c = Instance.new("TextLabel", r1a) r1c.Size = UDim2.new(1, -22, 1, 0) r1c.Position = UDim2.new(0, 22, 0, 0) r1c.BackgroundTransparency = 1 r1c.TextScaled = true r1c.TextXAlignment = Enum.TextXAlignment.Left r1c.TextColor3 = Color3.fromRGB(220, 160, 60) r1c.FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold) r1c.TextTruncate = Enum.TextTruncate.SplitWord r1c.Text = "Kicked: " .. t1.DisplayName .. " @" .. t1.Name
		local r1d = Instance.new("TextButton", r1a) r1d.Size = UDim2.new(1, 0, 1, 0) r1d.BackgroundTransparency = 1 r1d.Text = "" r1d.ZIndex = 2
		r1d.MouseButton1Click:Connect(function()
			setclipboard(t1.Name) toclipboard(t1.Name)
			r1a.BackgroundColor3 = Color3.fromRGB(200, 230, 210) r1a.BackgroundTransparency = 0
			TS:Create(r1a, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {BackgroundTransparency = 1}):Play()
		end)
		TS:Create(r1a, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {BackgroundTransparency = 1}):Play()
		task.wait() L[17].CanvasPosition = Vector2.new(0, L[17].AbsoluteCanvasSize.Y)
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
		local r2a = Instance.new("Frame", L[17]) r2a.Size = UDim2.new(1, 0, 0, 22) r2a.BackgroundColor3 = Color3.fromRGB(200, 230, 210) r2a.BackgroundTransparency = 0 r2a.BorderSizePixel = 0
		local r2b = Instance.new("ImageLabel", r2a) r2b.Size = UDim2.new(0, 18, 0, 18) r2b.Position = UDim2.new(0, 0, 0, 2) r2b.BackgroundTransparency = 1 r2b.BorderSizePixel = 0
		local ok2, id2 = pcall(function() return Players:GetUserThumbnailAsync(t2.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48) end) if ok2 then r2b.Image = id2 end
		local r2c = Instance.new("TextLabel", r2a) r2c.Size = UDim2.new(1, -22, 1, 0) r2c.Position = UDim2.new(0, 22, 0, 0) r2c.BackgroundTransparency = 1 r2c.TextScaled = true r2c.TextXAlignment = Enum.TextXAlignment.Left r2c.TextColor3 = Color3.fromRGB(200, 60, 60) r2c.FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold) r2c.TextTruncate = Enum.TextTruncate.SplitWord r2c.Text = "Banned: " .. t2.DisplayName .. " @" .. t2.Name
		local r2d = Instance.new("TextButton", r2a) r2d.Size = UDim2.new(1, 0, 1, 0) r2d.BackgroundTransparency = 1 r2d.Text = "" r2d.ZIndex = 2
		r2d.MouseButton1Click:Connect(function()
			setclipboard(t2.Name) toclipboard(t2.Name)
			r2a.BackgroundColor3 = Color3.fromRGB(200, 230, 210) r2a.BackgroundTransparency = 0
			TS:Create(r2a, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {BackgroundTransparency = 1}):Play()
		end)
		TS:Create(r2a, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {BackgroundTransparency = 1}):Play()
		task.wait() L[17].CanvasPosition = Vector2.new(0, L[17].AbsoluteCanvasSize.Y)
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
	local t3 = Players:FindFirstChild(prev3)
	RS.RemoteEvents.UnbanPlayer:FireServer(prev3)
	local r3a = Instance.new("Frame", L[17]) r3a.Size = UDim2.new(1, 0, 0, 22) r3a.BackgroundColor3 = Color3.fromRGB(200, 230, 210) r3a.BackgroundTransparency = 0 r3a.BorderSizePixel = 0
	local r3b = Instance.new("ImageLabel", r3a) r3b.Size = UDim2.new(0, 18, 0, 18) r3b.Position = UDim2.new(0, 0, 0, 2) r3b.BackgroundTransparency = 1 r3b.BorderSizePixel = 0
	if t3 then local ok3, id3 = pcall(function() return Players:GetUserThumbnailAsync(t3.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48) end) if ok3 then r3b.Image = id3 end end
	local r3c = Instance.new("TextLabel", r3a) r3c.Size = UDim2.new(1, -22, 1, 0) r3c.Position = UDim2.new(0, 22, 0, 0) r3c.BackgroundTransparency = 1 r3c.TextScaled = true r3c.TextXAlignment = Enum.TextXAlignment.Left r3c.TextColor3 = Color3.fromRGB(60, 180, 100) r3c.FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold) r3c.TextTruncate = Enum.TextTruncate.SplitWord
	r3c.Text = t3 and ("Unbanned: " .. t3.DisplayName .. " @" .. t3.Name) or ("Unbanned: " .. prev3)
	local r3d = Instance.new("TextButton", r3a) r3d.Size = UDim2.new(1, 0, 1, 0) r3d.BackgroundTransparency = 1 r3d.Text = "" r3d.ZIndex = 2
	local copyName = t3 and t3.Name or prev3
	r3d.MouseButton1Click:Connect(function()
		setclipboard(copyName) toclipboard(copyName)
		r3a.BackgroundColor3 = Color3.fromRGB(200, 230, 210) r3a.BackgroundTransparency = 0
		TS:Create(r3a, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {BackgroundTransparency = 1}):Play()
	end)
	TS:Create(r3a, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {BackgroundTransparency = 1}):Play()
	task.wait() L[17].CanvasPosition = Vector2.new(0, L[17].AbsoluteCanvasSize.Y)
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
