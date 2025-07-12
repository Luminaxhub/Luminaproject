-- Fixed Player TP GUI with Avatar and Username showing correctly
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlayerTPGUI"
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 500, 0, 400)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Top Bar
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
topBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -60, 1, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "⚡ Player Teleporter"
titleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 1, 0)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 20
closeButton.BorderSizePixel = 0
closeButton.Parent = topBar
closeButton.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

-- Player List
local playerListFrame = Instance.new("ScrollingFrame")
playerListFrame.Size = UDim2.new(0.45, -20, 1, -40)
playerListFrame.Position = UDim2.new(0, 10, 0, 35)
playerListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
playerListFrame.ScrollBarThickness = 6
playerListFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
playerListFrame.BorderSizePixel = 0
playerListFrame.Parent = mainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = playerListFrame

-- Buttons
local buttonFrame = Instance.new("Frame")
buttonFrame.Size = UDim2.new(0.55, -20, 0, 100)
buttonFrame.Position = UDim2.new(0.45, 10, 0, 35)
buttonFrame.BackgroundTransparency = 1
buttonFrame.Parent = mainFrame

local teleportButton = Instance.new("TextButton")
teleportButton.Size = UDim2.new(1, 0, 0, 40)
teleportButton.Position = UDim2.new(0, 0, 0, 0)
teleportButton.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
teleportButton.Text = "Teleport"
teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportButton.Font = Enum.Font.SourceSansBold
teleportButton.TextSize = 18
teleportButton.Parent = buttonFrame

local cancelButton = Instance.new("TextButton")
cancelButton.Size = UDim2.new(1, 0, 0, 40)
cancelButton.Position = UDim2.new(0, 0, 0, 50)
cancelButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
cancelButton.Text = "Cancel"
cancelButton.TextColor3 = Color3.fromRGB(255, 255, 255)
cancelButton.Font = Enum.Font.SourceSansBold
cancelButton.TextSize = 18
cancelButton.Parent = buttonFrame

-- Functionality
local selectedPlayer = nil
local function refreshPlayerList()
	playerListFrame:ClearAllChildren()
	UIListLayout.Parent = playerListFrame
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			local item = Instance.new("Frame")
			item.Size = UDim2.new(1, 0, 0, 40)
			item.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
			item.Name = player.Name
			item.Parent = playerListFrame

			local thumb = Instance.new("ImageLabel")
			thumb.Size = UDim2.new(0, 36, 0, 36)
			thumb.Position = UDim2.new(0, 2, 0.5, -18)
			thumb.BackgroundTransparency = 1
			thumb.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
			thumb.Parent = item

			local nameLabel = Instance.new("TextLabel")
			nameLabel.Size = UDim2.new(1, -44, 1, 0)
			nameLabel.Position = UDim2.new(0, 44, 0, 0)
			nameLabel.Text = player.Name
			nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			nameLabel.TextXAlignment = Enum.TextXAlignment.Left
			nameLabel.BackgroundTransparency = 1
			nameLabel.Font = Enum.Font.SourceSans
			nameLabel.TextSize = 16
			nameLabel.Parent = item

			local success, content = pcall(function()
				return Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
			end)
			if success and content then
				thumb.Image = content
			end

			item.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					selectedPlayer = player
					for _, other in ipairs(playerListFrame:GetChildren()) do
						if other:IsA("Frame") then
							other.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
						end
					end
					item.BackgroundColor3 = Color3.fromRGB(80, 150, 100)
				end
			end)
		end
	end
end

teleportButton.MouseButton1Click:Connect(function()
	if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
		LocalPlayer.Character:MoveTo(selectedPlayer.Character.HumanoidRootPart.Position + Vector3.new(2, 0, 2))
	end
end)

cancelButton.MouseButton1Click:Connect(function()
	selectedPlayer = nil
	for _, btn in ipairs(playerListFrame:GetChildren()) do
		if btn:IsA("Frame") then
			btn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
		end
	end
end)

refreshPlayerList()
Players.PlayerAdded:Connect(refreshPlayerList)
Players.PlayerRemoving:Connect(refreshPlayerList)
