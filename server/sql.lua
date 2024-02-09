function server_items_getAllItems()
    local result = MYSQL.Sync.fetchAll('SELECT * FROM items')
    return result
end

function server_items_pickRandomItem()
    if not result then
        server_items_getAllItems()
    end
    local random = math.random(1, #result)
    return result[random]
end
