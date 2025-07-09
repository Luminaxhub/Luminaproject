local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Global variables for hitbox settings
_G.HeadSize = 15
_G.Disabled = false
_G.SelectedColor = BrickColor.new("Lime green") -- Default selected color, pastikan ini ada di daftar Anda

-- Create the main ScreenGui
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "HitboxExpander by Luminaprojects"
gui.ResetOnSpawn = false -- Mencegah GUI direset saat pemain respawn

-- Create the main frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 220)
frame.Position = UDim2.new(0.5, -150, 0.5, -110) -- Diposisikan di tengah
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true -- Memungkinkan untuk menerima input
frame.Draggable = true -- Memungkinkan untuk diseret oleh pengguna
frame.ClipsDescendants = true -- PENTING untuk scrolling frame

-- Create the title bar
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -70, 0, 30) -- Ukuran disesuaikan untuk memberi ruang pada tombol
title.Text = "Hitbox Expander by Luminaprojects"
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
minimizeBtn.Position = UDim2.new(1, -65, 0, 0) -- Diposisikan di samping tombol tutup
minimizeBtn.Text = "-"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 18
minimizeBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
minimizeBtn.TextColor3 = Color3.new(1, 1, 1)

-- Create the close button (X)
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 0) -- Diposisikan di kanan atas
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0) -- Warna merah untuk tutup
closeBtn.TextColor3 = Color3.new(1, 1, 1)

-- Connect close button functionality
closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy() -- Hancurkan seluruh GUI
end)

-- Hitbox Size Label
local sizeLabel = Instance.new("TextLabel", frame)
sizeLabel.Position = UDim2.new(0, 10, 0, 40)
sizeLabel.Size = UDim2.new(0, 120, 0, 25)
sizeLabel.Text = "Ukuran Hitbox:"
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
sizeBox.PlaceholderText = "Masukkan ukuran (misal: 15)"
sizeBox.TextScaled = true
sizeBox.SizeConstraint = Enum.SizeConstraint.RelativeXX

sizeBox.FocusLost:Connect(function(enterPressed)
	local num = tonumber(sizeBox.Text)
	if num and num >= 1 then -- Pastikan ukuran adalah angka positif
		_G.HeadSize = num
	else
		sizeBox.Text = tostring(_G.HeadSize) -- Kembali jika input tidak valid
	end
end)

-- Color Label
local colorLabel = Instance.new("TextLabel", frame)
colorLabel.Position = UDim2.new(0, 10, 0, 75)
colorLabel.Size = UDim2.new(0, 120, 0, 25)
colorLabel.Text = "Warna:"
colorLabel.TextColor3 = Color3.new(1, 1, 1)
colorLabel.BackgroundTransparency = 1
colorLabel.Font = Enum.Font.Gotham
colorLabel.TextSize = 14
colorLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Color Dropdown Button (menampilkan warna saat ini)
local colorDropdown = Instance.new("TextButton", frame)
colorDropdown.Position = UDim2.new(0, 140, 0, 75)
colorDropdown.Size = UDim2.new(0, 140, 0, 25)
colorDropdown.Text = _G.SelectedColor.Name -- Menampilkan nama warna awal
colorDropdown.BackgroundColor3 = _G.SelectedColor.Color
colorDropdown.TextColor3 = Color3.new(1, 1, 1)
colorDropdown.Font = Enum.Font.Gotham
colorDropdown.TextSize = 14
colorDropdown.TextScaled = true
colorDropdown.SizeConstraint = Enum.SizeConstraint.RelativeXX
colorDropdown.ZIndex = 2 -- Pastikan ini di bawah opsi dropdown saat terbuka

-- ScrollingFrame untuk opsi warna
local colorOptionsFrame = Instance.new("ScrollingFrame", frame)
colorOptionsFrame.Size = UDim2.new(0, 140, 0, 100) -- Tinggi tetap untuk area yang dapat digulir
colorOptionsFrame.Position = UDim2.new(0, 140, 0, 105) -- Posisi di bawah tombol dropdown
colorOptionsFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
colorOptionsFrame.BackgroundTransparency = 0 -- Pastikan tidak transparan
colorOptionsFrame.BorderSizePixel = 0
colorOptionsFrame.ScrollBarThickness = 8
colorOptionsFrame.ScrollBarImageTransparency = 0.5
colorOptionsFrame.Visible = false -- Tersembunyi secara default
colorOptionsFrame.ZIndex = 3 -- Pastikan ini di atas elemen lain

