local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

_G.HeadSize = 15
_G.Disabled = false
_G.SelectedColor = BrickColor.new("Lime green") -- Initial color

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "Luminaprojects - hitbox V1"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 220)
frame.Position = UDim2.new(0.5, -150, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local minimizeBtn = Instance.new("TextButton", frame)
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -35, 0, 5)
minimizeBtn.Text = "-"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 18
minimizeBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
minimizeBtn.TextColor3 = Color3.new(1, 1, 1)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -40, 0, 30)
title.Text = "Luminaprojects - hitbox V1"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Position = UDim2.new(0, 0, 0, 0)

local sizeLabel = Instance.new("TextLabel", frame)
sizeLabel.Position = UDim2.new(0, 10, 0, 40)
sizeLabel.Size = UDim2.new(0, 120, 0, 25)
sizeLabel.Text = "Hitbox Size:"
sizeLabel.TextColor3 = Color3.new(1, 1, 1)
sizeLabel.BackgroundTransparency = 1
sizeLabel.Font = Enum.Font.Gotham
sizeLabel.TextSize = 14

local sizeBox = Instance.new("TextBox", frame)
sizeBox.Position = UDim2.new(0, 140, 0, 40)
sizeBox.Size = UDim2.new(0, 140, 0, 25)
sizeBox.Text = tostring(_G.HeadSize)
sizeBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
sizeBox.TextColor3 = Color3.new(1, 1, 1)
sizeBox.Font = Enum.Font.Gotham
sizeBox.TextSize = 14
sizeBox.FocusLost:Connect(function()
	local num = tonumber(sizeBox.Text)
	if num then
		_G.HeadSize = num
	end
end)

local colorLabel = Instance.new("TextLabel", frame)
colorLabel.Position = UDim2.new(0, 10, 0, 75)
colorLabel.Size = UDim2.new(0, 120, 0, 25)
colorLabel.Text = "Color:"
colorLabel.TextColor3 = Color3.new(1, 1, 1)
colorLabel.BackgroundTransparency = 1
colorLabel.Font = Enum.Font.Gotham
colorLabel.TextSize = 14

local colorDropdown = Instance.new("TextButton", frame)
colorDropdown.Position = UDim2.new(0, 140, 0, 75)
colorDropdown.Size = UDim2.new(0, 140, 0, 25)
colorDropdown.Text = "Lime green" -- Initial text
colorDropdown.BackgroundColor3 = BrickColor.new("Lime green").Color -- Initial background color
colorDropdown.TextColor3 = Color3.new(1, 1, 1)
colorDropdown.Font = Enum.Font.Gotham
colorDropdown.TextSize = 14

