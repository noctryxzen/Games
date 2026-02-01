local GetService = setmetatable({}, {
    __index = function(s, n)
        s[n] = game:GetService(n)
        return s[n]
    end
})

local Local = GetService.Players.LocalPlayer
local Remote = GetService.ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteEvent")
local Pickups = GetService.Workspace:WaitForChild("pickups")

local Connections = getconnections(Remote.OnClientEvent)

for _, Connection in Connections do
    local Original = Connection.Function
    
    Connection:Disable()
    
    Remote.OnClientEvent:Connect(function(...)
        local Args = {...}
        
        if Args[1] == 27 and type(Args[2]) == "string" then
            if Args[2]:match("^You already have") or Args[2]:match("^You do not have the") then
                return
            end
        end
        
        Original(...)
    end)
end

Pickups.ChildAdded:Connect(function(Item)
    local Backpack = Local:FindFirstChild("Backpack")
    local Character = Local.Character
    
    if Backpack and Character then
        if not (Backpack:FindFirstChild(Item.Name) or Character:FindFirstChild(Item.Name)) then
            Remote:FireServer(12, Item)
        end
    end
end)

Pickups.ChildRemoved:Connect(function(Item)
    Remote:FireServer(12, Item)
end)

for _, Item in Pickups:GetChildren() do
    local Backpack = Local:FindFirstChild("Backpack")
    local Character = Local.Character
    
    if Backpack and Character then
        if not (Backpack:FindFirstChild(Item.Name) or Character:FindFirstChild(Item.Name)) then
            Remote:FireServer(12, Item)
        end
    end
end

task.spawn(function()
    while true do
        task.wait(1)
        
        for _, Item in Pickups:GetChildren() do
            local Backpack = Local:FindFirstChild("Backpack")
            local Character = Local.Character
            
            if Backpack and Character then
                if not (Backpack:FindFirstChild(Item.Name) or Character:FindFirstChild(Item.Name)) then
                    Remote:FireServer(12, Item)
                end
            end
        end
    end
end)

warn("ok")
