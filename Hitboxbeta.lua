local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "HitboxExpander BETA"

local frame = Instance.new("Frame", ScreenGui)
frame.Size = UDim2.new(0, 320, 0, 440)
frame.Position = UDim2.new(0.5, -160, 0.5, -220)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local minimizeButton = Instance.new("TextButton", frame)
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -35, 0, 5)
minimizeButton.Text = "-"
minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.BorderSizePixel = 0

local minimized = false
local originalSize = frame.Size

minimizeButton.MouseButton1Click:Connect(function()
	if minimized then
		frame:TweenSize(originalSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
	else
		frame:TweenSize(UDim2.new(0, 320, 0, 40), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
	end
	minimized = not minimized
end)

-- Tabs
local tabNames = {"Color", "More Fitur", "HitboxSetting"}
local tabFrames = {}
local buttons = {}

local tabBar = Instance.new("Frame", frame)
tabBar.Size = UDim2.new(1, 0, 0, 30)
tabBar.Position = UDim2.new(0, 0, 0, 0)
tabBar.BackgroundTransparency = 1

for i, name in ipairs(tabNames) do
	local btn = Instance.new("TextButton", tabBar)
	btn.Size = UDim2.new(1 / #tabNames, 0, 1, 0)
	btn.Position = UDim2.new((i - 1) / #tabNames, 0, 0, 0)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(50 + i * 20, 50, 50)
	btn.TextColor3 = Color3.new(1, 1, 1)
	buttons[name] = btn
end

local container = Instance.new("Frame", frame)
container.Size = UDim2.new(1, 0, 1, -60)
container.Position = UDim2.new(0, 0, 0, 30)
container.BackgroundTransparency = 1

-- Color Tab
local colorFrame = Instance.new("Frame", container)
colorFrame.Size = UDim2.new(1, 0, 1, 0)
colorFrame.BackgroundTransparency = 1
tabFrames["Color"] = colorFrame

local searchBox = Instance.new("TextBox", colorFrame)
searchBox.Size = UDim2.new(1, -20, 0, 30)
searchBox.Position = UDim2.new(0, 10, 0, 0)
searchBox.PlaceholderText = "Search color..."
searchBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
searchBox.TextColor3 = Color3.new(1, 1, 1)
searchBox.Text = ""

local scrollFrame = Instance.new("ScrollingFrame", colorFrame)
scrollFrame.Position = UDim2.new(0, 10, 0, 40)
scrollFrame.Size = UDim2.new(1, -20, 1, -50)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.ScrollBarThickness = 6
scrollFrame.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scrollFrame)
layout.Padding = UDim.new(0, 5)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- 999 Warna
local baseColorNames = {"Lime green", "Really blue", "Black", "New Yeller", "White", "Bright violet", "Hot pink", "Bright orange", "Pastel Blue", "Crimson", "Royal purple", "Bright bluish green", "Bright yellow", "Salmon", "Dark green", "Steel blue", "Lavender", "Bright red", "Cool yellow", "Teal", "Cyan", "Magenta", "Brick yellow", "Dark stone grey", "Earth green", "Navy blue", "Medium stone grey", "Reddish brown", "Medium red", "Bright green", "Pastel orange", "Pastel yellow", "Pastel green", "Pastel violet", "Pastel Blue-green", "Medium lilac", "Bright reddish violet", "Sand green", "Sand blue", "Pearl gold", "Pearl light grey", "Ghost grey", "Really black", "Bright blue", "Light blue", "Light red", "Light green", "Khaki", "Alder", "Artichoke", "Burgundy", "Cashmere", "Copper", "CGA brown", "Dark taupe", "Dusty Rose", "Fawn brown", "Fog", "Grime", "Institutional white", "Lilac", "Mulberry", "Moss", "Nougat", "Olivine", "Persimmon", "Really red", "Royal blue", "Rust", "Sage green", "Seashell", "Shamrock", "Slime green", "Smoky grey", "Storm blue", "Sunrise", "Sunset", "Taupe", "Toothpaste", "Wheat", "Really yellow", "Institutional blue", "Camo", "Eggplant", "Carnation pink", "Deep orange", "Pastel brown", "Lavender grey", "Fog grey", "Baby blue", "Mauve", "Tan", "Very light orange", "Bright yellowish green", "Plum", "Rose", "Very dark grey"}
local allButtons = {}

for i = 1, 999 do
	local name = baseColorNames[(i - 1) % #baseColorNames + 1]
	local full = name .. " #" .. i
	local btn = Instance.new("TextButton", scrollFrame)
	btn.Name = full
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.BackgroundColor3 = BrickColor.new(name).Color
	btn.Text = full
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.BorderSizePixel = 0
	table.insert(allButtons, btn)

	btn.MouseButton1Click:Connect(function()
		_G.SelectedColor = BrickColor.new(name)
	end)
end

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
	local query = string.lower(searchBox.Text)
	for _, btn in ipairs(allButtons) do
		btn.Visible = (query == "") or string.find(string.lower(btn.Name), query)
	end
end)

-- More Fitur Tab
local moreFrame = Instance.new("Frame", container)
moreFrame.Size = UDim2.new(1, 0, 1, 0)
moreFrame.BackgroundTransparency = 1
tabFrames["More Fitur 📜"] = moreFrame

local wsInput = Instance.new("TextBox", moreFrame)
wsInput.PlaceholderText = "WalkSpeed"
wsInput.Size = UDim2.new(0.5, -15, 0, 25)
wsInput.Position = UDim2.new(0, 10, 0, 10)
wsInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
wsInput.TextColor3 = Color3.new(1,1,1)
wsInput.ClearTextOnFocus = false
wsInput.FocusLost:Connect(function()
	local val = tonumber(wsInput.Text)
	if val then LocalPlayer.Character.Humanoid.WalkSpeed = val end
end)

local jpInput = wsInput:Clone()
jpInput.PlaceholderText = "JumpPower"
jpInput.Position = UDim2.new(0.5, 5, 0, 10)
jpInput.Parent = moreFrame
jpInput.FocusLost:Connect(function()
	local val = tonumber(jpInput.Text)
	if val then LocalPlayer.Character.Humanoid.JumpPower = val end
end)

-- HitboxSetting Tab
local hitboxFrame = Instance.new("Frame", container)
hitboxFrame.Size = UDim2.new(1, 0, 1, 0)
hitboxFrame.BackgroundTransparency = 1
tabFrames["HitboxSetting"] = hitboxFrame

local sizeX = Instance.new("TextBox", hitboxFrame)
sizeX.PlaceholderText = "Size X"
sizeX.Position = UDim2.new(0, 10, 0, 10)
sizeX.Size = UDim2.new(0.3, -15, 0, 25)
sizeX.BackgroundColor3 = Color3.fromRGB(40,40,40)
sizeX.TextColor3 = Color3.new(1,1,1)
sizeX.Text = "5"

local sizeY = sizeX:Clone()
sizeY.PlaceholderText = "Y"
sizeY.Position = UDim2.new(0.35, 5, 0, 10)
sizeY.Parent = hitboxFrame
sizeY.Text = "5"

local sizeZ = sizeX:Clone()
sizeZ.PlaceholderText = "Z"
sizeZ.Position = UDim2.new(0.7, 5, 0, 10)
sizeZ.Parent = hitboxFrame
sizeZ.Text = "1"

local toggle = Instance.new("TextButton", hitboxFrame)
toggle.Text = "Toggle Hitbox OFF"
toggle.Size = UDim2.new(1, -20, 0, 25)
toggle.Position = UDim2.new(0, 10, 0, 45)
toggle.BackgroundColor3 = Color3.fromRGB(70, 100, 70)
toggle.TextColor3 = Color3.new(1,1,1)

_G.HitboxEnabled = false
toggle.MouseButton1Click:Connect(function()
	_G.HitboxEnabled = not _G.HitboxEnabled
	toggle.Text = _G.HitboxEnabled and "Toggle Hitbox ON" or "Toggle Hitbox OFF"
end)

for _, frameTab in pairs(tabFrames) do
	frameTab.Parent = container
	frameTab.Visible = false
end
tabFrames["Color"].Visible = true

for name, btn in pairs(buttons) do
	btn.MouseButton1Click:Connect(function()
		for n, f in pairs(tabFrames) do f.Visible = false end
		tabFrames[name].Visible = true
	end)
end

-- Credit
local credit = Instance.new("TextLabel", frame)
credit.Size = UDim2.new(1, 0, 0, 30)
credit.Position = UDim2.new(0, 0, 1, -30)
credit.BackgroundTransparency = 1
credit.Text = "⭐ Luminaprojects - Youtube Luminaprojects ⭐"
credit.TextColor3 = Color3.new(1, 1, 0.4)
credit.TextScaled = true
credit.Font = Enum.Font.SourceSansBold