-- Expanded list of BrickColors
local colorOptions = {
    ["White"] = BrickColor.new("White"),
    ["Light Stone Grey"] = BrickColor.new("Light stone grey"),
    ["Medium Stone Grey"] = BrickColor.new("Medium stone grey"),
    ["Dark Stone Grey"] = BrickColor.new("Dark stone grey"),
    ["Black"] = BrickColor.new("Black"),
    ["Really Black"] = BrickColor.new("Really black"),
    ["Brown"] = BrickColor.new("Brown"),
    ["Dark Brown"] = BrickColor.new("Dark brown"),
    ["Fossil"] = BrickColor.new("Fossil"),
    ["Sand Red"] = BrickColor.new("Sand red"),
    ["Dark Orange"] = BrickColor.new("Dark orange"),
    ["Bright Orange"] = BrickColor.new("Bright orange"),
    ["Earth Orange"] = BrickColor.new("Earth orange"),
    ["New Yeller"] = BrickColor.new("New Yeller"),
    ["Bright Yellow"] = BrickColor.new("Bright yellow"),
    ["Pastel Yellow"] = BrickColor.new("Pastel yellow"),
    ["Light Yellow"] = BrickColor.new("Light yellow"),
    ["Cool Yellow"] = BrickColor.new("Cool yellow"),
    ["Lime Green"] = BrickColor.new("Lime green"),
    ["Bright Green"] = BrickColor.new("Bright green"),
    ["Dark Green"] = BrickColor.new("Dark green"),
    ["Forest Green"] = BrickColor.new("Forest green"),
    ["Deep Green"] = BrickColor.new("Deep green"),
    ["Really Green"] = BrickColor.new("Really green"),
    ["Sea Green"] = BrickColor.new("Sea green"),
    ["Teal"] = BrickColor.new("Teal"),
    ["Institutional White"] = BrickColor.new("Institutional white"),
    ["Cadet Blue"] = BrickColor.new("Cadet blue"),
    ["Dark Blue"] = BrickColor.new("Dark blue"),
    ["Bright Blue"] = BrickColor.new("Bright blue"),
    ["Really Blue"] = BrickColor.new("Really blue"),
    ["Medium Blue"] = BrickColor.new("Medium blue"),
    ["Navy Blue"] = BrickColor.new("Navy blue"),
    ["Storm Blue"] = BrickColor.new("Storm blue"),
    ["Lapis"] = BrickColor.new("Lapis"),
    ["Royal Blue"] = BrickColor.new("Royal blue"),
    ["Electric Blue"] = BrickColor.new("Electric blue"),
    ["Bright Violet"] = BrickColor.new("Bright violet"),
    ["Lilac"] = BrickColor.new("Lilac"),
    ["Lavender"] = BrickColor.new("Lavender"),
    ["Plum"] = BrickColor.new("Plum"),
    ["Hot Pink"] = BrickColor.new("Hot pink"),
    ["Bright Red"] = BrickColor.new("Bright red"),
    ["Really Red"] = BrickColor.new("Really red"),
    ["Dark Red"] = BrickColor.new("Dark red"),
    ["Maroon"] = BrickColor.new("Maroon"),
    ["Crimson"] = BrickColor.new("Crimson"),
    ["Cork"] = BrickColor.new("Cork"),
    ["Burlap"] = BrickColor.new("Burlap"),
    ["Khaki"] = BrickColor.new("Khaki"),
    ["Pastel Blue"] = BrickColor.new("Pastel blue"),
    ["Dusty Rose"] = BrickColor.new("Dusty rose"),
    ["Baby Blue"] = BrickColor.new("Baby blue"),
    ["Artichoke"] = BrickColor.new("Artichoke"),
    ["Faded Green"] = BrickColor.new("Faded green"),
    ["Sage Green"] = BrickColor.new("Sage green"),
    ["Moss Green"] = BrickColor.new("Moss green"),
    ["Camo"] = BrickColor.new("Camo"),
    ["Grime"] = BrickColor.new("Grime"),
    ["Olive"] = BrickColor.new("Olive"),
    ["Army Green"] = BrickColor.new("Army green"),
    ["Shamrock"] = BrickColor.new("Shamrock"),
    ["Dark Teal"] = BrickColor.new("Dark teal"),
    ["Quill Grey"] = BrickColor.new("Quill grey"),
    ["Fog"] = BrickColor.new("Fog"),
    ["Cloudy Grey"] = BrickColor.new("Cloudy grey"),
    ["Smoky Grey"] = BrickColor.new("Smoky grey"),
    ["Gunmetal"] = BrickColor.new("Gunmetal"),
    ["Ash Grey"] = BrickColor.new("Ash grey"),
    ["Ghost Grey"] = BrickColor.new("Ghost grey"),
    ["Dark Indigo"] = BrickColor.new("Dark indigo"),
    ["Deep Blue"] = BrickColor.new("Deep blue"),
    ["Violet"] = BrickColor.new("Violet"),
    ["Bright Lilac"] = BrickColor.new("Bright lilac"),
    ["Dark Indigo"] = BrickColor.new("Dark indigo"), -- Duplicate, but keeping for variety if user wants
    ["Dark Maroon"] = BrickColor.new("Dark maroon"),
    ["Deep Orange"] = BrickColor.new("Deep orange"),
    ["Gold"] = BrickColor.new("Gold"),
    ["Pearl"] = BrickColor.new("Pearl"),
    ["Dark Gold"] = BrickColor.new("Dark gold"),
    ["Bronze"] = BrickColor.new("Bronze"),
    ["Copper"] = BrickColor.new("Copper"),
    ["Sand Green"] = BrickColor.new("Sand green"),
    ["Dark Taupe"] = BrickColor.new("Dark taupe"),
    ["Medium Brown"] = BrickColor.new("Medium brown"),
    ["Light Brown"] = BrickColor.new("Light brown"),
    ["Tan"] = BrickColor.new("Tan"),
    ["Cream"] = BrickColor.new("Cream"),
    ["Beige"] = BrickColor.new("Beige"),
    ["Light Orange"] = BrickColor.new("Light orange"),
    ["Neon Orange"] = BrickColor.new("Neon orange"),
    ["Bright Salmon"] = BrickColor.new("Bright salmon"),
    ["Salmon"] = BrickColor.new("Salmon"),
    ["Light Reddish Violet"] = BrickColor.new("Light reddish violet"),
    ["Nougat"] = BrickColor.new("Nougat"),
    ["Medium Nougat"] = BrickColor.new("Medium nougat"),
    ["Dark Nougat"] = BrickColor.new("Dark nougat"),
    ["Bright Yellowish Green"] = BrickColor.new("Bright yellowish green"),
    ["Spring Yellowish Green"] = BrickColor.new("Spring yellowish green"),
    ["Olive Green"] = BrickColor.new("Olive green"),
    ["Dark Olive Green"] = BrickColor.new("Dark olive green"),
    ["Medium Green"] = BrickColor.new("Medium green"),
    ["Sand Green"] = BrickColor.new("Sand green"),
    ["Dark Green"] = BrickColor.new("Dark green"), -- Duplicate, but keeping for variety
    ["Earth Green"] = BrickColor.new("Earth green"),
    ["Dark Stone Grey"] = BrickColor.new("Dark stone grey"), -- Duplicate, but keeping for variety
    ["Medium Stone Grey"] = BrickColor.new("Medium stone grey"), -- Duplicate, but keeping for variety
    ["Light Stone Grey"] = BrickColor.new("Light stone grey"), -- Duplicate, but keeping for variety
    ["Sand Blue"] = BrickColor.new("Sand blue"),
    ["Medium Blue"] = BrickColor.new("Medium blue"), -- Duplicate, but keeping for variety
    ["Dark Blue"] = BrickColor.new("Dark blue"), -- Duplicate, but keeping for variety
    ["Sky Blue"] = BrickColor.new("Sky blue"),
    ["Light Blue"] = BrickColor.new("Light blue"),
    ["Aqua"] = BrickColor.new("Aqua"),
    ["Cyan"] = BrickColor.new("Cyan"),
    ["Medium Cyan"] = BrickColor.new("Medium cyan"),
    ["Dark Cyan"] = BrickColor.new("Dark cyan"),
    ["Electric Cyan"] = BrickColor.new("Electric cyan"),
    ["Bright Cyan"] = BrickColor.new("Bright cyan"),
    ["Dark Teal"] = BrickColor.new("Dark teal"), -- Duplicate, but keeping for variety
    ["Bright Greenish Yellow"] = BrickColor.new("Bright greenish yellow"),
    ["Medium Lime"] = BrickColor.new("Medium lime"),
    ["Dark Lime"] = BrickColor.new("Dark lime"),
    ["Bright Orange"] = BrickColor.new("Bright orange"), -- Duplicate, but keeping for variety
    ["Neon Yellow"] = BrickColor.new("Neon yellow"),
    ["Neon Green"] = BrickColor.new("Neon green"),
    ["Neon Blue"] = BrickColor.new("Neon blue"),
    ["Neon Red"] = BrickColor.new("Neon red"),
    ["Neon Pink"] = BrickColor.new("Neon pink"),
    ["Neon Violet"] = BrickColor.new("Neon violet"),
    ["Neon Orange"] = BrickColor.new("Neon orange"), -- Duplicate, but keeping for variety
    ["Neon Yellowish Green"] = BrickColor.new("Neon yellowish green"),
    ["Neon Bright Green"] = BrickColor.new("Neon bright green"),
    ["Neon Deep Green"] = BrickColor.new("Neon deep green"),
    ["Neon Dark Green"] = BrickColor.new("Neon dark green"),
    ["Neon Sea Green"] = BrickColor.new("Neon sea green"),
    ["Neon Teal"] = BrickColor.new("Neon teal"),
    ["Neon Dark Teal"] = BrickColor.new("Neon dark teal"),
    ["Neon Cadet Blue"] = BrickColor.new("Neon cadet blue"),
    ["Neon Dark Blue"] = BrickColor.new("Neon dark blue"),
    ["Neon Really Blue"] = BrickColor.new("Neon really blue"),
    ["Neon Medium Blue"] = BrickColor.new("Neon medium blue"),
    ["Neon Navy Blue"] = BrickColor.new("Neon navy blue"),
    ["Neon Storm Blue"] = BrickColor.new("Neon storm blue"),
    ["Neon Lapis"] = BrickColor.new("Neon lapis"),
    ["Neon Royal Blue"] = BrickColor.new("Neon royal blue"),
    ["Neon Electric Blue"] = BrickColor.new("Neon electric blue"),
    ["Neon Bright Violet"] = BrickColor.new("Neon bright violet"),
    ["Neon Lilac"] = BrickColor.new("Neon lilac"),
    ["Neon Lavender"] = BrickColor.new("Neon lavender"),
    ["Neon Plum"] = BrickColor.new("Neon plum"),
    ["Neon Hot Pink"] = BrickColor.new("Neon hot pink"),
    ["Neon Bright Red"] = BrickColor.new("Neon bright red"),
    ["Neon Really Red"] = BrickColor.new("Neon really red"),
    ["Neon Dark Red"] = BrickColor.new("Neon dark red"),
    ["Neon Maroon"] = BrickColor.new("Neon maroon"),
    ["Neon Crimson"] = BrickColor.new("Neon crimson"),
    ["Neon Brown"] = BrickColor.new("Neon brown"),
    ["Neon Dark Brown"] = BrickColor.new("Neon dark brown"),
    ["Neon Fossil"] = BrickColor.new("Neon fossil"),
    ["Neon Sand Red"] = BrickColor.new("Neon sand red"),
    ["Neon Dark Orange"] = BrickColor.new("Neon dark orange"),
    ["Neon Earth Orange"] = BrickColor.new("Neon earth orange"),
    ["Neon New Yeller"] = BrickColor.new("Neon new yeller"),
    ["Neon Bright Yellow"] = BrickColor.new("Neon bright yellow"),
    ["Neon Pastel Yellow"] = BrickColor.new("Neon pastel yellow"),
    ["Neon Light Yellow"] = BrickColor.new("Neon light yellow"),
    ["Neon Cool Yellow"] = BrickColor.new("Neon cool yellow"),
    ["Neon White"] = BrickColor.new("Neon white"),
    ["Neon Light Stone Grey"] = BrickColor.new("Neon light stone grey"),
    ["Neon Medium Stone Grey"] = BrickColor.new("Neon medium stone grey"),
    ["Neon Dark Stone Grey"] = BrickColor.new("Neon dark stone grey"),
    ["Neon Black"] = BrickColor.new("Neon black"),
    ["Neon Really Black"] = BrickColor.new("Neon really black"),
}


