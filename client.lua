local PlayerData                = {}
ESX                             = nil

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
end) 

Citizen.CreateThread(function()
    if Config.NPCEnable == true then
        for i, v in pairs(Config.NPC) do
            RequestModel(v.npc)
            while not HasModelLoaded(v.npc) do
                Wait(1)
            end
            meth_dealer_seller = CreatePed(1, v.npc, v.x, v.y, v.z, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(meth_dealer_seller, true)
            SetPedDiesWhenInjured(meth_dealer_seller, false)
            SetPedCanPlayAmbientAnims(meth_dealer_seller, true)
            SetPedCanRagdollFromPlayerImpact(meth_dealer_seller, false)
            SetEntityInvincible(meth_dealer_seller, true)
            FreezeEntityPosition(meth_dealer_seller, true)
        end
    end
end)


function BrkyPz()
    local elements = {
        {label = 'Pizza Üret',   value = 'brky-legal'},
        {label = 'Menü Kapat',   value = 'kapat'},

    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'brky-legal', {
        title    = 'Pizzacı Garfield',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'brky-legal' then
           menu.close()
           veranim()
           exports['sway_taskbar']:taskBar(3000, "Malzemelere Bakılıyor!")
           veranim()
            TriggerServerEvent("brky:pizza")
        elseif data.current.value == 'kapat' then
            menu.close()
        end
    end)
end

function Kasap()
    local elements = {
        {label = 'Sucuk Üret',   value = 'sucuk'},
        {label = 'Menü Kapat',   value = 'kapat'},

    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sucuk', {
        title    = 'Kasap Faruk',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'sucuk' then
           menu.close()
           veranim()
           exports['sway_taskbar']:taskBar(3000, "Ete Bakılıyor!")
           veranim()
            TriggerServerEvent("brky:sucuk")
        elseif data.current.value == 'kapat' then
            menu.close()
        end
    end)
end

function veranim() 
    RequestAnimDict("mp_common")
    while not HasAnimDictLoaded("mp_common")do 
        Citizen.Wait(0)
    end;b=CreateObject(GetHashKey('prop_weed_bottle'),0,0,0,true)
    AttachEntityToEntity(b,PlayerPedId(),
    GetPedBoneIndex(PlayerPedId(),57005),0.13,0.02,0.0,-90.0,0,0,1,1,0,1,0,1)
    AttachEntityToEntity(p,l,GetPedBoneIndex(l,57005),0.13,0.02,0.0,-90.0,0,0,1,1,0,1,0,1)
    TaskPlayAnim(GetPlayerPed(-1),"mp_common","givetake1_a",8.0,-8.0,-1,0,0,false,false,false)
    TaskPlayAnim(l,"mp_common","givetake1_a",8.0,-8.0,-1,0,0,false,false,false)
    Wait(1550)
    DeleteEntity(b)
    ClearPedTasks(pid)
    ClearPedTasks(l)
end

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.SellX, Config.SellY, Config.SellZ, true) < 2 then
                DrawText3D(Config.SellX, Config.SellY, 57.0, " ~g~[E] ~w~ Garfield")
                    if IsControlJustReleased(1, 51) then
                        BrkyPz()                
            end
        end
    end
 end)

 Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.EtX, Config.EtY, Config.EtZ, true) < 2 then
                DrawText3D(Config.EtX, Config.EtY, 115.30, " ~g~[E] ~w~ Kasap Faruk")
                    if IsControlJustReleased(1, 51) then
                        Kasap()                
            end
        end
    end
 end)

 function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 0, 0, 0, 100)
end

Citizen.CreateThread(function()
	Citizen.Wait(500)
    kasap = AddBlipForCoord(Config.EtX, Config.EtY, Config.EtY)
    SetBlipSprite(kasap, 480)
    SetBlipScale(kasap, 0.6)
    SetBlipColour(kasap, 1)
    SetBlipAsShortRange(kasap, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Kasap Faruk")
    EndTextCommandSetBlipName(kasap)
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)
    Garfield = AddBlipForCoord(Config.SellX, Config.SellY, Config.SellZ)
    SetBlipSprite(Garfield, 480)
    SetBlipScale(Garfield, 0.6)
    SetBlipColour(Garfield, 1)
    SetBlipAsShortRange(Garfield, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Pizzacı Garfield")
    EndTextCommandSetBlipName(Garfield)
end)
