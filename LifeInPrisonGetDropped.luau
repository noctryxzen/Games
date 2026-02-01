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
    local o = Connection.Function
    
    Connection:Disable()
    
    Remote.OnClientEvent:Connect(function(...)
        local a = {...}
        
        if a[1] == 27 and type(a[2]) == "string" then
            if a[2]:match("^You already have") or a[2]:match("^You do not have the") then
                return
            end
        end
        
        o(...)
    end)
end

Pickups.ChildAdded:Connect(function(Item)
    Remote:FireServer(12, Item)
end)

Pickups.ChildRemoved:Connect(function(Item)
    Remote:FireServer(12, Item)
end)

for _, Item in Pickups:GetChildren() do
    Remote:FireServer(12, Item)
end

task.spawn(function()
    while true do
        task.wait(0.2)
        
        for _, Item in Pickups:GetChildren() do
            Remote:FireServer(12, Item)
        end
    end
end)

warn("ok")
