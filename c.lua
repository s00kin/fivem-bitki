ESX = nil
CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(15)
    end

    Citizen.Wait(5000)
    PlayerData = ESX.GetPlayerData()
end)


RegisterNetEvent('zlomus:sokin')
AddEventHandler('zlomus:sokin', function(source, player, org, orglabel, secondorg, secondorglabel)
    local elements = {
        {label = 'Wysłane przez: '..player},
        {label = orglabel..' wygrało?'},
        {label = '<font color=green>Wygrało</font>', value = 'win'},
        {label = '<font color=red>Anuluj</font>', value = 'cancel'},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'wonrequest', {
        title    = 'Bitka - '..orglabel,
        align    = 'center',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'win' then
            exports['screenshot-basic']:requestScreenshotUploadImgur(function(status)
            end, function(data)
                local response = json.decode(data)
                TriggerServerEvent('sokin:zlomus_serverwonrequest', source, org, orglabel, secondorg, secondorglabel, response.data.link)
            end)
            menu.close()
        elseif data.current.value == 'cancel' then
            menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)
end)