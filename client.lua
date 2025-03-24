-- main.lua
local OBX = exports['obx-core']:GetCoreObject()

--------------------------------------
-- Buyer Side: Catalog & Store Prop --
--------------------------------------

-- Opens the buyer catalog using OX_lib.
function openBuyerMenu()
    local catalogOptions = {}
    for _, recipe in ipairs(Config.Recipes) do
        table.insert(catalogOptions, {
            title = recipe.name,
            description = "Price: $" .. (recipe.price or 100),
            icon = 'fa-solid fa-chair',  -- fallback icon if image is missing
            img = recipe.img,            -- image path defined in config.lua
            onSelect = function()
                -- Trigger a server event to place an order.
                TriggerServerEvent('furniture:orderItem', recipe.name)
                OBX.Functions.Notify("Order placed for " .. recipe.name, "success")
            end,
        })
    end

    lib.registerContext({
        id = 'furniture_buyer_menu',
        title = 'Furniture Catalog',
        options = catalogOptions,
    })
    lib.showContext('furniture_buyer_menu')
end

-- Spawns the store prop at a designated location.
function spawnStoreProp()
    local storeLocation = vector3(200.0, 300.0, 40.0)  -- Change these coordinates as needed
    local storeModel = `prop_furniture_store`          -- Replace with your store prop model
    RequestModel(storeModel)
    while not HasModelLoaded(storeModel) do
        Wait(10)
    end
    local prop = CreateObject(storeModel, storeLocation.x, storeLocation.y, storeLocation.z, false, false, false)
    FreezeEntityPosition(prop, true)
    return prop
end

-- Create the store prop and register an ox_target zone for interaction.
CreateThread(function()
    local storeProp = spawnStoreProp()
    exports.ox_target:addEntityZone(storeProp, {
        name = 'furniture_store',
        options = {
            {
                name = 'open_furniture_catalog',
                icon = 'fa-solid fa-chair',
                label = 'Browse Furniture Catalog',
                onSelect = function()
                    openBuyerMenu()
                end,
            },
        },
        distance = 2.5,
    })
end)

------------------------------
-- Builder Side: Order Queue --
------------------------------

-- Opens the builder menu showing pending orders.
function openBuilderMenu(orders)
    local builderOptions = {}
    for _, order in ipairs(orders) do
        table.insert(builderOptions, {
            title = order.recipeName .. " (Order ID: " .. order.id .. ")",
            description = "Placed by: " .. order.buyer,
            icon = 'fa-solid fa-tools',
            onSelect = function()
                -- When a builder selects an order, trigger its completion.
                TriggerServerEvent('furniture:orderComplete', order.id)
            end,
        })
    end

    lib.registerContext({
        id = 'furniture_builder_menu',
        title = 'Pending Furniture Orders',
        options = builderOptions,
    })
    lib.showContext('furniture_builder_menu')
end

-- Receives the pending orders from the server.
RegisterNetEvent('furniture:client:sendPendingOrders', function(orders)
    openBuilderMenu(orders)
end)

-- Builder command to request pending orders.
RegisterCommand("furnitureorders", function()
    TriggerServerEvent('furniture:getPendingOrders')
end, false)
