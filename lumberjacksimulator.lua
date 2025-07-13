
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoClickerUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Frame Utama
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 160)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 25)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🌲 Lumber Jeck Simulator"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 17
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Parent = MainFrame

-- Auto Click Toggle
local ClickToggle = Instance.new("TextButton")
ClickToggle.Size = UDim2.new(0.8, 0, 0, 30)
ClickToggle.Position = UDim2.new(0.1, 0, 0, 35)
ClickToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ClickToggle.Text = "Auto Click: OFF"
ClickToggle.Font = Enum.Font.Gotham
ClickToggle.TextSize = 14
ClickToggle.TextColor3 = Color3.new(1, 1, 1)
ClickToggle.Parent = MainFrame

-- Auto Rebirth Toggle
local RebirthToggle = Instance.new("TextButton")
RebirthToggle.Size = UDim2.new(0.8, 0, 0, 30)
RebirthToggle.Position = UDim2.new(0.1, 0, 0, 75)
RebirthToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
RebirthToggle.Text = "Auto Rebirth: OFF"
RebirthToggle.Font = Enum.Font.Gotham
RebirthToggle.TextSize = 14
RebirthToggle.TextColor3 = Color3.new(1, 1, 1)
RebirthToggle.Parent = MainFrame

-- Minimize Button
local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.new(0.8, 0, 0, 28)
Minimize.Position = UDim2.new(0.1, 0, 0, 115)
Minimize.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Minimize.Text = "🔻 Hide"
Minimize.Font = Enum.Font.Gotham
Minimize.TextSize = 14
Minimize.TextColor3 = Color3.new(1, 1, 1)
Minimize.Parent = MainFrame

-- Credit
local Credit = Instance.new("TextLabel")
Credit.Size = UDim2.new(1, 0, 0, 20)
Credit.Position = UDim2.new(0, 0, 1, -20)
Credit.BackgroundTransparency = 1
Credit.Text = "Script by - @Luminaprojects"
Credit.Font = Enum.Font.Gotham
Credit.TextSize = 13
Credit.TextColor3 = Color3.fromRGB(255, 0, 0)
Credit.Parent = MainFrame

-- RGB Credit Animation
spawn(function()
	while true do
		for h = 0, 1, 0.01 do
			Credit.TextColor3 = Color3.fromHSV(h, 1, 1)
			task.wait(0.03)
		end
	end
end)

-- Auto Click & Auto Rebirth Logic
local autoClick, autoRebirth = false, false
ClickToggle.MouseButton1Click:Connect(function()
	autoClick = not autoClick
	ClickToggle.Text = "Auto Click: " .. (autoClick and "ON" or "OFF")
	ClickToggle.BackgroundColor3 = autoClick and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
end)
RebirthToggle.MouseButton1Click:Connect(function()
	autoRebirth = not autoRebirth
	RebirthToggle.Text = "Auto Rebirth: " .. (autoRebirth and "ON" or "OFF")
	RebirthToggle.BackgroundColor3 = autoRebirth and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
end)

-- Execute loops
RunService.RenderStepped:Connect(function()
	if autoClick then
		local view = workspace.CurrentCamera.ViewportSize
		VirtualInputManager:SendMouseButtonEvent(view.X/2, view.Y/2, 0, true, game, 0)
		VirtualInputManager:SendMouseButtonEvent(view.X/2, view.Y/2, 0, false, game, 0)
	end
	if autoRebirth then
		local args = {
			ReplicatedStorage:WaitForChild("Items"):WaitForChild("Pencil"):WaitForChild("10")
		}
		ReplicatedStorage:WaitForChild("GameClient"):WaitForChild("Events"):WaitForChild("RemoteEvent"):WaitForChild("ClickChangeEvent"):FireServer(unpack(args))
	end
end)

-- Minimize Logic
local minimized = false
Minimize.MouseButton1Click:Connect(function()
	minimized = not minimized
	MainFrame.Visible = not minimized
	if minimized then
		local restoreBtn = Instance.new("TextButton")
		restoreBtn.Size = UDim2.new(0, 160, 0, 35)
		restoreBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
		restoreBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		restoreBtn.Text = "🔼 Show Script"
		restoreBtn.Font = Enum.Font.Gotham
		restoreBtn.TextSize = 14
		restoreBtn.TextColor3 = Color3.new(1, 1, 1)
		restoreBtn.Parent = ScreenGui
		restoreBtn.Active = true
		restoreBtn.Draggable = true
		restoreBtn.MouseButton1Click:Connect(function()
			MainFrame.Visible = true
			minimized = false
			restoreBtn:Destroy()
		end)
	end
end)

