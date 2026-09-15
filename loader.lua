--[[
    ============================================================
    Pathos Hub — Loader
    ============================================================
    Author: Noxis-spec
    GitHub: https://github.com/Noxis-spec/lithos
    Version: 1.2.0
--]]

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player  = Players.LocalPlayer

local VERSION = "1.2.0"
local BASE = "https://cdn.jsdelivr.net/gh/Noxis-spec/lithos@main/"

local gui = Instance.new("ScreenGui")
gui.Name = "PathosLoader"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = player:WaitForChild("PlayerGui")

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(8, 6, 10)
bg.BackgroundTransparency = 1
bg.BorderSizePixel = 0
bg.Parent = gui

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 30, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(8, 6, 10)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 30, 0)),
})
gradient.Rotation = 45
gradient.Parent = bg

local container = Instance.new("Frame")
container.Size = UDim2.new(0, 360, 0, 340)
container.Position = UDim2.new(0.5, -180, 0.5, -170)
container.BackgroundTransparency = 1
container.Parent = bg

local logoBg = Instance.new("Frame")
logoBg.Size = UDim2.new(0, 70, 0, 70)
logoBg.Position = UDim2.new(0.5, -35, 0, 0)
logoBg.BackgroundColor3 = Color3.fromRGB(180, 120, 20)
logoBg.BorderSizePixel = 0
logoBg.Parent = container

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(1, 0)
logoCorner.Parent = logoBg

local logoGradient = Instance.new("UIGradient")
logoGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 200, 70)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 60, 0)),
})
logoGradient.Rotation = 90
logoGradient.Parent = logoBg

local logoText = Instance.new("TextLabel")
logoText.Size = UDim2.new(1, 0, 1, 0)
logoText.BackgroundTransparency = 1
logoText.Text = "P"
logoText.TextColor3 = Color3.fromRGB(255, 255, 255)
logoText.TextSize = 38
logoText.Font = Enum.Font.GothamBlack
logoText.Parent = logoBg

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 88)
title.BackgroundTransparency = 1
title.Text = "PATHOS HUB"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 24
title.Font = Enum.Font.GothamBlack
title.Parent = container

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 16)
subtitle.Position = UDim2.new(0, 0, 0, 118)
subtitle.BackgroundTransparency = 1
subtitle.Text = "By Noxis"
subtitle.TextColor3 = Color3.fromRGB(200, 150, 80)
subtitle.TextSize = 13
subtitle.Font = Enum.Font.Gotham
subtitle.Parent = container

local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(0, 280, 0, 8)
barBg.Position = UDim2.new(0.5, -140, 0, 170)
barBg.BackgroundColor3 = Color3.fromRGB(35, 30, 25)
barBg.BorderSizePixel = 0
barBg.Parent = container

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1, 0)
barCorner.Parent = barBg

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(255, 180, 50)
barFill.BorderSizePixel = 0
barFill.Parent = barBg

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(1, 0)
fillCorner.Parent = barFill

local percentText = Instance.new("TextLabel")
percentText.Size = UDim2.new(1, 0, 0, 20)
percentText.Position = UDim2.new(0, 0, 0, 190)
percentText.BackgroundTransparency = 1
percentText.Text = "0%"
percentText.TextColor3 = Color3.fromRGB(255, 220, 100)
percentText.TextSize = 16
percentText.Font = Enum.Font.GothamBold
percentText.Parent = container

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 18)
status.Position = UDim2.new(0, 0, 0, 220)
status.BackgroundTransparency = 1
status.Text = "Initializing..."
status.TextColor3 = Color3.fromRGB(180, 180, 180)
status.TextSize = 13
status.Font = Enum.Font.Gotham
status.Parent = container

-- Version in bottom-right corner (bigger, with hub name)
local versionLabel = Instance.new("TextLabel")
versionLabel.Size = UDim2.new(0, 300, 0, 24)
versionLabel.Position = UDim2.new(1, -310, 1, -40)
versionLabel.BackgroundTransparency = 1
versionLabel.Text = "PATHOS HUB v" .. VERSION
versionLabel.TextColor3 = Color3.fromRGB(200, 150, 80)
versionLabel.TextSize = 14
versionLabel.Font = Enum.Font.GothamBold
versionLabel.TextXAlignment = Enum.TextXAlignment.Right
versionLabel.Parent = bg

-- Credits in bottom-right (below version)
local creditsLabel = Instance.new("TextLabel")
creditsLabel.Size = UDim2.new(0, 300, 0, 18)
creditsLabel.Position = UDim2.new(1, -310, 1, -22)
creditsLabel.BackgroundTransparency = 1
creditsLabel.Text = "Created by Noxis"
creditsLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
creditsLabel.TextSize = 12
creditsLabel.Font = Enum.Font.Gotham
creditsLabel.TextXAlignment = Enum.TextXAlignment.Right
creditsLabel.Parent = bg

TweenService:Create(bg, TweenInfo.new(0.4), {
    BackgroundTransparency = 0
}):Play()

task.spawn(function()
    while gui.Parent do
        local t1 = TweenService:Create(logoBg, TweenInfo.new(0.9, Enum.EasingStyle.Sine), {
            Size = UDim2.new(0, 78, 0, 78),
            Position = UDim2.new(0.5, -39, 0, -4),
        })
        t1:Play()
        t1.Completed:Wait()
        local t2 = TweenService:Create(logoBg, TweenInfo.new(0.9, Enum.EasingStyle.Sine), {
            Size = UDim2.new(0, 70, 0, 70),
            Position = UDim2.new(0.5, -35, 0, 0),
        })
        t2:Play()
        t2.Completed:Wait()
    end
end)

local function setProgress(t)
    TweenService:Create(barFill, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(t, 0, 1, 0)
    }):Play()
    percentText.Text = math.floor(t * 100) .. "%"
end

local function fetch(name)
    local url = BASE .. name
    local ok, result = pcall(function()
        return game:HttpGet(url)
    end)
    if not ok or not result or #result < 10 then
        warn("[Pathos Loader] Failed to fetch:", name)
        return nil
    end
    return result
end

task.wait(0.4)

status.Text = "Fetching main.lua..."
setProgress(0.33)
local mainCode = fetch("main.lua")

task.wait(0.3)
status.Text = "Fetching ui.lua..."
setProgress(0.66)
local uiCode = fetch("ui.lua")

task.wait(0.3)
status.Text = "Launching..."
setProgress(1)
task.wait(0.6)

local fadeOut = TweenService:Create(bg, TweenInfo.new(0.4), {
    BackgroundTransparency = 1
})
fadeOut:Play()
fadeOut.Completed:Wait()

gui:Destroy()

if mainCode then
    local ok, err = pcall(function()
        loadstring(mainCode)()
    end)
    if not ok then warn("[Pathos Loader] main.lua error:", err) end
end

if uiCode then
    local ok, err = pcall(function()
        loadstring(uiCode)()
    end)
    if not ok then warn("[Pathos Loader] ui.lua error:", err) end
end

print("[Pathos Loader] done — v" .. VERSION)