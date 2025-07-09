local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players:GetLocalPlayer()

_G.HeadSize = 10
_G.Disabled = false

local customColorOptions = {
	["White"] = BrickColor.new("White"),
	["Grey"] = BrickColor.new("Grey"),
	["Light yellow"] = BrickColor.new("Light yellow"),
	["Brick yellow"] = BrickColor.new("Brick yellow"),
	["Light green (Mint)"] = BrickColor.new("Light green (Mint)"),
	["Light reddish violet"] = BrickColor.new("Light reddish violet"),
	["Pastel Blue"] = BrickColor.new("Pastel Blue"),
	["Light orange brown"] = BrickColor.new("Light orange brown"),
	["Nougat"] = BrickColor.new("Nougat"),
	["Bright red"] = BrickColor.new("Bright red"),
	["Med. reddish violet"] = BrickColor.new("Med. reddish violet"),
	["Bright blue"] = BrickColor.new("Bright blue"),
	["Bright yellow"] = BrickColor.new("Bright yellow"),
	["Earth orange"] = BrickColor.new("Earth orange"),
	["Black"] = BrickColor.new("Black"),
	["Dark grey"] = BrickColor.new("Dark grey"),
	["Dark green"] = BrickColor.new("Dark green"),
	["Medium green"] = BrickColor.new("Medium green"),
	["Light green"] = BrickColor.new("Light green"),
	["Light reddish orange"] = BrickColor.new("Light reddish orange"),
	["Bright violet"] = BrickColor.new("Bright violet"),
	["Bright orange"] = BrickColor.new("Bright orange"),
	["Bright bluish green"] = BrickColor.new("Bright bluish green"),
	["Bright yellowish green"] = BrickColor.new("Bright yellowish green"),
	["Light bluish violet"] = BrickColor.new("Light bluish violet"),
	["Transparent"] = BrickColor.new("Transparent"),
	["Tr. Red"] = BrickColor.new("Tr. Red"),
	["Tr. Blue"] = BrickColor.new("Tr. Blue"),
	["Tr. Yellow"] = BrickColor.new("Tr. Yellow"),
	["Tr. Green"] = BrickColor.new("Tr. Green"),
	["Tr. Flu. Red"] = BrickColor.new("Tr. Flu. Red"),
	["Tr. Flu. Blue"] = BrickColor.new("Tr. Flu. Blue"),
	["Tr. Flu. Yellow"] = BrickColor.new("Tr. Flu. Yellow"),
	["Tr. Flu. Green"] = BrickColor.new("Tr. Flu. Green"),
	["Tr. Brown"] = BrickColor.new("Tr. Brown"),
	["Medium red"] = BrickColor.new("Medium red"),
	["Medium blue"] = BrickColor.new("Medium blue"),
	["Light grey"] = BrickColor.new("Light grey"),
	["Sand green"] = BrickColor.new("Sand green"),
	["Sand red"] = BrickColor.new("Sand red"),
	["Reddish brown"] = BrickColor.new("Reddish brown"),
	["Medium stone grey"] = BrickColor.new("Medium stone grey"),
	["Dark stone grey"] = BrickColor.new("Dark stone grey"),
	["Dark red"] = BrickColor.new("Dark red"),
	["Teal"] = BrickColor.new("Teal"),
	["Pastel Blue-green"] = BrickColor.new("Pastel Blue-green"),
	["Royal purple"] = BrickColor.new("Royal purple"),
	["Hot pink"] = BrickColor.new("Hot pink"),
	["Deep orange"] = BrickColor.new("Deep orange"),
	["Really red"] = BrickColor.new("Really red"),
	["Bright reddish violet"] = BrickColor.new("Bright reddish violet"),
	["Pastel violet"] = BrickColor.new("Pastel violet"),
	["Cool yellow"] = BrickColor.new("Cool yellow"),
	["Royal blue"] = BrickColor.new("Royal blue"),
	["Camo"] = BrickColor.new("Camo"),
	["Grime"] = BrickColor.new("Grime"),
	["Shamrock"] = BrickColor.new("Shamrock"),
	["Dark taupe"] = BrickColor.new("Dark taupe"),
	["Mulberry"] = BrickColor.new("Mulberry"),
	["Indigo"] = BrickColor.new("Indigo"),
	["Maroon"] = BrickColor.new("Maroon"),
	["Ghost grey"] = BrickColor.new("Ghost grey"),
	["Steel blue"] = BrickColor.new("Steel blue"),
	["Crimson"] = BrickColor.new("Crimson"),
	["Mid gray"] = BrickColor.new("Mid gray"),
	["Institutional white"] = BrickColor.new("Institutional white"),
	["Really black"] = BrickColor.new("Really black"),
	["Smoky grey"] = BrickColor.new("Smoky grey"),
	["Sea green"] = BrickColor.new("Sea green"),
	["Baby blue"] = BrickColor.new("Baby blue"),
	["Carnation pink"] = BrickColor.new("Carnation pink"),
	["Pearl"] = BrickColor.new("Pearl"),
	["Cashmere"] = BrickColor.new("Cashmere"),
	["Pine Cone"] = BrickColor.new("Pine Cone"),
	["Khaki"] = BrickColor.new("Khaki"),
	["Sand blue"] = BrickColor.new("Sand blue"),
	["Sand violet"] = BrickColor.new("Sand violet"),
	["Medium lilac"] = BrickColor.new("Medium lilac"),
	["Olive"] = BrickColor.new("Olive"),
	["Bronze"] = BrickColor.new("Bronze"),
	["Flint"] = BrickColor.new("Flint"),
	["Salmon"] = BrickColor.new("Salmon"),
	["Magenta"] = BrickColor.new("Magenta"),
	["Cocoa"] = BrickColor.new("Cocoa"),
	["Champagne"] = BrickColor.new("Champagne"),
	["Fog"] = BrickColor.new("Fog"),
	["Storm blue"] = BrickColor.new("Storm blue"),
	["Army green"] = BrickColor.new("Army green"),
	["Moss"] = BrickColor.new("Moss"),
	["Lapis"] = BrickColor.new("Lapis"),
	["Cadet blue"] = BrickColor.new("Cadet blue"),
	["Persimmon"] = BrickColor.new("Persimmon"),
	["Eggplant"] = BrickColor.new("Eggplant"),
	["Artichoke"] = BrickColor.new("Artichoke"),
	["Evergreen"] = BrickColor.new("Evergreen"),
	["Sand"] = BrickColor.new("Sand"),
	["Gold"] = BrickColor.new("Gold"),
	["Copper"] = BrickColor.new("Copper"),
	["Silver"] = BrickColor.new("Silver"),
	["Lime green"] = BrickColor.new("Lime green"),
	["New Yeller"] = BrickColor.new("New Yeller"),
	["Orange"] = BrickColor.new("Orange"),
	["Bright yellowish orange"] = BrickColor.new("Bright yellowish orange"),
	["Tawny"] = BrickColor.new("Tawny"),
	["Marigold"] = BrickColor.new("Marigold"),
	["Banana"] = BrickColor.new("Banana"),
	["Chocolate"] = BrickColor.new("Chocolate"),
	["Galaxy"] = BrickColor.new("Galaxy"),
	["Light blue"] = BrickColor.new("Light blue"),
	["Peach"] = BrickColor.new("Peach"),
	["Rose gold"] = BrickColor.new("Rose gold"),
	["Fawn brown"] = BrickColor.new("Fawn brown"),
	["Vanilla"] = BrickColor.new("Vanilla"),
	["Mint"] = BrickColor.new("Mint"),
	["Sunrise"] = BrickColor.new("Sunrise"),
	["Night blue"] = BrickColor.new("Night blue"),
	["Pastel orange"] = BrickColor.new("Pastel orange"),
	["Yellow"] = BrickColor.new("Yellow"),
	["Cement"] = BrickColor.new("Cement"),
	["Coal"] = BrickColor.new("Coal"),
	["Water blue"] = BrickColor.new("Water blue"),
	["Obsidian"] = BrickColor.new("Obsidian"),
	["Neon pink"] = BrickColor.new("Neon pink"),
	["Wine red"] = BrickColor.new("Wine red"),
	["Sepia"] = BrickColor.new("Sepia"),
	["Cobalt"] = BrickColor.new("Cobalt"),
	["Neon yellow"] = BrickColor.new("Neon yellow"),
	["Copper brown"] = BrickColor.new("Copper brown"),
	["Ultramarine"] = BrickColor.new("Ultramarine"),
	["Sunburst"] = BrickColor.new("Sunburst"),
	["Really blue"] = BrickColor.new("Really blue"),
	["Ice"] = BrickColor.new("Ice"),
	["Turquoise"] = BrickColor.new("Turquoise"),
	["Burlap"] = BrickColor.new("Burlap"),
	["Snow white"] = BrickColor.new("Snow white"),
	["Pear"] = BrickColor.new("Pear"),
	["Steel"] = BrickColor.new("Steel"),
	["Dusty rose"] = BrickColor.new("Dusty rose"),
	["Brown"] = BrickColor.new("Brown"),
	["Tusk"] = BrickColor.new("Tusk"),
	["Driftwood"] = BrickColor.new("Driftwood"),
	["Earth orange"] = BrickColor.new("Earth orange"),
	["Gum pink"] = BrickColor.new("Gum pink"),
	["Ink blue"] = BrickColor.new("Ink blue"),
	["Ash"] = BrickColor.new("Ash"),
	["Clay"] = BrickColor.new("Clay"),
	["Forest green"] = BrickColor.new("Forest green"),
	["Terracotta"] = BrickColor.new("Terracotta"),
	["Bright yellow"] = BrickColor.new("Bright yellow"),
	["Pastel yellow"] = BrickColor.new("Pastel yellow"),
	["Mocha"] = BrickColor.new("Mocha"),
	["Deep orange"] = BrickColor.new("Deep orange"),
	["Butterscotch"] = BrickColor.new("Butterscotch"),
	["Neon green"] = BrickColor.new("Neon green"),
	["Light orange"] = BrickColor.new("Light orange"),
	["Dark blue"] = BrickColor.new("Dark blue"),
	["Cloudy grey"] = BrickColor.new("Cloudy grey"),
}

