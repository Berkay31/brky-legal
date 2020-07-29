ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("brky:pizza")
AddEventHandler("brky:pizza", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('sucuk').count > 0 and xPlayer.getInventoryItem('domates').count > 2 and xPlayer.getInventoryItem('ketcap').count > 0 and xPlayer.getInventoryItem('hamur').count > 0 then
                xPlayer.removeInventoryItem('sucuk', 1)
                xPlayer.removeInventoryItem('domates', 3)
                xPlayer.removeInventoryItem('ketcap', 1)
                xPlayer.removeInventoryItem('hamur', 1)
                xPlayer.addInventoryItem('pizza', 1)
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '1 adet Pizza ürettin!'})
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Üzerinde yeterli malzeme yok!'})
            end
        end
    end)

RegisterNetEvent("brky:sucuk")
AddEventHandler("brky:sucuk", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('et').count > 2 then
                xPlayer.removeInventoryItem('et', 3)
                xPlayer.addInventoryItem('sucuk', 1)
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '3 adet et işledin!'})
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '1 sucuk elde ettin!'})
            elseif xPlayer.getInventoryItem('et').count < 3 then
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Üzerinde yeterli et yok!'})
            end
        end
    end)
