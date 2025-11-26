local completedMission = false


AddEventHandler('Mission',function()

     Citizen.CreateThread(function()
        
        --Create UI text message to kill 100
        --And show HP for npcs
        while not completedMission do
            --_menuPool:ProcessMenus()
            Citizen.Wait(0)
        end
     end)
end)

AddEventHandler('MissionComplete',function()
    completedMission = true
end)


local picked
AddEventHandler('ShowOptions',function()
    picked = false
   
    Citizen.CreateThread(function()
        _menuPool = NativeUI.CreatePool()
        mainMenu = NativeUI.CreateMenu("T.L.M.S","You wether embrace it, wether go away.")
        option = NativeUI.CreateItem("I'm With It","")
        option1 = NativeUI.CreateItem("Decline","")
        _menuPool:Add(mainMenu)
        mainMenu:AddItem(option)
        mainMenu:AddItem(option1)
        mainMenu:Visible(true)
        while not picked do
            _menuPool:ProcessMenus()
            mainMenu.OnItemSelect = function(menu,item,index)
                if item == option then
                    TriggerEvent('Mission')
                elseif item == option1 then
                    TriggerEvent('Decline')
                end
                picked = true
            end
         Citizen.Wait(0)
        end
    end)
end)

AddEventHandler('AbortTalk',function()
    picked = true
end)