local finalUniqueColorOptions = {}
for name, brick in pairs(customColorOptions) do
    table.insert(finalUniqueColorOptions, {Name = name, BrickColor = brick})
end

table.sort(finalUniqueColorOptions, function(a, b)
    return a.Name < b.Name
end)

_G.SelectedColor = BrickColor.new("Lime green")
local foundDefault = false
for _, colorEntry in pairs(finalUniqueColorOptions) do
    if colorEntry.Name == "Lime green" then
        _G.SelectedColor = colorEntry.BrickColor
        foundDefault = true
        break
    end
end
if not foundDefault and #finalUniqueColorOptions > 0 then
    _G.SelectedColor = finalUniqueColorOptions[1].BrickColor
end


local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "HitboxExpander by Luminaprojects"
gui.ResetOnSpawn = false -- Prevent GUI from resetting on player spawn

-- Create the main frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 600, 0, 400) -- Ukuran UI lebih lebar
frame.Position = UDim2.new(0.5, -300, 0.5, -200) -- Diposisikan di tengah
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true -- Memungkinkan untuk menerima input
frame.Draggable = true -- Memungkinkan untuk diseret oleh pengguna
frame.ClipsDescendants = true -- PENTING untuk scrolling frame

-- Create the title bar
local titleBar = Instance.new("Frame", frame)
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
titleBar.BorderSizePixel = 0
titleBar.Position = UDim2.new(0, 0, 0, 0)

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, -70, 1, 0)
title.Text = "Hitbox Expander by Luminaprojects"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Position = UDim2.new(0, 0, 0, 0)
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextScaled = true
title.SizeConstraint = Enum.SizeConstraint.RelativeXX
title.TextWrapped = true

