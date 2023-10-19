local QBCore = exports['qb-core']:GetCoreObject()


exports['qb-target']:AddTargetModel('prop_vend_coffe_01', {
    options = {
        {
            type = "client",
            event = "apachivending:hack",
            icon = "fa-solid fa-laptop-code",
            label = "Coffee vending robbery",
         },
    },
    distance = 2.5
})

exports['qb-target']:AddTargetModel('prop_vend_soda_01', {
    options = {
        {
            type = "client",
            event = "apachivending:hack",
            icon = "fa-solid fa-laptop-code", 
            label = "Soda vending robbery",
         },
    },
    distance = 2.5
})


function takeAnim()
    local ped = PlayerPedId()
    while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do
        RequestAnimDict("amb@prop_human_bum_bin@idle_b")
        Wait(100)
    end
    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "idle_d", 8.0, 8.0, -1, 50, 0, false, false, false)
    Wait(50000)
    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "exit", 8.0, 8.0, -1, 50, 0, false, false, false)
end




RegisterNetEvent('apachivending:hack', function()
    
    local hasItem = QBCore.Functions.HasItem('weapon_crowbar')
    if not hasItem then  QBCore.Functions.Notify("You need a crowbar", 'error') return end
    exports['ps-ui']:Thermite(function(success)
        if success then
            TriggerEvent('apachivending:rob')
            takeAnim()
        else
            TriggerEvent('apachivending:fail')
        end
    end, 10, 5, 3)

end)




RegisterNetEvent("apachivending:fail", function()
    QBCore.Functions.Notify("you failed", 'error')
end)





RegisterNetEvent('apachivending:rob', function()
    QBCore.Functions.Progressbar('robbing', 'robbing the vending machine', 25000, false, true, {
    disableMovement = true,
    disableCarMovement = true,
    disableMouse = false,
    disableCombat = true
    }, {}, {}, {}, function()
        QBCore.Functions.Notify("run over from the police !!!", 'success')
        exports['ps-dispatch']:SuspiciousActivity()
        TriggerServerEvent('apachivending:AddMoney')
    end, function()
        QBCore.Functions.Notify("why did you stop ?", 'error')
end)
end)

