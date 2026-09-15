--[[
    Pathos / Lithos — Main Logic
    Author: Noxis-spec
    Version: 1.0.0

    FLAGS:
      OreESP, FastMine, AutoMine, Speed, Noclip, Fullbright
--]]

if not game:IsLoaded() then game.Loaded:Wait() end

local Players    = game:GetService("Players")
local Workspace  = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local player     = Players.LocalPlayer

_G.PathosFlags = _G.PathosFlags or {
    OreESP     = false,
    FastMine   = false,
    AutoMine   = false,
    Speed      = false,
    Noclip     = false,
    Fullbright = false,
}
local Flags = _G.PathosFlags

-- Цвета для каждого типа руды
local ORE_COLORS = {
    Coal   = Color3.fromRGB(100, 100, 100),
    Copper = Color3.fromRGB(220, 130, 70),
    Iron   = Color3.fromRGB(200, 200, 220),
    Nickel = Color3.fromRGB(180, 180, 180),
    Zinc   = Color3.fromRGB(140, 160, 180),
    Slate  = Color3.fromRGB(80, 80, 90),
    Rock   = Color3.fromRGB(120, 120, 120),
}

-- ============================================================
-- ORE ESP
-- ============================================================
local oreCache = {}

local function applyOreESP(model)
    if oreCache[model] then return end
    if not model:IsA("Model") then return end
    local color = ORE_COLORS[model.Name] or Color3.fromRGB(255, 255, 0)
    local hl = Instance.new("Highlight")
    hl.FillColor = color
    hl.OutlineColor = color
    hl.FillTransparency = 1
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Adornee = model
    hl.Parent = game:GetService("CoreGui")
    oreCache[model] = hl
end

task.spawn(function()
    while task.wait(1) do
        if Flags.OreESP then
            pcall(function()
                local oresFolder = Workspace:FindFirstChild("Ores")
                if oresFolder then
                    for _, m in ipairs(oresFolder:GetChildren()) do
                        if m:IsA("Model") then applyOreESP(m) end
                    end
                end
            end)
            for model, hl in pairs(oreCache) do
                if not model.Parent or not hl.Parent then
                    pcall(function() hl:Destroy() end)
                    oreCache[model] = nil
                end
            end
        else
            for model, hl in pairs(oreCache) do
                pcall(function() hl:Destroy() end)
                oreCache[model] = nil
            end
        end
    end
end)

-- ============================================================
-- FAST MINE (TimeBeforeSwing = 0)
-- ============================================================
task.spawn(function()
    while task.wait(0.5) do
        if not Flags.FastMine then continue end
        pcall(function()
            local char = player.Character
            if not char then return end
            local tool = char:FindFirstChildOfClass("Tool")
            if not tool then return end
            local config = tool:FindFirstChild("Configuration")
            if config then
                local tbs = config:FindFirstChild("TimeBeforeSwing")
                if tbs then
                    tbs.Value = 0
                end
            end
        end)
    end
end)

-- ============================================================
-- AUTO MINE (trigger ProximityPrompt)
-- ============================================================
task.spawn(function()
    while task.wait(0.1) do
        if not Flags.AutoMine then continue end
        local char = player.Character
        if not char then continue end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then continue end

        pcall(function()
            local oresFolder = Workspace:FindFirstChild("Ores")
            if not oresFolder then return end

            local closest, closestDist = nil, math.huge
            for _, model in ipairs(oresFolder:GetChildren()) do
                local part = model:FindFirstChild("Ore") or model:FindFirstChildWhichIsA("BasePart")
                if part then
                    local dist = (part.Position - root.Position).Magnitude
                    if dist < closestDist then
                        closestDist = dist
                        closest = part
                    end
                end
            end

            if closest and closestDist < 15 then
                local prompt = closest:FindFirstChildOfClass("ProximityPrompt")
                if not prompt then
                    -- prompt может быть в родителе
                    prompt = closest.Parent and closest.Parent:FindFirstChildOfClass("ProximityPrompt")
                end
                if prompt then
                    prompt:InputHoldBegin()
                    task.wait(0.05)
                    prompt:InputHoldEnd()
                end
            end
        end)
    end
end)

-- ============================================================
-- SPEED / NOCLIP
-- ============================================================
RunService.RenderStepped:Connect(function()
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        if Flags.Speed then
            hum.WalkSpeed = 60
        else
            hum.WalkSpeed = 16
        end
    end
    if Flags.Noclip then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)

print("[Pathos Main] loaded")