-- Create the minimize button
local minimizeBtn = Instance.new("TextButton", titleBar)
minimizeBtn.Size = UDim2.new(0, 30, 1, 0)
minimizeBtn.Position = UDim2.new(1, -65, 0, 0)
minimizeBtn.Text = "-"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 18
minimizeBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
minimizeBtn.TextColor3 = Color3.new(1, 1, 1)

-- Create the close button (X)
local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 30, 1, 0)
closeBtn.Position = UDim2.new(1, -35, 0, 0)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
closeBtn.TextColor3 = Color3.new(1, 1, 1)

-- Connect close button functionality
closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy() -- Hancurkan seluruh GUI
end)

-- Tab System Frame
local tabFrame = Instance.new("Frame", frame)
tabFrame.Size = UDim2.new(1, 0, 0, 30)
tabFrame.Position = UDim2.new(0, 0, 0, 30) -- Di bawah titleBar
tabFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
tabFrame.BorderSizePixel = 0

local tabLayout = Instance.new("UIListLayout", tabFrame)
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabLayout.Padding = UDim.new(0, 5)

-- Tab Buttons
local mainTabBtn = Instance.new("TextButton", tabFrame)
mainTabBtn.Size = UDim2.new(0.33, 0, 1, 0)
mainTabBtn.Text = "Utama"
mainTabBtn.Font = Enum.Font.GothamBold
mainTabBtn.TextSize = 16
mainTabBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
mainTabBtn.TextColor3 = Color3.new(1, 1, 1)
mainTabBtn.Name = "MainTab"

