local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KuoHubPromo"
screenGui.ResetOnSpawn = false
screenGui.Parent = pgui

local font = Enum.Font.GothamBold

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 450, 0, 320)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -160)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = mainFrame

local shadow = Instance.new("ImageLabel")
shadow.Size = UDim2.new(1, 30, 1, 30)
shadow.Position = UDim2.new(0, -15, 0, -15)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://103308551113442"
shadow.ImageColor3 = Color3.new(0, 0, 0)
shadow.ImageTransparency = 0.6
shadow.ZIndex = 0
shadow.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 50)
title.Position = UDim2.new(0, 20, 0, 20)
title.BackgroundTransparency = 1
title.Text = "UPDATE!"
title.TextColor3 = Color3.fromRGB(0, 255, 150)
title.Font = font
title.TextSize = 32
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = mainFrame

local titleTH = Instance.new("TextLabel")
titleTH.Size = UDim2.new(1, -40, 0, 50)
titleTH.Position = UDim2.new(0, 20, 0, 20)
titleTH.BackgroundTransparency = 1
titleTH.Text = "อัปเดตแล้วนะ!"
titleTH.TextColor3 = Color3.fromRGB(0, 255, 150)
titleTH.Font = font
titleTH.TextSize = 32
titleTH.TextXAlignment = Enum.TextXAlignment.Left
titleTH.Parent = mainFrame

local descThai = Instance.new("TextLabel")
descThai.Size = UDim2.new(1, -40, 0, 120)
descThai.Position = UDim2.new(0, 20, 0, 75)
descThai.BackgroundTransparency = 1
descThai.Text = [[คุณยังใช้ GitHub อยู่ใช่มั้ย?
loadstring(game:HttpGet('https://raw.githubusercontent.com/33260-maker/KenHub.lua/refs/heads/main/Premium.lua'))()
สองวันที่ผ่านมา GitHub ล่มบ่อยมาก ทำให้โหลดไม่ได้แนะนำเลย! เปลี่ยนมาใช้ลิงก์ใหม่ สั้นกว่า จำง่ายกว่า และเสถียรกว่า 100%
loadstring(game:HttpGet("https://pastefy.app/of4UGeHS/raw"))()]]
descThai.TextColor3 = Color3.fromRGB(220, 220, 220)
descThai.Font = Enum.Font.Gotham
descThai.TextSize = 17
descThai.TextWrapped = true
descThai.TextXAlignment = Enum.TextXAlignment.Left
descThai.TextYAlignment = Enum.TextYAlignment.Top
descThai.Visible = true
descThai.Parent = mainFrame

local descEng = Instance.new("TextLabel")
descEng.Size = UDim2.new(1, -40, 0, 120)
descEng.Position = UDim2.new(0, 20, 0, 75)
descEng.BackgroundTransparency = 1
descEng.Text = [[Still using GitHub? loadstring(game:HttpGet('https://raw.githubusercontent.com/33260-maker/KenHub.lua/refs/heads/main/Premium.lua'))() GitHub has been down frequently for the past 2 days... causing load failures Recommended! Switch to the new link - shorter, easier to remember, and 100% stable loadstring(game:HttpGet("https://pastefy.app/of4UGeHS/raw"))()]]
descEng.TextColor3 = Color3.fromRGB(220, 220, 220)
descEng.Font = Enum.Font.Gotham
descEng.TextSize = 16
descEng.TextWrapped = true
descEng.TextXAlignment = Enum.TextXAlignment.Left
descEng.TextYAlignment = Enum.TextYAlignment.Top
descEng.Visible = false
descEng.Parent = mainFrame

local langFrame = Instance.new("Frame")
langFrame.Size = UDim2.new(0, 195, 0, 25)
langFrame.Position = UDim2.new(1, -445, 0, 5)
langFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
langFrame.BorderSizePixel = 0
langFrame.Parent = mainFrame

local langCorner = Instance.new("UICorner")
langCorner.CornerRadius = UDim.new(0, 8)
langCorner.Parent = langFrame

local other = Instance.new("TextLabel")
other.Size = UDim2.new(0.5, -1, 1, 0)
other.Position = UDim2.new(0, 260, 0, 0)
other.BackgroundTransparency = 1
other.Text = "⬅เปลี่ยนภาษาข้อความ | Change Language Text"
other.TextColor3 = Color3.fromRGB(0, 255, 150)
other.Font = Enum.Font.GothamBold
other.TextSize = 12
other.Parent = langFrame

local thaiBtn = Instance.new("TextButton")
thaiBtn.Size = UDim2.new(0.5, -1, 1, 0)
thaiBtn.Position = UDim2.new(0, 1, 0, 0)
thaiBtn.BackgroundTransparency = 1
thaiBtn.Text = "🇹🇭 ข้อความภาษาไทย"
thaiBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
thaiBtn.Font = Enum.Font.GothamBold
thaiBtn.TextSize = 14
thaiBtn.Parent = langFrame

local engBtn = Instance.new("TextButton")
engBtn.Size = UDim2.new(0.5, 0, 1, 0)
engBtn.Position = UDim2.new(0.5, 1,0, 0)
engBtn.BackgroundTransparency = 1
engBtn.Text = "🇺🇸 ENGLISH"
engBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
engBtn.Font = Enum.Font.GothamBold
engBtn.TextSize = 14
engBtn.Parent = langFrame
title.Visible = false
thaiBtn.MouseButton1Click:Connect(function()
    descThai.Visible = true
    descEng.Visible = false
    titleTH.Visible = true
    title.Visible = false
    thaiBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
    engBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
end)

engBtn.MouseButton1Click:Connect(function()
    descEng.Visible = true
    descThai.Visible = false
    titleTH.Visible = false
    title.Visible = true
    engBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
    thaiBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
end)

local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(0, 380, 0, 55)
copyBtn.Position = UDim2.new(0.5, -190, 1, -80)
copyBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
copyBtn.Text = "Get New loadstring Script | ก็อปปี้ลิ้งสคริปต์ใหม่"
copyBtn.TextColor3 = Color3.new(0, 0, 0)
copyBtn.Font = font
copyBtn.TextSize = 18
copyBtn.Parent = mainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 12)
btnCorner.Parent = copyBtn

copyBtn.MouseButton1Click:Connect(function()
    setclipboard('loadstring(game:HttpGet("https://pastefy.app/GAEZLeje/raw"))()')
    
    copyBtn.Text = "Copied! | คัดลอกแล้ว!"
    copyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    
    task.wait(1.5)
    copyBtn.Text = "Get New loadstring Script | ก็อปปี้ลิ้งสคริปต์ใหม่"
    copyBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
end)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -50, 0, 10)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
closeBtn.Font = font
closeBtn.TextSize = 28
closeBtn.Parent = mainFrame

closeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -225, 0.5, -480)}):Play()
    task.wait(0.5)
    screenGui:Destroy()
end)

mainFrame.Position = UDim2.new(0.5, -225, 0.5, -480)
TweenService:Create(mainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -225, 0.5, -160)}):Play()
