local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- Settings
_G.Aimbot = true
_G.ESP = true
_G.FOVSize = 250
_G.Sensitivity = 0.4
_G.TargetPart = "Head"

-- UI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "Luminaprojects Aimbot"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 230)
frame.Position = UDim2.new(0, 20, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

local function newTextLabel(parent, text, pos)
	local label = Instance.new("TextLabel", parent)
	label.Size = UDim2.new(1, -20, 0, 20)
	label.Position = pos
	label.Text = text
	label.TextColor3 = Color3.new(1, 1, 1)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextWrapped = true
	return label
end

local function newSlider(parent, min, max, default, callback, ypos)
	local slider = Instance.new("Frame", parent)
	slider.Size = UDim2.new(1, -20, 0, 20)
	slider.Position = ypos
	slider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	slider.BorderSizePixel = 0

	local fill = Instance.new("Frame", slider)
	fill.Size = UDim2.new(default / max, 0, 1, 0)
	fill.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
	fill.BorderSizePixel = 0

	local dragging = false

	slider.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = true end
	end)
	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end
	end)
	UserInputService.InputChanged:Connect(function(i)
		if dragging then
			local percent = math.clamp((i.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
			fill.Size = UDim2.new(percent, 0, 1, 0)
			local val = math.floor((min + (max - min) * percent) * 100) / 100
			callback(val)
		end
	end)
end

local function newDropdown(parent, text, options, ypos, callback)
	local label = newTextLabel(parent, text, ypos)
	local dropdown = Instance.new("TextButton", parent)
	dropdown.Position = ypos + UDim2.new(0, 0, 0, 20)
	dropdown.Size = UDim2.new(1, -20, 0, 25)
	dropdown.Text = options[1]
	dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	dropdown.TextColor3 = Color3.new(1, 1, 1)
	dropdown.Font = Enum.Font.Gotham
	dropdown.TextSize = 14
	dropdown.BorderSizePixel = 0

	local i = 1
	dropdown.MouseButton1Click:Connect(function()
		i = (i % #options) + 1
		dropdown.Text = options[i]
		callback(options[i])
	end)
end

-- UI Elements
newTextLabel(frame, "Aimbot : ON", UDim2.new(0, 10, 0, 10))
newSlider(frame, 0.1, 1, _G.Sensitivity, function(val)
	_G.Sensitivity = val
end, UDim2.new(0, 10, 0, 30))

newTextLabel(frame, "FOV (%)", UDim2.new(0, 10, 0, 60))
newSlider(frame, 50, 600, _G.FOVSize, function(val)
	_G.FOVSize = val
end, UDim2.new(0, 10, 0, 80))

newDropdown(frame, "Target Part", {"Head", "Torso"}, UDim2.new(0, 10, 0, 110), function(part)
	_G.TargetPart = part
end)

newTextLabel(frame, "ESP : ON", UDim2.new(0, 10, 0, 140))

-- FOV Circle
local fov = Drawing.new("Circle")
fov.Color = Color3.new(1, 1, 1)
fov.Thickness = 1.2
fov.Filled = false
fov.Transparency = 0.5
fov.Visible = true

-- ESP Boxes
local function createESP(player)
	local box = Drawing.new("Square")
	box.Thickness = 1
	box.Transparency = 0.8
	box.Color = Color3.new(1, 1, 1)
	box.Filled = false
	box.Visible = false
	return box
end

local ESPBoxes = {}
for _, p in pairs(Players:GetPlayers()) do
	if p ~= LocalPlayer then
		ESPBoxes[p] = createESP(p)
	end
end

Players.PlayerAdded:Connect(function(p)
	if p ~= LocalPlayer then
		ESPBoxes[p] = createESP(p)
	end
end)

Players.PlayerRemoving:Connect(function(p)
	if ESPBoxes[p] then
		ESPBoxes[p]:Remove()
		ESPBoxes[p] = nil
	end
end)

-- Logic
local function getClosest()
	local closest, dist = nil, math.huge
	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild(_G.TargetPart) then
			local pos, onScreen = Camera:WorldToViewportPoint(plr.Character[_G.TargetPart].Position)
			if onScreen then
				local mag = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
				if mag < _G.FOVSize and mag < dist then
					closest = plr.Character[_G.TargetPart]
					dist = mag
				end
			end
		end
	end
	return closest
end

RunService.RenderStepped:Connect(function()
	fov.Position = Vector2.new(Mouse.X, Mouse.Y + 36)
	fov.Radius = _G.FOVSize

	-- ESP Box
	if _G.ESP then
		for plr, box in pairs(ESPBoxes) do
			if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
				local root = plr.Character.HumanoidRootPart
				local pos, visible = Camera:WorldToViewportPoint(root.Position)
				if visible then
					local scale = 50 / (root.Position - Camera.CFrame.Position).Magnitude
					box.Size = Vector2.new(20 * scale, 40 * scale)
					box.Position = Vector2.new(pos.X - box.Size.X/2, pos.Y - box.Size.Y/2)
					box.Visible = true
				else
					box.Visible = false
				end
			end
		end
	end

	-- Aimbot
	if _G.Aimbot then
		local target = getClosest()
		if target then
			local pos = Camera:WorldToViewportPoint(target.Position)
			local move = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)) * _G.Sensitivity
			mousemoverel(move.X, move.Y)
		end
	end
end)
