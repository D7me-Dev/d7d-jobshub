local QBCore = exports["qb-core"]:GetCoreObject()
local ShowHub = false
local showState = {}

local function GetJobCfg(jobName)
    if not Config or not Config.Jobs then return nil end
    return Config.Jobs[jobName]
end

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    local pd = QBCore.Functions.GetPlayerData()
    local jobCfg = GetJobCfg(pd.job.name)
    if jobCfg then
        Wait(50)
        TriggerServerEvent("PoliceHub:Refresh:Server")
        -- SendNUIMessage({ action = "open", Title = jobCfg.Title, Style = jobCfg.Style })
    end
end)

AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    local pd = QBCore.Functions.GetPlayerData()
    local jobCfg = GetJobCfg(pd.job.name)
    if jobCfg then
        Wait(50)
        TriggerServerEvent("PoliceHub:Refresh:Server")
    end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    local jobCfg = GetJobCfg(job.name)
    if jobCfg then
        TriggerServerEvent("PoliceHub:Refresh:Server")
        SendNUIMessage({ action = "open", Title = jobCfg.Title, Style = jobCfg.Style })
    else
        SendNUIMessage({ action = "Hide" })
    end
end)

RegisterNetEvent('PoliceHub:Refresh:Client', function(args, Counter, title, style)
    SendNUIMessage({
        action = "Refresh",
        Data = args,
        Officers = Counter,
        Title = title,
        Style = style
    })
end)

for jobName, cfg in pairs(Config.Jobs or {}) do
    local cmd = ("%s_%s"):format(cfg.Command, jobName)
    local label = ("Toggle %s Hub"):format(jobName)
    local defaultKey = "EQUALS"

    RegisterCommand(cmd, function()
        local pd = QBCore.Functions.GetPlayerData()
        if not pd or not pd.job or pd.job.name ~= jobName then return end

        showState[jobName] = not showState[jobName]
        if showState[jobName] then
            SendNUIMessage({ action = "open", Title = cfg.Title, Style = cfg.Style })
        else
            SendNUIMessage({ action = "Hide" })
        end
    end, false)
    RegisterKeyMapping(cmd, label, "keyboard", defaultKey)
end

RegisterCommand("toggle_focus", function()
    local pd = QBCore.Functions.GetPlayerData()
    if not pd or not pd.job then return end
    if Config.Jobs[pd.job.name] then
        SetNuiFocus(true, true)
    end
end, false)
RegisterKeyMapping("toggle_focus", "Toggle Focus", "keyboard", "F11")


RegisterNUICallback('hide', function(_, cb)
    SetNuiFocus(false, false)
    cb(true)
end)

RegisterNUICallback('Duty', function()
    TriggerServerEvent('QBCore:ToggleDuty')
    TriggerServerEvent("PoliceHub:Refresh:Server")
    TriggerServerEvent("Duty:LogToggle")
    TriggerServerEvent("PoliceHub:Log", "duty")
end)

RegisterNUICallback('Commander', function()
    local pd = QBCore.Functions.GetPlayerData()
    TriggerServerEvent("PoliceHub:Commander:Add", pd.citizenid, pd.source)
    TriggerServerEvent("PoliceHub:Refresh:Server")
    TriggerServerEvent("PoliceHub:Log", "commander", { cid = pd.citizenid, src = pd.source })
end)

RegisterNUICallback('Dispatch', function()
    local pd = QBCore.Functions.GetPlayerData()
    TriggerServerEvent("PoliceHub:Disptach:Add", pd.citizenid, pd.source)
    TriggerServerEvent("PoliceHub:Refresh:Server")
    TriggerServerEvent("PoliceHub:Log", "dispatch", { cid = pd.citizenid, src = pd.source })
end)

RegisterNUICallback('Break', function()
    local pd = QBCore.Functions.GetPlayerData()
    TriggerServerEvent("PoliceHub:Break:Add", pd.citizenid, pd.source, 5)
    TriggerServerEvent("PoliceHub:Refresh:Server")
    TriggerServerEvent("PoliceHub:Log", "break", { cid = pd.citizenid, src = pd.source, minutes = 5 })
end)

RegisterNUICallback('CallSign', function()
    if lib and lib.inputDialog then
        local input = lib.inputDialog('Change Call Sign', {
            { type = 'input', label = 'New Call Sign', placeholder = 'P-1', required = true },
        })
        if input and input[1] and input[1] ~= "" then
            local newSign = tostring(input[1])
            local pd = QBCore.Functions.GetPlayerData()
            local oldSign = (pd.metadata and pd.metadata.callsign) or nil
            TriggerServerEvent("PoliceHub:Server:CallSignNew", newSign)
            TriggerServerEvent("PoliceHub:Log", "callsign", { new = newSign, old = oldSign })
        else
            TriggerServerEvent("PoliceHub:Server:CallSignNew", nil)
            TriggerServerEvent("PoliceHub:Log", "callsign", { new = nil, old = nil })
        end
    else
        TriggerServerEvent("PoliceHub:Server:CallSignNew", nil)
        TriggerServerEvent("PoliceHub:Log", "callsign", { new = nil, old = nil })
    end
    TriggerServerEvent("PoliceHub:Refresh:Server")
end)