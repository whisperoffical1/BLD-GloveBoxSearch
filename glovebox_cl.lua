local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("qb-glovebox:searchVehicle", function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local vehicle = QBCore.Functions.GetClosestVehicle(pos)

    if vehicle then
        local plate = GetVehicleNumberPlateText(vehicle)
        QBCore.Functions.TriggerCallback("qb-glovebox:search", function(result)
            if result.success then
                QBCore.Functions.Notify(result.message, "success")
            else
                QBCore.Functions.Notify(result.message, "error")
            end
        end, plate)
    else
        QBCore.Functions.Notify("No vehicle nearby to search!", "error")
    end
end)

-- Add a keybind or command
RegisterCommand("searchcar", function()
    TriggerEvent("qb-glovebox:searchVehicle")
end, false)
