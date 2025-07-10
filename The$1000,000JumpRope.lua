local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "The $1,000,000 Jump Rope"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 500, 0, 320)
main.Position = UDim2.new(0.5, -250, 0.5, -160)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.BorderSizePixel = 0
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)

-- Tab "Main" sample:
local y = 20
local function addMainButton(text, callback)
    local btn = Instance.new("TextButton", main)
    btn.Size = UDim2.new(0, 200, 0, 40)
    btn.Position = UDim2.new(0, 20, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    btn.Text = text
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(callback)
    y = y + 50
end

addMainButton("Inf Money 💸", function()
    local args = { "100000" }
    game:GetService("ReplicatedStorage"):WaitForChild("CratesUtilities"):WaitForChild("Remotes"):WaitForChild("GiveReward"):FireServer(unpack(args))
end)

addMainButton("🎁 Free Gear", function()
    local args = {
        game:GetService("Players"):WaitForChild(game.Players.LocalPlayer.Name)
    }
    game:GetService("ReplicatedStorage"):WaitForChild("FreeGear_Remotes"):WaitForChild("FreeGearEvent"):FireServer(unpack(args))
end)

addMainButton("Finish Wins 🏆", function()
    local args = { false }
    game:GetService("ReplicatedStorage"):WaitForChild("RestartRemotes"):WaitForChild("Loader"):FireServer(unpack(args))
end)

addMainButton("Change clothes 👚", function()
    game:GetService("ReplicatedStorage"):WaitForChild("Random_Remotes"):WaitForChild("Wear"):FireServer()
end)

addMainButton("Inf Skill FrontMan 👺 (Green)", function()
    game:GetService("ReplicatedStorage"):WaitForChild("Frontman_Remotes"):WaitForChild("green"):FireServer()
end)

addMainButton("Inf Skill FrontMan 👺 (Red)", function()
    game:GetService("ReplicatedStorage"):WaitForChild("Frontman_Remotes"):WaitForChild("red"):FireServer()
end)

addMainButton("Freetool Skiptime ✨", function()
    local args = { "reset" }
    game:GetService("ReplicatedStorage"):WaitForChild("Timer_Remotes"):WaitForChild("FreeToolsStart"):FireServer(unpack(args))
end)

-- For full UI setup (sidebar, minimize/close, tabs, credit tab, etc.), see full version from earlier response

addMainButton("Ride Car 🚗", function()
    game:GetService("ReplicatedStorage"):WaitForChild("Car_Remotes"):WaitForChild("Equip"):FireServer()
end)

addMainButton("Ride Helicopter 🚁", function()
    game:GetService("ReplicatedStorage"):WaitForChild("Heli_Remotes"):WaitForChild("Equip"):FireServer()
end)
