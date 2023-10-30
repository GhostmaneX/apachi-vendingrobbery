# Forked & Modified From - Apachi vending robbery By - GhostmaneX#2077

## Showcase ( Old Video )

[![Watch the video](https://media.discordapp.net/attachments/1131638732513103912/1164519160261386302/image.png)](https://www.youtube.com/watch?v=ao_eqPx2wEA)


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
