loadstring(game:HttpGet("https://raw.githubusercontent.com/noctryxzen/FilterGC/refs/heads/main/isGC.luau"))()

ReplicatedStorage = game:GetService("ReplicatedStorage")
MortisEvent = ReplicatedStorage.Events.GameEvents.MortisChanceEvent
make_me_mortis = true

_add = function()
	ReplicatedStorage.RagdollRemote.OnClientEvent:Connect(function(p)
		if p:find("Enable") then firesignal(ReplicatedStorage.RagdollRemote.OnClientEvent, "Disable") end
	end)
	repeat task.wait(.5) until #filtergc("function", {Name = "isInHitbox"}) > 0
	for i, v in next, filtergc("function", {Name = "isInHitbox"}) do hookfunction(v, newcclosure(function() return true end)) end
end

MortisEvent:FireServer(make_me_mortis and "PurchaseComplete")
ReplicatedStorage.Events.GameEvents.RoundStart.OnClientEvent:Connect(function() MortisEvent:FireServer(make_me_mortis and "PurchaseComplete") end)
game:GetService("Players").LocalPlayer.CharacterAdded:Connect(_add)
_add()

warn("ok")
