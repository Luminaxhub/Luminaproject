local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Global variables for hitbox settings
_G.HeadSize = 15
_G.Disabled = false
_G.SelectedColor = BrickColor.new("Lime green") -- Default selected color, ensure it's in your list

-- Create the main ScreenGui
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "HitboxExpanderV2 by Luminaprojects"
gui.ResetOnSpawn = false -- Prevent GUI from resetting on player spawn

-- Create the main frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 220)
frame.Position = UDim2.new(0.5, -150, 0.5, -110) -- Centered
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true -- Allows it to receive input
frame.Draggable = true -- Allows it to be dragged by the user
frame.ClipsDescendants = true -- Important for the scrolling frame

-- Create the title bar
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -70, 0, 30) -- Adjusted size to make space for buttons
title.Text = "Hitbox ExpanderV2 by Luminaprojects"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Position = UDim2.new(0, 0, 0, 0)
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextScaled = true
title.SizeConstraint = Enum.SizeConstraint.RelativeXX

-- Create the minimize button
local minimizeBtn = Instance.new("TextButton", frame)
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -65, 0, 0) -- Positioned next to close button
minimizeBtn.Text = "-"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 18
minimizeBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
minimizeBtn.TextColor3 = Color3.new(1, 1, 1)

-- Create the close button (X)
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 0) -- Positioned at the top right
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0) -- Red color for close
closeBtn.TextColor3 = Color3.new(1, 1, 1)

-- Connect close button functionality
closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy() -- Destroy the entire GUI
end)

-- Hitbox Size Label
local sizeLabel = Instance.new("TextLabel", frame)
sizeLabel.Position = UDim2.new(0, 10, 0, 40)
sizeLabel.Size = UDim2.new(0, 120, 0, 25)
sizeLabel.Text = "Hitbox Size:"
sizeLabel.TextColor3 = Color3.new(1, 1, 1)
sizeLabel.BackgroundTransparency = 1
sizeLabel.Font = Enum.Font.Gotham
sizeLabel.TextSize = 14
sizeLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Hitbox Size Input Box
local sizeBox = Instance.new("TextBox", frame)
sizeBox.Position = UDim2.new(0, 140, 0, 40)
sizeBox.Size = UDim2.new(0, 140, 0, 25)
sizeBox.Text = tostring(_G.HeadSize)
sizeBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
sizeBox.TextColor3 = Color3.new(1, 1, 1)
sizeBox.Font = Enum.Font.Gotham
sizeBox.TextSize = 14
sizeBox.PlaceholderText = "Enter size (e.g., 15)"
sizeBox.TextScaled = true
sizeBox.SizeConstraint = Enum.SizeConstraint.RelativeXX

sizeBox.FocusLost:Connect(function(enterPressed)
	local num = tonumber(sizeBox.Text)
	if num and num >= 1 then -- Ensure size is a positive number
		_G.HeadSize = num
	else
		sizeBox.Text = tostring(_G.HeadSize) -- Revert if invalid input
	end
end)

-- Color Label
local colorLabel = Instance.new("TextLabel", frame)
colorLabel.Position = UDim2.new(0, 10, 0, 75)
colorLabel.Size = UDim2.new(0, 120, 0, 25)
colorLabel.Text = "Color:"
colorLabel.TextColor3 = Color3.new(1, 1, 1)
colorLabel.BackgroundTransparency = 1
colorLabel.Font = Enum.Font.Gotham
colorLabel.TextSize = 14
colorLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Color Dropdown Button (displays current color)
local colorDropdown = Instance.new("TextButton", frame)
colorDropdown.Position = UDim2.new(0, 140, 0, 75)
colorDropdown.Size = UDim2.new(0, 140, 0, 25)
colorDropdown.Text = _G.SelectedColor.Name -- Display initial color name
colorDropdown.BackgroundColor3 = _G.SelectedColor.Color
colorDropdown.TextColor3 = Color3.new(1, 1, 1)
colorDropdown.Font = Enum.Font.Gotham
colorDropdown.TextSize = 14
colorDropdown.TextScaled = true
colorDropdown.SizeConstraint = Enum.SizeConstraint.RelativeXX

-- ScrollingFrame for color options
local colorOptionsFrame = Instance.new("ScrollingFrame", frame)
colorOptionsFrame.Size = UDim2.new(0, 140, 0, 100) -- Fixed height for scrollable area
colorOptionsFrame.Position = UDim2.new(0, 140, 0, 105) -- Position below the dropdown button
colorOptionsFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
colorOptionsFrame.BorderSizePixel = 0
colorOptionsFrame.ScrollBarThickness = 8
colorOptionsFrame.ScrollBarImageTransparency = 0.5
colorOptionsFrame.Visible = false -- Hidden by default
colorOptionsFrame.ZIndex = 3 -- Ensure it's on top of other elements

