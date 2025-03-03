local QBCore = exports['qb-core']:GetCoreObject()

local gloveboxItems = {
    { name = "tosti", label = "Tosti", chance = 100 }
}

-- Table to track searched vehicles
local searchedVehicles = {}

-- Function to randomly select an item
local function getRandomGloveboxItem()
    local randomRoll = math.random(1, 100)
    local cumulativeChance = 0

    for _, item in ipairs(gloveboxItems) do
        cumulativeChance = cumulativeChance + item.chance
        if randomRoll <= cumulativeChance then
            return item
        end
    end

    return { name = "nothing", label = "Nothing" }
end

QBCore.Functions.CreateCallback("qb-glovebox:search", function(source, cb, plate)
    local Player = QBCore.Functions.GetPlayer(source)

    -- Check if the vehicle has already been searched
    if searchedVehicles[plate] then
        cb({ success = false, message = "This vehicle's glovebox has already been searched!" })
        return
    end

    -- Optional: Check if the vehicle is owned
    local result = MySQL.Sync.fetchScalar('SELECT citizenid FROM player_vehicles WHERE plate = ?', {plate})
    if result then
        cb({ success = false, message = "This vehicle is owned and cannot be searched." })
        return
    end

    -- Get a random item
    local item = getRandomGloveboxItem()
    if item.name ~= "nothing" then
        Player.Functions.AddItem(item.name, 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item.name], "add")
    end

    -- Mark the vehicle as searched
    searchedVehicles[plate] = true

    cb({ success = true, message = "You found: " .. item.label })
end)

-- Clear the searched vehicles table on resource stop
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        searchedVehicles = {}
    end
end)
