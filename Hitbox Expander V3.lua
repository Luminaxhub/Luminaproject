local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

_G.HeadSize = 15
_G.Disabled = false
_G.SelectedColor = BrickColor.new("Lime green")
_G.Key = "LuminaHitboxV3"

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "HitboxExpander - Luminaprojects"

-- Key Frame
local keyFrame = Instance.new("Frame", gui)
keyFrame.Size = UDim2.new(0, 320, 0, 150)
keyFrame.Position = UDim2.new(0.5, -160, 0.5, -75)
keyFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
keyFrame.BorderSizePixel = 0
keyFrame.Active = true
keyFrame.Draggable = true

local keyCorner = Instance.new("UICorner", keyFrame)
keyCorner.CornerRadius = UDim.new(0, 8)

local keyTitle = Instance.new("TextLabel", keyFrame)
keyTitle.Size = UDim2.new(1, 0, 0, 30)
keyTitle.Text = "🔑 Key Verifiy - Luminaprojects"
keyTitle.TextColor3 = Color3.new(1, 1, 1)
keyTitle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextSize = 16
keyTitle.Parent = keyFrame

local keyBox = Instance.new("TextBox", keyFrame)
keyBox.Size = UDim2.new(0, 280, 0, 30)
keyBox.Position = UDim2.new(0.5, -140, 0, 50)
keyBox.PlaceholderText = "Enter your key..."
keyBox.Text = ""
keyBox.TextColor3 = Color3.new(1, 1, 1)
keyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 14
keyBox.Parent = keyFrame

local verifyBtn = Instance.new("TextButton", keyFrame)
verifyBtn.Size = UDim2.new(0, 120, 0, 30)
verifyBtn.Position = UDim2.new(0.5, -60, 0, 95)
verifyBtn.Text = "✅ Verify"
verifyBtn.TextColor3 = Color3.new(1, 1, 1)
verifyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
verifyBtn.Font = Enum.Font.GothamBold
verifyBtn.TextSize = 14
verifyBtn.Parent = keyFrame

-- Main UI Frame (Hidden until verified)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 310)
frame.Position = UDim2.new(0.5, -160, 0.5, -155)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Visible = false

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Hitbox Expander - Luminaprojects"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = frame

local sizeLabel = Instance.new("TextLabel", frame)
sizeLabel.Position = UDim2.new(0, 10, 0, 40)
sizeLabel.Size = UDim2.new(0, 120, 0, 25)
sizeLabel.Text = "Hitbox Size:"
sizeLabel.TextColor3 = Color3.new(1, 1, 1)
sizeLabel.BackgroundTransparency = 1
sizeLabel.Font = Enum.Font.Gotham
sizeLabel.TextSize = 14
sizeLabel.Parent = frame

local sizeBox = Instance.new("TextBox", frame)
sizeBox.Position = UDim2.new(0, 160, 0, 40)
sizeBox.Size = UDim2.new(0, 140, 0, 25)
sizeBox.Text = tostring(_G.HeadSize)
sizeBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
sizeBox.TextColor3 = Color3.new(1, 1, 1)
sizeBox.Font = Enum.Font.Gotham
sizeBox.TextSize = 14
sizeBox.Parent = frame
sizeBox.FocusLost:Connect(function()
	local num = tonumber(sizeBox.Text)
	if num then _G.HeadSize = num end
end)

local themeLabel = Instance.new("TextLabel", frame)
themeLabel.Position = UDim2.new(0, 10, 0, 75)
themeLabel.Size = UDim2.new(0, 120, 0, 25)
themeLabel.Text = "Theme Color:"
themeLabel.TextColor3 = Color3.new(1, 1, 1)
themeLabel.BackgroundTransparency = 1
themeLabel.Font = Enum.Font.Gotham
themeLabel.TextSize = 14
themeLabel.Parent = frame

local themeBtn = Instance.new("TextButton", frame)
themeBtn.Position = UDim2.new(0, 160, 0, 75)
themeBtn.Size = UDim2.new(0, 140, 0, 25)
themeBtn.Text = "🎨 Change Theme"
themeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
themeBtn.TextColor3 = Color3.new(1, 1, 1)
themeBtn.Font = Enum.Font.Gotham
themeBtn.TextSize = 13
themeBtn.Parent = frame

local themes = {
	Color3.fromRGB(30,30,30),
	Color3.fromRGB(45,45,80),
	Color3.fromRGB(80,30,30),
	Color3.fromRGB(20,80,80),
	Color3.fromRGB(10,10,10),
	Color3.fromRGB(70,40,90),
	Color3.fromRGB(50,50,50)
}
local themeIndex = 1
themeBtn.MouseButton1Click:Connect(function()
	themeIndex += 1
	if themeIndex > #themes then themeIndex = 1 end
	frame.BackgroundColor3 = themes[themeIndex]
end)

-- Scrollable Color List
local scrollFrame = Instance.new("ScrollingFrame", frame)
scrollFrame.Position = UDim2.new(0, 10, 0, 110)
scrollFrame.Size = UDim2.new(0, 300, 0, 130)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 6
scrollFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
scrollFrame.BorderSizePixel = 0
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y

local uiList = Instance.new("UIListLayout", scrollFrame)
uiList.Padding = UDim.new(0, 2)
uiList.SortOrder = Enum.SortOrder.LayoutOrder

scrollFrame.Parent = frame

-- 50 Colors
local colorList = {}
for i, brick in ipairs(BrickColor.palette()) do
	if #colorList >= 50 then break end
	table.insert(colorList, brick)
end

for _, brick in ipairs(colorList) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 24)
	btn.Text = brick.Name
	btn.BackgroundColor3 = brick.Color
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 13
	btn.Parent = scrollFrame
	btn.MouseButton1Click:Connect(function()
		_G.SelectedColor = brick
	end)
end

local toggleBtn = Instance.new("TextButton", frame)
toggleBtn.Position = UDim2.new(0, 10, 0, 250)
toggleBtn.Size = UDim2.new(0, 300, 0, 35)
toggleBtn.Text = "Enable Hitbox"
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 16
toggleBtn.Parent = frame

toggleBtn.MouseButton1Click:Connect(function()
	_G.Disabled = not _G.Disabled
	toggleBtn.Text = _G.Disabled and "Disable Hitbox" or "Enable Hitbox"
	toggleBtn.BackgroundColor3 = _G.Disabled and Color3.fromRGB(170, 0, 0) or Color3.fromRGB(0, 170, 0)
end)

-- Key Validation Logic
verifyBtn.MouseButton1Click:Connect(function()
	if keyBox.Text == _G.Key then
		keyFrame.Visible = false
		frame.Visible = true
	else
		verifyBtn.Text = "❌ Invalid Key"
		wait(1.5)
		verifyBtn.Text = "✅ Verify"
	end
end)

-- Hitbox Function
RunService.RenderStepped:Connect(function()
	if _G.Disabled then
		for _, plr in pairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
				local part = plr.Character.HumanoidRootPart
				pcall(function()
					part.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
					part.Transparency = 0.7
					part.BrickColor = _G.SelectedColor
					part.Material = Enum.Material.Neon
					part.CanCollide = false
				end)
			end
		end
	end
end)
