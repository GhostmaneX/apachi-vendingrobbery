local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('apachivending:AddMoney', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddMoney('cash', Config.Reward, 'Vending Robbery')
    
end)