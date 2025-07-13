-- Roblox Player Teleporter UI (Tanpa Gambar - UI Hitam Default)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PlayerTeleporterUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "PlayerTeleporter"
MainFrame.Size = UDim2.new(0, 700, 0, 450)
MainFrame.Position = UDim2.new(0.5, -350, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Draggable functionality
local dragging, dragStart, startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        if dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -100, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Player Teleporter"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 20
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0.5, -15)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 20
CloseButton.BorderSizePixel = 0
CloseButton.Parent = TopBar
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -40)
ContentFrame.Position = UDim2.new(0, 0, 0, 40)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

local LeftPanel = Instance.new("ScrollingFrame")
LeftPanel.Size = UDim2.new(0.5, 0, 1, 0)
LeftPanel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LeftPanel.BorderSizePixel = 0
LeftPanel.ScrollBarThickness = 8
LeftPanel.Parent = ContentFrame

local PlayerListLayout = Instance.new("UIListLayout")
PlayerListLayout.Padding = UDim.new(0, 5)
PlayerListLayout.Parent = LeftPanel

local RightPanel = Instance.new("Frame")
RightPanel.Size = UDim2.new(0.5, 0, 1, 0)
RightPanel.Position = UDim2.new(0.5, 0, 0, 0)
RightPanel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
RightPanel.BorderSizePixel = 0
RightPanel.Parent = ContentFrame

local SelectedName = Instance.new("TextLabel")
SelectedName.Size = UDim2.new(1, -20, 0, 50)
SelectedName.Position = UDim2.new(0, 10, 0, 10)
SelectedName.BackgroundTransparency = 1
SelectedName.Text = "No player selected"
SelectedName.TextColor3 = Color3.fromRGB(255, 255, 255)
SelectedName.Font = Enum.Font.SourceSansBold
SelectedName.TextSize = 20
SelectedName.Parent = RightPanel

local CancelButton = Instance.new("TextButton")
CancelButton.Size = UDim2.new(1, -20, 0, 40)
CancelButton.Position = UDim2.new(0, 10, 0, 70)
CancelButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CancelButton.Text = "Cancel"
CancelButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CancelButton.Font = Enum.Font.SourceSansBold
CancelButton.TextSize = 18
CancelButton.Parent = RightPanel

local TeleportButton = Instance.new("TextButton")
TeleportButton.Size = UDim2.new(1, -20, 0, 40)
TeleportButton.Position = UDim2.new(0, 10, 0, 120)
TeleportButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
TeleportButton.Text = "Teleport"
TeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportButton.Font = Enum.Font.SourceSansBold
TeleportButton.TextSize = 18
TeleportButton.Parent = RightPanel

local selectedPlayer = nil

local function createPlayerButton(player)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = player.Name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 16
    btn.Parent = LeftPanel

    btn.MouseButton1Click:Connect(function()
        selectedPlayer = player
        SelectedName.Text = player.Name
    end)
end

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        createPlayerButton(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    createPlayerButton(player)
end)

Players.PlayerRemoving:Connect(function(player)
    if selectedPlayer == player then
        selectedPlayer = nil
        SelectedName.Text = "No player selected"
    end
    local btn = LeftPanel:FindFirstChild(player.Name)
    if btn then
        btn:Destroy()
    end
end)

CancelButton.MouseButton1Click:Connect(function()
    selectedPlayer = nil
    SelectedName.Text = "No player selected"
end)

TeleportButton.MouseButton1Click:Connect(function()
    if selectedPlayer and selectedPlayer.Character and LocalPlayer.Character then
        local targetHRP = selectedPlayer.Character:FindFirstChild("HumanoidRootPart")
        local localHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetHRP and localHRP then
            localHRP.CFrame = targetHRP.CFrame + Vector3.new(0, 5, 0)
        end
    end
end)
