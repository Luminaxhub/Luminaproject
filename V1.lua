-- UI Loadstring ESP Circle & Box with Healthbar - Luminaprojects (Fixed Version)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- ESP CIRCLE
local CircleESP = {}
local function createCircle(player)
	local circle = Drawing.new("Circle")
	circle.Thickness = 1
	circle.Radius = 10
	circle.Filled = true
	circle.Transparency = 1
	circle.Color = Color3.new(1, 1, 1)
	circle.Visible = false
	CircleESP[player] = circle
end

-- ESP BOX
local ESPBoxes = {}
local HealthBars = {}
local function createESP(player)
	local box = Drawing.new("Square")
	box.Thickness = 1
	box.Transparency = 0.9
	box.Color = Color3.new(1, 1, 1)
	box.Filled = false
	box.Visible = false
	ESPBoxes[player] = box

	local health = Drawing.new("Square")
	health.Thickness = 2
	health.Transparency = 0.9
	health.Filled = true
	health.Visible = false
	HealthBars[player] = health
end

for _, player in pairs(Players:GetPlayers()) do
	if player ~= LocalPlayer then
		createCircle(player)
		createESP(player)
	end
end

Players.PlayerAdded:Connect(function(player)
	if player ~= LocalPlayer then
		createCircle(player)
		createESP(player)
	end
end)

Players.PlayerRemoving:Connect(function(player)
	if CircleESP[player] then CircleESP[player]:Remove() CircleESP[player] = nil end
	if ESPBoxes[player] then ESPBoxes[player]:Remove() ESPBoxes[player] = nil end
	if HealthBars[player] then HealthBars[player]:Remove() HealthBars[player] = nil end
end)

local showCircle = false
local showBox = false
RunService.RenderStepped:Connect(function()
	for player, circle in pairs(CircleESP) do
		local char = player.Character
		if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
			local root = char.HumanoidRootPart
			local pos, visible = Camera:WorldToViewportPoint(root.Position)
			if visible and showCircle then
				circle.Position = Vector2.new(pos.X, pos.Y)
				circle.Visible = true
			else
				circle.Visible = false
			end
		else
			circle.Visible = false
		end
	end
	for player, box in pairs(ESPBoxes) do
		local char = player.Character
		if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
			local hrp = char.HumanoidRootPart
			local pos, visible = Camera:WorldToViewportPoint(hrp.Position)
			if visible and showBox then
				local distance = (Camera.CFrame.Position - hrp.Position).Magnitude
				local scale = 50 / distance
				box.Size = Vector2.new(20 * scale, 40 * scale)
				box.Position = Vector2.new(pos.X - box.Size.X / 2, pos.Y - box.Size.Y / 2)
				box.Visible = true

				local hp = char.Humanoid.Health / char.Humanoid.MaxHealth
				local healthBar = HealthBars[player]
				healthBar.Size = Vector2.new(box.Size.X * hp, 2)
				healthBar.Position = Vector2.new(box.Position.X, box.Position.Y + box.Size.Y + 2)
				healthBar.Color = Color3.fromRGB(0, 255, 0)
				healthBar.Visible = true
			else
				box.Visible = false
				HealthBars[player].Visible = false
			end
		else
			box.Visible = false
			HealthBars[player].Visible = false
		end
	end
end)

-- UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Universal Esp"
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

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "Universal Esp"
Title.Size = UDim2.new(1, -40, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Text = "✕"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.TextSize = 14
CloseBtn.MouseButton1Click:Connect(function()
	MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Sine", 0.3, true)
	task.wait(0.3)
	MainFrame.Visible = false
end)

local MinBtn = Instance.new("TextButton", MainFrame)
MinBtn.Text = "-"
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -60, 0, 0)
MinBtn.BackgroundTransparency = 1
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextColor3 = Color3.new(1, 1, 1)
MinBtn.TextSize = 14

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	MainFrame:TweenSize(minimized and UDim2.new(0, 150, 0, 30) or UDim2.new(0, 300, 0, 220), "Out", "Sine", 0.3, true)
end)

local function createToggle(text, posY, callback)
	local Label = Instance.new("TextLabel", MainFrame)
	Label.Text = text
	Label.Position = UDim2.new(0, 10, 0, posY)
	Label.Size = UDim2.new(0.5, 0, 0, 25)
	Label.BackgroundTransparency = 1
	Label.Font = Enum.Font.Gotham
	Label.TextColor3 = Color3.new(1, 1, 1)
	Label.TextSize = 13

	local Toggle = Instance.new("TextButton", MainFrame)
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
end

createToggle("Esp Circle 🛡️", 40, function(state) showCircle = state end)
createToggle("Esp Box 🛡️", 75, function(state) showBox = state end)

local credit = Instance.new("TextLabel", MainFrame)
credit.Text = "Script by - Luminaprojects"
credit.Position = UDim2.new(0, 10, 1, -25)
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
