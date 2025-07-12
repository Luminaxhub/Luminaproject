-- UI Loadstring ESP Circle & Box with Healthbar - Luminaprojects
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Create UI
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "UNIVERSAL ESP"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Size = UDim2.new(0, 300, 0, 150)
MainFrame.Position = UDim2.new(0.7, 0, 0.2, 0)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderSizePixel = 0
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "UNIVERSAL ESP"
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
	for _, obj in pairs(MainFrame:GetChildren()) do
		if obj ~= Title and obj ~= CloseBtn and obj ~= MinBtn then
			obj.Visible = contentVisible
		end
	end
end)

-- ESP Circle Toggle
local CircleLabel = Instance.new("TextLabel", MainFrame)
CircleLabel.Text = "Esp Circle 🛡️"
CircleLabel.Position = UDim2.new(0, 10, 0, 40)
CircleLabel.Size = UDim2.new(0.5, 0, 0, 25)
CircleLabel.BackgroundTransparency = 1
CircleLabel.Font = Enum.Font.Gotham
CircleLabel.TextColor3 = Color3.new(1,1,1)
CircleLabel.TextSize = 13

local CircleToggle = Instance.new("TextButton", MainFrame)
CircleToggle.Size = UDim2.new(0, 50, 0, 20)
CircleToggle.Position = UDim2.new(1, -60, 0, 42)
CircleToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CircleToggle.Text = ""
CircleToggle.AutoButtonColor = false
Instance.new("UICorner", CircleToggle).CornerRadius = UDim.new(1,0)

local CircleDot = Instance.new("Frame", CircleToggle)
CircleDot.Size = UDim2.new(0.5, -2, 1, -4)
CircleDot.Position = UDim2.new(0, 2, 0, 2)
CircleDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", CircleDot).CornerRadius = UDim.new(1,0)

local circleEnabled = false
CircleToggle.MouseButton1Click:Connect(function()
	circleEnabled = not circleEnabled
	CircleDot:TweenPosition(UDim2.new(circleEnabled and 0.5 or 0, 2, 0, 2), "Out", "Sine", 0.2, true)
end)

-- ESP Box Toggle
local BoxLabel = CircleLabel:Clone()
BoxLabel.Text = "Esp Box 🛡️"
BoxLabel.Position = UDim2.new(0, 10, 0, 75)
BoxLabel.Parent = MainFrame

local BoxToggle = CircleToggle:Clone()
BoxToggle.Position = UDim2.new(1, -60, 0, 77)
BoxToggle.Parent = MainFrame

local BoxDot = BoxToggle:FindFirstChild("Frame")
local boxEnabled = false
BoxToggle.MouseButton1Click:Connect(function()
	boxEnabled = not boxEnabled
	BoxDot:TweenPosition(UDim2.new(boxEnabled and 0.5 or 0, 2, 0, 2), "Out", "Sine", 0.2, true)
end)

-- Credit Text RGB
local credit = Instance.new("TextLabel", MainFrame)
credit.Text = "⚙️ Script by - Luminaprojects"
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

-- ESP Circle + Health Bar
local CircleESP, HealthBar = {}, {}
local function createCircle(player)
	local circle = Drawing.new("Circle")
	circle.Thickness, circle.Radius, circle.Filled = 1, 10, true
	circle.Transparency = 1
	circle.Color = Color3.new(1, 1, 1)
	circle.Visible = false
	CircleESP[player] = circle

	local health = Drawing.new("Square")
	health.Filled = true
	health.Thickness = 1
	health.Transparency = 0.9
	health.Color = Color3.new(0, 1, 0)
	health.Visible = false
	HealthBar[player] = health
end

for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then createCircle(p) end end
Players.PlayerAdded:Connect(function(p) if p ~= LocalPlayer then createCircle(p) end end)
Players.PlayerRemoving:Connect(function(p)
	if CircleESP[p] then CircleESP[p]:Remove(); CircleESP[p] = nil end
	if HealthBar[p] then HealthBar[p]:Remove(); HealthBar[p] = nil end
end)

-- ESP Box + Health Bar
local ESPBoxes, BoxHealth = {}, {}
local function createBox(player)
	local box = Drawing.new("Square")
	box.Thickness = 1
	box.Transparency = 0.9
	box.Color = Color3.new(1, 1, 1)
	box.Filled = false
	box.Visible = false
	ESPBoxes[player] = box

	local hp = Drawing.new("Square")
	hp.Filled = true
	hp.Thickness = 1
	hp.Transparency = 0.9
	hp.Color = Color3.new(0, 1, 0)
	hp.Visible = false
	BoxHealth[player] = hp
end

for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then createBox(p) end end
Players.PlayerAdded:Connect(function(p) if p ~= LocalPlayer then createBox(p) end end)
Players.PlayerRemoving:Connect(function(p)
	if ESPBoxes[p] then ESPBoxes[p]:Remove(); ESPBoxes[p] = nil end
	if BoxHealth[p] then BoxHealth[p]:Remove(); BoxHealth[p] = nil end
end)

RunService.RenderStepped:Connect(function()
	for p, circle in pairs(CircleESP) do
		local char = p.Character
		if circleEnabled and char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
			local root = char.HumanoidRootPart
			local pos, vis = Camera:WorldToViewportPoint(root.Position)
			if vis then
				circle.Position = Vector2.new(pos.X, pos.Y)
				circle.Visible = true

				local hp = HealthBar[p]
				local healthPercent = math.clamp(char.Humanoid.Health / char.Humanoid.MaxHealth, 0, 1)
				local barW = 40 * healthPercent
				hp.Size = Vector2.new(barW, 3)
				hp.Position = Vector2.new(pos.X - barW/2, pos.Y + 10)
				hp.Color = Color3.fromRGB(255 * (1 - healthPercent), 255 * healthPercent, 0)
				hp.Visible = true
			else
				circle.Visible = false
				HealthBar[p].Visible = false
			end
		else
			circle.Visible = false
			HealthBar[p].Visible = false
		end
	end

	for p, box in pairs(ESPBoxes) do
		local char = p.Character
		if boxEnabled and char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
			local hrp = char.HumanoidRootPart
			local pos, vis = Camera:WorldToViewportPoint(hrp.Position)
			if vis then
				local dist = (Camera.CFrame.Position - hrp.Position).Magnitude
				local scale = 50 / dist
				local w, h = 20 * scale, 40 * scale
				box.Size = Vector2.new(w, h)
				box.Position = Vector2.new(pos.X - w/2, pos.Y - h/2)
				box.Visible = true

				local hp = BoxHealth[p]
				local healthPercent = math.clamp(char.Humanoid.Health / char.Humanoid.MaxHealth, 0, 1)
				hp.Size = Vector2.new(w * healthPercent, 4)
				hp.Position = Vector2.new(pos.X - w/2, pos.Y + h/2 + 2)
				hp.Color = Color3.fromRGB(255 * (1 - healthPercent), 255 * healthPercent, 0)
				hp.Visible = true
			else
				box.Visible = false
				BoxHealth[p].Visible = false
			end
		else
			box.Visible = false
			BoxHealth[p].Visible = false
		end
	end
end)
