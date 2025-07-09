--Owner luminaprojects, script by me. thanks for using
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "💫🕊️ Hitbox Expander BETA"

local frame = Instance.new("Frame", ScreenGui)
frame.Size = UDim2.new(0, 320, 0, 440)
frame.Position = UDim2.new(0.5, -160, 0.5, -220)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Minimize Button
local minimizeButton = Instance.new("TextButton", frame)
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -35, 0, 5)
minimizeButton.Text = "-"
minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.BorderSizePixel = 0

local minimized = false
local originalSize = frame.Size

minimizeButton.MouseButton1Click:Connect(function()
    if minimized then
        frame:TweenSize(originalSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
    else
        frame:TweenSize(UDim2.new(0, 320, 0, 40), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
    end
    minimized = not minimized
end)

local colorTab = Instance.new("TextButton", frame)
colorTab.Size = UDim2.new(0, 150, 0, 30)
colorTab.Position = UDim2.new(0, 5, 0, 5)
colorTab.Text = "Color Picker"
colorTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
colorTab.TextColor3 = Color3.new(1, 1, 1)
colorTab.BorderSizePixel = 0

local settingTab = Instance.new("TextButton", frame)
settingTab.Size = UDim2.new(0, 150, 0, 30)
settingTab.Position = UDim2.new(0, 165, 0, 5)
settingTab.Text = "More Setting 📜"
settingTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
settingTab.TextColor3 = Color3.new(1, 1, 1)
settingTab.BorderSizePixel = 0

local container = Instance.new("Frame", frame)
container.Position = UDim2.new(0, 0, 0, 40)
container.Size = UDim2.new(1, 0, 1, -70)
container.BackgroundTransparency = 1
container.ClipsDescendants = true

local colorContent = Instance.new("Frame", container)
colorContent.Position = UDim2.new(0, 0, 0, 0)
colorContent.Size = UDim2.new(1, 0, 1, 0)
colorContent.BackgroundTransparency = 1

local settingContent = Instance.new("Frame", container)
settingContent.Position = UDim2.new(1, 0, 0, 0)
settingContent.Size = UDim2.new(1, 0, 1, 0)
settingContent.BackgroundTransparency = 1

local searchBox = Instance.new("TextBox", colorContent)
searchBox.Size = UDim2.new(1, -20, 0, 30)
searchBox.Position = UDim2.new(0, 10, 0, 0)
searchBox.PlaceholderText = "Search color..."
searchBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
searchBox.TextColor3 = Color3.new(1, 1, 1)
searchBox.ClearTextOnFocus = false
searchBox.Text = ""

local scrollFrame = Instance.new("ScrollingFrame", colorContent)
scrollFrame.Position = UDim2.new(0, 10, 0, 40)
scrollFrame.Size = UDim2.new(1, -20, 1, -50)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.ScrollBarThickness = 6
scrollFrame.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scrollFrame)
layout.Padding = UDim.new(0, 5)
layout.SortOrder = Enum.SortOrder.LayoutOrder

local morePanel = settingContent

local speedInput = Instance.new("TextBox", morePanel)
speedInput.Position = UDim2.new(0, 10, 0, 0)
speedInput.Size = UDim2.new(1, -20, 0, 25)
speedInput.PlaceholderText = "WalkSpeed (default 16)"
speedInput.BackgroundColor3 = Color3.fromRGB(50,50,50)
speedInput.TextColor3 = Color3.new(1,1,1)
speedInput.ClearTextOnFocus = false
speedInput.FocusLost:Connect(function()
    local val = tonumber(speedInput.Text)
    if val then LocalPlayer.Character.Humanoid.WalkSpeed = val end
end)

local jumpInput = Instance.new("TextBox", morePanel)
jumpInput.Position = UDim2.new(0, 10, 0, 35)
jumpInput.Size = UDim2.new(1, -20, 0, 25)
jumpInput.PlaceholderText = "JumpPower (default 50)"
jumpInput.BackgroundColor3 = Color3.fromRGB(50,50,50)
jumpInput.TextColor3 = Color3.new(1,1,1)
jumpInput.ClearTextOnFocus = false
jumpInput.FocusLost:Connect(function()
    local val = tonumber(jumpInput.Text)
    if val then LocalPlayer.Character.Humanoid.JumpPower = val end
end)

local tpButton = Instance.new("TextButton", morePanel)
tpButton.Position = UDim2.new(0, 10, 0, 70)
tpButton.Size = UDim2.new(1, -20, 0, 25)
tpButton.Text = "Enable TP Tool"
tpButton.BackgroundColor3 = Color3.fromRGB(70,70,70)
tpButton.TextColor3 = Color3.new(1,1,1)
tpButton.MouseButton1Click:Connect(function()
    local Tool = Instance.new("Tool", LocalPlayer.Backpack)
    Tool.RequiresHandle = false
    Tool.Name = "TP Tool ☠️"
    Tool.Activated:Connect(function()
        local mouse = LocalPlayer:GetMouse()
        if mouse and mouse.Hit then
            LocalPlayer.Character:MoveTo(mouse.Hit.p)
        end
    end)
end)

local infJump = false
local infBtn = Instance.new("TextButton", morePanel)
infBtn.Position = UDim2.new(0, 10, 0, 105)
infBtn.Size = UDim2.new(1, -20, 0, 25)
infBtn.Text = "Toggle Infinite Jump"
infBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
infBtn.TextColor3 = Color3.new(1,1,1)
infBtn.MouseButton1Click:Connect(function()
    infJump = not infJump
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    char:WaitForChild("HumanoidRootPart")
    RunService.Stepped:Connect(function()
        if infJump then
            LocalPlayer.Character.Humanoid:ChangeState("Jumping")
        end
    end)
end)

local function createESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local box = Instance.new("BoxHandleAdornment")
            box.Size = Vector3.new(4, 6, 1)
            box.Color3 = Color3.fromRGB(0, 170, 255)
            box.Transparency = 0.5
            box.AlwaysOnTop = true
            box.ZIndex = 5
            box.Adornee = player.Character:FindFirstChild("HumanoidRootPart")
            box.Parent = player.Character
        end
    end
end

local espBtn = Instance.new("TextButton", morePanel)
espBtn.Position = UDim2.new(0, 10, 0, 140)
espBtn.Size = UDim2.new(1, -20, 0, 25)
espBtn.Text = "Enable ESP"
espBtn.BackgroundColor3 = Color3.fromRGB(100,100,100)
espBtn.TextColor3 = Color3.new(1,1,1)
espBtn.MouseButton1Click:Connect(createESP)

-- WallHack
local function wallhack()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Transparency < 1 then
            obj.LocalTransparencyModifier = 0.5
        end
    end
end

local wallBtn = Instance.new("TextButton", morePanel)
wallBtn.Position = UDim2.new(0, 10, 0, 175)
wallBtn.Size = UDim2.new(1, -20, 0, 25)
wallBtn.Text = "Enable Wallhack"
wallBtn.BackgroundColor3 = Color3.fromRGB(120,120,120)
wallBtn.TextColor3 = Color3.new(1,1,1)
wallBtn.MouseButton1Click:Connect(wallhack)

local credit = Instance.new("TextLabel", frame)
credit.Size = UDim2.new(1, 0, 0, 30)
credit.Position = UDim2.new(0, 0, 1, -30)
credit.BackgroundTransparency = 1
credit.Text = "⭐ Luminaprojects - Youtube Luminaprojects ⭐"
credit.TextColor3 = Color3.new(1, 1, 0.4)
credit.TextScaled = true
credit.Font = Enum.Font.SourceSansBold

-- Color Generator
local function generateColor(index)
    local r = (index * 37) % 256
    local g = (index * 73) % 256
    local b = (index * 151) % 256
    return Color3.fromRGB(r, g, b)
end

local allButtons = {}
for i = 1, 1000 do
    local color = generateColor(i)
    local btn = Instance.new("TextButton", scrollFrame)
    btn.Name = "Color #" .. i
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = color
    btn.Text = "Color #" .. i
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BorderSizePixel = 0
    table.insert(allButtons, btn)
    btn.MouseButton1Click:Connect(function()
        _G.SelectedColor = color
    end)
end

local function updateVisibleButtons()
    local query = string.lower(searchBox.Text)
    for _, btn in ipairs(allButtons) do
        btn.Visible = (query == "") or string.find(string.lower(btn.Name), query)
    end
end
searchBox:GetPropertyChangedSignal("Text"):Connect(updateVisibleButtons)
updateVisibleButtons()

-- Tab Animasi Geser
colorTab.MouseButton1Click:Connect(function()
    TweenService:Create(colorContent, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
        Position = UDim2.new(0, 0, 0, 0)
    }):Play()
    TweenService:Create(settingContent, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
        Position = UDim2.new(1, 0, 0, 0)
    }):Play()
end)

settingTab.MouseButton1Click:Connect(function()
    TweenService:Create(colorContent, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
        Position = UDim2.new(-1, 0, 0, 0)
    }):Play()
    TweenService:Create(settingContent, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
        Position = UDim2.new(0, 0, 0, 0)
    }):Play()
end)