local moreSettingsTabBtn = Instance.new("TextButton", tabFrame)
moreSettingsTabBtn.Size = UDim2.new(0.33, 0, 1, 0)
moreSettingsTabBtn.Text = "Pengaturan Lainnya"
moreSettingsTabBtn.Font = Enum.Font.GothamBold
moreSettingsTabBtn.TextSize = 16
moreSettingsTabBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
moreSettingsTabBtn.TextColor3 = Color3.new(1, 1, 1)
moreSettingsTabBtn.Name = "MoreSettingsTab"

local tpToolTabBtn = Instance.new("TextButton", tabFrame)
tpToolTabBtn.Size = UDim2.new(0.34, 0, 1, 0)
tpToolTabBtn.Text = "Alat TP"
tpToolTabBtn.Font = Enum.Font.GothamBold
tpToolTabBtn.TextSize = 16
tpToolTabBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
tpToolTabBtn.TextColor3 = Color3.new(1, 1, 1)
tpToolTabBtn.Name = "TPToolTab"

-- Content Frames for each tab
local contentFrame = Instance.new("Frame", frame)
contentFrame.Size = UDim2.new(1, 0, 1, -60) -- Sisa ruang di bawah tabFrame
contentFrame.Position = UDim2.new(0, 0, 0, 60)
contentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
contentFrame.BorderSizePixel = 0
contentFrame.ClipsDescendants = true

local mainContent = Instance.new("Frame", contentFrame)
mainContent.Size = UDim2.new(1, 0, 1, 0)
mainContent.Position = UDim2.new(0, 0, 0, 0)
mainContent.BackgroundTransparency = 1
mainContent.Visible = true

local moreSettingsContent = Instance.new("Frame", contentFrame)
moreSettingsContent.Size = UDim2.new(1, 0, 1, 0)
moreSettingsContent.Position = UDim2.new(0, 0, 0, 0)
moreSettingsContent.BackgroundTransparency = 1
moreSettingsContent.Visible = false

local tpToolContent = Instance.new("Frame", contentFrame)
tpToolContent.Size = UDim2.new(1, 0, 1, 0)
tpToolContent.Position = UDim2.new(0, 0, 0, 0)
tpToolContent.BackgroundTransparency = 1
tpToolContent.Visible = false

local currentActiveTab = mainContent

local function setActiveTab(tab)
    currentActiveTab.Visible = false
    currentActiveTab = tab
    currentActiveTab.Visible = true

    mainTabBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    moreSettingsTabBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    tpToolTabBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

    if tab == mainContent then
        mainTabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    elseif tab == moreSettingsContent then
        moreSettingsTabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    elseif tab == tpToolContent then
        tpToolTabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end

mainTabBtn.MouseButton1Click:Connect(function() setActiveTab(mainContent) end)
moreSettingsTabBtn.MouseButton1Click:Connect(function() setActiveTab(moreSettingsContent) end)
tpToolTabBtn.MouseButton1Click:Connect(function() setActiveTab(tpToolContent) end)

-- Initialize active tab
setActiveTab(mainContent)


-- --- Main Tab Content (Hitbox Settings) ---
local sizeLabel = Instance.new("TextLabel", mainContent)
sizeLabel.Position = UDim2.new(0.05, 0, 0.05, 0)
sizeLabel.Size = UDim2.new(0.4, 0, 0, 25)
sizeLabel.Text = "Ukuran Hitbox:"
sizeLabel.TextColor3 = Color3.new(1, 1, 1)
sizeLabel.BackgroundTransparency = 1
sizeLabel.Font = Enum.Font.Gotham
sizeLabel.TextSize = 14
sizeLabel.TextXAlignment = Enum.TextXAlignment.Left

local sizeBox = Instance.new("TextBox", mainContent)
sizeBox.Position = UDim2.new(0.05, 0, 0.15, 0)
sizeBox.Size = UDim2.new(0.9, 0, 0, 30)
sizeBox.Text = tostring(_G.HeadSize)
sizeBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
sizeBox.TextColor3 = Color3.new(1, 1, 1)
sizeBox.Font = Enum.Font.Gotham
sizeBox.TextSize = 14
sizeBox.PlaceholderText = "Masukkan ukuran (misal: 15)"
sizeBox.TextScaled = true
sizeBox.SizeConstraint = Enum.SizeConstraint.RelativeXX

sizeBox.FocusLost:Connect(function(enterPressed)
	local num = tonumber(sizeBox.Text)
	if num and num >= 1 then
		_G.HeadSize = num
	else
		sizeBox.Text = tostring(_G.HeadSize)
	end
end)

