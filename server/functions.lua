function functions_Locale(msg)
    return Config.Locales[Config.Locale][msg] or msg
end

function server_functions_setNPCName(ped, name)
    ped = NetworkGetEntityFromNetworkId(ped)
    Entity(ped).state.name = name
end

function server_functions_setNPCGender(ped, gender)
    ped = NetworkGetEntityFromNetworkId(ped)
    Entity(ped).state.gender = gender
end

function server_functions_setNPCAge(ped, age)
    ped = NetworkGetEntityFromNetworkId(ped)
    Entity(ped).state.age = age
end

function server_functions_setNPCJob(ped, job)
    ped = NetworkGetEntityFromNetworkId(ped)
    Entity(ped).state.job = job
end

function mergeTable(t1, t2)
    local exists = {}
    for _, v in ipairs(t1) do
        exists[v] = true
    end

    for _, v in ipairs(t2) do
        if not exists[v] then
            table.insert(t1, v)
            exists[v] = true
        end
    end
end

function mergeTable2(destination, source)
    for key, value in pairs(source) do
        if type(value) == "table" and type(destination[key]) == "table" then
            mergeTable(destination[key], value)
        else
            destination[key] = value
        end
    end
end

function isTableEmpty(t)
    return next(t) == nil
end

function server_functions_setNPCLicenses(ped, licenses)
    ped = NetworkGetEntityFromNetworkId(ped)
    local oldlicenses = server_functions_getNPCLicenses(ped)
    if isTableEmpty(oldlicenses) then
        Entity(ped).state.licenses = licenses
    else
        mergeTable(oldlicenses, licenses)
        Entity(ped).state.licenses = oldlicenses
    end
end

function server_functions_setNPCWeapons(ped, weapons)
    ped = NetworkGetEntityFromNetworkId(ped)
    local oldweapons = server_functions_getNPCWeapons(ped)
    if isTableEmpty(oldweapons) then
        Entity(ped).state.weapons = GetRandomWeapons()
        return Entity(ped).state.weapons
    else
        mergeTable(oldweapons, weapons)
        Entity(ped).state.weapons = oldweapons
    end
end

function server_functions_setNPCItems(ped, items)
    ped = NetworkGetEntityFromNetworkId(ped)
    local olditems = server_functions_getNPCItems(ped)
    if isTableEmpty(olditems) then
        numberofitems = math.random(10)
        for i = 1, numberofitems do
            table.insert(items, server_items_pickRandomItem())
        end
        Entity(ped).state.items = items
        return Entity(ped).state.items
    else
        mergeTable(olditems, items)
        Entity(ped).state.items = olditems
    end
end

function Chance(percent)
    return math.random(1, 100) <= percent
end

function picksomethingintablethatsnotthis(value, table)
    local newvalue = table[math.random(1, #table)]
    if newvalue == value then
        return picksomethingintablethatsnotthis(value, table)
    else
        return newvalue
    end
end

function GetRandomWeapons()
    if Chance(HasWeapons) then
        local weapons = {}
        weapons.name = {}
        local pickedWeapons = {}
        for i = 1, HowManyWeapons do
            local newWeapon
            if Chance(HasIllegalWeapon) then
                newWeapon = getRandomIllegalWeapon()
            else
                newWeapon = Config.Weapons[math.random(1, #Config.Weapons)]
            end
            if tableContains(pickedWeapons, newWeapon) then
                newWeapon = picksomethingintablethatsnotthis(newWeapon, Config.Weapons)
            end
            table.insert(weapons, newWeapon)
            table.insert(pickedWeapons, newWeapon)
        end
        return weapons
    else
        return {}
    end
end

function server_function_getIllegalNPCData(ped)
    illegalstuff = {}
    illegalstuff.weapons = {}
    illegalstuff.items = {}
    for k, v in pairs(server_functions_getNPCWeapons(ped)) do
        if v.illegal then
            table.insert(illegalstuff.weapons, v)
        end
    end

    for k, v in pairs(server_functions_getNPCItems(ped)) do
        if v.illegal then
            table.insert(illegalstuff.items, v)
        end
    end
    return illegalstuff
end

function server_functions_getNPCLicenses(ped)
    return Entity(ped).state.licenses
end

function server_functions_getNPCName(ped)
    return Entity(ped).state.name
end

function server_functions_getNPCGender(ped)
    return Entity(ped).state.gender
end

function server_functions_getNPCAge(ped)
    return Entity(ped).state.age
end

function server_functions_getNPCJob(ped)
    return Entity(ped).state.job
end

function server_functions_getNPCWeapons(ped)
    if Entity(ped).state.weapons == nil or next(Entity(ped).state.weapons) == nil then
        weapons = GetRandomWeapons()
        Entity(ped).state.weapons = weapons
        return Entity(ped).state.weapons
    end
    return Entity(ped).state.weapons
end

function server_functions_getNPCItems(ped)
    if Entity(ped).state.items == nil then
        items = {}
        numberofitems = HowManyItems
        for i = 1, numberofitems do
            table.insert(items, server_items_pickRandomItem())
        end
        Entity(ped).state.items = items
        --print(Entity(ped).state.items == nil, Entity(ped).state.items)
        return Entity(ped).state.items
    end
    return Entity(ped).state.items
end

function getRandomIllegalWeapon()
    local illegalWeapons = {}
    for _, weapon in pairs(Config.Weapons) do
        if weapon.illegal then
            table.insert(illegalWeapons, weapon)
        end
    end
    local randomIndex = math.random(1, #illegalWeapons)
    return illegalWeapons[randomIndex]
end

function getRandomIllegalItem()
    illegalItems = {}
    items = server_items_getAllItems()
    for k, v in pairs(items) do
        if tableContains(Config.IllegalItems, v.name) then
            table.insert(illegalItems, v)
        end
    end
    if #illegalItems == 0 then
        error("No illegal items found in Database! that match Config!")
    end

    if randomIndex == 1 then
        return IllegalItems[1]
    else
        local randomIndex = math.random(1, #illegalItems)
        return illegalItems[randomIndex]
    end
end
