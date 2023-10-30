local CoreObject = exports[Config.Settings.CoreExport]:GetCoreObject()
local players = {}

Citizen.CreateThread(function()
    exports[Config.Settings.TargetExport]:AddTargetModel('prop_vend_coffe_01', {
        options = {
            {
                type = "client",
                event = "apachi-vendingrobbery:hack",
                icon = "fa-solid fa-laptop-code",
                label = "Vending Nachine Robbery",
            },
        },
        distance = 2.5
    })

    exports[Config.Settings.TargetExport]:AddTargetModel('prop_vend_soda_01', {
        options = {
            {
                type = "client",
                event = "apachi-vendingrobbery:hack",
                icon = "fa-solid fa-laptop-code",
                label = "Vending Nachine Robbery",
            },
        },
        distance = 2.5
    })
end)

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

function HasItem(item)
    local retval = nil
    CoreObject.Functions.TriggerCallback("CoreObject:HasItem", function(data)
        retval = data
    end, item)

    while retval == nil do
        Wait(1)
    end

    return retval
end

function hasCooldownPassed(source)
    local currentTime = GetGameTimer()
    if not players[source] or (currentTime - players[source]) >= Config.Settings.UseageCooldown then
        return true
    else
        return false
    end
end

RegisterNetEvent('apachi-vendingrobbery:hack', function()
    local src = source

    if not hasCooldownPassed(src) then
        local timeLeft = ((players[src] + Config.Settings.UseageCooldown - GetGameTimer()) / 1000)
        local time = { time = math.floor(timeLeft) }
        CoreObject.Functions.Notify(("Wait %ds until you can rob again."):format(time.time), 'error')        
        return
    else
        CoreObject.Functions.TriggerCallback('apachi-vendingrobbery:CheckForItems', function(HasItems)
            if HasItems then
                exports['apachi-vendingrobbery']:Thermite(function(success)
                    if success then
                        CoreObject.Functions.Progressbar('robbing', 'robbing the vending machine', 25000, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {}, {}, {}, function()
                            players[src] = GetGameTimer()
                            CoreObject.Functions.Notify("run over from the police !!!", 'success')
                            TriggerServerEvent('apachi-vendingrobbery:RobberyReward')
                            exports[Config.Settings.DispatchExport]:ApachiVendRobbery()
                        end, function()
                            CoreObject.Functions.Notify("why did you stop ?", 'error')
                        end)
                        takeAnim()
                    else
                        CoreObject.Functions.Notify("you failed", 'error')
                    end
                end, 10, 5, 3)
            elseif not HasItems then
                CoreObject.Functions.Notify("Go get a Hammer", 'error')
            end
        end)
    end
end)