local colorLabel = Instance.new("TextLabel", mainContent)
colorLabel.Position = UDim2.new(0.05, 0, 0.3, 0)
colorLabel.Size = UDim2.new(0.4, 0, 0, 25)
colorLabel.Text = "Warna:"
colorLabel.TextColor3 = Color3.new(1, 1, 1)
colorLabel.BackgroundTransparency = 1
colorLabel.Font = Enum.Font.Gotham
colorLabel.TextSize = 14
colorLabel.TextXAlignment = Enum.TextXAlignment.Left

local colorDropdown = Instance.new("TextButton", mainContent)
colorDropdown.Position = UDim2.new(0.05, 0, 0.4, 0)
colorDropdown.Size = UDim2.new(0.9, 0, 0, 30)
colorDropdown.Text = _G.SelectedColor.Name
colorDropdown.BackgroundColor3 = _G.SelectedColor.Color
colorDropdown.TextColor3 = Color3.new(1, 1, 1)
colorDropdown.Font = Enum.Font.Gotham
colorDropdown.TextSize = 14
colorDropdown.TextScaled = true
colorDropdown.SizeConstraint = Enum.SizeConstraint.RelativeXX
colorDropdown.ZIndex = 2

local colorOptionsFrame = Instance.new("ScrollingFrame", mainContent)
colorOptionsFrame.Size = UDim2.new(0.9, 0, 0.4, 0) -- Tinggi disesuaikan
colorOptionsFrame.Position = UDim2.new(0.05, 0, 0.5, 0) -- Posisi di bawah dropdown
colorOptionsFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
colorOptionsFrame.BackgroundTransparency = 0
colorOptionsFrame.BorderSizePixel = 0
colorOptionsFrame.ScrollBarThickness = 8
colorOptionsFrame.ScrollBarImageTransparency = 0.5
colorOptionsFrame.Visible = false
colorOptionsFrame.ZIndex = 3

local listLayout = Instance.new("UIListLayout", colorOptionsFrame)
listLayout.FillDirection = Enum.FillDirection.Vertical
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
listLayout.VerticalAlignment = Enum.VerticalAlignment.Top
listLayout.Padding = UDim.new(0, 2)

local dropdownOpen = false

