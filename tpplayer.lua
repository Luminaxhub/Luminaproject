local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PlayerTeleporterUI"
ScreenGui.ResetOnSpawn = false -- Penting agar UI tidak hilang saat spawn
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "PlayerTeleporter"
MainFrame.Size = UDim2.new(0, 700, 0, 450) -- Ukuran yang lebih mendekati gambar
MainFrame.Position = UDim2.new(0.5, -350, 0.5, -225) -- Posisikan di tengah layar
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45) -- Warna dasar gelap
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true -- Penting untuk minimize
MainFrame.Parent = ScreenGui

-- Corner for rounded edges (optional, can be subtle)
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Draggable functionality
local dragging
local dragInput
local dragStart
local startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Handled = true
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Top Bar (for title and buttons)
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 40) -- Lebih tinggi dari sebelumnya
TopBar.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TitleIcon = Instance.new("ImageLabel")
TitleIcon.Name = "TitleIcon"
TitleIcon.Size = UDim2.new(0, 24, 0, 24)
TitleIcon.Position = UDim2.new(0, 10, 0.5, -12)
TitleIcon.BackgroundTransparency = 1
TitleIcon.Image = "rbxassetid://6284683070" -- Contoh ikon kilat (Lightning Bolt)
TitleIcon.ImageColor3 = Color3.fromRGB(150, 150, 255)
TitleIcon.Parent = TopBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, -100, 1, 0)
TitleLabel.Position = UDim2.new(0, 40, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Player Teleporter"
TitleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 20
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopBar

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0.5, -15) -- Lebih ke tengah vertikal
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 20
CloseButton.BorderSizePixel = 0
CloseButton.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Minimize Button (right next to close, similar style)
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0.5, -15) -- Di sebelah kiri close button
MinimizeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
MinimizeButton.Text = "—"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.TextSize = 20
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Parent = TopBar

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 5)
MinimizeCorner.Parent = MinimizeButton

local isMinimized = false
local originalSize = MainFrame.Size

MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame.Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset, 0, TopBar.Size.Y.Offset)
        for _, child in pairs(MainFrame:GetChildren()) do
            if child ~= TopBar then
                child.Visible = false
            end
        end
    else
        MainFrame.Size = originalSize
        for _, child in pairs(MainFrame:GetChildren()) do
            child.Visible = true
        end
    end
end)

-- Main Content Frame (below TopBar)
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, 0, 1, -TopBar.Size.Y.Offset)
ContentFrame.Position = UDim2.new(0, 0, 0, TopBar.Size.Y.Offset)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

-- GridLayout for main content (Online Players and Actions)
local MainGridLayout = Instance.new("UIListLayout")
MainGridLayout.FillDirection = Enum.FillDirection.Horizontal
MainGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
MainGridLayout.VerticalAlignment = Enum.VerticalAlignment.Top
MainGridLayout.Padding = UDim.new(0, 10)
MainGridLayout.Parent = ContentFrame

-- Left Panel: Online Players
local OnlinePlayersPanel = Instance.new("Frame")
OnlinePlayersPanel.Name = "OnlinePlayersPanel"
OnlinePlayersPanel.Size = UDim2.new(0.5, -5, 1, 0) -- Setengah lebar ContentFrame
OnlinePlayersPanel.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
OnlinePlayersPanel.BorderSizePixel = 0
OnlinePlayersPanel.Parent = ContentFrame

local PlayersTitleFrame = Instance.new("Frame")
PlayersTitleFrame.Name = "PlayersTitleFrame"
PlayersTitleFrame.Size = UDim2.new(1, 0, 0, 30)
PlayersTitleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50) -- Lebih terang dari panel
PlayersTitleFrame.BorderSizePixel = 0
PlayersTitleFrame.Parent = OnlinePlayersPanel

local PlayersIcon = Instance.new("ImageLabel")
PlayersIcon.Name = "PlayersIcon"
PlayersIcon.Size = UDim2.new(0, 20, 0, 20)
PlayersIcon.Position = UDim2.new(0, 10, 0.5, -10)
PlayersIcon.BackgroundTransparency = 1
PlayersIcon.Image = "rbxassetid://4975551395" -- Contoh ikon orang
PlayersIcon.ImageColor3 = Color3.fromRGB(150, 150, 255)
PlayersIcon.Parent = PlayersTitleFrame

