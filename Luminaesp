-- UI Loadstring ESP Full with Healthbar, Tracer, Nametag, Distance - Luminaprojects
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local ESPBoxes, CircleESP, Tracers, HealthBars, Nametags = {}, {}, {}, {}, {}

-- Utility Functions
local function removeESP(player)
	if ESPBoxes[player] then ESPBoxes[player]:Remove() ESPBoxes[player] = nil end
	if CircleESP[player] then CircleESP[player]:Remove() CircleESP[player] = nil end
	if Tracers[player] then Tracers[player]:Remove() Tracers[player] = nil end
	if HealthBars[player] then HealthBars[player]:Remove() HealthBars[player] = nil end
	if Nametags[player] then Nametags[player]:Remove() Nametags[player] = nil end
end

local function createESP(player)
	-- Box
	local box = Drawing.new("Square")
	box.Thickness = 1
	box.Transparency = 0.9
	box.Color = Color3.new(1, 1, 1)
	box.Filled = false
	box.Visible = false
	ESPBoxes[player] = box

	-- Circle
	local circle = Drawing.new("Circle")
	circle.Thickness = 1
	circle.Radius = 10
	circle.Filled = true
	circle.Transparency = 1
	circle.Color = Color3.new(1, 1, 1)
	circle.Visible = false
	CircleESP[player] = circle

	-- Tracer
	local tracer = Drawing.new("Line")
	tracer.Thickness = 1
	tracer.Transparency = 0.8
	tracer.Color = Color3.new(1, 1, 1)
	tracer.Visible = false
	Tracers[player] = tracer

	-- Health Bar
	local health = Drawing.new("Square")
	health.Thickness = 1
	health.Filled = true
	health.Transparency = 0.9
	health.Color = Color3.new(0, 1, 0)
	health.Visible = false
	HealthBars[player] = health

	-- Nametag + Distance
	local name = Drawing.new("Text")
	name.Size = 13
	name.Center = true
	name.Outline = true
	name.Color = Color3.new(1, 1, 1)
	name.Visible = false
	Nametags[player] = name
end

for _, player in ipairs(Players:GetPlayers()) do
	if player ~= LocalPlayer then createESP(player) end
end

Players.PlayerAdded:Connect(function(player)
	if player ~= LocalPlayer then createESP(player) end
end)
Players.PlayerRemoving:Connect(function(player)
	removeESP(player)
end)

-- Toggle Variables
local enabledCircle, enabledBox, enabledTracer, enabledName = false, false, false, false

-- Connect Toggles (linked to UI toggles by events)
_G.ToggleCircleESP = function(on) enabledCircle = on end
_G.ToggleBoxESP = function(on) enabledBox = on end
_G.ToggleTracerESP = function(on) enabledTracer = on end
_G.ToggleNametag = function(on) enabledName = on end

RunService.RenderStepped:Connect(function()
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
			local hrp = player.Character.HumanoidRootPart
			local humanoid = player.Character.Humanoid
			local pos, visible = Camera:WorldToViewportPoint(hrp.Position)
			local dist = (Camera.CFrame.Position - hrp.Position).Magnitude

			-- Check visibility
			if visible and humanoid.Health > 0 then
				-- Box
				if enabledBox and ESPBoxes[player] then
					local scale = 50 / dist
					local w, h = 20 * scale, 40 * scale
					ESPBoxes[player].Size = Vector2.new(w, h)
					ESPBoxes[player].Position = Vector2.new(pos.X - w / 2, pos.Y - h / 2)
					ESPBoxes[player].Visible = true
				else if ESPBoxes[player] then ESPBoxes[player].Visible = false end end

				-- Circle
				if enabledCircle and CircleESP[player] then
					CircleESP[player].Position = Vector2.new(pos.X, pos.Y)
					CircleESP[player].Visible = true
				else if CircleESP[player] then CircleESP[player].Visible = false end end

				-- Tracer
				if enabledTracer and Tracers[player] then
					Tracers[player].From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
					Tracers[player].To = Vector2.new(pos.X, pos.Y)
					Tracers[player].Visible = true
				else if Tracers[player] then Tracers[player].Visible = false end end

				-- Health Bar
				if HealthBars[player] then
					local box = ESPBoxes[player]
					if box and box.Visible then
						local percent = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
						local width = box.Size.X * percent
						HealthBars[player].Size = Vector2.new(width, 4)
						HealthBars[player].Position = Vector2.new(box.Position.X, box.Position.Y + box.Size.Y + 2)
						HealthBars[player].Color = Color3.fromRGB(255 * (1 - percent), 255 * percent, 0)
						HealthBars[player].Visible = true
					else
						HealthBars[player].Visible = false
					end
				end

				-- Name + Distance
				if enabledName and Nametags[player] then
					Nametags[player].Text = player.Name .. " [" .. math.floor(dist) .. "m]"
					Nametags[player].Position = Vector2.new(pos.X, pos.Y - 35)
					Nametags[player].Visible = true
				else if Nametags[player] then Nametags[player].Visible = false end end
			else
				removeESP(player)
			end
		end
	end
end)

-- Link Toggles to UI
if _G.ToggleCircleESP then _G.ToggleCircleESP(false) end
if _G.ToggleBoxESP then _G.ToggleBoxESP(false) end
if _G.ToggleTracerESP then _G.ToggleTracerESP(false) end
if _G.ToggleNametag then _G.ToggleNametag(false) end
