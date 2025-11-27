AddEventHandler('Mission',function()
    GiveWeaponToPed(PlayerPedId(),"WEAPON_ASSAULTRIFLE_MK2",600,false,true)
    GiveWeaponToPed(PlayerPedId(),"WEAPON_MARKSMANRIFLE",60,false,true)

    local dc = vector3(732.23,133.42,79.845)
    AddDoorToSystem(`gate_01`,`prop_fnclink_02gate2`,dc,false,true,false)
    DoorSystemSetDoorState(`gate_01`,0,false, false)

end)