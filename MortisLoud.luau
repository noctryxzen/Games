local GetService = setmetatable({}, {
    __index = function(s, n)
        s[n] = (cloneref and clonefunction(cloneref) or function(x) return x end)(clonefunction(game.GetService)(game, n));
        return s[n];
    end;
});

--// Main
for i = 1,3 do
    GetService.RunService.PreSimulation:Connect(newcclosure(clonefunction(function()
        GetService.ReplicatedStorage.Events.GameEvents.HammerSwingEvent:FireServer(nil)
    end)))
end
