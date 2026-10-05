-- MaDsLootBodyPlus Addon
local AddonName, Addon = ...

-- State
local isEnabled = false
local isLootPassEnabled = false

-- The Main Frame for Events and UI
local frame = CreateFrame("Frame", "MaDsLootBodyPlusFrame", UIParent, "BasicFrameTemplateWithInset")
frame:SetSize(280, 180)
frame:SetPoint("CENTER")
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
frame:Hide() -- Hidden by default

-- Title Text
frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
frame.title:SetPoint("CENTER", frame.TitleBg, "CENTER", 0, 0)
frame.title:SetText("MaDsLootBodyPlus")

-- Auto Accept Section
local autoAcceptText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
autoAcceptText:SetPoint("TOP", frame, "TOP", 0, -35)

local toggleBtn = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
toggleBtn:SetPoint("TOP", autoAcceptText, "BOTTOM", 0, -5)
toggleBtn:SetSize(150, 25)

-- Loot Pass Section
local lootText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
lootText:SetPoint("TOP", toggleBtn, "BOTTOM", 0, -15)

local lootToggleBtn = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
lootToggleBtn:SetPoint("TOP", lootText, "BOTTOM", 0, -5)
lootToggleBtn:SetSize(150, 25)

-- Helper to Update UI based on state
local function UpdateUI()
    if isEnabled then
        autoAcceptText:SetText("Auto-Accept (Res/Summon): |cff00ff00Enabled|r")
        toggleBtn:SetText("Disable Auto-Accept")
    else
        autoAcceptText:SetText("Auto-Accept (Res/Summon): |cffff0000Disabled|r")
        toggleBtn:SetText("Enable Auto-Accept")
    end

    if isLootPassEnabled then
        lootText:SetText("Auto-Pass All Loot: |cff00ff00Enabled|r")
        lootToggleBtn:SetText("Disable Auto-Pass")
    else
        lootText:SetText("Auto-Pass All Loot: |cffff0000Disabled|r")
        lootToggleBtn:SetText("Enable Auto-Pass")
    end
end

-- Button Click Handlers
toggleBtn:SetScript("OnClick", function()
    isEnabled = not isEnabled
    UpdateUI()
    print("|cff00ff00[MaDsLootBodyPlus]|r Auto-Accept is now " .. (isEnabled and "Enabled" or "Disabled"))
end)

lootToggleBtn:SetScript("OnClick", function()
    isLootPassEnabled = not isLootPassEnabled
    UpdateUI()
    print("|cff00ff00[MaDsLootBodyPlus]|r Auto-Pass Loot is now " .. (isLootPassEnabled and "Enabled" or "Disabled"))
end)

-- Event Handling
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("RESURRECT_REQUEST")
eventFrame:RegisterEvent("CONFIRM_SUMMON")
eventFrame:RegisterEvent("START_LOOT_ROLL")

eventFrame:SetScript("OnEvent", function(self, event, arg1, ...)
    if event == "ADDON_LOADED" and arg1 == AddonName then
        UpdateUI()
        self:UnregisterEvent("ADDON_LOADED")
    
    elseif event == "RESURRECT_REQUEST" then
        if isEnabled then
            C_Timer.After(10, function()
                if isEnabled then
                    AcceptResurrect()
                    StaticPopup_Hide("RESURRECT_NO_SICKNESS")
                    StaticPopup_Hide("RESURRECT_NO_TIMER")
                    StaticPopup_Hide("RESURRECT")
                end
            end)
        end

    elseif event == "CONFIRM_SUMMON" then
        if isEnabled then
            C_Timer.After(10, function()
                if isEnabled then
                    C_SummonInfo.ConfirmSummon()
                    StaticPopup_Hide("CONFIRM_SUMMON")
                end
            end)
        end

    elseif event == "START_LOOT_ROLL" then
        if isLootPassEnabled then
            local rollID = arg1
            RollOnLoot(rollID, 0) -- 0 corresponds to 'Pass'
        end
    end
end)

-- Slash Commands
SLASH_MADSLOOTBODYPLUS1 = "/lb"
SlashCmdList["MADSLOOTBODYPLUS"] = function(msg)
    msg = string.lower(msg or "")
    if msg == "enable" then
        isEnabled = true
        isLootPassEnabled = true
        UpdateUI()
        print("|cff00ff00[MaDsLootBodyPlus]|r All Features Enabled")
    elseif msg == "disable" then
        isEnabled = false
        isLootPassEnabled = false
        UpdateUI()
        print("|cff00ff00[MaDsLootBodyPlus]|r All Features Disabled")
    else
        -- Toggle Window
        if frame:IsShown() then
            frame:Hide()
        else
            frame:Show()
            UpdateUI()
        end
    end
end
