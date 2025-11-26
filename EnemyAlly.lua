local description = {
{model = "s_m_m_armoured_01", weapon = "w_pi_singleshoth4", weaponHash = "WEAPON_GADGETPISTOL"},
{model = "s_m_m_armoured_02", weapon = "w_pi_vintage_pistol", weaponHash = "WEAPON_VINTAGEPISTOL" },
{model = "s_m_m_chemsec_01", weapon = "w_pi_sns_pistolmk2", weaponHash = "WEAPON_SNSPISTOL_MK2"},
{model = "s_m_m_fibsec_01", weapon = "W_PI_COMBATPISTOL", weaponHash = "WEAPON_COMBATPISTOL" },
{model = "s_m_y_swat_01", weapon = "w_pi_singleshoth4", weaponHash = "WEAPON_GADGETPISTOL" },
{model = "ig_josh", weapon = "w_pi_wep1_gun", weaponHash = "WEAPON_DOUBLEACTION" }}


local maxAmmount = 7
local onLevel = 5
local dead = 0
local dc = vector3(656,106,80.8)
local dc2 = vector3(710, 141,80.8)
local npcs = {}
local blips = {}

AddEventHandler('onClientResourceStart', function(resourceName)

    if GetCurrentResourceName() == resourceName then

        for data, i in pairs(description) do -- Prepare all needed models and weapons for enemy group
            RequestModel(GetHashKey(i.model))
            while not HasModelLoaded(GetHashKey(i.model)) do
                Citizen.Wait(10)
            end

            RequestModel(GetHashKey(i.weapon))
            while not HasModelLoaded(GetHashKey(i.weapon)) do
                Citizen.Wait(10)
            end
        end
        AddRelationshipGroup("Group") -- Ensure group
        SetRelationshipBetweenGroups(5,GetHashKey("Group"),GetHashKey("PLAYER")) -- Player is the enemy for the group
        SetRelationshipBetweenGroups(0,GetHashKey("Group"),GetHashKey("Group"))  -- Group loves each other
    end

end)


function PreparePed(i)
    local x = math.random(dc.x,dc2.x)
    local y = math.random(dc.y,dc2.y) -- Getting coordinates in range of the room

    local ped = CreatePed(4,description[math.random(#description)].model,vector3(x,y,80.8),245.0,false,false)
    
    blips[i] = AddBlipForEntity(ped) -- For each npc in list there is a matching blip via giving the same index from first list

    SetPedRelationshipGroupHash(ped,GetHashKey("Group")) --
    SetPedArmour(ped,100)

    SetPedCombatMovement(ped, 2) 
    SetPedCombatRange(ped, 0)    

    SetPedCombatAttributes(ped,46,true)

    GiveWeaponToPed(ped,description[math.random(#description)].weaponHash,20,false,true)
    
    return ped
end


AddEventHandler('Mission',function()

    for i=1, onLevel do
        npcs[i]= PreparePed(i)
        i=i+1
    end
   Citizen.CreateThread(function()
        RegulateAllyOnLevel()
    end)

end)

function InformDeath(i) --Set of rules for the death of i element of npcs list
    CreateMoneyPickups(GetEntityCoords(npcs[i]),math.random(100,200),10,0)
    RemoveBlip(blips[i])
    DeleteInTime(npcs[i])
    npcs[i] = nil

    dead=dead+1
    if maxAmmount-dead >= onLevel then
        npcs[i]=PreparePed(i)
    end
   
    if dead == maxAmmount then --Maybe this should be happened in other script
        RequestModel("w_mg_minigun")
        while not HasModelLoaded(GetHashKey("w_mg_minigun")) do
            Citizen.Wait(10)
        end
        GiveWeaponToPed(PlayerPedId(),"WEAPON_MINIGUN",300,false,true)   
    end
end
function RegulateAllyOnLevel()

    while dead~=maxAmmount do
        for i = 1, #npcs do
            if npcs[i] ~= nil then
                if IsEntityDead(npcs[i]) then
                    InformDeath(i)
                elseif GetEntityHealth(npcs[i]) <=120 then
                    SetPedCombatMovement(npcs[i], 1)
                    SetPedCombatAttributes(npcs[i], 11, true) 
                    SetPedCombatAttributes(npcs[i], 5, true)  
                    SetPedCombatAttributes(npcs[i], 3, true)  
                end
                
            end
        end        
        Citizen.Wait(0)
    end
    print("All killed mission complete")
end


function DeleteInTime(ped)
    Citizen.CreateThread(function()
        Citizen.Wait(5000)
        DeletePed(ped) 
    end)
end

