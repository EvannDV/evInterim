ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)
RegisterNetEvent('ev:SetJob')
AddEventHandler('ev:SetJob', function(label, job)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.setJob(job, 0)
    TriggerClientEvent('esx:showNotification', source, "Vous venez d'être recruté en tant que ~y~"..label)
end)