local function populateColorOptions()
	for _, child in pairs(colorOptionsFrame:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end

	local optionHeight = 25
	local totalContentHeight = 0

	for _, colorEntry in pairs(finalUniqueColorOptions) do
		local opt = Instance.new("TextButton")
		opt.Size = UDim2.new(1, 0, 0, optionHeight)
		opt.Text = colorEntry.Name
		opt.BackgroundColor3 = colorEntry.BrickColor.Color
		opt.TextColor3 = Color3.new(1, 1, 1)
		opt.Font = Enum.Font.Gotham
		opt.TextSize = 13
		opt.TextScaled = true
		opt.SizeConstraint = Enum.SizeConstraint.RelativeXX
		opt.Parent = colorOptionsFrame
		opt.ZIndex = 4

		opt.MouseButton1Click:Connect(function()
			_G.SelectedColor = colorEntry.BrickColor
			colorDropdown.Text = colorEntry.Name
			colorDropdown.BackgroundColor3 = colorEntry.BrickColor.Color
			colorOptionsFrame.Visible = false
			dropdownOpen = false
		end)
		totalContentHeight += optionHeight + listLayout.Padding.Offset
	end

	colorOptionsFrame.CanvasSize = UDim2.new(0, 0, 0, totalContentHeight)
end

colorDropdown.MouseButton1Click:Connect(function()
	dropdownOpen = not dropdownOpen
	colorOptionsFrame.Visible = dropdownOpen
	if dropdownOpen then
		populateColorOptions()
	end
end)

local toggleBtn = Instance.new("TextButton", mainContent)
toggleBtn.Position = UDim2.new(0.05, 0, 0.85, 0)
toggleBtn.Size = UDim2.new(0.9, 0, 0, 30)
toggleBtn.Text = "Aktifkan Hitbox"
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 16

toggleBtn.MouseButton1Click:Connect(function()
	_G.Disabled = not _G.Disabled
	toggleBtn.Text = _G.Disabled and "Nonaktifkan Hitbox" or "Aktifkan Hitbox"
	toggleBtn.BackgroundColor3 = _G.Disabled and Color3.fromRGB(170, 0, 0) or Color3.fromRGB(0, 170, 0)
end)


-- --- More Settings Tab Content (Movement) ---
local walkSpeedLabel = Instance.new("TextLabel", moreSettingsContent)
walkSpeedLabel.Position = UDim2.new(0.05, 0, 0.05, 0)
walkSpeedLabel.Size = UDim2.new(0.4, 0, 0, 25)
walkSpeedLabel.Text = "Kecepatan Jalan:"
walkSpeedLabel.TextColor3 = Color3.new(1, 1, 1)
walkSpeedLabel.BackgroundTransparency = 1
walkSpeedLabel.Font = Enum.Font.Gotham
walkSpeedLabel.TextSize = 14
walkSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

local walkSpeedBox = Instance.new("TextBox", moreSettingsContent)
walkSpeedBox.Position = UDim2.new(0.05, 0, 0.15, 0)
walkSpeedBox.Size = UDim2.new(0.9, 0, 0, 30)
walkSpeedBox.Text = tostring(LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and LocalPlayer.Character.Humanoid.WalkSpeed or 16)
walkSpeedBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
walkSpeedBox.TextColor3 = Color3.new(1, 1, 1)
walkSpeedBox.Font = Enum.Font.Gotham
walkSpeedBox.TextSize = 14
walkSpeedBox.PlaceholderText = "Misal: 16"
walkSpeedBox.TextScaled = true
walkSpeedBox.SizeConstraint = Enum.SizeConstraint.RelativeXX

walkSpeedBox.FocusLost:Connect(function()
    local num = tonumber(walkSpeedBox.Text)
    if num and num >= 0 and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = num
    else
        walkSpeedBox.Text = tostring(LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and LocalPlayer.Character.Humanoid.WalkSpeed or 16)
    end
end)

local jumpPowerLabel = Instance.new("TextLabel", moreSettingsContent)
jumpPowerLabel.Position = UDim2.new(0.05, 0, 0.3, 0)
jumpPowerLabel.Size = UDim2.new(0.4, 0, 0, 25)
jumpPowerLabel.Text = "Kekuatan Lompat:"
jumpPowerLabel.TextColor3 = Color3.new(1, 1, 1)
jumpPowerLabel.BackgroundTransparency = 1
jumpPowerLabel.Font = Enum.Font.Gotham
jumpPowerLabel.TextSize = 14
jumpPowerLabel.TextXAlignment = Enum.TextXAlignment.Left

local jumpPowerBox = Instance.new("TextBox", moreSettingsContent)
jumpPowerBox.Position = UDim2.new(0.05, 0, 0.4, 0)
jumpPowerBox.Size = UDim2.new(0.9, 0, 0, 30)
jumpPowerBox.Text = tostring(LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and LocalPlayer.Character.Humanoid.JumpPower or 50)
jumpPowerBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
jumpPowerBox.TextColor3 = Color3.new(1, 1, 1)
jumpPowerBox.Font = Enum.Font.Gotham
jumpPowerBox.TextSize = 14
jumpPowerBox.PlaceholderText = "Misal: 50"
jumpPowerBox.TextScaled = true
jumpPowerBox.SizeConstraint = Enum.SizeConstraint.RelativeXX

jumpPowerBox.FocusLost:Connect(function()
    local num = tonumber(jumpPowerBox.Text)
    if num and num >= 0 and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = num
    else
        jumpPowerBox.Text = tostring(LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and LocalPlayer.Character.Humanoid.JumpPower or 50)
    end
end)

local movementNote = Instance.new("TextLabel", moreSettingsContent)
movementNote.Position = UDim2.new(0.05, 0, 0.55, 0)
movementNote.Size = UDim2.new(0.9, 0, 0.2, 0)
movementNote.Text = "(Catatan: Perubahan ini akan langsung diterapkan pada karakter Anda di game.)"
movementNote.TextColor3 = Color3.fromRGB(150, 150, 150)
movementNote.BackgroundTransparency = 1
movementNote.Font = Enum.Font.Gotham
movementNote.TextSize = 12
movementNote.TextWrapped = true
movementNote.TextXAlignment = Enum.TextXAlignment.Left


-- --- TP Tool Tab Content ---
local tpMessageLabel = Instance.new("TextLabel", tpToolContent)
tpMessageLabel.Position = UDim2.new(0.05, 0, 0.05, 0)
tpMessageLabel.Size = UDim2.new(0.9, 0, 0, 25)
tpMessageLabel.Text = "Pesan TP:"
tpMessageLabel.TextColor3 = Color3.new(1, 1, 1)
tpMessageLabel.BackgroundTransparency = 1
tpMessageLabel.Font = Enum.Font.Gotham
tpMessageLabel.TextSize = 14
tpMessageLabel.TextXAlignment = Enum.TextXAlignment.Left

local tpStatusBox = Instance.new("TextBox", tpToolContent)
tpStatusBox.Position = UDim2.new(0.05, 0, 0.15, 0)
tpStatusBox.Size = UDim2.new(0.9, 0, 0, 30)
tpStatusBox.Text = "Siap untuk teleportasi."
tpStatusBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
tpStatusBox.TextColor3 = Color3.new(1, 1, 1)
tpStatusBox.Font = Enum.Font.Gotham
tpStatusBox.TextSize = 14
tpStatusBox.TextScaled = true
tpStatusBox.SizeConstraint = Enum.SizeConstraint.RelativeXX
tpStatusBox.ClearTextOnFocus = false
tpStatusBox.Editable = false -- Tidak bisa diedit pengguna

local tpToClickBtn = Instance.new("TextButton", tpToolContent)
tpToClickBtn.Position = UDim2.new(0.05, 0, 0.3, 0)
tpToClickBtn.Size = UDim2.new(0.9, 0, 0, 30)
tpToClickBtn.Text = "Aktifkan Alat TP (Klik Lokasi)"
tpToClickBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
tpToClickBtn.TextColor3 = Color3.new(1, 1, 1)
tpToClickBtn.Font = Enum.Font.GothamBold
tpToClickBtn.TextSize = 16

local tpToolActive = false
local mouse = LocalPlayer:GetMouse()

tpToClickBtn.MouseButton1Click:Connect(function()
    tpToolActive = not tpToolActive
    if tpToolActive then
        tpStatusBox.Text = "TP Tool diaktifkan! Klik di game untuk teleportasi."
        tpToClickBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0) -- Warna oranye saat aktif
        tpToClickBtn.Text = "Nonaktifkan Alat TP (Klik Lokasi)"
    else
        tpStatusBox.Text = "TP Tool dinonaktifkan."
        tpToClickBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200) -- Warna biru saat tidak aktif
        tpToClickBtn.Text = "Aktifkan Alat TP (Klik Lokasi)"
    end
