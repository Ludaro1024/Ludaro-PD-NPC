Config.Policejobs = { "police", "sherriff" }

Config.PoliceStations = {
    ["LSPD"] = {
        coords = vector4(0, 0, 0),
        blip = {
            id = 60,
            color = 38,
            label = "LSPD"
        },
        jail = {
            coords = vector4(0, 0, 0),
            marker = {
                type = 1,
                color = { r = 0, g = 0, b = 0, a = 100 },
                scale = { x = 1.0, y = 1.0, z = 1.0 }
            },
            blip = {
                id = 60,
                color = 38,
                label = "LSPD Jail"
            },
            reward = 2000
        }

    }
}


Config.IllegalItems = { "weed", "meth" }

Config.IllegalWeapons = { "WEAPON_PISTOL" }

Config.Licenses = {
    ["weapon"] = "weapon",
    ["driver"] = "driver"
}
