-- UI Loadstring ESP Full Feature with HealthBar, Tracer, Nametag, Distance - Luminaprojects
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "📜 Universal - Esp"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Size = UDim2.new(0, 300, 0, 30)
MainFrame.Position = UDim2.new(0.7, 0, 0.2, 0)
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "📜 Universal - Esp"
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Text = "✕"
CloseBtn.Size = UDim2.new(0, 30, 1, 0)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.TextSize = 14
CloseBtn.MouseButton1Click:Connect(function()
	ScreenGui.Enabled = false
end)

local MinBtn = Instance.new("TextButton", MainFrame)
MinBtn.Text = "-"
MinBtn.Size = UDim2.new(0, 30, 1, 0)
MinBtn.Position = UDim2.new(1, -60, 0, 0)
MinBtn.BackgroundTransparency = 1
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextColor3 = Color3.new(1, 1, 1)
MinBtn.TextSize = 14

local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = ScreenGui
ContentFrame.Position = MainFrame.Position + UDim2.new(0, 0, 0, 35)
ContentFrame.Size = UDim2.new(0, 300, 0, 200)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Name = "ContentFrame"

local function createToggle(parent, text, order, callback)
	local label = Instance.new("TextLabel", parent)
	label.Position = UDim2.new(0, 10, 0, 10 + order * 30)
	label.Size = UDim2.new(0.6, 0, 0, 20)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Gotham
	label.TextSize = 13
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Text = text
	label.TextXAlignment = Enum.TextXAlignment.Left

	local toggle = Instance.new("TextButton", parent)
	toggle.Position = UDim2.new(1, -60, 0, 10 + order * 30)
	toggle.Size = UDim2.new(0, 50, 0, 20)
	toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	toggle.Text = ""
	toggle.AutoButtonColor = false
	Instance.new("UICorner", toggle).CornerRadius = UDim.new(1, 0)

	local dot = Instance.new("Frame", toggle)
	dot.Size = UDim2.new(0.5, -2, 1, -4)
	dot.Position = UDim2.new(0, 2, 0, 2)
	dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

	local state = false
	toggle.MouseButton1Click:Connect(function()
		state = not state
		dot:TweenPosition(UDim2.new(state and 0.5 or 0, 2, 0, 2), "Out", "Sine", 0.2, true)
		callback(state)
	end)
end

local toggleIndex = 0
createToggle(ContentFrame, "Esp Circle 🛡️", toggleIndex, function(val) _G.CircleESP = val end) toggleIndex += 1
createToggle(ContentFrame, "Esp Box 🛡️", toggleIndex, function(val) _G.BoxESP = val end) toggleIndex += 1
createToggle(ContentFrame, "Esp Tracer 🛡️", toggleIndex, function(val) _G.TracerESP = val end) toggleIndex += 1
createToggle(ContentFrame, "Nametag + Distance 🛡️", toggleIndex, function(val) _G.NametagESP = val end) toggleIndex += 1

-- Credit
local credit = Instance.new("TextLabel", ContentFrame)
credit.Text = "Script by - Luminaprojects"
credit.Position = UDim2.new(0, 10, 0, 10 + toggleIndex * 30 + 10)
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

-- Minimize behavior
local isMinimized = false
MinBtn.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	ContentFrame.Visible = not isMinimized
end)

-- ESP core logic ditambahkan di luar UI bagian, di bagian terpisah ESP Engine.