end)

mouse.Button1Down:Connect(function()
    if tpToolActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local targetPosition = mouse.Hit.p
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(0, 3, 0)) -- Sedikit di atas tanah
        tpStatusBox.Text = "Teleportasi ke lokasi yang diklik!"
        tpToolActive = false -- Nonaktifkan setelah teleportasi
        tpToClickBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
        tpToClickBtn.Text = "Aktifkan Alat TP (Klik Lokasi)"
    end
end)

local playerListLabel = Instance.new("TextLabel", tpToolContent)
playerListLabel.Position = UDim2.new(0.05, 0, 0.45, 0)
playerListLabel.Size = UDim2.new(0.4, 0, 0, 25)
playerListLabel.Text = "Teleportasi ke Pemain:"
playerListLabel.TextColor3 = Color3.new(1, 1, 1)
playerListLabel.BackgroundTransparency = 1
playerListLabel.Font = Enum.Font.Gotham
playerListLabel.TextSize = 14
playerListLabel.TextXAlignment = Enum.TextXAlignment.Left

local playerListFrame = Instance.new("ScrollingFrame", tpToolContent)
playerListFrame.Size = UDim2.new(0.9, 0, 0.3, 0) -- Tinggi untuk daftar pemain
playerListFrame.Position = UDim2.new(0.05, 0, 0.55, 0)
playerListFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
playerListFrame.BackgroundTransparency = 0
playerListFrame.BorderSizePixel = 0
playerListFrame.ScrollBarThickness = 8
playerListFrame.ScrollBarImageTransparency = 0.5
playerListFrame.ZIndex = 3

local playerListLayout = Instance.new("UIListLayout", playerListFrame)
playerListLayout.FillDirection = Enum.FillDirection.Vertical
playerListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
playerListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
playerListLayout.Padding = UDim.new(0, 2)

local selectedPlayerId = nil