local PlayersTitleLabel = Instance.new("TextLabel")
PlayersTitleLabel.Name = "PlayersTitleLabel"
PlayersTitleLabel.Size = UDim2.new(1, -40, 1, 0)
PlayersTitleLabel.Position = UDim2.new(0, 35, 0, 0)
PlayersTitleLabel.BackgroundTransparency = 1
PlayersTitleLabel.Text = "Online Players"
PlayersTitleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
PlayersTitleLabel.Font = Enum.Font.SourceSansBold
PlayersTitleLabel.TextSize = 16
PlayersTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
PlayersTitleLabel.Parent = PlayersTitleFrame

local PlayersScrollingFrame = Instance.new("ScrollingFrame")
PlayersScrollingFrame.Name = "PlayersScrollingFrame"
PlayersScrollingFrame.Size = UDim2.new(1, 0, 1, -PlayersTitleFrame.Size.Y.Offset)
PlayersScrollingFrame.Position = UDim2.new(0, 0, 0, PlayersTitleFrame.Size.Y.Offset)
PlayersScrollingFrame.BackgroundTransparency = 1
PlayersScrollingFrame.BorderSizePixel = 0
PlayersScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 90)
PlayersScrollingFrame.ScrollBarThickness = 6
PlayersScrollingFrame.Parent = OnlinePlayersPanel

local PlayerListLayout = Instance.new("UIListLayout")
PlayerListLayout.FillDirection = Enum.FillDirection.Vertical
PlayerListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
PlayerListLayout.Padding = UDim.new(0, 5)
PlayerListLayout.Parent = PlayersScrollingFrame

local PlayerAspectRatio = Instance.new("UIAspectRatioConstraint")
PlayerAspectRatio.AspectRatio = 10 -- Untuk memastikan item pemain tidak terlalu lebar
PlayerAspectRatio.Parent = PlayersScrollingFrame

-- Right Panel: Actions
local ActionsPanel = Instance.new("Frame")
ActionsPanel.Name = "ActionsPanel"
ActionsPanel.Size = UDim2.new(0.5, -5, 1, 0) -- Setengah lebar ContentFrame
ActionsPanel.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
ActionsPanel.BorderSizePixel = 0
ActionsPanel.Parent = ContentFrame

local ActionsTitleFrame = Instance.new("Frame")
ActionsTitleFrame.Name = "ActionsTitleFrame"
ActionsTitleFrame.Size = UDim2.new(1, 0, 0, 30)
ActionsTitleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ActionsTitleFrame.BorderSizePixel = 0
ActionsTitleFrame.Parent = ActionsPanel

local ActionsIcon = Instance.new("ImageLabel")
ActionsIcon.Name = "ActionsIcon"
ActionsIcon.Size = UDim2.new(0, 20, 0, 20)
ActionsIcon.Position = UDim2.new(0, 10, 0.5, -10)
ActionsIcon.BackgroundTransparency = 1
ActionsIcon.Image = "rbxassetid://4975551395" -- Contoh ikon kilat
ActionsIcon.ImageColor3 = Color3.fromRGB(255, 150, 50)
ActionsIcon.Parent = ActionsTitleFrame

local ActionsTitleLabel = Instance.new("TextLabel")
ActionsTitleLabel.Name = "ActionsTitleLabel"
ActionsTitleLabel.Size = UDim2.new(1, -40, 1, 0)
ActionsTitleLabel.Position = UDim2.new(0, 35, 0, 0)
ActionsTitleLabel.BackgroundTransparency = 1
ActionsTitleLabel.Text = "Actions"
ActionsTitleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
ActionsTitleLabel.Font = Enum.Font.SourceSansBold
ActionsTitleLabel.TextSize = 16
ActionsTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
ActionsTitleLabel.Parent = ActionsTitleFrame

