local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoClickerUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 130)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Lumber Jeck Simulator"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Parent = MainFrame

local Toggle = Instance.new("TextButton")
Toggle.Size = UDim2.new(0.8, 0, 0, 30)
Toggle.Position = UDim2.new(0.1, 0, 0.4, 0)
Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Toggle.Text = "Status: OFF"
Toggle.Font = Enum.Font.Gotham
Toggle.TextSize = 16
Toggle.TextColor3 = Color3.new(1, 1, 1)
Toggle.Parent = MainFrame

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.new(0.8, 0, 0, 30)
Minimize.Position = UDim2.new(0.1, 0, 0.7, 0)
Minimize.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Minimize.Text = "🔻 Hide"
Minimize.Font = Enum.Font.Gotham
Minimize.TextSize = 14
Minimize.TextColor3 = Color3.new(1, 1, 1)
Minimize.Parent = MainFrame

local Credit = Instance.new("TextLabel")
Credit.Size = UDim2.new(1, 0, 0, 20)
Credit.Position = UDim2.new(0, 0, 1, -20)
Credit.BackgroundTransparency = 1
Credit.Text = "Script by - @Luminaprojects"
Credit.Font = Enum.Font.Gotham
Credit.TextSize = 13
Credit.TextColor3 = Color3.fromRGB(255, 0, 0)
Credit.Parent = MainFrame

-- RGB Credit Text Animation
spawn(function()
	while true do
		for hue = 0, 1, 0.01 do
			Credit.TextColor3 = Color3.fromHSV(hue, 1, 1)
			task.wait(0.03)
		end
	end
end)

-- Toggle AutoClick
local autoClick = false
Toggle.MouseButton1Click:Connect(function()
	autoClick = not autoClick
	Toggle.Text = "Status: " .. (autoClick and "ON" or "OFF")
	Toggle.BackgroundColor3 = autoClick and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
end)

-- AutoClick Loop
RunService.RenderStepped:Connect(function()
	if autoClick then
		local screenSize = workspace.CurrentCamera.ViewportSize
		local centerX = screenSize.X / 2
		local centerY = screenSize.Y / 2
		VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, true, game, 0)
		VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, false, game, 0)
	end
end)

-- Minimize / Show Logic
local minimized = false
Minimize.MouseButton1Click:Connect(function()
	minimized = not minimized
	MainFrame.Visible = not minimized
	Minimize.Text = minimized and "🔼 Show" or "🔻 Hide"
	if minimized then
		-- Replace with small restore button
		local restoreBtn = Instance.new("TextButton")
		restoreBtn.Size = UDim2.new(0, 120, 0, 30)
		restoreBtn.Position = UDim2.new(0.05, 0, 0.3, 0)
		restoreBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		restoreBtn.Text = "🔼 Show AutoClicker"
		restoreBtn.Font = Enum.Font.Gotham
		restoreBtn.TextSize = 14
		restoreBtn.TextColor3 = Color3.new(1, 1, 1)
		restoreBtn.Parent = ScreenGui

		restoreBtn.MouseButton1Click:Connect(function()
			MainFrame.Visible = true
			minimized = false
			restoreBtn:Destroy()
		end)
	end
end)