-- MORE SETTING SIDE UI
local MoreSetting = Instance.new("Frame")
MoreSetting.Size = UDim2.new(0, 220, 0, 140)
MoreSetting.Position = UDim2.new(0.25, 0, 0.3, 0)
MoreSetting.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MoreSetting.BorderSizePixel = 0
MoreSetting.Parent = ScreenGui
MoreSetting.Active = true
MoreSetting.Draggable = true

local MoreTitle = Instance.new("TextLabel")
MoreTitle.Size = UDim2.new(1, 0, 0, 25)
MoreTitle.Position = UDim2.new(0, 0, 0, 0)
MoreTitle.BackgroundTransparency = 1
MoreTitle.Text = "🎄 More Setting"
MoreTitle.Font = Enum.Font.GothamBold
MoreTitle.TextSize = 17
MoreTitle.TextColor3 = Color3.new(1, 1, 1)
MoreTitle.Parent = MoreSetting

-- Auto Reward
local RewardToggle = Instance.new("TextButton")
RewardToggle.Size = UDim2.new(0.8, 0, 0, 30)
RewardToggle.Position = UDim2.new(0.1, 0, 0, 35)
RewardToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
RewardToggle.Text = "Auto Reward: OFF"
RewardToggle.Font = Enum.Font.Gotham
RewardToggle.TextSize = 14
RewardToggle.TextColor3 = Color3.new(1, 1, 1)
RewardToggle.Parent = MoreSetting

local autoReward = false
RewardToggle.MouseButton1Click:Connect(function()
	autoReward = not autoReward
	RewardToggle.Text = "Auto Reward: " .. (autoReward and "ON" or "OFF")
	RewardToggle.BackgroundColor3 = autoReward and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
end)

task.spawn(function()
	while true do
		if autoReward then
			for i = 1, 12 do
				local args = { "Reward" .. i }
				pcall(function()
					ReplicatedStorage:WaitForChild("GameClient"):WaitForChild("Events"):WaitForChild("RemoteEvent"):WaitForChild("ClaimGift"):FireServer(unpack(args))
				end)
				wait(0.5)
			end
		end
		wait(5)
	end
end)

-- Clicker Tool Auto
local ToolToggle = Instance.new("TextButton")
ToolToggle.Size = UDim2.new(0.8, 0, 0, 30)
ToolToggle.Position = UDim2.new(0.1, 0, 0, 75)
ToolToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToolToggle.Text = "Clicker Tool Auto: OFF"
ToolToggle.Font = Enum.Font.Gotham
ToolToggle.TextSize = 14
ToolToggle.TextColor3 = Color3.new(1, 1, 1)
ToolToggle.Parent = MoreSetting

local autoTool = false
ToolToggle.MouseButton1Click:Connect(function()
	autoTool = not autoTool
	ToolToggle.Text = "Clicker Tool Auto: " .. (autoTool and "ON" or "OFF")
	ToolToggle.BackgroundColor3 = autoTool and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
end)

task.spawn(function()
	while true do
		if autoTool then
			for i = 1, 12 do
				local pencil = ReplicatedStorage:FindFirstChild("Items"):FindFirstChild("Pencil")
				if pencil and pencil:FindFirstChild(tostring(i)) then
					local args = { pencil[tostring(i)] }
					pcall(function()
						ReplicatedStorage:WaitForChild("GameClient"):WaitForChild("Events"):WaitForChild("RemoteEvent"):WaitForChild("ClickChangeEvent"):FireServer(unpack(args))
					end)
				end
			end
		end
		wait(2)
	end
end)

-- RGB Credit bawah MoreSetting
local MoreCredit = Instance.new("TextLabel")
MoreCredit.Size = UDim2.new(1, 0, 0, 20)
MoreCredit.Position = UDim2.new(0, 0, 1, -20)
MoreCredit.BackgroundTransparency = 1
MoreCredit.Text = "Script by - @Luminaprojects"
MoreCredit.Font = Enum.Font.Gotham
MoreCredit.TextSize = 13
MoreCredit.TextColor3 = Color3.fromRGB(255, 0, 0)
MoreCredit.Parent = MoreSetting

task.spawn(function()
	while true do
		for h = 0, 1, 0.01 do
			MoreCredit.TextColor3 = Color3.fromHSV(h, 1, 1)
			task.wait(0.03)
		end
	end
end)
