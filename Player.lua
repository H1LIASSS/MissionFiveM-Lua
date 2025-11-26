RegisterCommand("coords", function(source,args,raw)
     print(GetEntityCoords(PlayerPedId(),true))
end)

AddEventHandler('onClientResourceStart',function(resourceName)
    if GetCurrentResourceName() == resourceName then
    local spawnPos = vector3(736.75, 129.40, 79.70)
    exports.spawnmanager:spawnPlayer({
        x = spawnPos.x,
        y = spawnPos.y,
        z = spawnPos.z,
        })
    end
end)