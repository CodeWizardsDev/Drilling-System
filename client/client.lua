---------------- Main data ----------------
local DrillProp, DrillProp2, soundId, soundPlaying = nil, nil, nil, false

require("@wizard-lib/client/ini")

---------------- Functions ----------------
local function LS()
    RequestAmbientAudioBank("DLC_HEIST_FLEECA_SOUNDSET", 0)
    RequestAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL", 0)
    RequestAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL_2", 0)
end
local function StartDrilling(callback)
    local scaleform = LoadScaleForm("DRILLING")
    local drilling = true
    local speed = 0.0
    local temperature = 0.0
    local position = 0.0
    local success = false
    local modelHash = RequestProp(Config.DrillMinigame.Model)
    local playerPed = PlayerPedId()
    
    -- Create and attach the drill
    local DrillProp = CreateObject(modelHash, 1.0, 1.0, 1.0, true, true, false)
    SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
    local boneIndex = GetPedBoneIndex(playerPed, 28422)
    AttachEntityToEntity(DrillProp, playerPed, boneIndex, 0.0, 0, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 2, true)
    SetEntityAsMissionEntity(DrillProp, true, true)
    FreezeEntityPosition(playerPed, true)
    PlayAnimation(playerPed, Config.DrillMinigame.AnimDict, Config.DrillMinigame.Animation, -1 , 49)
    local function cleanup()
        if DrillProp then
            FreezeEntityPosition(playerPed, false)
            StopAnimTask(playerPed, Config.DrillMinigame.AnimDict, Config.DrillMinigame.Animation, 1.0)
            DetachEntity(DrillProp, true, true)
            DeleteObject(DrillProp)
            DrillProp = nil
        end
        if soundPlaying then
            StopSound(soundId)
            ReleaseSoundId(soundId)
            StopGameplayCamShaking(true)
            soundPlaying = false
        end
        for _, control in ipairs(Config.DisableControl) do
            DisableControlAction(0, control, false)
        end
        drilling = false
    end
    while drilling do
        for _, control in ipairs(Config.DisableControl) do
            DisableControlAction(0, control, true)
        end
        DrawScaleformMovie(scaleform, 0.65, 0.5, 0.7, 0.7, 0.5, 255, 255, 255, 255, 0)
        
        if IsControlPressed(0, Config.DrillMinigame.Key) then
            speed = math.min(speed + 0.1, Config.DrillMinigame.MaxSpeed)
            if not soundPlaying then
                LS()
                soundId = GetSoundId()
                PlaySoundFromEntity(soundId, "Drill", DrillProp, "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
                if Config.DrillMinigame.ShakeCam then ShakeGameplayCam("SKY_DIVING_SHAKE", Config.DrillMinigame.ShakeInt) end
                soundPlaying = true
            end  
        else
            speed = math.max(0.0, speed - 0.1)
            if soundPlaying then
                StopSound(soundId)
                ReleaseSoundId(soundId)
                StopGameplayCamShaking(true)
                soundPlaying = false
            end
        end
        temperature = temperature + (speed * 0.1)
        if not IsControlPressed(0, 172) then
            temperature = math.max(0.0, temperature - Config.DrillMinigame.CooldownRate)
        end
        position = position + (speed * 0.01)
        if temperature >= Config.DrillMinigame.MaxTemp then
            cleanup()
            success = false
        end
        if position >= 1.0 then
            cleanup()
            success = true
        end
        BeginScaleformMovieMethod(scaleform, "SET_DRILL_POSITION")
        ScaleformMovieMethodAddParamFloat(position)
        EndScaleformMovieMethod()
        BeginScaleformMovieMethod(scaleform, "SET_TEMPERATURE")
        ScaleformMovieMethodAddParamFloat(temperature)
        EndScaleformMovieMethod()
        BeginScaleformMovieMethod(scaleform, "SET_SPEED")
        ScaleformMovieMethodAddParamFloat(speed)
        EndScaleformMovieMethod()
        Wait(0)
    end
    SetScaleformMovieAsNoLongerNeeded(scaleform)
    if callback then callback(success) end
    return success
end
local function StartVault(numdis, callback)
    local scaleform = LoadScaleForm("VAULT_DRILL")
    local modelHash = RequestProp(Config.VaultMinigame.Model)
    local playerPed = PlayerPedId()
    
    -- Create and attach the vault drill prop
    local DrillProp2 = CreateObject(modelHash, 1.0, 1.0, 1.0, true, true, false)
    SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
    local boneIndex = GetPedBoneIndex(playerPed, 28422)
    AttachEntityToEntity(DrillProp2, playerPed, boneIndex, 0.0, 0, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 2, true)
    SetEntityAsMissionEntity(DrillProp2, true, true)
    FreezeEntityPosition(playerPed, true)
    PlayAnimation(playerPed, Config.VaultMinigame.AnimDict, Config.VaultMinigame.Animation, -1 , 49)
    local function cleanup()
        if DrillProp2 then
            FreezeEntityPosition(playerPed, false)
            StopAnimTask(playerPed, Config.VaultMinigame.AnimDict, Config.VaultMinigame.Animation, 1.0)
            DetachEntity(DrillProp2, true, true)
            DeleteObject(DrillProp2)
            DrillProp2 = nil
        end
        if soundPlaying then
            StopSound(soundId)
            ReleaseSoundId(soundId)
            StopGameplayCamShaking(true)
            soundPlaying = false
        end
        for _, control in ipairs(Config.DisableControl) do
            DisableControlAction(0, control, false)
        end
        drilling = false
    end
    BeginScaleformMovieMethod(scaleform, "SET_NUM_DISCS")
    ScaleformMovieMethodAddParamInt(numdis)
    EndScaleformMovieMethod()
    local active = true
    local speed = 0.0
    local temperature = 0.0
    local position = 0.0
    local success = false
    while active do
        for _, control in ipairs(Config.DisableControl) do
            DisableControlAction(0, control, true)
        end
        DrawScaleformMovie(scaleform, 0.65, 0.5, 0.7, 0.7, 255, 255, 255, 255, 0)
        -- Update drill parameters
        if IsControlPressed(0, Config.VaultMinigame.Key) then
            speed = math.min(speed + 0.1, Config.VaultMinigame.MaxSpeed)
            if not soundPlaying then
                LS()
                soundId = GetSoundId()
                PlaySoundFromEntity(soundId, "Drill", DrillProp2, "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
                if Config.VaultMinigame.ShakeCam then ShakeGameplayCam("SKY_DIVING_SHAKE", Config.VaultMinigame.ShakeInt) end
                soundPlaying = true
            end  
        else
            speed = math.max(speed - 0.1, 0.0)
            if soundPlaying then
                StopSound(soundId)
                ReleaseSoundId(soundId)
                StopGameplayCamShaking(true)
                soundPlaying = false
            end
        end
        
        -- Calculate temperature based on speed
        if speed > 0.4 then
            temperature = temperature + (speed * 0.01)
        else
            temperature = math.max(0.0, temperature - Config.VaultMinigame.CooldownRate)
        end
        
        -- Update position if not overheated
        if temperature < Config.VaultMinigame.MaxTemp then
            position = position + (speed * 0.001)
        end
        
        -- Update scaleform
        BeginScaleformMovieMethod(scaleform, "SET_SPEED")
        ScaleformMovieMethodAddParamFloat(speed)
        EndScaleformMovieMethod()
        
        BeginScaleformMovieMethod(scaleform, "SET_TEMPERATURE")
        ScaleformMovieMethodAddParamFloat(temperature)
        EndScaleformMovieMethod()
        
        BeginScaleformMovieMethod(scaleform, "SET_DRILL_POSITION")
        ScaleformMovieMethodAddParamFloat(position)
        EndScaleformMovieMethod()
        
        -- Check for completion or failure
        if position >= 1.0 then
            cleanup()
            success = true
            active = false
        elseif temperature >= Config.DrillMinigame.MaxTemp then
            cleanup()
            success = false
            active = false
        end
        Wait(0)
    end
    SetScaleformMovieAsNoLongerNeeded(scaleform)
    if callback then callback(success) end
    return success
end
local function StartLaser(numdis, callback)
    local scaleform = LoadScaleForm("VAULT_LASER")
    local modelHash = RequestProp(Config.LaserMinigame.Model)
    local playerPed = PlayerPedId()
    
    -- Create and attach the laser prop
    local LaserProp = CreateObject(modelHash, 1.0, 1.0, 1.0, true, true, false)
    SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
    local boneIndex = GetPedBoneIndex(playerPed, 28422)
    AttachEntityToEntity(LaserProp, playerPed, boneIndex, 0.0, 0, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 2, true)
    SetEntityAsMissionEntity(LaserProp, true, true)
    FreezeEntityPosition(playerPed, true)
    PlayAnimation(playerPed, Config.LaserMinigame.AnimDict, Config.LaserMinigame.Animation, -1 , 49)
    local function cleanup()
        if LaserProp then
            FreezeEntityPosition(playerPed, false)
            StopAnimTask(playerPed, Config.LaserMinigame.AnimDict, Config.LaserMinigame.Animation, 1.0)
            DetachEntity(LaserProp, true, true)
            DeleteObject(LaserProp)
            LaserProp = nil
        end
        StopGameplayCamShaking(true)
        for _, control in ipairs(Config.DisableControl) do
            DisableControlAction(0, control, false)
        end
        drilling = false
    end
    BeginScaleformMovieMethod(scaleform, "SET_NUM_DISCS")
    ScaleformMovieMethodAddParamInt(numdis)
    EndScaleformMovieMethod()
    BeginScaleformMovieMethod(scaleform, "SET_LASER_VISIBLE")
    ScaleformMovieMethodAddParamInt(true)
    EndScaleformMovieMethod()
    local active = true
    local speed = 0.0
    local temperature = 0.0
    local position = 0.0
    local success = false
    while active do
        for _, control in ipairs(Config.DisableControl) do
            DisableControlAction(0, control, true)
        end
        DrawScaleformMovie(scaleform, 0.65, 0.5, 0.7, 0.7, 255, 255, 255, 255, 0)
        -- Update drill parameters
        if IsControlPressed(0, Config.LaserMinigame.Key) then
            speed = math.min(speed + 0.1, Config.LaserMinigame.MaxSpeed)
            if Config.LaserMinigame.ShakeCam then ShakeGameplayCam("SKY_DIVING_SHAKE", Config.LaserMinigame.ShakeInt) end
        else
            speed = math.max(speed - 0.1, 0.0)
            StopGameplayCamShaking(true)
        end
        
        -- Calculate temperature based on speed
        if speed > 0.4 then
            temperature = temperature + (speed * 0.004)
        else
            temperature = math.max(0.0, temperature - Config.LaserMinigame.CooldownRate)
        end
        
        -- Update position if not overheated
        if temperature < Config.LaserMinigame.MaxTemp then
            position = position + (speed * 0.001)
        end
        
        -- Update scaleform
        BeginScaleformMovieMethod(scaleform, "SET_SPEED")
        ScaleformMovieMethodAddParamFloat(speed)
        EndScaleformMovieMethod()
        
        BeginScaleformMovieMethod(scaleform, "SET_TEMPERATURE")
        ScaleformMovieMethodAddParamFloat(temperature)
        EndScaleformMovieMethod()
        
        BeginScaleformMovieMethod(scaleform, "SET_DRILL_POSITION")
        ScaleformMovieMethodAddParamFloat(position)
        EndScaleformMovieMethod()
        
        -- Check for completion or failure
        if position >= 1.0 then
            cleanup()
            success = true
            active = false
        elseif temperature >= Config.DrillMinigame.MaxTemp then
            cleanup()
            success = false
            active = false
        end
        Wait(0)
    end
    SetScaleformMovieAsNoLongerNeeded(scaleform)
    if callback then callback(success) end
    return success
end


---------------- Exports ----------------
exports('StartDrilling', StartDrilling)
exports('StartLaser', StartLaser)
exports('StartVault', StartVault)


---------------- Exports Examples ----------------
RegisterCommand('drillgame', function()
    exports['wizard-drilling']:StartDrilling(function(success)
        if success then
            TriggerEvent('chat:addMessage', {
                color = {0, 255, 0},
                args = {'Wizard Drilling', locale('success.success')}
            })
        else
            TriggerEvent('chat:addMessage', {
                color = {255, 0, 0},
                args = {'Wizard Drilling', locale('error.failed')}
            })
        end
    end)
end, false)
RegisterCommand('drillgame2', function()
    exports['wizard-drilling']:StartVault(4, function(success)
        if success then
            TriggerEvent('chat:addMessage', {
                color = {0, 255, 0},
                args = {'Wizard Drilling', locale('success.success')}
            })
        else
            TriggerEvent('chat:addMessage', {
                color = {255, 0, 0},
                args = {'Wizard Drilling', locale('error.failed')}
            })
        end
    end)
end, false)
RegisterCommand('lasergame', function()
    exports['wizard-drilling']:StartLaser(4, function(success)
        if success then
            TriggerEvent('chat:addMessage', {
                color = {0, 255, 0},
                args = {'Wizard Drilling', locale('success.success')}
            })
        else
            TriggerEvent('chat:addMessage', {
                color = {255, 0, 0},
                args = {'Wizard Drilling', locale('error.failed')}
            })
        end
    end)
end, false)