-- Action content
local PlayerSelectionFrame = Instance.new("Frame")
PlayerSelectionFrame.Name = "PlayerSelectionFrame"
PlayerSelectionFrame.Size = UDim2.new(1, -20, 0, 100) -- Ukuran untuk avatar dan nama
PlayerSelectionFrame.Position = UDim2.new(0.5, - (1 - 20/ActionsPanel.AbsoluteSize.X) * 0.5 * ActionsPanel.AbsoluteSize.X, 0, 40) -- Posisi relatif
PlayerSelectionFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
PlayerSelectionFrame.BorderSizePixel = 0
PlayerSelectionFrame.Parent = ActionsPanel

local SelectedPlayerAvatar = Instance.new("ImageLabel")
SelectedPlayerAvatar.Name = "SelectedPlayerAvatar"
SelectedPlayerAvatar.Size = UDim2.new(0, 80, 0, 80)
SelectedPlayerAvatar.Position = UDim2.new(0, 10, 0.5, -40)
SelectedPlayerAvatar.BackgroundTransparency = 1
SelectedPlayerAvatar.Image = "rbxassetid://3927622941" -- Default placeholder (Roblox logo)
SelectedPlayerAvatar.Parent = PlayerSelectionFrame

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(0.5, 0) -- Lingkaran
AvatarCorner.Parent = SelectedPlayerAvatar

local SelectedPlayerName = Instance.new("TextLabel")
SelectedPlayerName.Name = "SelectedPlayerName"
SelectedPlayerName.Size = UDim2.new(1, -110, 1, 0)
SelectedPlayerName.Position = UDim2.new(0, 100, 0, 0)
SelectedPlayerName.BackgroundTransparency = 1
SelectedPlayerName.Text = "No player selected"
SelectedPlayerName.TextColor3 = Color3.fromRGB(255, 255, 255)
SelectedPlayerName.Font = Enum.Font.SourceSansSemibold
SelectedPlayerName.TextSize = 18
SelectedPlayerName.TextWrapped = true
SelectedPlayerName.Parent = PlayerSelectionFrame

local CancelButton = Instance.new("TextButton")
CancelButton.Name = "CancelButton"
CancelButton.Size = UDim2.new(1, -20, 0, 40)
CancelButton.Position = UDim2.new(0.5, -(MainFrame.AbsoluteSize.X/2 - 10), 0, 160) -- Sesuaikan posisi
CancelButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50) -- Merah
CancelButton.Text = "X Cancel"
CancelButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CancelButton.Font = Enum.Font.SourceSansBold
CancelButton.TextSize = 18
CancelButton.BorderSizePixel = 0
CancelButton.Parent = ActionsPanel

local CancelCorner = Instance.new("UICorner")
CancelCorner.CornerRadius = UDim.new(0, 5)
CancelCorner.Parent = CancelButton

CancelButton.MouseButton1Click:Connect(function()
    SelectedPlayerName.Text = "No player selected"
    SelectedPlayerAvatar.Image = "rbxassetid://3927622941" -- Reset ke placeholder
    -- Anda bisa menambahkan logika lain di sini jika perlu
end)

local TeleportButton = Instance.new("TextButton")
TeleportButton.Name = "TeleportButton"
TeleportButton.Size = UDim2.new(1, -20, 0, 40)
TeleportButton.Position = UDim2.new(0.5, -(MainFrame.AbsoluteSize.X/2 - 10), 0, 210) -- Di bawah Cancel
TeleportButton.BackgroundColor3 = Color3.fromRGB(50, 200, 100) -- Hijau
TeleportButton.Text = "Teleport"
TeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportButton.Font = Enum.Font.SourceSansBold
TeleportButton.TextSize = 18
TeleportButton.BorderSizePixel = 0
TeleportButton.Parent = ActionsPanel

local TeleportCorner = Instance.new("UICorner")
TeleportCorner.CornerRadius = UDim.new(0, 5)
TeleportCorner.Parent = TeleportButton

local selectedPlayer = nil