local dropdownOpen = false
colorDropdown.MouseButton1Click:Connect(function()
	if dropdownOpen then return end
	dropdownOpen = true

	-- Create a ScrollingFrame to hold the options
	local scrollFrame = Instance.new("ScrollingFrame", frame)
	scrollFrame.Size = UDim2.new(0, 140, 0, 150) -- Adjust height as needed for visible options
	scrollFrame.Position = UDim2.new(0, 140, 0, 105)
	scrollFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	scrollFrame.BorderSizePixel = 0
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0) -- Will be updated dynamically
	scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y -- Automatically adjust canvas size based on content
	scrollFrame.ScrollBarThickness = 8
	scrollFrame.ZIndex = 2
	scrollFrame.Name = "ColorDropdownScrollFrame"

	local yOffset = 0
	for name, brick in pairs(colorOptions) do
		local opt = Instance.new("TextButton", scrollFrame)
		opt.Size = UDim2.new(1, 0, 0, 20) -- Full width of scrollFrame
		opt.Position = UDim2.new(0, 0, 0, yOffset)
		opt.Text = name
		opt.BackgroundColor3 = brick.Color
		opt.TextColor3 = Color3.new(1, 1, 1)
		opt.Font = Enum.Font.Gotham
		opt.TextSize = 13
		opt.ZIndex = 2
		opt.Name = "DropdownOption"
		opt.MouseButton1Click:Connect(function()
			colorDropdown.Text = name
			colorDropdown.BackgroundColor3 = brick.Color
			_G.SelectedColor = brick
			scrollFrame:Destroy() -- Destroy the scroll frame when an option is selected
			dropdownOpen = false
		end)
		yOffset += 22 -- Space between options
	end

	-- Add a click detector to close the dropdown if clicked outside
	local function closeDropdown()
		if dropdownOpen then
			scrollFrame:Destroy()
			dropdownOpen = false
		end
	end

	local connection
	connection = UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and not gameProcessedEvent then
			-- Check if the click was outside the dropdown and the dropdown button itself
			local mousePos = UserInputService:GetMouseLocation()
			local dropdownAbsolutePos = colorDropdown.AbsolutePosition
			local dropdownAbsoluteSize = colorDropdown.AbsoluteSize
			local scrollFrameAbsolutePos = scrollFrame.AbsolutePosition
			local scrollFrameAbsoluteSize = scrollFrame.AbsoluteSize

			local clickedOnDropdownButton = mousePos.X >= dropdownAbsolutePos.X and mousePos.X <= (dropdownAbsolutePos.X + dropdownAbsoluteSize.X) and
											mousePos.Y >= dropdownAbsolutePos.Y and mousePos.Y <= (dropdownAbsolutePos.Y + dropdownAbsoluteSize.Y)

			local clickedOnScrollFrame = mousePos.X >= scrollFrameAbsolutePos.X and mousePos.X <= (scrollFrameAbsolutePos.X + scrollFrameAbsoluteSize.X) and
										 mousePos.Y >= scrollFrameAbsolutePos.Y and mousePos.Y <= (scrollFrameAbsolutePos.Y + scrollFrameAbsoluteSize.Y)

			if not clickedOnDropdownButton and not clickedOnScrollFrame then
				closeDropdown()
				connection:Disconnect() -- Disconnect the event listener after closing
			end
		end
	end)
end)

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

local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	local goalSize = minimized and UDim2.new(0, 300, 0, 40) or UDim2.new(0, 300, 0, 220)
	TweenService:Create(frame, TweenInfo.new(0.25), {Size = goalSize}):Play()

	for _, v in pairs(frame:GetChildren()) do
		if v ~= title and v ~= minimizeBtn and v ~= gui then -- Exclude gui itself
			v.Visible = not minimized
		end
	end
end)

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
