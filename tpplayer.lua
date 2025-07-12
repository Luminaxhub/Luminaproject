-- Players TP Gui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PlayerTPGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 150)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Text = "Player TP Gui"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 22
Title.Parent = MainFrame

local TextBox = Instance.new("TextBox")
TextBox.PlaceholderText = "Enter Player Name"
TextBox.Size = UDim2.new(1, -20, 0, 30)
TextBox.Position = UDim2.new(0, 10, 0, 50)
TextBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.Font = Enum.Font.SourceSans
TextBox.TextSize = 18
TextBox.Text = ""
TextBox.Parent = MainFrame

local TeleportButton = Instance.new("TextButton")
TeleportButton.Text = "Teleport"
TeleportButton.Size = UDim2.new(1, -20, 0, 30)
TeleportButton.Position = UDim2.new(0, 10, 0, 100)
TeleportButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
TeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportButton.Font = Enum.Font.SourceSansBold
TeleportButton.TextSize = 20
TeleportButton.Parent = MainFrame

TeleportButton.MouseButton1Click:Connect(function()
	local playerName = TextBox.Text
	local targetPlayer = game.Players:FindFirstChild(playerName)
	local localPlayer = game.Players.LocalPlayer
	
	if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		localPlayer.Character:MoveTo(targetPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 3, 0))
	else
		warn("Player not found or invalid")
	end
end)
