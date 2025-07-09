-- Hitbox, ESP Box, Chams UI by Luminaprojects
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Global Config
_G.HeadSize = 50
_G.Disabled = true

-- UI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "ESP_Hitbox_UI"
gui.ResetOnSpawn = false

-- Main Frame
local frame = Instance.new("Frame", gui)
frame.Position = UDim2.new(0.5, -175, 0.5, -150)
frame.Size = UDim2.new(0, 350, 0, 240)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -40, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.Text = "🎯 ESP MENU - Luminaprojects"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left

-- Minimize
local minimize = Instance.new("TextButton", frame)
minimize.Size = UDim2.new(0, 30, 0, 30)
minimize.Position = UDim2.new(1, -35, 0, 5)
minimize.Text = "-"
minimize.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimize.TextColor3 = Color3.new(1, 1, 1)
minimize.BorderSizePixel = 0

local container = Instance.new("Frame", frame)
container.Position = UDim2.new(0, 0, 0, 40)
container.Size = UDim2.new(1, 0, 1, -50)
container.BackgroundTransparency = 1

-- Toggle Button Creator
local function createToggle(text, callback)
    local toggle = Instance.new("TextButton", container)
    toggle.Size = UDim2.new(1, -20, 0, 30)
    toggle.Position = UDim2.new(0, 10, 0, #container:GetChildren() * 35 - 10)
    toggle.Text = text .. " 😳: OFF"
    toggle.TextColor3 = Color3.new(1, 1, 1)
    toggle.BackgroundColor3 = Color3.fromRGB(40,40,40)
    toggle.Font = Enum.Font.Gotham
    toggle.TextSize = 16
    toggle.BorderSizePixel = 0
    local state = false

    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.Text = text .. " 😳: " .. (state and "ON" or "OFF")
        callback(state)
    end)
end

-- ESP BOX
createToggle("ESP Box", function(state)
    if state then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local esp = Instance.new("BoxHandleAdornment", player.Character)
                esp.Adornee = player.Character.HumanoidRootPart
                esp.AlwaysOnTop = true
                esp.ZIndex = 5
                esp.Size = Vector3.new(4, 6, 1)
                esp.Transparency = 0.5
                esp.Color3 = Color3.new(0, 0.7, 1)
                esp.Name = "ESPBox"
            end
        end
    else
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character then
                local old = p.Character:FindFirstChild("ESPBox")
                if old then old:Destroy() end
            end
        end
    end
end)

-- ESP CHAMS
createToggle("ESP Chams", function(state)
    if state then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                for _, part in ipairs(p.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.Material = Enum.Material.Neon
                        part.Color = Color3.fromRGB(255, 100, 100)
                    end
                end
            end
        end
    else
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                for _, part in ipairs(p.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.Material = Enum.Material.Plastic
                        part.Color = Color3.fromRGB(255, 255, 255)
                    end
                end
            end
        end
    end
end)

-- HITBOX TOGGLE
createToggle("Hitbox Expander", function(state)
    _G.Disabled = state
end)

-- CUSTOM SIZE
local input = Instance.new("TextBox", container)
input.Size = UDim2.new(1, -20, 0, 25)
input.Position = UDim2.new(0, 10, 0, #container:GetChildren() * 35)
input.PlaceholderText = "Custom HeadSize (default: 10)"
input.BackgroundColor3 = Color3.fromRGB(60,60,60)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(_G.HeadSize)
input.ClearTextOnFocus = false
input.Font = Enum.Font.Gotham
input.TextSize = 14

input.FocusLost:Connect(function()
    local size = tonumber(input.Text)
    if size then
        _G.HeadSize = size
    end
end)

-- Hitbox Script
RunService.RenderStepped:Connect(function()
    if _G.Disabled then
        for _, v in pairs(Players:GetPlayers()) do
            if v.Name ~= LocalPlayer.Name then
                pcall(function()
                    local part = v.Character and v.Character:FindFirstChild("HumanoidRootPart")
                    if part then
                        part.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
                        part.Transparency = 0.7
                        part.BrickColor = BrickColor.new("Really blue")
                        part.Material = Enum.Material.Neon
                        part.CanCollide = false
                    end
                end)
            end
        end
    end
end)

-- Minimize
local minimized = false
minimize.MouseButton1Click:Connect(function()
    if minimized then
        frame:TweenSize(UDim2.new(0, 350, 0, 240), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
    else
        frame:TweenSize(UDim2.new(0, 350, 0, 50), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
    end
    minimized = not minimized
end)
