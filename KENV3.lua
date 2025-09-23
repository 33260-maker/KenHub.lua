-- ======================
--    ⚡ KEN HUB V3 ⚡️
-- ======================

-- 📌 Logo Button (Left Side)
local LogoGui = Instance.new("ScreenGui")
LogoGui.Parent = game.CoreGui
LogoGui.ResetOnSpawn = false

local LogoBtn = Instance.new("ImageButton")
LogoBtn.Parent = LogoGui
LogoBtn.Size = UDim2.new(0, 60, 0, 60)
LogoBtn.Position = UDim2.new(0, 10, 0.4, 0)
LogoBtn.BackgroundTransparency = 1
LogoBtn.Image = "rbxassetid://76679361348099"

local toggleButton = Instance.new("TextLabel")
toggleButton.Parent = LogoBtn
toggleButton.Size = UDim2.new(1,0,1,0)
toggleButton.BackgroundTransparency = 1
toggleButton.TextColor3 = Color3.new(1,1,1)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextScaled = true
toggleButton.Active = false
toggleButton.Selectable = false

-- ======================
-- ⚡ Toggle UI with Logo
-- ======================
LogoBtn.MouseButton1Click:Connect(function()
if Window and Window.ToggleUI then
Window:ToggleUI()
end
end)

-- ======================
-- 🎮 Make Logo Draggable (PC + Mobile)
-- ======================
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
local delta = input.Position - dragStart
LogoBtn.Position = UDim2.new(
startPos.X.Scale, startPos.X.Offset + delta.X,
startPos.Y.Scale, startPos.Y.Offset + delta.Y
)
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

-- ======================
-- 🚀 Example Functions (EN+TH Label)
-- ======================
local function dualLabel(en, th)
return en .. "\n<font color="rgb(180,180,180)" size="12">" .. th .. "</font>"
end

-- Main Tab
local TabMain = Window:NewTab("Main/หน้าหลัก")
local SecMain = TabMain:NewSection(dualLabel("⚙️ Controls", "ควบคุม"))

-- Functions Tab
local TabFunc = Window:NewTab("Functions/ฟังก์ชัน")
local SecFunc = TabFunc:NewSection(dualLabel("🚀 Scripts", "สคริปต์"))

-- Increase WalkSpeed
SecFunc:NewButton(dualLabel("🏃 Increase Speed", "เพิ่มความเร็วเดิน"),"",function()
local plr = game.Players.LocalPlayer
if plr.Character and plr.Character:FindFirstChild("Humanoid") then
plr.Character.Humanoid.WalkSpeed = 50
end
end)

-- Fly Script
SecFunc:NewButton(dualLabel("✈️ Fly", "บิน"),"",function()
pcall(function()
loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Gui-Fly-v3-37111"))()
end)
end)

-- God Mode
SecFunc:NewButton(dualLabel("🛡️ God Mode", "โหมดอมตะ"),"",function()
print("God Mode script here")
end)

-- Invisible Script
SecFunc:NewButton(dualLabel("👻 Invisible", "ล่องหน"),"",function()
pcall(function()
loadstring(game:HttpGet('https://pastebin.com/raw/3Rnd9rHf'))()
end)
end)

-- ======================
-- 📢 Notification after KEN Hub Loaded
-- ======================
if _function and _function.getid and _function.gamename then
local script_id, game_name = _function.getid(), _function.gamename()
if script_id then
game.StarterGui:SetCore(
"SendNotification",
{
Title = "KENHub Loaded!",
Text = game_name .. " Script Loaded!",
Icon = "rbxassetid://76679361348099",
Duration = 5
}
)
end
end
