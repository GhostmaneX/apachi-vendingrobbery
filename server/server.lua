local CoreObject = exports[Config.Settings.CoreExport]:GetCoreObject()

RegisterNetEvent('apachi-vendingrobbery:RobberyReward', function()
    local src = source
    local price = math.random(300, 600)
    local Player = CoreObject.Functions.GetPlayer(src)
    Player.Functions.AddMoney(Config.Settings.Payment, price, "sold-casino-chips")
end)

CoreObject.Functions.CreateCallback('apachi-vendingrobbery:CheckForItems', function(source, cb)
    local src = source
    local Ply = CoreObject.Functions.GetPlayer(src)
    local hammer = Ply.Functions.GetItemByName("weapon_hammer")
    if hammer ~= nil then
        cb(true)
    else
        cb(false)
    end
end)
