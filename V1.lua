-- UI Loadstring ESP Circle & Box with Healthbar - Luminaprojects
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- ESP Data
local CircleESP = {}
local BoxESP = {}
local HealthBars = {}

-- Create UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Universal - Esp"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Size = UDim2.new(0, 240, 0, 30)
MainFrame.Position = UDim2.new(0.7, 0, 0.2, 0)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local ExpandFrame = Instance.new("Frame", ScreenGui)
ExpandFrame.Name = "ExpandFrame"
ExpandFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ExpandFrame.Size = UDim2.new(0, 240, 0, 200)
ExpandFrame.Position = UDim2.new(0.7, 0, 0.2, 30)
ExpandFrame.BackgroundTransparency = 0.2
ExpandFrame.BorderSizePixel = 0
ExpandFrame.Visible = true
Instance.new("UICorner", ExpandFrame).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "Universal - Esp"
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
	ScreenGui:Destroy()
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
	ExpandFrame.Visible = not minimized
	MainFrame.Size = UDim2.new(0, 240, 0, minimized and 30 or 30)
end)

-- Toggle
local function createToggle(name, yPos, callback)
	local Label = Instance.new("TextLabel", ExpandFrame)
	Label.Text = name
	Label.Position = UDim2.new(0, 10, 0, yPos)
	Label.Size = UDim2.new(0.5, 0, 0, 25)
	Label.BackgroundTransparency = 1
	Label.Font = Enum.Font.Gotham
	Label.TextColor3 = Color3.new(1, 1, 1)
	Label.TextSize = 13

	local Toggle = Instance.new("TextButton", ExpandFrame)
	Toggle.Size = UDim2.new(0, 50, 0, 20)
	Toggle.Position = UDim2.new(1, -60, 0, yPos + 2)
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

createToggle("Esp Circle 🛡️", 10, function(on)
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			if on and not CircleESP[player] then
				local circ = Drawing.new("Circle")
				circ.Radius = 10
				circ.Filled = true
				circ.Thickness = 1
				circ.Color = Color3.new(1, 1, 1)
				circ.Visible = false
				CircleESP[player] = circ

				local bar = Drawing.new("Line")
				bar.Thickness = 2
				bar.Color = Color3.new(0, 1, 0)
				bar.Visible = false
				HealthBars[player] = bar
			elseif not on and CircleESP[player] then
				CircleESP[player]:Remove()
				HealthBars[player]:Remove()
				CircleESP[player] = nil
				HealthBars[player] = nil
			end
		end
	end
end)

createToggle("Esp Box 🛡️", 45, function(on)
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			if on and not BoxESP[player] then
				local box = Drawing.new("Square")
				box.Thickness = 1
				box.Transparency = 0.9
				box.Color = Color3.new(1, 1, 1)
				box.Filled = false
				box.Visible = false
				BoxESP[player] = box

				local bar = Drawing.new("Line")
				bar.Thickness = 2
				bar.Color = Color3.new(0, 1, 0)
				bar.Visible = false
				HealthBars[player] = bar
			elseif not on and BoxESP[player] then
				BoxESP[player]:Remove()
				HealthBars[player]:Remove()
				BoxESP[player] = nil
				HealthBars[player] = nil
			end
		end
	end
end)

-- RGB Credit
local credit = Instance.new("TextLabel", ExpandFrame)
credit.Text = "Script by - Luminaprojects"
credit.Position = UDim2.new(0, 10, 0, 80)
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

-- Update ESP
RunService.RenderStepped:Connect(function()
	for player, circle in pairs(CircleESP) do
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
			local pos, visible = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
			if visible then
				circle.Position = Vector2.new(pos.X, pos.Y)
				circle.Visible = true

				local hp = player.Character.Humanoid.Health / player.Character.Humanoid.MaxHealth
				local bar = HealthBars[player]
				bar.From = Vector2.new(pos.X - 15, pos.Y + 15)
				bar.To = Vector2.new(pos.X - 15 + (30 * hp), pos.Y + 15)
				bar.Visible = true
			else
				circle.Visible = false
				HealthBars[player].Visible = false
			end
		else
			circle.Visible = false
			if HealthBars[player] then
				HealthBars[player].Visible = false
			end
		end
	end
	for player, box in pairs(BoxESP) do
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
			local hrp = player.Character.HumanoidRootPart
			local pos, visible = Camera:WorldToViewportPoint(hrp.Position)
			if visible then
				local dist = (Camera.CFrame.Position - hrp.Position).Magnitude
				local scale = 50 / dist
				box.Size = Vector2.new(20 * scale, 40 * scale)
				box.Position = Vector2.new(pos.X - box.Size.X / 2, pos.Y - box.Size.Y / 2)
				box.Visible = true

				local hp = player.Character.Humanoid.Health / player.Character.Humanoid.MaxHealth
				local bar = HealthBars[player]
				bar.From = Vector2.new(pos.X - 15, pos.Y + 22)
				bar.To = Vector2.new(pos.X - 15 + (30 * hp), pos.Y + 22)
				bar.Visible = true
			else
				box.Visible = false
				HealthBars[player].Visible = false
			end
		else
			box.Visible = false
			if HealthBars[player] then
				HealthBars[player].Visible = false
			end
		end
	end
end)

Players.PlayerRemoving:Connect(function(player)
	if CircleESP[player] then
		CircleESP[player]:Remove()
		CircleESP[player] = nil
	end
	if BoxESP[player] then
		BoxESP[player]:Remove()
		BoxESP[player] = nil
	end
	if HealthBars[player] then
		HealthBars[player]:Remove()
		HealthBars[player] = nil
	end
end)

Players.PlayerAdded:Connect(function(player)
	-- Recreate ESP when new player joins
end)