-- Function to create player list item
local function createPlayerItem(player)
    local PlayerItem = Instance.new("TextButton")
    PlayerItem.Name = player.Name
    PlayerItem.Size = UDim2.new(1, 0, 0, 50) -- Fixed height
    PlayerItem.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    PlayerItem.BorderSizePixel = 0
    PlayerItem.Parent = PlayersScrollingFrame

    local ItemCorner = Instance.new("UICorner")
    ItemCorner.CornerRadius = UDim.new(0, 5)
    ItemCorner.Parent = PlayerItem

    local AvatarImage = Instance.new("ImageLabel")
    AvatarImage.Name = "AvatarImage"
    AvatarImage.Size = UDim2.new(0, 40, 0, 40)
    AvatarImage.Position = UDim2.new(0, 5, 0.5, -20)
    AvatarImage.BackgroundTransparency = 1
    AvatarImage.Parent = PlayerItem

    -- Load avatar thumbnail asynchronously
    local thumbType = Enum.ThumbnailType.HeadShot
    local thumbSize = Enum.ThumbnailSize.Size420x420
    local content, ready = Players:GetUserThumbnailAsync(player.UserId, thumbType, thumbSize)
    if ready then
        AvatarImage.Image = content
    else
        -- Fallback if not ready immediately
        local success, err = pcall(function()
            content = Players:GetUserThumbnailAsync(player.UserId, thumbType, thumbSize)
        end)
        if success then
            AvatarImage.Image = content
        else
            warn("Failed to load thumbnail for", player.Name, ":", err)
        end
    end

    local ItemAvatarCorner = Instance.new("UICorner")
    ItemAvatarCorner.CornerRadius = UDim.new(0.5, 0)
    ItemAvatarCorner.Parent = AvatarImage

    local PlayerNameLabel = Instance.new("TextLabel")
    PlayerNameLabel.Name = "PlayerName"
    PlayerNameLabel.Size = UDim2.new(1, -60, 1, 0)
    PlayerNameLabel.Position = UDim2.new(0, 50, 0, 0)
    PlayerNameLabel.BackgroundTransparency = 1
    PlayerNameLabel.Text = player.Name
    PlayerNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    PlayerNameLabel.Font = Enum.Font.SourceSansSemibold
    PlayerNameLabel.TextSize = 16
    PlayerNameLabel.TextXAlignment = Enum.TextXAlignment.Left
    PlayerNameLabel.Parent = PlayerItem

    -- Selection logic
    PlayerItem.MouseButton1Click:Connect(function()
        if selectedPlayer then
            -- Deselect previous player visually
            local prevItem = PlayersScrollingFrame:FindFirstChild(selectedPlayer.Name)
            if prevItem then
                prevItem.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            end
        end

        selectedPlayer = player
        PlayerItem.BackgroundColor3 = Color3.fromRGB(70, 70, 80) -- Highlight selected player

        SelectedPlayerName.Text = player.Name
        SelectedPlayerAvatar.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    end)
end

-- Populate initial player list
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        createPlayerItem(player)
    end
end

-- Update player list on PlayerAdded
Players.PlayerAdded:Connect(function(player)
    createPlayerItem(player)
end)

-- Update player list on PlayerRemoving (remove from list)
Players.PlayerRemoving:Connect(function(player)
    local playerItem = PlayersScrollingFrame:FindFirstChild(player.Name)
    if playerItem then
        playerItem:Destroy()
    end
    if selectedPlayer == player then
        selectedPlayer = nil
        SelectedPlayerName.Text = "No player selected"
        SelectedPlayerAvatar.Image = "rbxassetid://3927622941"
    end
end)

-- Teleport button logic
TeleportButton.MouseButton1Click:Connect(function()
    if selectedPlayer and selectedPlayer.Character and LocalPlayer.Character then
        local targetHumanoidRootPart = selectedPlayer.Character:FindFirstChild("HumanoidRootPart")
        local localHumanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

        if targetHumanoidRootPart and localHumanoidRootPart then
            localPlayer.Character:SetPrimaryPartCFrame(targetHumanoidRootPart.CFrame + Vector3.new(0, 5, 0)) -- Teleport slightly above target
            print("Teleported to:", selectedPlayer.Name)
        else
            warn("Could not teleport: Target or local character parts missing.")
        end
    else
        warn("No player selected or character not found.")
    end
end)

-- Initial selection state
SelectedPlayerName.Text = "No player selected"
SelectedPlayerAvatar.Image = "rbxassetid://3927622941" -- Roblox Logo as default
