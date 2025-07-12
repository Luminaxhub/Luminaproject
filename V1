-- Elegant UI + Universal ESP + Scrollable Theme Picker by Luminaprojects
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local ScreenGui = Instance.new("ScreenGui", Players.LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "Universal esp - Luminaprojects"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local Header = Instance.new("Frame", MainFrame)
Header.Size, Header.Position = UDim2.new(1,0,0,30), UDim2.new(0,0,0,0)
Header.BackgroundColor3 = Color3.fromRGB(30,30,30)
Instance.new("UICorner", Header).CornerRadius = UDim.new(0,10)
local HeaderLabel = Instance.new("TextLabel", Header)
HeaderLabel.Size, HeaderLabel.BackgroundTransparency = UDim2.new(1,0,1,0), 1
HeaderLabel.Text = "🌙 Universal esp - Luminaprojects"
HeaderLabel.Font = Enum.Font.GothamBold
HeaderLabel.TextSize = 16
HeaderLabel.TextColor3 = Color3.new(1,1,1)
HeaderLabel.TextXAlignment = Enum.TextXAlignment.Center

local function makeBtn(txt, posX)
    local b = Instance.new("TextButton", Header)
    b.Size, b.Position = UDim2.new(0,30,0,0), UDim2.new(1,posX,0,0)
    b.Text, b.BackgroundTransparency = txt, 1
    b.Font, b.TextSize, b.TextColor3 = Enum.Font.Gotham, 14, Color3.new(1,1,1)
    return b
end
local CloseBtn = makeBtn("✕", -30)
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

local Side, Cont
local MinBtn = makeBtn("━", -60)
local Minimized = false
MinBtn.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    Side.Visible = not Minimized
    Cont.Visible = not Minimized
end)

Side = Instance.new("Frame", MainFrame)
Side.Size, Side.Position = UDim2.new(0,140,1,-30), UDim2.new(0,0,0,30)
Side.BackgroundColor3 = Color3.fromRGB(25,25,25)
Instance.new("UICorner", Side).CornerRadius = UDim.new(0,0)

local TabBtn = Instance.new("TextButton", Side)
TabBtn.Size, TabBtn.Position = UDim2.new(1,0,0,50), UDim2.new(0,0,0,0)
TabBtn.Text = "Main"
TabBtn.Font, TabBtn.TextSize = Enum.Font.GothamSemibold, 16
TabBtn.TextColor3 = Color3.new(1,1,1)
TabBtn.BackgroundTransparency = 1

local TabLabel = Instance.new("TextLabel", Side)
TabLabel.Size, TabLabel.Position = UDim2.new(1,0,0,50), UDim2.new(0,0,0,50)
TabLabel.Text = "⚙️ Universal Esp"
TabLabel.Font, TabLabel.TextSize = Enum.Font.Gotham, 14
TabLabel.TextColor3 = Color3.new(1,1,1)
TabLabel.BackgroundTransparency = 1

-- SCROLLABLE THEME PICKER
local ThemeScroll = Instance.new("ScrollingFrame", Side)
ThemeScroll.Size = UDim2.new(1, -20, 0, 80)
ThemeScroll.Position = UDim2.new(0, 10, 0, 100)
ThemeScroll.CanvasSize = UDim2.new(0, 0, 0, 200)
ThemeScroll.ScrollBarThickness = 4
ThemeScroll.BackgroundTransparency = 1

local themeColors = {
    Color3.fromRGB(35, 35, 120),
    Color3.fromRGB(120, 35, 35),
    Color3.fromRGB(35, 120, 35),
    Color3.fromRGB(120, 120, 35),
    Color3.fromRGB(35, 120, 120),
    Color3.fromRGB(120, 35, 120),
    Color3.fromRGB(200, 100, 50),
    Color3.fromRGB(50, 200, 100),
    Color3.fromRGB(100, 50, 200),
    Color3.fromRGB(200, 50, 100),
}

for i, color in ipairs(themeColors) do
    local btn = Instance.new("TextButton", ThemeScroll)
    btn.Size = UDim2.new(1, 0, 0, 20)
    btn.Position = UDim2.new(0, 0, 0, (i - 1) * 22)
    btn.BackgroundColor3 = color
    btn.Text = ""
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    btn.MouseButton1Click:Connect(function()
        Side.BackgroundColor3 = color
    end)
end

Cont = Instance.new("Frame", MainFrame)
Cont.Size, Cont.Position = UDim2.new(1,-140,1,-30), UDim2.new(0,140,0,30)
Cont.BackgroundColor3 = Color3.fromRGB(30,30,30)
Instance.new("UICorner", Cont).CornerRadius = UDim.new(0,6)

local ScriptBox = Instance.new("TextBox", Cont)
ScriptBox.Size, ScriptBox.Position = UDim2.new(0.65,0,0.7,0), UDim2.new(0,20,0,20)
ScriptBox.MultiLine, ScriptBox.ClearTextOnFocus = true, false
ScriptBox.Font, ScriptBox.TextSize, ScriptBox.TextColor3 = Enum.Font.Code, 14, Color3.new(1,1,1)
ScriptBox.Text = "-- ESP Script"
ScriptBox.BackgroundColor3 = Color3.fromRGB(25,25,25)
Instance.new("UICorner", ScriptBox).CornerRadius = UDim.new(0,4)

-- SLIDER + TEXT "🕊️ Esp v1"
local label = Instance.new("TextLabel", Cont)
label.Size, label.Position = UDim2.new(0,120,0,25), UDim2.new(0.02,0,0.8,0)
label.Text = "🕊️ Esp v1"
label.Font, label.TextSize, label.TextColor3 = Enum.Font.GothamSemibold, 16, Color3.new(1,1,1)
label.BackgroundTransparency = 1

local Slider = Instance.new("Frame", Cont)
Slider.Size, Slider.Position = UDim2.new(0, 150, 0, 20), UDim2.new(0, 140, 0.8, 0)
Slider.BackgroundColor3 = Color3.fromRGB(60,60,60)
Instance.new("UICorner", Slider).CornerRadius = UDim.new(1,0)

local knob = Instance.new("Frame", Slider)
knob.Size = UDim2.new(0,20,0,20)
knob.Position = UDim2.new(0,0,0,0)
knob.BackgroundColor3 = Color3.fromRGB(200,200,200)
Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

knob.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 then
        local moveConn
        moveConn = UserInputService.InputChanged:Connect(function(move)
            if move.UserInputType==Enum.UserInputType.MouseMovement then
                local x = math.clamp(move.Position.X - Slider.AbsolutePosition.X, 0, Slider.AbsoluteSize.X - knob.AbsoluteSize.X)
                knob.Position = UDim2.new(0, x, 0, 0)
            end
        end)
        UserInputService.InputEnded:Connect(function(e)
            if e.UserInputType==Enum.UserInputType.MouseButton1 then
                if moveConn then moveConn:Disconnect() end
            end
        end)
    end
end)
