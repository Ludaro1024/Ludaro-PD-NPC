function functions_Locale(msg)
    return Translation[Config.Locale][msg] or msg
end

function server_functions_setNPCName(ped, name)
    Entity(ped).state.name = name
end

function server_functions_setNPCGender(ped, gender)
    Entity(ped).state.gender = gender
end

function server_functions_setNPCAge(ped, age)
    Entity(ped).state.age = age
end

function server_functions_setNPCJob(ped, job)
    Entity(ped).state.job = job
end

function server_function_getIllegalNPCData(ped)
    return Entity(ped).state.illegal or defaultillegaldata
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
    local oldlicenses = server_functions_getNPCLicenses(ped)
    if isTableEmpty(oldlicenses) then
        Entity(ped).state.licenses = licenses
    else
        mergeTable(oldlicenses, licenses)
        Entity(ped).state.licenses = oldlicenses
    end
end

local defaultillegaldata = { alcohol = 0, drugs = 0, weapons = {}, items = {} }

function server_functions_setIllegalData(ped, licenses)
    local olddata = server_function_getIllegalNPCData(ped) 

    if isTableEmpty(olddata) then
        Entity(ped).state.illegal = defaultillegaldata
    else
        mergeTable(olddata, licenses)
        Entity(ped).state.illegal = olddata
    end
end
function server_functions_getNPCLicenses(ped)
    return Entity(ped).state.licenses or nil
end

function server_functions_getNPCName(ped)
    return Entity(ped).state.name or nil
end

function server_functions_getNPCGender(ped)
    return Entity(ped).state.gender or nil
end

function server_functions_getNPCAge(ped)
    return Entity(ped).state.age or nil
end

function server_functions_getNPCJob(ped)
    return Entity(ped).state.job or nil
end
