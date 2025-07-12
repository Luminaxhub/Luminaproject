-- UI Loadstring ESP Circle & Box with Healthbar + TP Tool - Luminaprojects
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Create UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Universal ESP"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Size = UDim2.new(0, 300, 0, 220)
MainFrame.Position = UDim2.new(0.7, 0, 0.2, 0)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- Scrolling Area
local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Size = UDim2.new(1, 0, 1, -30)
Scroll.Position = UDim2.new(0, 0, 0, 30)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 300)
Scroll.ScrollBarThickness = 4
Scroll.BackgroundTransparency = 1
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Scroll.CanvasPosition = Vector2.new(0, 0)
Scroll.Name = "Scroll"

-- Title
local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "Universal ESP"
Title.Size = UDim2.new(1, -40, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Text = "✕"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.TextSize = 14
CloseBtn.MouseButton1Click:Connect(function()
	MainFrame.Visible = false
end)

-- Minimize Button
local MinBtn = Instance.new("TextButton", MainFrame)
MinBtn.Text = "-"
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -60, 0, 0)
MinBtn.BackgroundTransparency = 1
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextColor3 = Color3.new(1, 1, 1)
MinBtn.TextSize = 14

local contentVisible = true
MinBtn.MouseButton1Click:Connect(function()
	contentVisible = not contentVisible
	Scroll.Visible = contentVisible
end)

-- Toggle Function
local function createToggle(parent, labelText, posY, callback)
	local Label = Instance.new("TextLabel", parent)
	Label.Text = labelText
	Label.Position = UDim2.new(0, 10, 0, posY)
	Label.Size = UDim2.new(0.5, 0, 0, 25)
	Label.BackgroundTransparency = 1
	Label.Font = Enum.Font.Gotham
	Label.TextColor3 = Color3.new(1, 1, 1)
	Label.TextSize = 13

	local Toggle = Instance.new("TextButton", parent)
	Toggle.Size = UDim2.new(0, 50, 0, 20)
	Toggle.Position = UDim2.new(1, -60, 0, posY + 2)
	Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Toggle.Text = ""
	Toggle.AutoButtonColor = false
	Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)

	local Dot = Instance.new("Frame", Toggle)
	Dot.Size = UDim2.new(0.5, -2, 1, -4)
	Dot.Position = UDim2.new(0, 2, 0, 2)
	Dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)

	local state = false
	Toggle.MouseButton1Click:Connect(function()
		state = not state
		Dot:TweenPosition(UDim2.new(state and 0.5 or 0, 2, 0, 2), "Out", "Sine", 0.2, true)
		callback(state)
	end)

	return posY + 35
end

-- ESP Toggle Section
local posY = 10
posY = createToggle(Scroll, "Esp Circle 🛡️", posY, function(on) print("Circle", on) end)
posY = createToggle(Scroll, "Esp Box 🛡️", posY, function(on) print("Box", on) end)

-- TP Tool
local tpBtn = Instance.new("TextButton", Scroll)
tpBtn.Position = UDim2.new(0, 10, 0, posY)
tpBtn.Size = UDim2.new(1, -20, 0, 20)
tpBtn.Text = "TP Tool"
tpBtn.Font = Enum.Font.Gotham
tpBtn.TextSize = 12
tpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
tpBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", tpBtn)
tpBtn.MouseButton1Click:Connect(function()
	local tool = Instance.new("Tool")
	tool.RequiresHandle = false
	tool.Name = "TP Tool"
	tool.Activated:Connect(function()
		local mouse = LocalPlayer:GetMouse()
		LocalPlayer.Character:MoveTo(mouse.Hit.Position)
	end)
	tool.Parent = LocalPlayer:WaitForChild("Backpack")
end)
posY += 25

-- RGB Credit
local credit = Instance.new("TextLabel", Scroll)
credit.Text = "Script by - Luminaprojects"
credit.Position = UDim2.new(0, 10, 0, posY)
credit.Size = UDim2.new(1, -20, 0, 20)
credit.Font = Enum.Font.Gotham
credit.TextSize = 12
credit.BackgroundTransparency = 1
credit.TextXAlignment = Enum.TextXAlignment.Left

spawn(function()
	while true do
		for h = 0, 1, 0.01 do
			credit.TextColor3 = Color3.fromHSV(h, 1, 1)
			wait(0.03)
		end
	end
end)

-- Finalize scroll size
Scroll.CanvasSize = UDim2.new(0, 0, 0, posY + 40)
