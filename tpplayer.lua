local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LoadstringUI"
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 500, 0, 350) -- Ukuran yang lebih besar untuk menampung elemen
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175) -- Posisikan di tengah layar
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45) -- Warna dasar gelap
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true -- Penting untuk minimize
mainFrame.Parent = screenGui

-- Draggable functionality
local dragging
local dragInput
local dragStart
local startPos

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Handled = true
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if dragging then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end
end)

mainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Top Bar (for title and buttons)
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(28, 28, 35) -- Sedikit lebih gelap dari mainFrame
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, -60, 1, 0) -- Beri ruang untuk tombol
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "⚡ Player Teleporter" -- Ubah sesuai kebutuhan Loadstring
titleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.TextWrapped = true
titleLabel.Padding = UDim.new(0, 10) -- Padding untuk teks
titleLabel.Parent = topBar

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 1, 0)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Merah
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 20
closeButton.BorderSizePixel = 0
closeButton.Parent = topBar

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Minimize Button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 30, 1, 0)
minimizeButton.Position = UDim2.new(1, -60, 0, 0) -- Di sebelah kiri close button
minimizeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 90) -- Abu-abu
minimizeButton.Text = "—" -- Atau "-"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Font = Enum.Font.SourceSansBold
minimizeButton.TextSize = 20
minimizeButton.BorderSizePixel = 0
minimizeButton.Parent = topBar

local isMinimized = false
local originalSize = mainFrame.Size

minimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        mainFrame.Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset, 0, topBar.Size.Y.Offset) -- Hanya menyisakan top bar
        -- Sembunyikan semua anak kecuali TopBar
        for _, child in pairs(mainFrame:GetChildren()) do
            if child ~= topBar then
                child.Visible = false
            end
        end
    else
        mainFrame.Size = originalSize
        -- Tampilkan kembali semua anak
        for _, child in pairs(mainFrame:GetChildren()) do
            child.Visible = true
        end
    end
end)

-- Content Frame (untuk menampung semua elemen di bawah top bar)
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, 0, 1, -30) -- Mengambil sisa ruang di bawah topBar
contentFrame.Position = UDim2.new(0, 0, 0, 30)
contentFrame.BackgroundTransparency = 1
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

-- Main Layout - Loadstring Input
local loadstringTextBox = Instance.new("TextBox")
loadstringTextBox.Name = "LoadstringInput"
loadstringTextBox.Size = UDim2.new(1, -20, 0.7, 0) -- Ambil sebagian besar ruang vertikal
loadstringTextBox.Position = UDim2.new(0, 10, 0, 10)
loadstringTextBox.PlaceholderText = "Paste your loadstring here..."
loadstringTextBox.Text = ""
loadstringTextBox.MultiLine = true -- Untuk baris kode yang panjang
loadstringTextBox.ClearTextOnFocus = false
loadstringTextBox.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
loadstringTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
loadstringTextBox.Font = Enum.Font.Monospace
loadstringTextBox.TextSize = 14
loadstringTextBox.TextXAlignment = Enum.TextXAlignment.Left
loadstringTextBox.TextYAlignment = Enum.TextYAlignment.Top
loadstringTextBox.BorderSizePixel = 0
loadstringTextBox.Parent = contentFrame

-- Execute Button
local executeButton = Instance.new("TextButton")
executeButton.Name = "ExecuteButton"
executeButton.Size = UDim2.new(1, -20, 0, 40)
executeButton.Position = UDim2.new(0, 10, 0.7, 20) -- Di bawah textbox
executeButton.BackgroundColor3 = Color3.fromRGB(50, 200, 100) -- Hijau
executeButton.Text = "🚀 Execute Loadstring"
executeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
executeButton.Font = Enum.Font.SourceSansBold
executeButton.TextSize = 18
executeButton.BorderSizePixel = 0
executeButton.Parent = contentFrame

executeButton.MouseButton1Click:Connect(function()
    local code = loadstringTextBox.Text
    if code and code ~= "" then
        local success, err = pcall(function()
            local func = loadstring(code)
            if func then
                func()
                warn("Loadstring executed successfully!")
            else
                warn("Failed to create function from loadstring:", err)
            end
        end)
        if not success then
            warn("Error executing loadstring:", err)
        end
    else
        warn("No loadstring code entered.")
    end
end)

-- (Optional) Status Label for feedback
local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 1, -30) -- Di bagian bawah frame
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.Text = "Ready."
statusLabel.Font = Enum.Font.SourceSans
statusLabel.TextSize = 14
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.BorderSizePixel = 0
statusLabel.Parent = contentFrame

-- Set status feedback
local function setStatus(message, color)
    statusLabel.Text = message
    statusLabel.TextColor3 = color or Color3.fromRGB(255, 255, 255)
end

executeButton.MouseButton1Click:Connect(function()
    local code = loadstringTextBox.Text
    if code and code ~= "" then
        local func, err = loadstring(code) -- loadstring returns function or nil + error
        if func then
            local success, runErr = pcall(func)
            if success then
                setStatus("Loadstring executed successfully!", Color3.fromRGB(50, 200, 100))
            else
                setStatus("Error executing loadstring: " .. (runErr or "Unknown error"), Color3.fromRGB(200, 50, 50))
            end
        else
            setStatus("Failed to loadstring: " .. (err or "Invalid code"), Color3.fromRGB(200, 150, 50))
        end
    else
        setStatus("Please paste a loadstring.", Color3.fromRGB(200, 150, 50))
    end
end)
