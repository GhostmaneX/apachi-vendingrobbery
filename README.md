
# Forked & Modified From - Apachi vending robbery By - GhostmaneX#2077

## Showcase

[![Watch the video](https://cdn.discordapp.com/attachments/859515992052989983/1168504422737915925/FREE___Apachi_vending_robbery___QBCore.mp4?ex=6552018c&is=653f8c8c&hm=2b779eef977e262654312a4b4a2c81151a9753a6ac3d65250901da7e52819746&)]

## Depencies

    PS-UI

    QBCore

    QB-TARGET
    
## add these into your dispatch resource, in /server/sv_dispatchcodes.lua
```
	["vendrobbery"] =  {displayCode = '10-90', description = "Vending Machine Robbery", radius = 0, recipientList = {'police'}, blipSprite = 162, blipColour = 0, blipScale = 0.9, blipLength = 2, sound = "Lose_1st", sound2 = "GTAO_FM_Events_Soundset", offset = "false"},
```

## add these into your dispatch resource, in /client/cl_events.lua
```
local function vendrobbery(vehicle)
    local vehdata = vehicleData(vehicle)
    local currentPos = GetEntityCoords(PlayerPedId())
    local locationInfo = getStreetandZone(currentPos)
    local heading = getCardinalDirectionFromHeading()
    TriggerServerEvent("dispatch:server:notify",{
        dispatchcodename = "vendrobbery", -- has to match the codes in sv_dispatchcodes.lua so that it generates the right blip
        dispatchCode = "10-90",
        firstStreet = locationInfo,
        model = vehdata.name, -- vehicle name
        plate = vehdata.plate, -- vehicle plate
        priority = 2, 
        firstColor = vehdata.colour, -- vehicle color
        heading = heading, 
        automaticGunfire = false,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = "Vending Machine Robbery",
        job = {"police"}
    })
end exports('vendrobbery', vendrobbery)
```