-- UIListLayout to arrange color options vertically
local listLayout = Instance.new("UIListLayout", colorOptionsFrame)
listLayout.FillDirection = Enum.FillDirection.Vertical
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
listLayout.VerticalAlignment = Enum.VerticalAlignment.Top
listLayout.Padding = UDim.new(0, 2) -- Padding between color options

-- Custom color options provided by the user
local customColorOptions = {
	["Sand"] = BrickColor.new("Sand"),
	["Fawn brown"] = BrickColor.new("Fawn brown"),
	["Dark red"] = BrickColor.new("Dark red"),
	["Pine green"] = BrickColor.new("Pine green"),
	["Red"] = BrickColor.new("Red"),
	["Olive"] = BrickColor.new("Olive"),
	["Green"] = BrickColor.new("Green"),
	["Army green"] = BrickColor.new("Army green"),
	["Rust"] = BrickColor.new("Rust"),
	["Bright yellowish orange"] = BrickColor.new("Bright yellowish orange"),
	["Tawny"] = BrickColor.new("Tawny"),
	["Marigold"] = BrickColor.new("Marigold"),
	["Medium stone grey"] = BrickColor.new("Medium stone grey"),
	["Silver"] = BrickColor.new("Silver"),
	["Lilac"] = BrickColor.new("Lilac"),
	["Ghost grey"] = BrickColor.new("Ghost grey"),
	["Royal purple"] = BrickColor.new("Royal purple"),
	["Bright yellowish brown"] = BrickColor.new("Bright yellowish brown"),
	["Clear blue"] = BrickColor.new("Clear blue"),
	["Coral"] = BrickColor.new("Coral"),
	["Reddish brown"] = BrickColor.new("Reddish brown"),
	["Ivory"] = BrickColor.new("Ivory"),
	["Shamrock"] = BrickColor.new("Shamrock"),
	["Mint"] = BrickColor.new("Mint"),
	["Sunrise"] = BrickColor.new("Sunrise"),
	["Night blue"] = BrickColor.new("Night blue"),
	["Pastel orange"] = BrickColor.new("Pastel orange"),
	["Dark red"] = BrickColor.new("Dark red"),
	["Galaxy"] = BrickColor.new("Galaxy"),
	["Navy blue"] = BrickColor.new("Navy blue"),
	["Yellow"] = BrickColor.new("Yellow"),
	["Flint"] = BrickColor.new("Flint"),
	["Eggplant"] = BrickColor.new("Eggplant"),
	["Terracotta"] = BrickColor.new("Terracotta"),
	["Lime green"] = BrickColor.new("Lime green"),
	["Cement"] = BrickColor.new("Cement"),
	["Pastel yellow"] = BrickColor.new("Pastel yellow"),
	["Bright violet"] = BrickColor.new("Bright violet"),
	["Coal"] = BrickColor.new("Coal"),
	["Bright reddish violet"] = BrickColor.new("Bright reddish violet"),
	["Maroon"] = BrickColor.new("Maroon"),
	["Water blue"] = BrickColor.new("Water blue"),
	["Institutional white"] = BrickColor.new("Institutional white"),
	["Mauve"] = BrickColor.new("Mauve"),
	["Obsidian"] = BrickColor.new("Obsidian"),
	["Magenta"] = BrickColor.new("Magenta"),
	["Crimson"] = BrickColor.new("Crimson"),
	["Pine cone"] = BrickColor.new("Pine cone"),
	["Orchid"] = BrickColor.new("Orchid"),
	["Sand blue"] = BrickColor.new("Sand blue"),
	["Neon pink"] = BrickColor.new("Neon pink"),
	["Baby blue"] = BrickColor.new("Baby blue"),
	["Amber"] = BrickColor.new("Amber"),
	["Wine red"] = BrickColor.new("Wine red"),
	["Sepia"] = BrickColor.new("Sepia"),
	["Cobalt"] = BrickColor.new("Cobalt"),
	["Cantaloupe"] = BrickColor.new("Cantaloupe"),
	["Neon yellow"] = BrickColor.new("Neon yellow"),
	["Pastel blue"] = BrickColor.new("Pastel blue"),
	["Sea green"] = BrickColor.new("Sea green"),
	["Copper brown"] = BrickColor.new("Copper brown"),
	["Toothpaste"] = BrickColor.new("Toothpaste"),
	["Cool yellow"] = BrickColor.new("Cool yellow"),
	["Hot pink"] = BrickColor.new("Hot pink"),
	["Black"] = BrickColor.new("Black"),
	["Ultramarine"] = BrickColor.new("Ultramarine"),
	["Sunburst"] = BrickColor.new("Sunburst"),
	["Really blue"] = BrickColor.new("Really blue"),
	["Vanilla"] = BrickColor.new("Vanilla"),
	["Pearl"] = BrickColor.new("Pearl"),
	["Sand green"] = BrickColor.new("Sand green"),
	["Ice"] = BrickColor.new("Ice"),
	["Carnation pink"] = BrickColor.new("Carnation pink"),
	["Goldenrod"] = BrickColor.new("Goldenrod"),
	["Pastel violet"] = BrickColor.new("Pastel violet"),
	["Lavender"] = BrickColor.new("Lavender"),
	["Pink"] = BrickColor.new("Pink"),
	["Turquoise"] = BrickColor.new("Turquoise"),
	["Mulberry"] = BrickColor.new("Mulberry"),
	["Rose gold"] = BrickColor.new("Rose gold"),
	["Bright green"] = BrickColor.new("Bright green"),
	["Blue"] = BrickColor.new("Blue"),
	["Cyan"] = BrickColor.new("Cyan"),
	["Pastel green"] = BrickColor.new("Pastel green"),
	["Fossil"] = BrickColor.new("Fossil"),
	["Sand red"] = BrickColor.new("Sand red"),
	["Bronze"] = BrickColor.new("Bronze"),
	["Earth orange"] = BrickColor.new("Earth orange"),
	["Grime"] = BrickColor.new("Grime"),
	["Dark taupe"] = BrickColor.new("Dark taupe"),
	["Burlap"] = BrickColor.new("Burlap"),
	["Snow white"] = BrickColor.new("Snow white"),
	["Pear"] = BrickColor.new("Pear"),
	["New Yeller"] = BrickColor.new("New Yeller"),
	["Slime green"] = BrickColor.new("Slime green"),
	["Khaki"] = BrickColor.new("Khaki"),
	["Steel blue"] = BrickColor.new("Steel blue"),
	["Cashmere"] = BrickColor.new("Cashmere"),
	["Tangerine"] = BrickColor.new("Tangerine"),
	["Steel"] = BrickColor.new("Steel"),
	["Berry"] = BrickColor.new("Berry"),
	["Slate"] = BrickColor.new("Slate"),
	["Really black"] = BrickColor.new("Really black"),
	["Stone"] = BrickColor.new("Stone"),
	["Gum pink"] = BrickColor.new("Gum pink"),
	["Ink"] = BrickColor.new("Ink"),
	["Ash grey"] = BrickColor.new("Ash grey"),
	["Dust"] = BrickColor.new("Dust"),
	["Dark green"] = BrickColor.new("Dark green"),
	["Ruby"] = BrickColor.new("Ruby"),
	["Smoky grey"] = BrickColor.new("Smoky grey"),
	["Dusty rose"] = BrickColor.new("Dusty rose"),
	["Brick yellow"] = BrickColor.new("Brick yellow"),
	["Light yellow"] = BrickColor.new("Light yellow"),
	["Light blue"] = BrickColor.new("Light blue"),
	["Peach"] = BrickColor.new("Peach"),
	["Indigo"] = BrickColor.new("Indigo"),
	["Emerald"] = BrickColor.new("Emerald"),
	["Charcoal"] = BrickColor.new("Charcoal"),
	["Sapphire"] = BrickColor.new("Sapphire"),
	["Burgundy"] = BrickColor.new("Burgundy"),
	["Sky blue"] = BrickColor.new("Sky blue"),
	["Grey"] = BrickColor.new("Grey"),
	["Beige"] = BrickColor.new("Beige"),
	["Alder"] = BrickColor.new("Alder"),
	["Bright bluish green"] = BrickColor.new("Bright bluish green"),
	["Royal blue"] = BrickColor.new("Royal blue"),
	["Gold"] = BrickColor.new("Gold"),
	["Grape"] = BrickColor.new("Grape"),
	["Bright red"] = BrickColor.new("Bright red"),
	["Pumpkin"] = BrickColor.new("Pumpkin"),
	["Clover"] = BrickColor.new("Clover"),
	["Neon orange"] = BrickColor.new("Neon orange"),
	["Dark orange"] = BrickColor.new("Dark orange"),
	["Nougat"] = BrickColor.new("Nougat"),
	["Teal"] = BrickColor.new("Teal"),
	["Dark stone grey"] = BrickColor.new("Dark stone grey"),
	["Tusk"] = BrickColor.new("Tusk"),
	["Light orange"] = BrickColor.new("Light orange"),
	["Cool red"] = BrickColor.new("Cool red"),
	["Cloudy grey"] = BrickColor.new("Cloudy grey"),
	["Dark blue"] = BrickColor.new("Dark blue"),
	["Jade"] = BrickColor.new("Jade"),
	["Butterscotch"] = BrickColor.new("Butterscotch"),
	["Storm blue"] = BrickColor.new("Storm blue"),
	["Sunset"] = BrickColor.new("Sunset"),
	["Pearl gold"] = BrickColor.new("Pearl gold"),
	["Clay"] = BrickColor.new("Clay"),
	["Really red"] = BrickColor.new("Really red"),
	["Moss"] = BrickColor.new("Moss"),
	["Ink blue"] = BrickColor.new("Ink blue"),
	["Brown"] = BrickColor.new("Brown"),
	["Mocha"] = BrickColor.new("Mocha"),
	["Deep orange"] = BrickColor.new("Deep orange"),
	["Driftwood"] = BrickColor.new("Driftwood"),
	["Platinum"] = BrickColor.new("Platinum"),
	["Forest green"] = BrickColor.new("Forest green"),
}