-- UIListLayout untuk mengatur opsi warna secara vertikal
local listLayout = Instance.new("UIListLayout", colorOptionsFrame)
listLayout.FillDirection = Enum.FillDirection.Vertical
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
listLayout.VerticalAlignment = Enum.VerticalAlignment.Top
listLayout.Padding = UDim.new(0, 2) -- Padding antar opsi warna

-- Opsi warna kustom yang disediakan oleh pengguna
local customColorOptions = {
	["Lilac"] = BrickColor.new("Lilac"),
["Banana"] = BrickColor.new("Banana"),
["Baby blue"] = BrickColor.new("Baby blue"),
["Pink"] = BrickColor.new("Pink"),
["Cashmere"] = BrickColor.new("Cashmere"),
["Mocha"] = BrickColor.new("Mocha"),
["Tangerine"] = BrickColor.new("Tangerine"),
["Flint"] = BrickColor.new("Flint"),
["Turquoise"] = BrickColor.new("Turquoise"),
["Mocha"] = BrickColor.new("Mocha"),
["Really white"] = BrickColor.new("Really white"),
["Bright reddish violet"] = BrickColor.new("Bright reddish violet"),
["Lilac"] = BrickColor.new("Lilac"),
["Platinum"] = BrickColor.new("Platinum"),
["Reddish brown"] = BrickColor.new("Reddish brown"),
["Cantaloupe"] = BrickColor.new("Cantaloupe"),
["Bright red"] = BrickColor.new("Bright red"),
["Toothpaste"] = BrickColor.new("Toothpaste"),
["Berry"] = BrickColor.new("Berry"),
["Sky blue"] = BrickColor.new("Sky blue"),
["Bright yellowish brown"] = BrickColor.new("Bright yellowish brown"),
["Dust"] = BrickColor.new("Dust"),
["Night blue"] = BrickColor.new("Night blue"),
["Deep orange"] = BrickColor.new("Deep orange"),
["Khaki"] = BrickColor.new("Khaki"),
["Pastel green"] = BrickColor.new("Pastel green"),
["Navy blue"] = BrickColor.new("Navy blue"),
["Bright green"] = BrickColor.new("Bright green"),
["Smoky grey"] = BrickColor.new("Smoky grey"),
["Lilac"] = BrickColor.new("Lilac"),
["Bright violet"] = BrickColor.new("Bright violet"),
["Obsidian"] = BrickColor.new("Obsidian"),
["Fawn brown"] = BrickColor.new("Fawn brown"),
["Silver"] = BrickColor.new("Silver"),
["White"] = BrickColor.new("White"),
["Silver"] = BrickColor.new("Silver"),
["Burgundy"] = BrickColor.new("Burgundy"),
["Grape"] = BrickColor.new("Grape"),
["Neon blue"] = BrickColor.new("Neon blue"),
["Slime green"] = BrickColor.new("Slime green"),
["Fawn brown"] = BrickColor.new("Fawn brown"),
["Clear blue"] = BrickColor.new("Clear blue"),
["Bronze"] = BrickColor.new("Bronze"),
["Sand red"] = BrickColor.new("Sand red"),
["Lilac"] = BrickColor.new("Lilac"),
["Yellow"] = BrickColor.new("Yellow"),
["Chocolate"] = BrickColor.new("Chocolate"),
["Cashmere"] = BrickColor.new("Cashmere"),
["Gold"] = BrickColor.new("Gold"),
["Jade"] = BrickColor.new("Jade"),
["Royal purple"] = BrickColor.new("Royal purple"),
["Bright violet"] = BrickColor.new("Bright violet"),
["Bright yellowish orange"] = BrickColor.new("Bright yellowish orange"),
["Ash"] = BrickColor.new("Ash"),
["Bright violet"] = BrickColor.new("Bright violet"),
["Really white"] = BrickColor.new("Really white"),
["Clear blue"] = BrickColor.new("Clear blue"),
["Slate"] = BrickColor.new("Slate"),
["Pearl gold"] = BrickColor.new("Pearl gold"),
["Marigold"] = BrickColor.new("Marigold"),
["Deep orange"] = BrickColor.new("Deep orange"),
["Peach"] = BrickColor.new("Peach"),
["Smoky grey"] = BrickColor.new("Smoky grey"),
["Silver"] = BrickColor.new("Silver"),
["Cashmere"] = BrickColor.new("Cashmere"),
["Obsidian"] = BrickColor.new("Obsidian"),
["Indigo"] = BrickColor.new("Indigo"),
["Bronze"] = BrickColor.new("Bronze"),
["Reddish brown"] = BrickColor.new("Reddish brown"),
["Coral"] = BrickColor.new("Coral"),
["Coal"] = BrickColor.new("Coal"),
["Neon orange"] = BrickColor.new("Neon orange"),
["Pine green"] = BrickColor.new("Pine green"),
["Institutional white"] = BrickColor.new("Institutional white"),
["Light green"] = BrickColor.new("Light green"),
["Ash grey"] = BrickColor.new("Ash grey"),
["Eggplant"] = BrickColor.new("Eggplant"),
["Driftwood"] = BrickColor.new("Driftwood"),
["Mauve"] = BrickColor.new("Mauve"),
["Eggplant"] = BrickColor.new("Eggplant"),
["Sand red"] = BrickColor.new("Sand red"),
["Sand red"] = BrickColor.new("Sand red"),
["Navy blue"] = BrickColor.new("Navy blue"),
["New Yeller"] = BrickColor.new("New Yeller"),
["Dark taupe"] = BrickColor.new("Dark taupe"),
["Teal"] = BrickColor.new("Teal"),
["Clover"] = BrickColor.new("Clover"),
["Smoky grey"] = BrickColor.new("Smoky grey"),
["Pear"] = BrickColor.new("Pear"),
["Light green"] = BrickColor.new("Light green"),
["Dark red"] = BrickColor.new("Dark red"),
["Neon pink"] = BrickColor.new("Neon pink"),
["Lavender"] = BrickColor.new("Lavender"),
["Grime"] = BrickColor.new("Grime"),
["Pastel violet"] = BrickColor.new("Pastel violet"),
["Neon orange"] = BrickColor.new("Neon orange"),
["Ash grey"] = BrickColor.new("Ash grey"),
["Steel"] = BrickColor.new("Steel"),
["Brown"] = BrickColor.new("Brown"),
["Wine red"] = BrickColor.new("Wine red"),
["Vanilla"] = BrickColor.new("Vanilla"),
["Mulberry"] = BrickColor.new("Mulberry"),
["Bright yellowish brown"] = BrickColor.new("Bright yellowish brown"),
["Bright bluish green"] = BrickColor.new("Bright bluish green"),
["Dark green"] = BrickColor.new("Dark green"),
["Carnation pink"] = BrickColor.new("Carnation pink"),
["Light green"] = BrickColor.new("Light green"),
["Light yellow"] = BrickColor.new("Light yellow"),
["Burlap"] = BrickColor.new("Burlap"),
["Dark taupe"] = BrickColor.new("Dark taupe"),
["Ice"] = BrickColor.new("Ice"),
["Alder"] = BrickColor.new("Alder"),
["Grape"] = BrickColor.new("Grape"),
["Maroon"] = BrickColor.new("Maroon"),
["Dusty rose"] = BrickColor.new("Dusty rose"),
["Toothpaste"] = BrickColor.new("Toothpaste"),
["Dark blue"] = BrickColor.new("Dark blue"),
["Mulberry"] = BrickColor.new("Mulberry"),
["Fossil"] = BrickColor.new("Fossil"),
["Ice"] = BrickColor.new("Ice"),
["Water blue"] = BrickColor.new("Water blue"),
["Pear"] = BrickColor.new("Pear"),
["Dark orange"] = BrickColor.new("Dark orange"),
["Pine cone"] = BrickColor.new("Pine cone"),
["Bright yellowish green"] = BrickColor.new("Bright yellowish green"),
["Beige"] = BrickColor.new("Beige"),
["Charcoal"] = BrickColor.new("Charcoal"),
["Emerald"] = BrickColor.new("Emerald"),
["Pine cone"] = BrickColor.new("Pine cone"),
["Bright bluish green"] = BrickColor.new("Bright bluish green"),
["Sunset"] = BrickColor.new("Sunset"),
["Cobalt"] = BrickColor.new("Cobalt"),
["Light orange"] = BrickColor.new("Light orange"),
["Ivory"] = BrickColor.new("Ivory"),
["Cantaloupe"] = BrickColor.new("Cantaloupe"),
["Dusty rose"] = BrickColor.new("Dusty rose"),
["Deep orange"] = BrickColor.new("Deep orange"),
["Goldenrod"] = BrickColor.new("Goldenrod"),
["Nougat"] = BrickColor.new("Nougat"),
["Lime green"] = BrickColor.new("Lime green"),
["Cement"] = BrickColor.new("Cement"),
["Chocolate"] = BrickColor.new("Chocolate"),
["Toothpaste"] = BrickColor.new("Toothpaste"),
["Stone"] = BrickColor.new("Stone"),
["Snow white"] = BrickColor.new("Snow white"),
["Turquoise"] = BrickColor.new("Turquoise"),
["Sapphire"] = BrickColor.new("Sapphire"),
["Sunburst"] = BrickColor.new("Sunburst"),
["Ink blue"] = BrickColor.new("Ink blue"),
["Ash"] = BrickColor.new("Ash"),
["Magenta"] = BrickColor.new("Magenta"),
["Pink"] = BrickColor.new("Pink"),
["Coal"] = BrickColor.new("Coal"),
["Gold"] = BrickColor.new("Gold"),
["Ink"] = BrickColor.new("Ink"),
["Really black"] = BrickColor.new("Really black"),
["Burgundy"] = BrickColor.new("Burgundy"),
["Black"] = BrickColor.new("Black"),
["Carnation pink"] = BrickColor.new("Carnation pink"),
["Orchid"] = BrickColor.new("Orchid"),
["Coal"] = BrickColor.new("Coal"),
["Brick yellow"] = BrickColor.new("Brick yellow"),
["Crimson"] = BrickColor.new("Crimson"),
["Grey"] = BrickColor.new("Grey"),
["Tusk"] = BrickColor.new("Tusk"),
["Yellow"] = BrickColor.new("Yellow"),
["Shamrock"] = BrickColor.new("Shamrock"),
["Alder"] = BrickColor.new("Alder"),
["Ink"] = BrickColor.new("Ink"),
["Cyan"] = BrickColor.new("Cyan"),
["Grime"] = BrickColor.new("Grime"),
["Clover"] = BrickColor.new("Clover"),
["Steel blue"] = BrickColor.new("Steel blue"),
["Dark red"] = BrickColor.new("Dark red"),
["Grey"] = BrickColor.new("Grey"),
["Carnation pink"] = BrickColor.new("Carnation pink"),
["Ash grey"] = BrickColor.new("Ash grey"),
["Army green"] = BrickColor.new("Army green"),
["Navy blue"] = BrickColor.new("Navy blue"),
["Pearl"] = BrickColor.new("Pearl"),
["Neon yellow"] = BrickColor.new("Neon yellow"),
["Flamingo"] = BrickColor.new("Flamingo"),
["Slime green"] = BrickColor.new("Slime green"),
["Sea green"] = BrickColor.new("Sea green"),
["Brick yellow"] = BrickColor.new("Brick yellow"),
["Bright bluish green"] = BrickColor.new("Bright bluish green"),
["Dust"] = BrickColor.new("Dust"),
["Clear blue"] = BrickColor.new("Clear blue"),
["Bright yellowish green"] = BrickColor.new("Bright yellowish green"),
["Blue"] = BrickColor.new("Blue"),
["New Yeller"] = BrickColor.new("New Yeller"),
["Vanilla"] = BrickColor.new("Vanilla"),
["Cobalt"] = BrickColor.new("Cobalt"),
["Blue"] = BrickColor.new("Blue"),
["Coral"] = BrickColor.new("Coral"),
["Royal purple"] = BrickColor.new("Royal purple"),
["Forest green"] = BrickColor.new("Forest green"),
["Army green"] = BrickColor.new("Army green"),
["Bright yellowish brown"] = BrickColor.new("Bright yellowish brown"),
["Sunburst"] = BrickColor.new("Sunburst"),
["Mocha"] = BrickColor.new("Mocha"),
["Sea green"] = BrickColor.new("Sea green"),
["Storm blue"] = BrickColor.new("Storm blue"),
["Bright violet"] = BrickColor.new("Bright violet"),
["Cement"] = BrickColor.new("Cement"),
["Earth orange"] = BrickColor.new("Earth orange"),
["Cloudy grey"] = BrickColor.new("Cloudy grey"),
["Pastel blue"] = BrickColor.new("Pastel blue"),
["Bright green"] = BrickColor.new("Bright green"),
["Sand green"] = BrickColor.new("Sand green"),
["Pine green"] = BrickColor.new("Pine green"),
["Peach"] = BrickColor.new("Peach"),
["Bright violet"] = BrickColor.new("Bright violet"),
["Orchid"] = BrickColor.new("Orchid"),
["Neon green"] = BrickColor.new("Neon green"),
["Steel"] = BrickColor.new("Steel"),
["Grey"] = BrickColor.new("Grey"),
["Brick yellow"] = BrickColor.new("Brick yellow"),
["Red"] = BrickColor.new("Red"),
["Gum pink"] = BrickColor.new("Gum pink"),
["Neon yellow"] = BrickColor.new("Neon yellow"),
["Stone"] = BrickColor.new("Stone"),
["Magenta"] = BrickColor.new("Magenta"),
["Sunset"] = BrickColor.new("Sunset"),
["Pastel yellow"] = BrickColor.new("Pastel yellow"),
["Bright red"] = BrickColor.new("Bright red"),
["Salmon"] = BrickColor.new("Salmon"),
["Alder"] = BrickColor.new("Alder"),
["Lilac"] = BrickColor.new("Lilac"),
["Lilac"] = BrickColor.new("Lilac"),
["Alder"] = BrickColor.new("Alder"),
["Ink"] = BrickColor.new("Ink"),
["Fog"] = BrickColor.new("Fog"),
["Dark blue"] = BrickColor.new("Dark blue"),
["Vanilla"] = BrickColor.new("Vanilla"),
["Neon green"] = BrickColor.new("Neon green"),
["Grime"] = BrickColor.new("Grime"),
["Neon pink"] = BrickColor.new("Neon pink"),
["Salmon"] = BrickColor.new("Salmon"),
["Ghost grey"] = BrickColor.new("Ghost grey"),
["Army green"] = BrickColor.new("Army green"),
["Dark green"] = BrickColor.new("Dark green"),
["Light green"] = BrickColor.new("Light green"),
["Wine red"] = BrickColor.new("Wine red"),
["Mint"] = BrickColor.new("Mint"),
["Clover"] = BrickColor.new("Clover"),
["Mint"] = BrickColor.new("Mint"),
["Bronze"] = BrickColor.new("Bronze"),
["Snow white"] = BrickColor.new("Snow white"),
["Brick yellow"] = BrickColor.new("Brick yellow"),
["Coal"] = BrickColor.new("Coal"),
["Ink blue"] = BrickColor.new("Ink blue"),
["Bright blue"] = BrickColor.new("Bright blue"),
["Neon blue"] = BrickColor.new("Neon blue"),
["Forest green"] = BrickColor.new("Forest green"),
["Terracotta"] = BrickColor.new("Terracotta"),
["Ink blue"] = BrickColor.new("Ink blue"),
["Wine red"] = BrickColor.new("Wine red"),
["Pastel green"] = BrickColor.new("Pastel green"),
["Dark orange"] = BrickColor.new("Dark orange"),
["Hot pink"] = BrickColor.new("Hot pink"),
["Deep orange"] = BrickColor.new("Deep orange"),
["Forest green"] = BrickColor.new("Forest green"),
["Cement"] = BrickColor.new("Cement"),
["Dark orange"] = BrickColor.new("Dark orange"),
["Sapphire"] = BrickColor.new("Sapphire"),
["Beige"] = BrickColor.new("Beige"),
["Bright yellowish green"] = BrickColor.new("Bright yellowish green"),
["Dark stone grey"] = BrickColor.new("Dark stone grey"),
["Brick yellow"] = BrickColor.new("Brick yellow"),
["Pastel orange"] = BrickColor.new("Pastel orange"),
["Night blue"] = BrickColor.new("Night blue"),
["Tangerine"] = BrickColor.new("Tangerine"),
["New Yeller"] = BrickColor.new("New Yeller"),
["Clay"] = BrickColor.new("Clay"),
["Sand green"] = BrickColor.new("Sand green"),
["Medium stone grey"] = BrickColor.new("Medium stone grey"),
["Pine cone"] = BrickColor.new("Pine cone"),
["Coal"] = BrickColor.new("Coal"),
["Pine cone"] = BrickColor.new("Pine cone"),
["Bright green"] = BrickColor.new("Bright green"),
["Baby blue"] = BrickColor.new("Baby blue"),
["Neon orange"] = BrickColor.new("Neon orange"),
["Peach"] = BrickColor.new("Peach"),
["Yellow"] = BrickColor.new("Yellow"),
["Sand green"] = BrickColor.new("Sand green"),
["Sea green"] = BrickColor.new("Sea green"),
["Earth orange"] = BrickColor.new("Earth orange"),
["Toothpaste"] = BrickColor.new("Toothpaste"),
["Platinum"] = BrickColor.new("Platinum"),
["Fawn brown"] = BrickColor.new("Fawn brown"),
["Bright blue"] = BrickColor.new("Bright blue"),
["Amber"] = BrickColor.new("Amber"),
["Gum pink"] = BrickColor.new("Gum pink"),
["Light orange"] = BrickColor.new("Light orange"),
["Platinum"] = BrickColor.new("Platinum"),
["Crimson"] = BrickColor.new("Crimson"),
["Green"] = BrickColor.new("Green"),
["Marigold"] = BrickColor.new("Marigold"),
["Coral"] = BrickColor.new("Coral"),
["Rust"] = BrickColor.new("Rust"),
["Mocha"] = BrickColor.new("Mocha"),
["Bright blue"] = BrickColor.new("Bright blue"),
["Bright blue"] = BrickColor.new("Bright blue"),
["Ultramarine"] = BrickColor.new("Ultramarine"),
["Cool red"] = BrickColor.new("Cool red"),
["Pearl gold"] = BrickColor.new("Pearl gold"),
["Yellow"] = BrickColor.new("Yellow"),
["Brick yellow"] = BrickColor.new("Brick yellow"),
["Cool yellow"] = BrickColor.new("Cool yellow"),
["Burlap"] = BrickColor.new("Burlap"),
["Bright yellowish brown"] = BrickColor.new("Bright yellowish brown"),
["Neon green"] = BrickColor.new("Neon green"),
["Dark blue"] = BrickColor.new("Dark blue"),
["Really black"] = BrickColor.new("Really black"),
["Bright yellow"] = BrickColor.new("Bright yellow"),
["Sand red"] = BrickColor.new("Sand red"),
["Fog"] = BrickColor.new("Fog"),
["Maroon"] = BrickColor.new("Maroon"),
["Driftwood"] = BrickColor.new("Driftwood"),
["Dark blue"] = BrickColor.new("Dark blue"),
["Indigo"] = BrickColor.new("Indigo"),
["Dark orange"] = BrickColor.new("Dark orange"),
["Toothpaste"] = BrickColor.new("Toothpaste"),
["Magenta"] = BrickColor.new("Magenta"),
["Amber"] = BrickColor.new("Amber"),
["Pastel orange"] = BrickColor.new("Pastel orange"),
["Neon pink"] = BrickColor.new("Neon pink"),
["Institutional white"] = BrickColor.new("Institutional white"),
["Institutional white"] = BrickColor.new("Institutional white"),
["Baby blue"] = BrickColor.new("Baby blue"),
["Carnation pink"] = BrickColor.new("Carnation pink"),
["Royal purple"] = BrickColor.new("Royal purple"),
["Pastel green"] = BrickColor.new("Pastel green"),
["Pear"] = BrickColor.new("Pear"),
["Sapphire"] = BrickColor.new("Sapphire"),
["Medium stone grey"] = BrickColor.new("Medium stone grey"),
["Goldenrod"] = BrickColor.new("Goldenrod"),
["Bright yellow"] = BrickColor.new("Bright yellow"),
["Burlap"] = BrickColor.new("Burlap"),
["Clay"] = BrickColor.new("Clay"),
["Smoky grey"] = BrickColor.new("Smoky grey"),
["Cantaloupe"] = BrickColor.new("Cantaloupe"),
["Amber"] = BrickColor.new("Amber"),
["Cloudy grey"] = BrickColor.new("Cloudy grey"),
["Cool red"] = BrickColor.new("Cool red"),
["Marigold"] = BrickColor.new("Marigold"),
["Clear blue"] = BrickColor.new("Clear blue"),
["Storm blue"] = BrickColor.new("Storm blue"),
["Pumpkin"] = BrickColor.new("Pumpkin"),
["Lilac"] = BrickColor.new("Lilac"),
["Gum pink"] = BrickColor.new("Gum pink"),
["Pearl gold"] = BrickColor.new("Pearl gold"),
["Royal blue"] = BrickColor.new("Royal blue"),
["Cement"] = BrickColor.new("Cement"),
["Neon green"] = BrickColor.new("Neon green"),
["Sky blue"] = BrickColor.new("Sky blue"),
["Emerald"] = BrickColor.new("Emerald"),
["Fog"] = BrickColor.new("Fog"),
["Emerald"] = BrickColor.new("Emerald"),
["Alder"] = BrickColor.new("Alder"),
["Beige"] = BrickColor.new("Beige"),
["Royal blue"] = BrickColor.new("Royal blue"),
["Shamrock"] = BrickColor.new("Shamrock"),
["Pink"] = BrickColor.new("Pink"),
["Marigold"] = BrickColor.new("Marigold"),
["Pastel yellow"] = BrickColor.new("Pastel yellow"),
["Fossil"] = BrickColor.new("Fossil"),
["Maroon"] = BrickColor.new("Maroon"),
["Terracotta"] = BrickColor.new("Terracotta"),
["Clay"] = BrickColor.new("Clay"),
["Pumpkin"] = BrickColor.new("Pumpkin"),
["Crimson"] = BrickColor.new("Crimson"),
["Snow white"] = BrickColor.new("Snow white"),
["Cyan"] = BrickColor.new("Cyan"),
["Cobalt"] = BrickColor.new("Cobalt"),
["Bright yellow"] = BrickColor.new("Bright yellow"),
["Ash grey"] = BrickColor.new("Ash grey"),
["Sea green"] = BrickColor.new("Sea green"),
["Sand"] = BrickColor.new("Sand"),
["Moss"] = BrickColor.new("Moss"),
["Storm blue"] = BrickColor.new("Storm blue"),
["Sand red"] = BrickColor.new("Sand red"),
["Salmon"] = BrickColor.new("Salmon"),
["Ink"] = BrickColor.new("Ink"),
["Fog"] = BrickColor.new("Fog"),
["Cloudy grey"] = BrickColor.new("Cloudy grey"),
["Peach"] = BrickColor.new("Peach"),
["Flint"] = BrickColor.new("Flint"),
["Deep orange"] = BrickColor.new("Deep orange"),
["Cool red"] = BrickColor.new("Cool red"),
["Banana"] = BrickColor.new("Banana"),
["Berry"] = BrickColor.new("Berry"),
["Night blue"] = BrickColor.new("Night blue"),
["Grape"] = BrickColor.new("Grape"),
["Gold"] = BrickColor.new("Gold"),
["Earth orange"] = BrickColor.new("Earth orange"),
["Peach"] = BrickColor.new("Peach"),
["Navy blue"] = BrickColor.new("Navy blue"),
["Berry"] = BrickColor.new("Berry"),
["Royal purple"] = BrickColor.new("Royal purple"),
["Dark orange"] = BrickColor.new("Dark orange"),
["Bright yellowish green"] = BrickColor.new("Bright yellowish green"),
["Ash"] = BrickColor.new("Ash"),
["Sunset"] = BrickColor.new("Sunset"),
["Shamrock"] = BrickColor.new("Shamrock"),
["Lavender"] = BrickColor.new("Lavender"),
["Butterscotch"] = BrickColor.new("Butterscotch"),
["Hot pink"] = BrickColor.new("Hot pink"),
["Dark red"] = BrickColor.new("Dark red"),
["Bright blue"] = BrickColor.new("Bright blue"),
["Pastel orange"] = BrickColor.new("Pastel orange"),
["Steel blue"] = BrickColor.new("Steel blue"),
["Ghost grey"] = BrickColor.new("Ghost grey"),
["Rose gold"] = BrickColor.new("Rose gold"),
["Orchid"] = BrickColor.new("Orchid"),
["Neon pink"] = BrickColor.new("Neon pink"),
["Bright violet"] = BrickColor.new("Bright violet"),
["Dark stone grey"] = BrickColor.new("Dark stone grey"),
["Steel blue"] = BrickColor.new("Steel blue"),
["Night blue"] = BrickColor.new("Night blue"),
["Rose gold"] = BrickColor.new("Rose gold"),
["Cloudy grey"] = BrickColor.new("Cloudy grey"),
["Grape"] = BrickColor.new("Grape"),
["Cloudy grey"] = BrickColor.new("Cloudy grey"),
["Neon yellow"] = BrickColor.new("Neon yellow"),
["Mint"] = BrickColor.new("Mint"),
["Pear"] = BrickColor.new("Pear"),
["Red"] = BrickColor.new("Red"),
["Sunset"] = BrickColor.new("Sunset"),
["Goldenrod"] = BrickColor.new("Goldenrod"),
["Fawn brown"] = BrickColor.new("Fawn brown"),
["Ice"] = BrickColor.new("Ice"),
["Bright bluish green"] = BrickColor.new("Bright bluish green"),
["Slate"] = BrickColor.new("Slate"),
["Dark stone grey"] = BrickColor.new("Dark stone grey"),
["Dark stone grey"] = BrickColor.new("Dark stone grey"),
["Gum pink"] = BrickColor.new("Gum pink"),
["Magenta"] = BrickColor.new("Magenta"),
["Obsidian"] = BrickColor.new("Obsidian"),
["Butterscotch"] = BrickColor.new("Butterscotch"),
["Chocolate"] = BrickColor.new("Chocolate"),
["Mint"] = BrickColor.new("Mint"),
["Obsidian"] = BrickColor.new("Obsidian"),
["Carnation pink"] = BrickColor.new("Carnation pink"),
["Bright green"] = BrickColor.new("Bright green"),
["Brown"] = BrickColor.new("Brown"),
["Olive"] = BrickColor.new("Olive"),
["Crimson"] = BrickColor.new("Crimson"),
["Charcoal"] = BrickColor.new("Charcoal"),
["Light orange"] = BrickColor.new("Light orange"),
["Grape"] = BrickColor.new("Grape"),
["
}

local dropdownOpen = false

-- Function to populate the color options frame
local function populateColorOptions()
	-- Hapus opsi yang ada
	for _, child in pairs(colorOptionsFrame:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end

	local optionHeight = 20 -- Tinggi setiap tombol opsi warna
	local totalContentHeight = 0

	-- Iterasi melalui opsi warna kustom
	for name, brick in pairs(customColorOptions) do
		local opt = Instance.new("TextButton")
		opt.Size = UDim2.new(1, 0, 0, optionHeight) -- Lebar penuh scrolling frame
		opt.Text = name
		opt.BackgroundColor3 = brick.Color
		opt.TextColor3 = Color3.new(1, 1, 1)
		opt.Font = Enum.Font.Gotham
		opt.TextSize = 13
		opt.TextScaled = true
		opt.SizeConstraint = Enum.SizeConstraint.RelativeXX
		opt.Parent = colorOptionsFrame -- Parent ke scrolling frame
		opt.ZIndex = 4 -- Pastikan opsi berada di atas scrolling frame itu sendiri

		opt.MouseButton1Click:Connect(function()
			_G.SelectedColor = brick
			colorDropdown.Text = name
			colorDropdown.BackgroundColor3 = brick.Color
			colorOptionsFrame.Visible = false -- Sembunyikan dropdown
			dropdownOpen = false
		end)
		totalContentHeight += optionHeight + listLayout.Padding.Offset
	end

	-- Sesuaikan CanvasSize agar sesuai dengan semua opsi, memungkinkan pengguliran
	colorOptionsFrame.CanvasSize = UDim2.new(0, 0, 0, totalContentHeight)
end

-- Connect color dropdown button functionality
colorDropdown.MouseButton1Click:Connect(function()
	dropdownOpen = not dropdownOpen
	colorOptionsFrame.Visible = dropdownOpen
	if dropdownOpen then
		populateColorOptions() -- Isi hanya saat membuka
	end
end)

-- Toggle Button (Enable/Disable Hitbox)
local toggleBtn = Instance.new("TextButton", frame)
toggleBtn.Position = UDim2.new(0, 10, 0, 170)
toggleBtn.Size = UDim2.new(0, 280, 0, 30)
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

-- Minimize functionality
local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	local goalSize = minimized and UDim2.new(0, 300, 0, 30) or UDim2.new(0, 300, 0, 220) -- Tinggi 30 hanya untuk bilah judul
	TweenService:Create(frame, TweenInfo.new(0.25), {Size = goalSize}):Play()

	-- Sembunyikan/tampilkan semua elemen kecuali judul dan tombol kontrol
	for _, v in pairs(frame:GetChildren()) do
		if v ~= title and v ~= minimizeBtn and v ~= closeBtn then -- Kecualikan tombol tutup dari toggle visibilitas
			v.Visible = not minimized
		end
	end
	-- Pastikan frame opsi warna tersembunyi saat diminimalkan
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
end)
