loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/FilterGC/refs/heads/main/isGC.luau"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Getter/refs/heads/main/GetFS.luau"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/NUI/refs/heads/main/Notification.luau"))()
local Circle=Drawing.new("Circle")
Circle.Visible,Circle.Thickness,Circle.Filled=true,1,false
Circle.Color,Circle.Radius=Color3.fromRGB(128,128,128),87
GetService.Workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
Circle.Position=GetService.Workspace.CurrentCamera.ViewportSize/2
end)
Circle.Position=GetService.Workspace.CurrentCamera.ViewportSize/2
local _={}
for i,v in next,GetService.Players:GetPlayers() do
if v==GetService.Players.LocalPlayer or _[v] then continue end
local Box=Drawing.new("Square")
Box.Thickness=2 Box.Transparency=1 Box.Filled=false Box.Visible=false
local Label=Drawing.new("Text")
Label.Size=14 Label.Center=true Label.Outline=true Label.Transparency=1 Label.Visible=false
_[v]={Box,Label}
end
GetService.Players.PlayerAdded:Connect(newcclosure(function(v)
if v==GetService.Players.LocalPlayer or _[v] then return end
local Box=Drawing.new("Square")
Box.Thickness=2 Box.Transparency=1 Box.Filled=false Box.Visible=false
local Label=Drawing.new("Text")
Label.Size=14 Label.Center=true Label.Outline=true Label.Transparency=1 Label.Visible=false
_[v]={Box,Label}
end))
GetService.Players.PlayerRemoving:Connect(newcclosure(function(v)
if not _[v] then return end
for i,v2 in next,_[v] do v2:Remove() end _[v]=nil
end))
GetService.RunService.PreSimulation:Connect(newcclosure(function()
for i,v in next,GetService.Players:GetPlayers() do
if not _[v] then continue end
local Box,Label=_[v][1],_[v][2]
local RootPart=v.Character and v.Character:FindFirstChild("HumanoidRootPart")
local Humanoid=v.Character and v.Character:FindFirstChildWhichIsA("Humanoid")
if RootPart and Humanoid and Humanoid.Health>0 then
local Position,Visible=GetService.Workspace.CurrentCamera:WorldToViewportPoint(RootPart.Position)
if Visible then
local Size,X,Y=1000/Position.Z,Position.X-500/Position.Z,Position.Y-1000/Position.Z
Box.Size=Vector2.new(Size,Size*2) Box.Position=Vector2.new(X,Y)
Box.Color=Color3.fromRGB(255,50,50) Box.Visible=true
Label.Text=v.DisplayName~=v.Name and v.DisplayName.." @"..v.Name or v.Name
Label.Position=Vector2.new(Position.X,Y-16) Label.Color=Color3.fromRGB(255,50,50) Label.Visible=true
else Box.Visible=false Label.Visible=false end
else Box.Visible=false Label.Visible=false end
end
end))
local o;for i,v in next,filtergc("function",{Constants={"RandomizeUnit","GunHit"}}) do
o=clonefunction(hookfunction(v,newcclosure(function(s,org,tgt,k)
local c,d=nil,87
for i,v in next,GetService.Players:GetPlayers() do
if v==GetService.Players.LocalPlayer or not v.Character then continue end
local h=v.Character:FindFirstChild("HumanoidRootPart")
local hm=v.Character:FindFirstChild("Humanoid")
if not h or not hm or hm.Health<=0 then continue end
if v.Character:FindFirstChildOfClass("ForceField") then continue end
local p,os=GetService.Workspace.CurrentCamera.WorldToViewportPoint(GetService.Workspace.CurrentCamera,h.Position)
if not os then continue end
local ok,wc=pcall(GetService.Workspace.Raycast,GetService.Workspace,org,(h.Position-org).Unit*(h.Position-org).Magnitude)
if ok and wc and not v.Character:IsAncestorOf(wc.Instance) then continue end
local dist=(Vector2.new(p.X,p.Y)-GetService.Workspace.CurrentCamera.ViewportSize/2).Magnitude
if dist<d then c,d=h,dist end
end
if c then return o(s,org,c.Position,k) end
return o(s,org,tgt,k)
end))) break
end
if o then
SendNotification({Title="Silent Aim",Text="It works now!",Duration=5})
else
SendNotification({Title="Silent Aim",Text="ProcessShot not found. Contact me cuz.",Duration=math.huge,Button1="Copy Discord",Callback=function(Button)
if Button=="Copy Discord" then
setclipboard("https://discord.com/users/1423268813402804244")
SendNotification({Title="Silent Aim",Text="Discord link copied to clipboard!",Duration=3})
end
end})
end
