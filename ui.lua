--[[
    Pathos / Lithos — UI Menu
    Author: Noxis-spec
    Version: 1.3.0
--]]

if not game:IsLoaded() then game.Loaded:Wait() end

_G.PathosFlags = _G.PathosFlags or {
    OreESP      = false,
    FastMine    = false,
    InstantMine = false,
    AutoMine    = false,
    MonsterESP  = false,
    VaseESP     = false,
    DropESP     = false,
    Speed       = false,
    Noclip      = false,
    Fullbright  = false,
}
local Flags = _G.PathosFlags

local VersionInfo = _G.PathosVersion or {
    Version = "1.3.0",
    Author  = "Noxis-spec",
    GitHub  = "github.com/Noxis-spec/lithos",
    Changelog = {},
}

local WindUI = loadstring(game:HttpGet(
    "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"
))()

local Window = WindUI:CreateWindow({
    Title       = "Pathos Hub",
    Icon        = "pickaxe",
    Author      = "By Noxis",
    Folder      = "PathosHub",
    Size        = UDim2.fromOffset(500, 520),
    Transparent = true,
    Theme       = "Dark",
    Resizable   = true,
})

-- ============================================================
-- MINING TAB
-- ============================================================
local MineTab = Window:Tab({ Title = "Mining", Icon = "pickaxe" })

MineTab:Toggle({
    Title    = "Ore ESP",
    Desc     = "Highlight all ores through walls",
    Icon     = "eye",
    Value    = false,
    Callback = function(state) Flags.OreESP = state end,
})

MineTab:Toggle({
    Title    = "Fast Mine",
    Desc     = "Remove pickaxe swing delay",
    Icon     = "zap",
    Value    = false,
    Callback = function(state) Flags.FastMine = state end,
})

MineTab:Toggle({
    Title    = "Instant Mine",
    Desc     = "Break any ore in one hit",
    Icon     = "hammer",
    Value    = false,
    Callback = function(state) Flags.InstantMine = state end,
})

MineTab:Toggle({
    Title    = "Auto Mine",
    Desc     = "Automatically mine nearest ore",
    Icon     = "cog",
    Value    = false,
    Callback = function(state) Flags.AutoMine = state end,
})

-- ============================================================
-- ESP TAB
-- ============================================================
local EspTab = Window:Tab({ Title = "ESP", Icon = "scan" })

EspTab:Toggle({
    Title    = "Monster ESP",
    Desc     = "Red outline around monsters",
    Icon     = "skull",
    Value    = false,
    Callback = function(state) Flags.MonsterESP = state end,
})

EspTab:Toggle({
    Title    = "Vase ESP",
    Desc     = "Yellow outline around vases",
    Icon     = "box",
    Value    = false,
    Callback = function(state) Flags.VaseESP = state end,
})

EspTab:Toggle({
    Title    = "Drop ESP",
    Desc     = "Green outline around dropped items",
    Icon     = "package",
    Value    = false,
    Callback = function(state) Flags.DropESP = state end,
})

-- ============================================================
-- MISC TAB
-- ============================================================
local MiscTab = Window:Tab({ Title = "Misc", Icon = "settings-2" })

MiscTab:Toggle({
    Title    = "Speed",
    Desc     = "Move faster than normal",
    Icon     = "wind",
    Value    = false,
    Callback = function(state) Flags.Speed = state end,
})

MiscTab:Toggle({
    Title    = "Noclip",
    Desc     = "Walk through walls",
    Icon     = "ghost",
    Value    = false,
    Callback = function(state) Flags.Noclip = state end,
})

MiscTab:Toggle({
    Title    = "Fullbright",
    Desc     = "Brighten the entire map",
    Icon     = "sun",
    Value    = false,
    Callback = function(state)
        Flags.Fullbright = state
        local lighting = game:GetService("Lighting")
        if state then
            lighting.Ambient = Color3.fromRGB(255, 255, 255)
            lighting.Brightness = 2
        else
            lighting.Ambient = Color3.fromRGB(70, 70, 70)
            lighting.Brightness = 1
        end
    end,
})

-- ============================================================
-- INFO TAB (version, changelog, credits)
-- ============================================================
local InfoTab = Window:Tab({ Title = "Info", Icon = "info" })

InfoTab:Paragraph({
    Title = "Pathos Hub",
    Desc  = "Version " .. VersionInfo.Version ..
            "\nAuthor: " .. VersionInfo.Author ..
            "\nGitHub: " .. VersionInfo.GitHub,
})

InfoTab:Divider()

InfoTab:Paragraph({
    Title = "Changelog",
    Desc  = "Latest changes — see below for each version.",
})

InfoTab:Divider()

-- Build changelog text from VersionInfo.Changelog
local changelogText = ""
for ver, data in pairs(VersionInfo.Changelog) do
    changelogText = changelogText .. "[" .. ver .. "]\n"
    if data.Added then
        for _, item in ipairs(data.Added) do
            changelogText = changelogText .. "  + " .. item .. "\n"
        end
    end
    if data.Changed then
        for _, item in ipairs(data.Changed) do
            changelogText = changelogText .. "  ~ " .. item .. "\n"
        end
    end
    if data.Fixed then
        for _, item in ipairs(data.Fixed) do
            changelogText = changelogText .. "  * " .. item .. "\n"
        end
    end
    changelogText = changelogText .. "\n"
end

InfoTab:Paragraph({
    Title = "Changes",
    Desc  = changelogText,
})

InfoTab:Divider()

InfoTab:Paragraph({
    Title = "Legend",
    Desc  = "+ Added   ~ Changed   * Fixed",
})

InfoTab:Divider()

InfoTab:Paragraph({
    Title = "Credits",
    Desc  = "Creator: Noxis-spec" ..
            "\nScript Logic: Noxis-spec" ..
            "\nUI Design: Noxis-spec + WindUI by Footagesus" ..
            "\nTesting: Noxis-spec",
})

InfoTab:Divider()

InfoTab:Paragraph({
    Title = "Warning",
    Desc  = "Use on alternate accounts only. Exploiting violates Roblox ToS.",
})

print("[Pathos Hub] UI loaded — v" .. VersionInfo.Version)