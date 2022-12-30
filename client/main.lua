ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)



Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)





Citizen.CreateThread(function()
    while true do
		local wait = 750

				for k in pairs {vector3(Config.posX,Config.posY,Config.posZ)} do
				local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
				local pos = {vector3(Config.posX,Config.posY,Config.posZ)}
				local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

				if dist <= 6 then
					wait = 0
					DrawMarker(6, Config.posX,Config.posY,Config.posZ-0.99, 0.0, 0.0, 0.0, -90, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 170, 0, 1, 2, 0, nil, nil, 0)  
				end

				if dist <= 1.0 then
					wait = 0
					
					RageUI.Text({ message = "[~b~E~s~] pour parler à betty", time_display = 1 })
					if IsControlJustPressed(1,51) then
						evItnetrim()
					end
				end

		end
    Citizen.Wait(wait)
    end
end)




-------------Menu



function evItnetrim()
    local evItnetrimMenu = RageUI.CreateMenu("Agence", Config.UrServ)
    RageUI.Visible(evItnetrimMenu, not RageUI.Visible(evItnetrimMenu))
    while evItnetrimMenu do
        Citizen.Wait(0)
        RageUI.IsVisible(evItnetrimMenu,true,true,true,function()

            RageUI.Separator("↓     ~g~Métiers Libres~s~     ↓")
            for k,v in pairs(evInterim) do
                RageUI.ButtonWithStyle("~g~→~s~ "..v.label, nil, {RightLabel = "→→"}, true,function(h,a,s)
                    if s then
                        local label = v.label
                        local job = v.job
                        TriggerServerEvent('ev:SetJob', label, job)	
                    end
                
                end)
            end
        
        end, function()
        end)
        if not RageUI.Visible(evItnetrimMenu) then
            evItnetrimMenu=RMenu:DeleteType("Delete", true)
        end

    end

end









--------------PED

Citizen.CreateThread(function()
    local hash = GetHashKey("cs_molly")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
      Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "cs_molly", Config.posXped, Config.posYped, Config.posZped-1, Config.pedH, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
end)



-------Blips


Citizen.CreateThread(function()
    local InterimBlip = AddBlipForCoord(vector3(Config.posX, Config.posY, Config.posZ))
    SetBlipSprite(InterimBlip, 590)
    SetBlipColour(InterimBlip, 43)
    SetBlipScale(InterimBlip, 0.8)
    SetBlipAsShortRange(InterimBlip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Agence d'intérim")
    EndTextCommandSetBlipName(InterimBlip)
end)

