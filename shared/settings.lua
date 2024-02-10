Config.Policejobs = { "police", "sherriff" } -- Jobs that can use the menu
Config.ShowIllegalWeapons = true             -- Show illegal weapons in the menu
Config.ShowIllegalItems = true               -- Show illegal items in the menu
Config.PoliceStations = {                    -- Police stations
    ["LSPD"] = {                             -- Name of the police station
        coords = vector4(459.0788, -1007.7595, 28.2599, 125.4730),
        blip = {
            id = 60,
            color = 38,
            label = "LSPD"
        },
        jail = {
            coords = vector4(459.0788, -1007.7595, 27.8599, 125.4730),
            marker = {
                type = 22,
                color = { r = 0, g = 0, b = 255, a = 255 },
                scale = { x = 1.0, y = 1.0, z = 1.0 }
            },
            blip = {
                id = 60,
                color = 38,
                label = "LSPD Jail"
            },
            reward = 2000,  -- Reward for jailing someone
            penalty = 2000, -- Penalty for jailing someone wrong
        }

    }
}

Config.SelectPedLength = 0.5                         -- Time to hold E to select a ped (in seconds)

Config.IllegalItems = { "cannabis", "meth", "weed" } -- spawnname of the item

Config.Weapons = {                                   -- Info: they dont have the weapons, they just have them in an imaginary inventory of theirs. :)
    { name = "WEAPON_PISTOL",       label = "Pistol",        illegal = true },
    { name = "WEAPON_COMBATPISTOL", label = "Combat Pistol", illegal = false },
    { name = "WEAPON_APPISTOL",     label = "AP Pistol",     illegal = false },
    { name = "WEAPON_PISTOL50",     label = "Pistol .50",    illegal = false },
    { name = "WEAPON_SNSPISTOL",    label = "SNS Pistol",    illegal = false },
    { name = "WEAPON_HEAVYPISTOL",  label = "Heavy Pistol",  illegal = false },
}
Config.Licenses = { -- not usable rn.
    ["weapon"] = "weapon",
    ["driver"] = "driver"
}
