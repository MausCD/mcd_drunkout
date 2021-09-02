local isdrunk = false
local dunkstatus = 0
local message = 0
local message2 = 0
local message3 = 0
local isdrunkout = 0
-- drunkmax ist 1 000 000
Citizen.CreateThread(function(source)	
    while true do
        Citizen.Wait(0)
        ped = GetPlayerPed(-1)
        TriggerEvent('esx_status:getStatus', 'drunk', function(status)
            dunkstatus = status.val
        end)
        if(dunkstatus >= 800000) then
        SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, true, true, false)
        if(isdrunkout == 0) then
        isdrunkout = 1
        TriggerEvent('mcd_drunkout:openGUI')
        end
        if(message3 == 0) then
            message3 = 1
            TriggerEvent('chat:addMessage', {
                color = { 255, 0, 0},
                multiline = true,
                args = {"Life-V", _U('drunktomutch1')}
            })
            end
        elseif(dunkstatus >= 700000) then
        SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, true, true, false)
        if(isdrunkout == 1) then
            isdrunkout = 0
            TriggerEvent('mcd_drunkout:closeGUI')
        end
        if(message == 0) then
        message = 1
        TriggerEvent('pNotify:SendNotification', {
            text = {_U('drunktext1')}
        })
        end


        if(message2 == 0) then
        message2 = 1
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = true,
            args = {"Life-V", _U('drunktomutch2')}
        })
        end
        else
        message = 0
        message2 = 0
        message3 = 0
        if(isdrunkout == 1) then
            isdrunkout = 0
            TriggerEvent('mcd_drunkout:closeGUI')
        end
        end
    end
end)

RegisterCommand("drunkstatus", function()
    print(isdrunkout)
    print(dunkstatus)
    TriggerEvent('pNotify:SendNotification', {
        text = {dunkstatus}
    })
end, false)

RegisterNetEvent('mcd_drunkout:openGUI')
AddEventHandler('mcd_drunkout:openGUI', function()
    SetNuiFocus(false,false)
    SendNUIMessage({type = 'opendrunkout'})
end)   

RegisterNetEvent('mcd_drunkout:closeGUI')
AddEventHandler('mcd_drunkout:closeGUI', function()
    SendNUIMessage({type = 'closedrunkout'})
end)