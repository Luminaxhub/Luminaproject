local tabFolder = Instance.new("Folder", frame)
tabFolder.Name = "Tabs"

local function createTabButton(name, index)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(0, 100, 0, 30)
	btn.Position = UDim2.new(0, (index-1)*100, 0, 0)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	return btn
end

local moreTab = Instance.new("Frame", tabFolder)
moreTab.Name = "More Fitur"
moreTab.Size = UDim2.new(1, 0, 1, -30)
moreTab.Position = UDim2.new(0, 0, 0, 30)
moreTab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
moreTab.Visible = false

local creditTab = Instance.new("Frame", tabFolder)
creditTab.Name = "Credit"
creditTab.Size = UDim2.new(1, 0, 1, -30)
creditTab.Position = UDim2.new(0, 0, 0, 30)
creditTab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
creditTab.Visible = false

local tabList = {
	["More Fitur"] = moreTab,
	["Credit"] = creditTab
}

local i = 1
for name, page in pairs(tabList) do
	local button = createTabButton(name, i)
	i += 1
	button.MouseButton1Click:Connect(function()
		for _, t in pairs(tabFolder:GetChildren()) do
			t.Visible = false
		end
		page.Visible = true
	end)
end

-- More Fitur content
local speedBox = Instance.new("TextBox", moreTab)
speedBox.PlaceholderText = "WalkSpeed"
speedBox.Position = UDim2.new(0, 10, 0, 10)
speedBox.Size = UDim2.new(0, 120, 0, 25)

local jumpBox = Instance.new("TextBox", moreTab)
jumpBox.PlaceholderText = "High Jump"
jumpBox.Position = UDim2.new(0, 10, 0, 45)
jumpBox.Size = UDim2.new(0, 120, 0, 25)

local applyBtn = Instance.new("TextButton", moreTab)
applyBtn.Text = "Apply"
applyBtn.Position = UDim2.new(0, 10, 0, 80)
applyBtn.Size = UDim2.new(0, 120, 0, 25)
applyBtn.MouseButton1Click:Connect(function()
	local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.WalkSpeed = tonumber(speedBox.Text) or 16
		hum.JumpPower = tonumber(jumpBox.Text) or 50
	end
end)

local InfJump = false
UserInputService = game:GetService("UserInputService")
UserInputService.JumpRequest:Connect(function()
	if InfJump and LocalPlayer.Character then
		LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
	end
end)

local infBtn = Instance.new("TextButton", moreTab)
infBtn.Text = "Toggle Inf Jump"
infBtn.Position = UDim2.new(0, 10, 0, 115)
infBtn.Size = UDim2.new(0, 120, 0, 25)
infBtn.MouseButton1Click:Connect(function()
	InfJump = not InfJump
	infBtn.Text = InfJump and "Inf Jump: ON" or "Inf Jump: OFF"
end)

local wallBtn = Instance.new("TextButton", moreTab)
wallBtn.Text = "Wallhack"
wallBtn.Position = UDim2.new(0, 10, 0, 150)
wallBtn.Size = UDim2.new(0, 120, 0, 25)
wallBtn.MouseButton1Click:Connect(function()
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Transparency < 1 then
			obj.LocalTransparencyModifier = 0.7
		end
	end
end)

local creditText = Instance.new("TextLabel", creditTab)
creditText.Size = UDim2.new(1, -20, 1, -20)
creditText.Position = UDim2.new(0, 10, 0, 10)
creditText.BackgroundTransparency = 1
creditText.TextColor3 = Color3.new(1, 1, 1)
creditText.TextWrapped = true
creditText.TextXAlignment = Enum.TextXAlignment.Left
creditText.TextYAlignment = Enum.TextYAlignment.Top
creditText.Font = Enum.Font.Code
creditText.TextSize = 18
creditText.Text = "📜 Owner : Luminaprojects\\n🕊️ Youtube : Luminaprojects."
