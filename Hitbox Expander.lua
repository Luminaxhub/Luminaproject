local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- UI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "LanguageSelector"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 130)
frame.Position = UDim2.new(0.5, -125, 0.5, -65)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true -- drag support desktop + android

-- Minimize Button
local minimizeBtn = Instance.new("TextButton", frame)
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -35, 0, 5)
minimizeBtn.Text = "-"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 18
minimizeBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
minimizeBtn.TextColor3 = Color3.new(1, 1, 1)

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "🌐 Select Language"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left

-- English Button
local enBtn = Instance.new("TextButton", frame)
enBtn.Position = UDim2.new(0.5, -110, 0, 50)
enBtn.Size = UDim2.new(0, 100, 0, 35)
enBtn.Text = "🇬🇧 English"
enBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
enBtn.TextColor3 = Color3.new(1, 1, 1)
enBtn.Font = Enum.Font.GothamBold
enBtn.TextSize = 14

-- Russian Button
local ruBtn = Instance.new("TextButton", frame)
ruBtn.Position = UDim2.new(0.5, 10, 0, 50)
ruBtn.Size = UDim2.new(0, 100, 0, 35)
ruBtn.Text = "🇷🇺 Русский"
ruBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
ruBtn.TextColor3 = Color3.new(1, 1, 1)
ruBtn.Font = Enum.Font.GothamBold
ruBtn.TextSize = 14

-- Color Picker Button
local colorBtn = Instance.new("TextButton", frame)
colorBtn.Position = UDim2.new(0.5, -50, 0, 90)
colorBtn.Size = UDim2.new(0, 100, 0, 25)
colorBtn.Text = "🎨 Color Edit"
colorBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
colorBtn.TextColor3 = Color3.new(1, 1, 1)
colorBtn.Font = Enum.Font.Gotham
colorBtn.TextSize = 13

-- Toggle Minimize
local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	local goalSize = minimized and UDim2.new(0, 250, 0, 40) or UDim2.new(0, 250, 0, 130)
	TweenService:Create(frame, TweenInfo.new(0.25), {Size = goalSize}):Play()

	enBtn.Visible = not minimized
	ruBtn.Visible = not minimized
	colorBtn.Visible = not minimized
end)

-- Color Picker Logic
local colors = {
	Color3.fromRGB(30,30,30),
	Color3.fromRGB(45,45,80),
	Color3.fromRGB(0,100,100),
	Color3.fromRGB(100,0,100),
	Color3.fromRGB(10,10,10),
	Color3.fromRGB(60,30,30)
}
local currentColorIndex = 1

colorBtn.MouseButton1Click:Connect(function()
	currentColorIndex += 1
	if currentColorIndex > #colors then currentColorIndex = 1 end
	frame.BackgroundColor3 = colors[currentColorIndex]
end)

-- Button Functions
enBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Luminaxhub/English/main/English.lua"))()
end)

ruBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Luminaxhub/Russian/main/Russia.lua"))()
end)
