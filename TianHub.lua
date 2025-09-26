-- ======================
-- 🔑 Key System + KEN HUB V3 Loader
-- ======================
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local GuiService = game:GetService("GuiService")
local player = Players.LocalPlayer

local VALID_KEY = "bencezshop125481342"
local KEY_LINK = "https://lootdest.org/s?vwrMcYmz"
local processing = false

local function sendNotif(title, text, dur)
    pcall(function()
        StarterGui:SetCore("SendNotification", {Title = title, Text = text, Duration = dur or 4})
    end)
end

-- ======================
-- ฟังก์ชันโหลด KEN HUB ตัวเต็ม
-- ======================
local function LoadKENHub()
    -- 📌 Logo Button
    local LogoGui = Instance.new("ScreenGui")
    LogoGui.Parent = game.CoreGui
    LogoGui.ResetOnSpawn = false

    local LogoBtn = Instance.new("ImageButton")
    LogoBtn.Parent = LogoGui
    LogoBtn.Size = UDim2.new(0, 60, 0, 60)
    LogoBtn.Position = UDim2.new(0, 10, 0.4, 0)
    LogoBtn.BackgroundTransparency = 1
    LogoBtn.Image = "rbxassetid://99764942615873"

    local toggleButton = Instance.new("TextLabel")
    toggleButton.Parent = LogoBtn
    toggleButton.Size = UDim2.new(1,0,1,0)
    toggleButton.BackgroundTransparency = 1
    toggleButton.TextColor3 = Color3.new(1,1,1)
    toggleButton.Font = Enum.Font.SourceSansBold
    toggleButton.TextScaled = true

    -- ⚡ UI Library
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window = Library.CreateLib("⚡ KEN Hub V3 ⚡","DarkTheme")

    -- 🎮 Make Logo Draggable
    local UserInputService = game:GetService("UserInputService")
    local dragging, dragInput, dragStart, startPos

    local function clampPosition(pos, size)
        local screen = workspace.CurrentCamera.ViewportSize
        local x = math.clamp(pos.X.Offset, 0, screen.X - size.X.Offset)
        local y = math.clamp(pos.Y.Offset, 0, screen.Y - size.Y.Offset)
        return UDim2.new(pos.X.Scale, x, pos.Y.Scale, y)
    end

    local function update(input)
        local delta = input.Position - dragStart
        local newPos = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
        LogoBtn.Position = clampPosition(newPos, LogoBtn.Size)
        if Window and Window.MainFrame then
            Window.MainFrame.Position = clampPosition(Window.MainFrame.Position, Window.MainFrame.Size)
        end
    end

    LogoBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = LogoBtn.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    LogoBtn.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement 
        or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    -- ✅ Toggle UI เมื่อกดโลโก้
    local uiVisible = true
    LogoBtn.MouseButton1Click:Connect(function()
        if Window and Window.MainFrame then
            uiVisible = not uiVisible
            Window.MainFrame.Visible = uiVisible
        end
    end)

    -- 🚀 Example Functions
    local function dualLabel(en, th)
        return en .. "\n<font color=\"rgb(180,180,180)\" size=\"12\">" .. th .. "</font>"
    end

    local TabMain = Window:NewTab("Main/หน้าหลัก")
    local SecMain = TabMain:NewSection(dualLabel("⚙️ Controls", "ควบคุม"))
    SecMain:NewSlider(dualLabel("🔍 UI Scale", "ปรับขนาด UI"), "", 0.5, 2, function(value)
        if Window and Window.MainFrame then
            Window.MainFrame.Size = UDim2.new(value, 0, value, 0)
        end
    end)

    local TabFunc = Window:NewTab("Functions/ฟังก์ชัน")
    local SecFunc = TabFunc:NewSection(dualLabel("🚀 Scripts", "สคริปต์"))

    SecFunc:NewButton(dualLabel("🏃 Increase Speed", "เพิ่มความเร็วเดิน"),"",function()
        local plr = game.Players.LocalPlayer
        if plr.Character and plr.Character:FindFirstChild("Humanoid") then
            plr.Character.Humanoid.WalkSpeed = 50
        end
    end)

    SecFunc:NewButton(dualLabel("✈️ Fly", "บิน"),"",function()
        pcall(function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Gui-Fly-v3-37111"))()
        end)
    end)

    SecFunc:NewButton(dualLabel("🛡️ God Mode", "โหมดอมตะ"),"",function()
        print("God Mode script here")
    end)

    SecFunc:NewButton(dualLabel("👻 Invisible", "ล่องหน"),"",function()
        pcall(function()
            loadstring(game:HttpGet('https://pastebin.com/raw/3Rnd9rHf'))()
        end)
    end)

    sendNotif("KENHub Loaded!", "Script Loaded Successfully!", 5)
end

-- ======================
-- Key UI
-- ======================
local function createKeyGui()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KENKeyGui"
    screenGui.Parent = player:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 420, 0, 200)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.BackgroundColor3 = Color3.fromRGB(22,22,22)
    frame.Parent = screenGui

    local txtBox = Instance.new("TextBox")
    txtBox.Size = UDim2.new(1, -20, 0, 40)
    txtBox.Position = UDim2.new(0, 10, 0, 60)
    txtBox.PlaceholderText = "กรอกคีย์..."
    txtBox.Parent = frame

    local msgLabel = Instance.new("TextLabel")
    msgLabel.Size = UDim2.new(1, -20, 0, 20)
    msgLabel.Position = UDim2.new(0, 10, 0, 110)
    msgLabel.BackgroundTransparency = 1
    msgLabel.TextColor3 = Color3.new(1,0,0)
    msgLabel.Text = ""
    msgLabel.Parent = frame

    local continueBtn = Instance.new("TextButton")
    continueBtn.Size = UDim2.new(0.48, 0, 0, 40)
    continueBtn.Position = UDim2.new(0, 10, 1, -50)
    continueBtn.Text = "Continue"
    continueBtn.Parent = frame

    local getKeyBtn = Instance.new("TextButton")
    getKeyBtn.Size = UDim2.new(0.48, 0, 0, 40)
    getKeyBtn.Position = UDim2.new(0.52, 0, 1, -50)
    getKeyBtn.Text = "Get Your Key"
    getKeyBtn.Parent = frame

    continueBtn.MouseButton1Click:Connect(function()
        if txtBox.Text == VALID_KEY then
            msgLabel.Text = "✅ Key ถูกต้อง กำลังโหลด..."
            wait(0.5)
            screenGui:Destroy()
            LoadKENHub()
        else
            msgLabel.Text = "❌ Key ไม่ถูกต้อง"
        end
    end)

    getKeyBtn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(KEY_LINK)
            sendNotif("Key Link", "คัดลอกลิงก์ไป clipboard แล้ว!", 4)
        else
            sendNotif("Key Link", "กรุณาไปที่: " .. KEY_LINK, 6)
        end
    end)
end

-- 🚀 Start Key UI
createKeyGui()
