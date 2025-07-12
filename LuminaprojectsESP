local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local ESPEnabled = true
local TeamCheck = true -- true: Filter tim diaktifkan (tidak menampilkan rekan satu tim)

-- GUI Setup
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "Luminaprojects_ESP"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 240, 0, 300)
main.Position = UDim2.new(0, 20, 0, 100)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "🎯 ESP MENU"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

-- ESP Toggle
local toggleESPText = Instance.new("TextLabel", main)
toggleESPText.Position = UDim2.new(0, 10, 0, 40)
toggleESPText.Size = UDim2.new(0, 100, 0, 20)
toggleESPText.Text = "ESP :"
toggleESPText.BackgroundTransparency = 1
toggleESPText.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleESPText.Font = Enum.Font.Gotham
toggleESPText.TextSize = 14
toggleESPText.TextXAlignment = Enum.TextXAlignment.Left

local toggleESP = Instance.new("TextButton", main)
toggleESP.Position = UDim2.new(1, -60, 0, 40)
toggleESP.Size = UDim2.new(0, 50, 0, 20)
toggleESP.Text = "ON"
toggleESP.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
toggleESP.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleESP.Font = Enum.Font.Gotham
toggleESP.TextSize = 14

toggleESP.MouseButton1Click:Connect(function()
	ESPEnabled = not ESPEnabled
	toggleESP.Text = ESPEnabled and "ON" or "OFF"
	toggleESP.BackgroundColor3 = ESPEnabled and Color3.fromRGB(50, 200, 100) or Color3.fromRGB(200, 50, 50)
end)

-- Team Filter Toggle
local toggleTeamFilterText = Instance.new("TextLabel", main)
toggleTeamFilterText.Position = UDim2.new(0, 10, 0, 65)
toggleTeamFilterText.Size = UDim2.new(0, 100, 0, 20)
toggleTeamFilterText.Text = "Team Filter :"
toggleTeamFilterText.BackgroundTransparency = 1
toggleTeamFilterText.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleTeamFilterText.Font = Enum.Font.Gotham
toggleTeamFilterText.TextSize = 14
toggleTeamFilterText.TextXAlignment = Enum.TextXAlignment.Left

local toggleTeamFilter = Instance.new("TextButton", main)
toggleTeamFilter.Position = UDim2.new(1, -60, 0, 65)
toggleTeamFilter.Size = UDim2.new(0, 50, 0, 20)
toggleTeamFilter.Text = "ON"
toggleTeamFilter.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
toggleTeamFilter.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleTeamFilter.Font = Enum.Font.Gotham
toggleTeamFilter.TextSize = 14

toggleTeamFilter.MouseButton1Click:Connect(function()
    TeamCheck = not TeamCheck
    toggleTeamFilter.Text = TeamCheck and "ON" or "OFF"
    toggleTeamFilter.BackgroundColor3 = TeamCheck and Color3.fromRGB(50, 200, 100) or Color3.fromRGB(200, 50, 50)
end)

-- More Settings
-- (walkspeed, jumppower, TP tool, minimize, close, RGB credit)
-- skipped in this snippet for size, but same as script you provided + fix + RGB + ESP drawing

-- ESP Function
local function createESP(player)
	local box = Drawing.new("Square")
	box.Color = Color3.fromRGB(255, 255, 255)
	box.Thickness = 2
	box.Filled = false
	box.Transparency = 1
	box.Visible = ESPEnabled

	local function hideOnDeath(character)
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			local deathConnection
			deathConnection = humanoid.Died:Connect(function()
				box.Visible = false
				if deathConnection then
					deathConnection:Disconnect()
				end
			end)
		end
	end

	if player.Character then
		hideOnDeath(player.Character)
	end
	player.CharacterAdded:Connect(function(newCharacter)
		hideOnDeath(newCharacter)
	end)

	RunService.RenderStepped:Connect(function()
		if not ESPEnabled then
			box.Visible = false
			return
		end

		local character = player.Character
		if not character then
			box.Visible = false
			return
		end

		local rootPart = character:FindFirstChild("HumanoidRootPart")
		local human = character:FindFirstChildOfClass("Humanoid")

		if not rootPart or not human or human.Health <= 0 then
			box.Visible = false
			return
		end

		if TeamCheck and player.Team == LocalPlayer.Team then
			box.Visible = false
			return
		end

		local pos, onscreen = Camera:WorldToViewportPoint(rootPart.Position)
		if onscreen then
			local scale = (rootPart.Position - Camera.CFrame.Position).Magnitude / 10
			local size = Vector2.new(60, 100) / scale
			box.Size = size
			box.Position = Vector2.new(pos.X - size.X / 2, pos.Y - size.Y / 2)
			box.Visible = true
		else
			box.Visible = false
		end
	end)
end

for _, p in ipairs(Players:GetPlayers()) do
	if p ~= LocalPlayer then
		createESP(p)
	end
end

Players.PlayerAdded:Connect(function(p)
	if p ~= LocalPlayer then
		createESP(p)
	end
end)

-- RGB Credit
local credit = Instance.new("TextLabel", main)
credit.Position = UDim2.new(0, 10, 0, 235)
credit.Size = UDim2.new(1, -20, 0, 20)
credit.Text = "Script by - luminaprojects"
credit.BackgroundTransparency = 1
credit.Font = Enum.Font.GothamItalic
credit.TextSize = 12
credit.TextXAlignment = Enum.TextXAlignment.Left

local hue = 0
RunService.RenderStepped:Connect(function()
    hue = (hue + 0.01) % 1
    credit.TextColor3 = Color3.fromHSV(hue, 1, 1)
end)
