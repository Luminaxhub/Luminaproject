-- UI Loadstring ESP Full Feature with HealthBar, Tracer, Nametag, Distance - Luminaprojects
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ESP_Menu"
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
Title.Text = "Universal - Esp"
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
ContentFrame.Parent = MainFrame -- drag ikut atas
ContentFrame.Position = UDim2.new(0, 0, 1, 5)
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

-- ESP Engine
local function createESP(player)
	local box, tracer, nameTag, circle, healthBar

	box = Drawing.new("Square")
	box.Thickness = 1
	box.Color = Color3.fromRGB(0, 255, 0)
	box.Transparency = 1
	box.Filled = false

	tracer = Drawing.new("Line")
	tracer.Thickness = 1
	tracer.Color = Color3.fromRGB(255, 255, 255)
	tracer.Transparency = 1

	nameTag = Drawing.new("Text")
	nameTag.Size = 13
	nameTag.Center = true
	nameTag.Outline = true
	nameTag.Color = Color3.new(1,1,1)

	circle = Drawing.new("Circle")
	circle.Color = Color3.new(1,1,1)
	circle.Thickness = 1
	circle.Filled = false
	circle.Transparency = 1
	circle.NumSides = 30
	circle.Radius = 6

	healthBar = Drawing.new("Line")
	healthBar.Color = Color3.new(0,1,0)
	healthBar.Thickness = 2

	local function update()
		if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
			box.Visible = false
			tracer.Visible = false
			nameTag.Visible = false
			circle.Visible = false
			healthBar.Visible = false
			return
		end
		local hrp = player.Character.HumanoidRootPart
		local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
		if not onScreen then box.Visible = false tracer.Visible = false nameTag.Visible = false circle.Visible = false healthBar.Visible = false return end

		local size = Vector2.new(40, 60)
		box.Size = size
		box.Position = Vector2.new(pos.X - size.X/2, pos.Y - size.Y/2)
		box.Visible = _G.BoxESP

		tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
		tracer.To = Vector2.new(pos.X, pos.Y)
		tracer.Visible = _G.TracerESP

		nameTag.Position = Vector2.new(pos.X, pos.Y - 40)
		nameTag.Text = player.Name .. " | " .. math.floor((LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude) .. "m"
		nameTag.Visible = _G.NametagESP

		circle.Position = Vector2.new(pos.X, pos.Y - 30)
		circle.Visible = _G.CircleESP

		local hp = player.Character:FindFirstChildOfClass("Humanoid")
		if hp then
			local percent = hp.Health / hp.MaxHealth
			healthBar.From = Vector2.new(pos.X - 25, pos.Y + 35)
			healthBar.To = Vector2.new(pos.X - 25 + 50 * percent, pos.Y + 35)
			healthBar.Visible = true
		else
			healthBar.Visible = false
		end
	end

	RunService.RenderStepped:Connect(update)
end

for _, player in ipairs(Players:GetPlayers()) do
	if player ~= LocalPlayer then
		createESP(player)
	end
end

Players.PlayerAdded:Connect(function(p)
	if p ~= LocalPlayer then
		createESP(p)
	end
end)
