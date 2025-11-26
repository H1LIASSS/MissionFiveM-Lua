local modelName = "ig_djsolmike"
local npc
local interactable = true


function WaitFor(value) -- value response for the statement of their last interaction (have been they talking)

    talking = value
    local distanceInteraction = 1.4

    while interactable do
        dp = GetEntityCoords(PlayerPedId(),true)
        dn = GetEntityCoords(npc,true)

        if GetDistanceBetweenCoords(dp,dn) <= distanceInteraction and not talking then
            print("1")
            TriggerEvent('ShowOptions')
            talking = true
        elseif talking and GetDistanceBetweenCoords(dp,dn) > distanceInteraction then
            TriggerEvent('AbortTalk')
            talking = false
        end
        Citizen.Wait(0)
    end
end

AddEventHandler('Decline',function()
    Citizen.CreateThread(function()
        WaitFor(true)
    end)
end)


AddEventHandler('onClientResourceStart', function(resourceName)

    if GetCurrentResourceName() == resourceName then
        local entitySpawn = vector3(734.75, 129.40, 80.70)
        
        RequestModel(GetHashKey(modelName))
        while not HasModelLoaded(GetHashKey(modelName)) do
            Citizen.Wait(10)
        end
        npc = CreatePed(4,modelName,entitySpawn.x,entitySpawn.y,entitySpawn.z,245.0,false,false)
        SetEntityInvincible(npc, true)

        Citizen.CreateThread(function()
            WaitFor(false)
        end)
        
        --[[local dc = vector3(732.23,133.42,79.845)
        AddDoorToSystem(`gate_01`,`prop_fnclink_02gate2`,dc.x,dc.y,dc.z,false,true,false)
        DoorSystemSetDoorState(`gate_01`,0,false, false)
        local currentState = DoorSystemGetDoorState(`gate_01`)
        local pendingState = DoorSystemGetDoorPendingState(`gate_01`)]]--
    end

end)