local dropdownOpen = false

-- Function to populate the color options frame
local function populateColorOptions()
	-- Clear existing options
	for _, child in pairs(colorOptionsFrame:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end

	local optionHeight = 20 -- Height of each color option button
	local totalContentHeight = 0

	-- Iterate through the custom color options
	for name, brick in pairs(customColorOptions) do
		local opt = Instance.new("TextButton")
		opt.Size = UDim2.new(1, 0, 0, optionHeight) -- Full width of scrolling frame
		opt.Text = name
		opt.BackgroundColor3 = brick.Color
		opt.TextColor3 = Color3.new(1, 1, 1)
		opt.Font = Enum.Font.Gotham
		opt.TextSize = 13
		opt.TextScaled = true
		opt.SizeConstraint = Enum.SizeConstraint.RelativeXX
		opt.Parent = colorOptionsFrame -- Parent to the scrolling frame

		opt.MouseButton1Click:Connect(function()
			_G.SelectedColor = brick
			colorDropdown.Text = name
			colorDropdown.BackgroundColor3 = brick.Color
			colorOptionsFrame.Visible = false -- Hide the dropdown
			dropdownOpen = false
		end)
		totalContentHeight += optionHeight + listLayout.Padding.Offset
	end

	-- Adjust CanvasSize to fit all options, allowing scrolling
	colorOptionsFrame.CanvasSize = UDim2.new(0, 0, 0, totalContentHeight)
end

-- Connect color dropdown button functionality
colorDropdown.MouseButton1Click:Connect(function()
	dropdownOpen = not dropdownOpen
	colorOptionsFrame.Visible = dropdownOpen
	if dropdownOpen then
		populateColorOptions() -- Populate only when opening
	end
end)

-- Toggle Button (Enable/Disable Hitbox)
local toggleBtn = Instance.new("TextButton", frame)
toggleBtn.Position = UDim2.new(0, 10, 0, 170)
toggleBtn.Size = UDim2.new(0, 280, 0, 30)
toggleBtn.Text = "Enable Hitbox"
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 16

toggleBtn.MouseButton1Click:Connect(function()
	_G.Disabled = not _G.Disabled
	toggleBtn.Text = _G.Disabled and "Disable Hitbox" or "Enable Hitbox"
	toggleBtn.BackgroundColor3 = _G.Disabled and Color3.fromRGB(170, 0, 0) or Color3.fromRGB(0, 170, 0)
end)

-- Minimize functionality
local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	local goalSize = minimized and UDim2.new(0, 300, 0, 30) or UDim2.new(0, 300, 0, 220) -- Height is 30 for title bar only
	TweenService:Create(frame, TweenInfo.new(0.25), {Size = goalSize}):Play()

	-- Hide/show all elements except title and control buttons
	for _, v in pairs(frame:GetChildren()) do
		if v ~= title and v ~= minimizeBtn and v ~= closeBtn then -- Exclude close button from visibility toggle
			v.Visible = not minimized
		end
	end
	-- Ensure color options frame is hidden when minimized
	if minimized then
		colorOptionsFrame.Visible = false
		dropdownOpen = false
	end
end)

-- Hitbox expansion logic (runs every frame)
RunService.RenderStepped:Connect(function()
	if _G.Disabled then
		for _, plr in pairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
				local part = plr.Character.HumanoidRootPart
				pcall(function() -- Use pcall to prevent script errors from stopping the loop
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
