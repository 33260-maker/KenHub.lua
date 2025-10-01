-- ======================
-- ⚡ KEN HUB V3 (RedzLib UI) ⚡
-- ======================

-- 📂 โหลด RedzLib
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/Library-ui/refs/heads/main/Redzhubui"))()

-- 🪟 สร้างหน้าต่างหลัก
local Window = redzlib:MakeWindow({
    Title = "KEN Hub",
    SubTitle = "by Ken9999",
    SaveFolder = "KEN_HUB_Config"
})

-- 🔽 ปุ่มย่อ/ขยาย (Minimize)
Window:AddMinimizeButton({
    Button = { Image = "rbxassetid://103308551113442", BackgroundTransparency = 0 },
    Corner = { CornerRadius = UDim.new(0, 15) },
})

-- 📑 Tab หลัก (Main)
local Tab1 = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://103308551113442"
})

-- ✅ Discord Invite
Tab1:AddDiscordInvite({
    Name = "กลุ่มแจกโปร",
    Description = "Join server",
    Logo = "rbxassetid://103308551113442",
    Invite = "https://discord.gg/Apn2j9Fez",
})

-- 📑 Tab ฟังก์ชัน (Functions)
local Tab2 = Window:MakeTab({
    Name = "Functions",
    Icon = "rbxassetid://103308551113442"
})

-- ======================
-- 🚀 ตัวอย่างปุ่มใน RedzLib
-- ======================

-- ปุ่มเพิ่ม Speed
Tab2:AddButton({
    Name = "🏃 Increase Speed",
    Callback = function()
        local plr = game.Players.LocalPlayer
        if plr.Character and plr.Character:FindFirstChild("Humanoid") then
            plr.Character.Humanoid.WalkSpeed = 50
        end
    end
})

-- ปุ่ม Fly
Tab2:AddButton({
    Name = "✈️ Fly",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Gui-Fly-v3-37111"))()
    end
})

-- ปุ่ม God Mode (ตัวอย่าง)
Tab2:AddButton({
    Name = "🛡️ God Mode",
    Callback = function()
        print("God Mode script here")
    end
})

-- ปุ่ม Invisible
Tab2:AddButton({
    Name = "👻 Invisible",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/3Rnd9rHf'))()
    end
})
