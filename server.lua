-- server.lua
local OBX = exports['obx-core']:GetCoreObject()

-- Table to hold pending orders
local pendingOrders = {}
local orderCounter = 0

-- When a buyer places an order.
RegisterNetEvent('furniture:orderItem', function(recipeName)
    local src = source
    orderCounter = orderCounter + 1
    local order = {
        id = orderCounter,
        recipeName = recipeName,
        recipe = nil,
        buyer = src,
        status = "pending"
    }
    -- Find the recipe details from Config.Recipes
    for _, rec in ipairs(Config.Recipes) do
        if rec.name == recipeName then
            order.recipe = rec
            break
        end
    end
    table.insert(pendingOrders, order)
    print("Order ID " .. order.id .. " for " .. recipeName .. " from player " .. src .. " has been placed!")
    TriggerClientEvent('OBX:Notify', src, "Your order for " .. recipeName .. " has been placed!", "success")
end)

-- When a builder requests pending orders.
RegisterNetEvent('furniture:getPendingOrders', function()
    local src = source
    TriggerClientEvent('furniture:client:sendPendingOrders', src, pendingOrders)
end)

-- When a builder marks an order as complete.
RegisterNetEvent('furniture:orderComplete', function(orderId)
    local src = source
    local orderIndex = nil
    for index, order in ipairs(pendingOrders) do
        if order.id == orderId then
            orderIndex = index
            break
        end
    end
    if orderIndex then
        local order = table.remove(pendingOrders, orderIndex)
        print("Order ID " .. order.id .. " completed by builder " .. src)
        TriggerClientEvent('OBX:Notify', src, "Order " .. order.id .. " completed!", "success")
        -- Notify the buyer that their order is complete.
        TriggerClientEvent('OBX:Notify', order.buyer, "Your order for " .. order.recipeName .. " is complete!", "success")
    else
        TriggerClientEvent('OBX:Notify', src, "Order not found or already completed.", "error")
    end
end)
