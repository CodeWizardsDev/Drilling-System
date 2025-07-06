--  ┍━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┑
--  │                                                                                                     │
--  │     ░█████╗░░█████╗░██████╗░███████╗  ░██╗░░░░░░░██╗██╗███████╗░█████╗░██████╗░██████╗░░██████╗     │
--  │     ██╔══██╗██╔══██╗██╔══██╗██╔════╝  ░██║░░██╗░░██║██║╚════██║██╔══██╗██╔══██╗██╔══██╗██╔════╝     │
--  │     ██║░░╚═╝██║░░██║██║░░██║█████╗░░  ░╚██╗████╗██╔╝██║░░███╔═╝███████║██████╔╝██║░░██║╚█████╗░     │
--  │     ██║░░██╗██║░░██║██║░░██║██╔══╝░░  ░░████╔═████║░██║██╔══╝░░██╔══██║██╔══██╗██║░░██║░╚═══██╗     │
--  │     ╚█████╔╝╚█████╔╝██████╔╝███████╗  ░░╚██╔╝░╚██╔╝░██║███████╗██║░░██║██║░░██║██████╔╝██████╔╝     │
--  │     ░╚════╝░░╚════╝░╚═════╝░╚══════╝  ░░░╚═╝░░░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░╚═════╝░     │
--  │                                                                                                     │
--  │                                                                                                     │
--  │                                                                                                     │
--  │                                     █▀▄ █▀█ █ █░░ █░░ █ █▄░█ █▀▀                                    │
--  │                                     █▄▀ █▀▄ █ █▄▄ █▄▄ █ █░▀█ █▄█                                    │
--  │                                                                                                     │
--  └─────────────────────────────────────────────────────────────────────────────────────────────────────┘
--
--          Thank you for downloading our script! we're glad to help you to make your server better:)
--          Feel free to contact us if you have any problem/idea for this script! 

--          This file controls all settings for the Wizard Drilling System.
--          Adjust these options to fit your server's framework, inventory, UI, and gameplay needs.


--          📚 Documentation:
--              - Wiki:    https://code-wizards.gitbook.io/codewizards/drilling-system/
--              - Discord: https://discord.gg/ZBvacHyczY
--              - GitHub:  https://github.com/CodeWizardsDev


--          🛠️ Quick Reference:
--              - Minigame Settings, Controls, Key Bindings
--              - Drill, Vault, Laser Configs


--          💡 Tip: 
--              All changes require a server restart or resource restart to take effect.






Config = {}

-- Controls to disable during the minigames
Config.DisableControl = {
    24,                                    -- Attack control disabled
    30,                                    -- Move Left/Right control disabled
    31,                                    -- Move Up/Down control disabled
    44,                                    -- Cover control disabled
    199,                                   -- Pause Menu control disabled
}

-- Settings for the Drill Minigame
Config.DrillMinigame = {
    Key = 172,                             -- Key to use the Drill
    
    Model = "hei_prop_heist_drill",        -- Model of the vault drill

    AnimDict = "anim@heists@fleeca_bank@drilling", -- Animation dictionary for the drill minigame
    Animation = "drill_straight_idle",             -- Animation for the drill minigame

    MaxSpeed = 0.3,                        -- Maximum speed allowed in the drill minigame
    MaxTemp = 1.0,                         -- Maximum temperature before overheating
    CooldownRate = 0.01,                   -- Rate at which the drill cools down

    ShakeCam = true,                       -- Enable camera shake while drilling
    ShakeInt = 0.6,                        -- Shake intensity for the camera
}

-- Settings for the Vault Drill Minigame
Config.VaultMinigame = {
    Key = 172,                             -- Key to use the Drill
    
    Model = "hei_prop_heist_drill",        -- Model of the vault drill

    AnimDict = "anim@heists@fleeca_bank@drilling", -- Animation dictionary for the drill minigame
    Animation = "drill_straight_idle",             -- Animation for the drill minigame

    MaxSpeed = 0.7,                        -- Maximum speed allowed in the vault drill minigame
    MaxTemp = 1.0,                         -- Maximum temperature before overheating
    CooldownRate = 0.01,                   -- Rate at which the vault mechanism cools down

    ShakeCam = true,                       -- Enable camera shake while drilling
    ShakeInt = 0.6,                        -- Shake intensity for the camera
}

-- Settings for the Laser Minigame
Config.LaserMinigame = {
    Key = 172,                             -- Key to use the Laser
    
    Model = "ch_prop_laserdrill_01a",      -- Model of the vault drill

    AnimDict = "anim@heists@fleeca_bank@drilling", -- Animation dictionary for the drill minigame
    Animation = "drill_straight_idle",             -- Animation for the drill minigame
    
    MaxSpeed = 2.5,                        -- Maximum speed allowed in the laser minigame
    MaxTemp = 1.0,                         -- Maximum temperature before overheating
    CooldownRate = 0.01,                   -- Rate at which the laser cools down

    ShakeCam = false,                      -- Enable camera shake while using laser
    ShakeInt = 0.6,                        -- Shake intensity for the camera
}