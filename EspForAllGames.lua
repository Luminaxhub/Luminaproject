local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Create UI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "Esp for all games"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 180)
frame.Position = UDim2.new(0.5, -160, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BackgroundTransparency = 0.1
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Corner
local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -35, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.Text = "🎯 ESP Menu - Luminaprojects"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left

-- Minimize
local minimize = Instance.new("TextButton", frame)
minimize.Size = UDim2.new(0, 30, 0, 30)
minimize.Position = UDim2.new(1, -35, 0, 5)
minimize.Text = "-"
minimize.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
minimize.TextColor3 = Color3.new(1, 1, 1)
minimize.BorderSizePixel = 0
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 20

local minimized = false
local originalSize = frame.Size

minimize.MouseButton1Click:Connect(function()
    if minimized then
        TweenService:Create(frame, TweenInfo.new(0.3), {Size = originalSize}):Play()
    else
        TweenService:Create(frame, TweenInfo.new(0.3), {Size = UDim2.new(0, 320, 0, 40)}):Play()
    end
    minimized = not minimized
end)

-- Toggle Creator with Animation
local function createToggle(name, pos, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = pos
    btn.Text = name .. ": OFF"
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14

    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 6)

    local enabled = false
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        btn.Text = name .. ": " .. (enabled and "ON" or "OFF")
        local color = enabled and Color3.fromRGB(0, 200, 255) or Color3.fromRGB(45, 45, 45)
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = color}):Play()
        callback(enabled)
    end)
end

-- ESP BOX
local espBoxParts = {}
local function toggleESPBox(state)
    if state then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local box = Instance.new("BoxHandleAdornment")
                box.Adornee = player.Character.HumanoidRootPart
                box.Size = Vector3.new(6, 9, 4)
                box.Color3 = Color3.fromRGB(255, 255, 0)
                box.AlwaysOnTop = true
                box.ZIndex = 5
                box.Transparency = 0.4
                box.Name = "ESP_BOX"
                box.Parent = player.Character
                table.insert(espBoxParts, box)
            end
        end
    else
        for _, box in ipairs(espBoxParts) do
            if box and box.Parent then
                box:Destroy()
            end
        end
        espBoxParts = {}
    end
end

-- ESP CHAMS
local originalParts = {}
local function toggleChams(state)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            for _, part in ipairs(player.Character:GetChildren()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    if state then
                        originalParts[part] = {Material = part.Material, Color = part.Color}
                        part.Material = Enum.Material.ForceField
                        part.Color = Color3.fromRGB(0, 255, 255)
                        part.LocalTransparencyModifier = 0.3
                    else
                        local data = originalParts[part]
                        if data then
                            part.Material = data.Material
                            part.Color = data.Color
                            part.LocalTransparencyModifier = 0
                        end
                    end
                end
            end
        end
    end
end

-- Create Toggles
createToggle("ESP Box 😳", UDim2.new(0, 10, 0, 50), toggleESPBox)
createToggle("ESP Chams 😳", UDim2.new(0, 10, 0, 90), toggleChams)
