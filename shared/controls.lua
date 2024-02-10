Config = {}
-- Controls can be found here: https://docs.fivem.net/docs/game-references/controls/
-- some controls need an ID (from the website) some work from STRINGS "U" as an example. these are bound to commands,

-- all Controls that are with Letters are Keymappings, they exist ingame in the fivem settings menu for every person to change, every control that is a number is a control that cant be changed by the player in the game.
Config.Commands = {
    OpenInteractionMenu = "ludaro-pd-npc:openmenu",
    ChangeDuty = "ludaro-pd-npc:onduty",
}
Config.Controls {
    SelectPed = 38, -- E
    OpenMenu = "U", -- U
    ChangeDuty = 166, -- F5
}
