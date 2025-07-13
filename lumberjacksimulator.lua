local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LumberSimUI"
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

-- FRAME: Main (Auto Click & Rebirth)
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
Title.Text = "🌲 Lumber Jeck Simulator"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 17
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

local AutoClick = Instance.new("TextButton")
AutoClick.Size = UDim2.new(0.8, 0, 0, 30)
AutoClick.Position = UDim2.new(0.1, 0, 0, 35)
AutoClick.Text = "Auto Click: OFF"
AutoClick.BackgroundColor3 = Color3.fromRGB(40,40,40)
AutoClick.TextColor3 = Color3.new(1,1,1)
AutoClick.Font = Enum.Font.Gotham
AutoClick.TextSize = 14
AutoClick.Parent = MainFrame

local Rebirth = Instance.new("TextButton")
Rebirth.Size = UDim2.new(0.8, 0, 0, 30)
Rebirth.Position = UDim2.new(0.1, 0, 0, 75)
Rebirth.Text = "Auto Rebirth: OFF"
Rebirth.BackgroundColor3 = Color3.fromRGB(40,40,40)
Rebirth.TextColor3 = Color3.new(1,1,1)
Rebirth.Font = Enum.Font.Gotham
Rebirth.TextSize = 14
Rebirth.Parent = MainFrame

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.new(0.8, 0, 0, 28)
Minimize.Position = UDim2.new(0.1, 0, 0, 115)
Minimize.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Minimize.Text = "🔻 Hide"
Minimize.Font = Enum.Font.Gotham
Minimize.TextSize = 14
Minimize.TextColor3 = Color3.new(1, 1, 1)
Minimize.Parent = MainFrame

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

-- FRAME: More Setting (Auto Reward & Tool)
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
MoreTitle.Text = "🎄 More Setting"
MoreTitle.TextColor3 = Color3.new(1,1,1)
MoreTitle.Font = Enum.Font.GothamBold
MoreTitle.TextSize = 17
MoreTitle.BackgroundTransparency = 1
MoreTitle.Parent = MoreSetting

local Reward = Instance.new("TextButton")
Reward.Size = UDim2.new(0.8, 0, 0, 30)
Reward.Position = UDim2.new(0.1, 0, 0, 35)
Reward.Text = "Auto Reward: OFF"
Reward.BackgroundColor3 = Color3.fromRGB(40,40,40)
Reward.TextColor3 = Color3.new(1,1,1)
Reward.Font = Enum.Font.Gotham
Reward.TextSize = 14
Reward.Parent = MoreSetting

local Tool = Instance.new("TextButton")
Tool.Size = UDim2.new(0.8, 0, 0, 30)
Tool.Position = UDim2.new(0.1, 0, 0, 75)
Tool.Text = "Clicker Tool Auto: OFF"
Tool.BackgroundColor3 = Color3.fromRGB(40,40,40)
Tool.TextColor3 = Color3.new(1,1,1)
Tool.Font = Enum.Font.Gotham
Tool.TextSize = 14
Tool.Parent = MoreSetting

local Credit2 = Credit:Clone()
Credit2.Parent = MoreSetting

-- RGB Credit bawah
spawn(function()
	while true do
		for h = 0, 1, 0.01 do
			Credit2.TextColor3 = Color3.fromHSV(h, 1, 1)
			task.wait(0.03)
		end
	end
end)

-- TOGGLE STATES
local autoClick, autoRebirth, autoReward, autoTool = false, false, false, false

AutoClick.MouseButton1Click:Connect(function()
	autoClick = not autoClick
	AutoClick.Text = "Auto Click: " .. (autoClick and "ON" or "OFF")
	AutoClick.BackgroundColor3 = autoClick and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
end)

Rebirth.MouseButton1Click:Connect(function()
	autoRebirth = not autoRebirth
	Rebirth.Text = "Auto Rebirth: " .. (autoRebirth and "ON" or "OFF")
	Rebirth.BackgroundColor3 = autoRebirth and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
end)

Reward.MouseButton1Click:Connect(function()
	autoReward = not autoReward
	Reward.Text = "Auto Reward: " .. (autoReward and "ON" or "OFF")
	Reward.BackgroundColor3 = autoReward and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
end)

Tool.MouseButton1Click:Connect(function()
	autoTool = not autoTool
	Tool.Text = "Clicker Tool Auto: " .. (autoTool and "ON" or "OFF")
	Tool.BackgroundColor3 = autoTool and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40, 40, 40)
end)

-- AUTO ACTIONS
RunService.RenderStepped:Connect(function()
	if autoClick then
		local input = game:GetService("VirtualInputManager")
		local size = workspace.CurrentCamera.ViewportSize
		input:SendMouseButtonEvent(size.X/2, size.Y/2, 0, true, game, 0)
		input:SendMouseButtonEvent(size.X/2, size.Y/2, 0, false, game, 0)
	end
	if autoRebirth then
		pcall(function()
			game:GetService("ReplicatedStorage"):WaitForChild("GameClient"):WaitForChild("Events"):WaitForChild("RemoteEvent"):WaitForChild("RebirthEvent"):FireServer()
		end)
	end
end)

task.spawn(function()
	while true do
		if autoReward then
			for i = 1, 12 do
				local args = {"Reward"..i}
				pcall(function()
					ReplicatedStorage:WaitForChild("GameClient"):WaitForChild("Events"):WaitForChild("RemoteEvent"):WaitForChild("ClaimGift"):FireServer(unpack(args))
				end)
				wait(0.5)
			end
		end
		wait(5)
	end
end)

task.spawn(function()
	while true do
		if autoTool then
			for i = 1, 12 do
				local item = ReplicatedStorage:FindFirstChild("Items"):FindFirstChild("Pencil"):FindFirstChild(tostring(i))
				if item then
					local args = {item}
					ReplicatedStorage:WaitForChild("GameClient"):WaitForChild("Events"):WaitForChild("RemoteEvent"):WaitForChild("ClickChangeEvent"):FireServer(unpack(args))
				end
			end
		end
		wait(2)
	end
end)

-- MINIMIZE ALL UI
local restoreBtn = nil
Minimize.MouseButton1Click:Connect(function()
	local minimized = not MainFrame.Visible
	MainFrame.Visible = not minimized
	MoreSetting.Visible = not minimized
	if minimized and not restoreBtn then
		restoreBtn = Instance.new("TextButton")
		restoreBtn.Size = UDim2.new(0, 160, 0, 35)
		restoreBtn.Position = UDim2.new(0.05, 0, 0.45, 0)
		restoreBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		restoreBtn.Text = "🔼 Show UI"
		restoreBtn.Font = Enum.Font.Gotham
		restoreBtn.TextSize = 14
		restoreBtn.TextColor3 = Color3.new(1, 1, 1)
		restoreBtn.Parent = ScreenGui
		restoreBtn.Active = true
		restoreBtn.Draggable = true
		restoreBtn.MouseButton1Click:Connect(function()
			MainFrame.Visible = true
			MoreSetting.Visible = true
			restoreBtn:Destroy()
			restoreBtn = nil
		end)
	end
end)
