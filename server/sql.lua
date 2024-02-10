function server_items_getAllItems()
    local result = MySQL.Sync.fetchAll("SELECT * FROM items")
    return result
end

function server_items_pickRandomItem()
    if not result then
        result = server_items_getAllItems()
    end
    local random = math.random(1, #result)
    if Chance(HasIllegalItem) then
        result[random] = getRandomIllegalItem()
        result[random].illegal = true
        return result[random]
    end
    if tableContains(Config.IllegalItems, result[random].name) then
        result[random].illegal = true
    else
        result[random].illegal = false
    end
    return result[random]
end
