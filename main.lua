--[[
    Pathos / Lithos — Main Logic
    Author: Noxis-spec
    Version: 1.2.0
--]]

if not game:IsLoaded() then game.Loaded:Wait() end

local Players    = game:GetService("Players")
local Workspace  = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local player     = Players.LocalPlayer

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

local ORE_COLORS = {
    Coal   = Color3.fromRGB(100, 100, 100),
    Copper = Color3.fromRGB(220, 130, 70),
    Iron   = Color3.fromRGB(200, 200, 220),
    Nickel = Color3.fromRGB(180, 180, 180),
    Zinc   = Color3.fromRGB(140, 160, 180),
    Slate  = Color3.fromRGB(80, 80, 90),
    Rock   = Color3.fromRGB(120, 120, 120),
    Dirt   = Color3.fromRGB(130, 100, 70),
}

local espCache = {}

local function applyESP(model, color)
    if espCache[model] then return end
    if not model or not model:IsA("Model") then return end
    local hl = Instance.new("Highlight")
    hl.FillColor = color
    hl.OutlineColor = color
    hl.FillTransparency = 1
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Adornee = model
    hl.Parent = game:GetService("CoreGui")
    espCache[model] = hl
end

local function cleanESP()
    for model, hl in pairs(espCache) do
        if not model.Parent or not hl.Parent then
            pcall(function() hl:Destroy() end)
            espCache[model] = nil
        end
    end
end

task.spawn(function()
    while task.wait(1) do
        if Flags.OreESP then
            pcall(function()
                local oresFolder = Workspace:FindFirstChild("Ores")
                if oresFolder then
                    for _, m in ipairs(oresFolder:GetChildren()) do
                        if m:IsA("Model") then
                            local color = ORE_COLORS[m.Name] or Color3.fromRGB(255, 255, 0)
                            applyESP(m, color)
                        end
                    end
                end
            end)
        end
        cleanESP()
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Flags.MonsterESP then
            pcall(function()
                local monsFolder = Workspace:FindFirstChild("Monsters")
                if monsFolder then
                    for _, m in ipairs(monsFolder:GetChildren()) do
                        if m:IsA("Model") then
                            applyESP(m, Color3.fromRGB(255, 0, 0))
                        end
                    end
                end
            end)
        end
        cleanESP()
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Flags.VaseESP then
            pcall(function()
                local vasesFolder = Workspace:FindFirstChild("Vases")
                if vasesFolder then
                    for _, m in ipairs(vasesFolder:GetChildren()) do
                        if m:IsA("Model") then
                            applyESP(m, Color3.fromRGB(255, 220, 0))
                        end
                    end
                end
            end)
        end
        cleanESP()
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Flags.DropESP then
            pcall(function()
                local dropFolder = Workspace:FindFirstChild("DroppedMaterials")
                if dropFolder then
                    for _, m in ipairs(dropFolder:GetChildren()) do
                        if m:IsA("Model") then
                            applyESP(m, Color3.fromRGB(0, 255, 100))
                        end
                    end
                end
            end)
        end
        cleanESP()
    end
end)

local function patchFastMine(tool)
    if not tool or not tool:IsA("Tool") then return end
    pcall(function()
        local config = tool:FindFirstChild("Configuration")
        if config then
            local tbs = config:FindFirstChild("TimeBeforeSwing")
            if tbs then tbs.Value = 0 end
        end
        local tbs2 = tool:FindFirstChild("TimeBeforeSwing")
        if tbs2 then tbs2.Value = 0 end
    end)
end

task.spawn(function()
    while task.wait(0.5) do
        if not Flags.FastMine then continue end
        local char = player.Character
        if char then
            local tool = char:FindFirstChildOfClass("Tool")
            if tool then patchFastMine(tool) end
        end
        local backpack = player:FindFirstChild("Backpack")
        if backpack then
            for _, t in ipairs(backpack:GetChildren()) do
                if t:IsA("Tool") then patchFastMine(t) end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if not Flags.InstantMine then continue end
        local char = player.Character
        if not char then continue end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then continue end

        pcall(function()
            local oresFolder = Workspace:FindFirstChild("Ores")
            if not oresFolder then return end

            for _, model in ipairs(oresFolder:GetChildren()) do
                local part = model:FindFirstChildWhichIsA("BasePart")
                if part and part.Parent then
                    local dist = (part.Position - root.Position).Magnitude
                    if dist < 12 then
                        local prompt = part:FindFirstChildOfClass("ProximityPrompt")
                        if not prompt and part.Parent then
                            prompt = part.Parent:FindFirstChildOfClass("ProximityPrompt")
                        end
                        if prompt then
                            prompt.HoldDuration = 0
                            prompt:InputHoldBegin()
                            task.wait()
                            prompt:InputHoldEnd()
                        end
                    end
                end
            end
        end)
    end
end)

task.spawn(function()
    while task.wait(0.3) do
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
                local part = model:FindFirstChildWhichIsA("BasePart")
                if part and part.Parent then
                    local dist = (part.Position - root.Position).Magnitude
                    if dist < closestDist then
                        closestDist = dist
                        closest = part
                    end
                end
            end

            if closest and closestDist < 15 then
                local prompt = closest:FindFirstChildOfClass("ProximityPrompt")
                if not prompt and closest.Parent then
                    prompt = closest.Parent:FindFirstChildOfClass("ProximityPrompt")
                end
                if prompt then
                    prompt:InputHoldBegin()
                    task.wait(0.1)
                    prompt:InputHoldEnd()
                end
            end
        end)
    end
end)

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

    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") then
            if Flags.Noclip then
                p.CanCollide = false
            else
                p.CanCollide = true
            end
        end
    end
end)

print("[Pathos Main] loaded — v1.2.0")