local function updatePlayerList()
    -- Hapus entri pemain lama
    for _, child in pairs(playerListFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    local playersInGame = Players:GetPlayers()
    local optionHeight = 25
    local totalContentHeight = 0

    -- Tambahkan pemain lokal dulu
    local localPlayerOpt = Instance.new("TextButton")
    localPlayerOpt.Size = UDim2.new(1, 0, 0, optionHeight)
    localPlayerOpt.Text = LocalPlayer.Name .. " (Anda)"
    localPlayerOpt.BackgroundColor3 = Color3.fromRGB(70, 70, 100) -- Warna berbeda untuk pemain lokal
    localPlayerOpt.TextColor3 = Color3.new(1, 1, 1)
    localPlayerOpt.Font = Enum.Font.Gotham
    localPlayerOpt.TextSize = 14
    localPlayerOpt.TextScaled = true
    localPlayerOpt.SizeConstraint = Enum.SizeConstraint.RelativeXX
    localPlayerOpt.Parent = playerListFrame
    localPlayerOpt.ZIndex = 4
    localPlayerOpt.MouseButton1Click:Connect(function()
        selectedPlayerId = LocalPlayer.UserId
        tpStatusBox.Text = "Anda memilih diri sendiri. Tidak perlu teleportasi."
    end)
    totalContentHeight += optionHeight + playerListLayout.Padding.Offset

    -- Urutkan pemain lain berdasarkan nama
    table.sort(playersInGame, function(a, b)
        return a.Name < b.Name
    end)

    for _, player in ipairs(playersInGame) do
        if player ~= LocalPlayer then -- Jangan tampilkan pemain lokal lagi
            local opt = Instance.new("TextButton")
            opt.Size = UDim2.new(1, 0, 0, optionHeight)
            opt.Text = player.Name
            opt.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            opt.TextColor3 = Color3.new(1, 1, 1)
            opt.Font = Enum.Font.Gotham
            opt.TextSize = 14
            opt.TextScaled = true
            opt.SizeConstraint = Enum.SizeConstraint.RelativeXX
            opt.Parent = playerListFrame
            opt.ZIndex = 4

            opt.MouseButton1Click:Connect(function()
                selectedPlayerId = player.UserId
                tpStatusBox.Text = "Pemain terpilih: " .. player.Name
            end)
            totalContentHeight += optionHeight + playerListLayout.Padding.Offset
        end
    end
    playerListFrame.CanvasSize = UDim2.new(0, 0, 0, totalContentHeight)
end

-- Perbarui daftar pemain saat pemain bergabung atau keluar
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)

-- Panggil pertama kali saat script dimulai
updatePlayerList()

local tpToSelectedPlayerBtn = Instance.new("TextButton", tpToolContent)
tpToSelectedPlayerBtn.Position = UDim2.new(0.05, 0, 0.9, 0)
tpToSelectedPlayerBtn.Size = UDim2.new(0.9, 0, 0, 30)
tpToSelectedPlayerBtn.Text = "Teleportasi ke Pemain Terpilih"
tpToSelectedPlayerBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
tpToSelectedPlayerBtn.TextColor3 = Color3.new(1, 1, 1)
tpToSelectedPlayerBtn.Font = Enum.Font.GothamBold
tpToSelectedPlayerBtn.TextSize = 16

tpToSelectedPlayerBtn.MouseButton1Click:Connect(function()
    if selectedPlayerId and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local targetPlayer = Players:GetPlayerByUserId(selectedPlayerId)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            -- Teleportasi ke posisi targetPlayer + sedikit offset Y untuk menghindari terjebak di dalam tanah
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 3, 0))
            tpStatusBox.Text = "Teleportasi ke " .. targetPlayer.Name .. " berhasil!"
        else
            tpStatusBox.Text = "Pemain tidak ditemukan atau karakternya tidak ada."
        end
    else
        tpStatusBox.Text = "Pilih pemain terlebih dahulu."
    end
end)


-- Minimize functionality
local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	local goalSize = minimized and UDim2.new(0, 600, 0, 30) or UDim2.new(0, 600, 0, 400) -- Tinggi 30 hanya untuk bilah judul
	TweenService:Create(frame, TweenInfo.new(0.25), {Size = goalSize}):Play()

	-- Sembunyikan/tampilkan semua elemen kecuali titleBar
	for _, v in pairs(frame:GetChildren()) do
		if v ~= titleBar then
			v.Visible = not minimized
		end
	end
    -- Pastikan color options frame tersembunyi saat diminimalkan
	if minimized then
		colorOptionsFrame.Visible = false
		dropdownOpen = false
	end
end)

-- Hitbox expansion logic (runs every frame)
RunService.RenderStepped:Connect(function()
	if _G.Disabled then
		for _, plr in pairs(Players:GetPlayers()) do
			if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
				-- Pastikan kita tidak mengubah hitbox pemain lokal itu sendiri
				if plr ~= LocalPlayer then
					local part = plr.Character.HumanoidRootPart
					pcall(function() -- Gunakan pcall untuk mencegah error script menghentikan loop
						part.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
						part.Transparency = 0.7
						part.BrickColor = _G.SelectedColor
						part.Material = Enum.Material.Neon
						part.CanCollide = false
					end)
				end
			end
		end
	end
end)