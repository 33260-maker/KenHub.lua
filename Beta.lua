--[[ควยเอ้ยมาดูโค้ดกูทำไมกูไม่รู้จะจัดการกับพวกมึงยังไงแล้ว]]--
--ขอ​สงวนลิขสิทธิ์ [KENHub.com]--
-- ======================
-- ⚡ KEN HUB V3 (RedzLib UI) + Key System + Translator ⚡
-- ======================

-- ====== ตั้งค่า (ถ้าต้องการ ปรับตรงนี้) ======
local ENABLE_TRANSLATOR = true        -- true = เปิดโหมดแปล (Dual) / false = ปิดแปล (แสดงอังกฤษล้วน)
local LANGUAGE_MODE = "Dual"          -- "Dual" = อังกฤษบน/ไทยล่าง, "EN" = อังกฤษ, "TH" = ไทย

-- ======================
-- 🌐 Translator System (อังกฤษบน / ไทยล่าง)
local Translator = {}
Translator.Enabled = ENABLE_TRANSLATOR
Translator.Mode = LANGUAGE_MODE

Translator.Dictionary = {
    ["KEN Hub Key System"] = "ระบบคีย์ KEN Hub",
    ["GET KEY"] = "รับคีย์",
    ["CHECK KEY"] = "ตรวจสอบคีย์",
    ["Enter Key..."] = "กรอกคีย์...",
    ["Key Correct! Loading KEN Hub..."] = "คีย์ถูกต้อง! กำลังโหลด KEN Hub...",
    ["Invalid Key! Press GET KEY to obtain."] = "คีย์ไม่ถูกต้อง! กรุณากดรับคีย์ใหม่",
    ["Increase Speed"] = "เพิ่มความเร็ว",
    ["Fly"] = "บิน",
    ["God Mode (Immortal)"] = "โหมดอมตะ",
    ["Invisible"] = "ล่องหน",
    ["Spawn Clone"] = "สร้างร่างแยก",
    ["Noclip (Walk Through Walls)"] = "ทะลุกำแพง",
    ["Black Hole"] = "หลุมดำ",
    ["Functions"] = "ฟังก์ชัน",
    ["Main"] = "หน้าหลัก",
    ["Tab3"] = "ตั้งค่าเพิ่มเติม",
    ["Speed"] = "ความเร็ว",
    ["Group Server"] = "กลุ่ม Discord",
    ["Join server"] = "เข้าร่วมเซิร์ฟเวอร์",
    ["KENHub Loaded!"] = "โหลด KEN HUB สำเร็จ!",
    ["Script Loaded!"] = "สคริปต์ถูกโหลดแล้ว!"
}

-- คืนค่าสำหรับแสดงใน UI
function Translator:t(key)
    if not self.Enabled then
        if self.Mode == "TH" then
            return self.Dictionary[key] or key
        else
            return key
        end
    end

    local th = self.Dictionary[key]
    if self.Mode == "Dual" and th then
        return key .. "\n" .. th
    elseif self.Mode == "TH" and th then
        return th
    else
        return key
    end
end

-- ======================
-- 🔑 Key System
-- ======================
local allowedKeys = {
    "nnvDYBgaHdzVmfAwirXXVykkqYDueGIu",
    "XvvhSnMxqlpqOQfPscVcnmUraRpBfhgp",
    "UfhrmiqBCbsjZNJVEuYyCwVkAayvbpZE"
}
local KEY_SAVE_FILE = "kenhub_key.txt"
local GET_KEY_LINK = "https://loot-link.com/s?TMcRLbhq"

local function safeReadFile(name)
    if pcall(function() return readfile(name) end) then return readfile(name) end
    return nil
end
local function safeWriteFile(name, content)
    pcall(function() writefile(name, content) end)
end
local function notify(msg)
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "KEN Hub",
            Text = msg,
            Duration = 5
        })
    end)
end
local function tryOpenLinkOrCopy(link)
    pcall(function() if setclipboard then setclipboard(link) end end)
    notify("ลิงก์ถูกคัดลอกไป clipboard แล้ว! เปิดในเบราว์เซอร์เพื่อรับคีย์")
end
local function checkKey(input)
    for _,k in ipairs(allowedKeys) do
        if input == k then return true end
    end
    return false
end

-- ======================
-- สร้าง GUI Key UI
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.Name = "KENHubKeyUI"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 400, 0, 200)
frame.Position = UDim2.new(0.5, -200, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = Translator:t("KEN Hub Key System")
title.TextColor3 = Color3.fromRGB(150,200,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.BackgroundTransparency = 1

local inputBox = Instance.new("TextBox", frame)
inputBox.Size = UDim2.new(1, -20, 0, 40)
inputBox.Position = UDim2.new(0, 10, 0, 60)
inputBox.PlaceholderText = Translator:t("Enter Key...")
inputBox.Font = Enum.Font.Gotham
inputBox.TextSize = 20
inputBox.BackgroundColor3 = Color3.fromRGB(25,25,50)
inputBox.TextColor3 = Color3.fromRGB(255,255,255)

local getKeyBtn = Instance.new("TextButton", frame)
getKeyBtn.Size = UDim2.new(0.45, -5, 0, 40)
getKeyBtn.Position = UDim2.new(0, 10, 0, 120)
getKeyBtn.Text = Translator:t("GET KEY")
getKeyBtn.Font = Enum.Font.GothamBold
getKeyBtn.TextSize = 20
getKeyBtn.BackgroundColor3 = Color3.fromRGB(40,40,80)
getKeyBtn.TextColor3 = Color3.fromRGB(120,180,255)

local checkKeyBtn = Instance.new("TextButton", frame)
checkKeyBtn.Size = UDim2.new(0.45, -5, 0, 40)
checkKeyBtn.Position = UDim2.new(0.55, 0, 0, 120)
checkKeyBtn.Text = Translator:t("CHECK KEY")
checkKeyBtn.Font = Enum.Font.GothamBold
checkKeyBtn.TextSize = 20
checkKeyBtn.BackgroundColor3 = Color3.fromRGB(40,40,80)
checkKeyBtn.TextColor3 = Color3.fromRGB(120,255,180)

local saved = safeReadFile(KEY_SAVE_FILE)
if saved and #saved > 0 then inputBox.Text = saved end

getKeyBtn.MouseButton1Click:Connect(function()
    tryOpenLinkOrCopy(GET_KEY_LINK)
end)

-- เมื่อเช็คคีย์ผ่าน จะเปิดตัว UI หลัก
checkKeyBtn.MouseButton1Click:Connect(function()
    local key = tostring(inputBox.Text)
    if checkKey(key) then
        notify(Translator:t("Key Correct! Loading KEN Hub..."))
        safeWriteFile(KEY_SAVE_FILE, key)
        screenGui:Destroy()

        -- ======================
        -- ⚡ โหลด RedzLib UI และสร้าง KEN HUB
        local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/Library-ui/refs/heads/main/Redzhubui"))()

        local Window = redzlib:MakeWindow({
            Title = "KEN Hub",
            SubTitle = "by Ken9999",
            SaveFolder = "KEN_HUB_Config"
        })

        Window:AddMinimizeButton({
            Button = { Image = "rbxassetid://103308551113442", BackgroundTransparency = 0 },
            Corner = { CornerRadius = UDim.new(0, 15) },
        })

        -- ===== Tab1 =====
        local Tab1 = Window:MakeTab({
            Name = Translator:t("Main"),
            Icon = "rbxassetid://103308551113442"
        })

        Tab1:AddDiscordInvite({
            Name = Translator:t("Group Server"),
            Description = Translator:t("Join server"),
            Logo = "rbxassetid://103308551113442",
            Invite = "https://discord.gg/Apn2j9Fez",
        })

        -- ===== Tab2 =====
        local Tab2 = Window:MakeTab({
            Name = Translator:t("Functions"),
            Icon = "rbxassetid://103308551113442"
        })

        -- ฟังก์ชันช่วยสร้างปุ่ม: รับ key (อังกฤษ) เป็นตัวระบุ และแสดง displayName ที่แปลแล้ว
        local function addFunctionButton(key, url, speed)
            local displayName = Translator:t(key)
            Tab2:AddButton({
                Name = displayName,
                Callback = function()
                    local plr = game.Players.LocalPlayer
                    -- ใช้ key ตรงนี้สำหรับ logic แทนการเปรียบเทียบกับ display text
                    if key == "Increase Speed" and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                        plr.Character.Humanoid.WalkSpeed = speed
                        notify( (Translator.Mode=="Dual" and (key.."\n"..(Translator.Dictionary[key] or "")) ) or Translator:t(key) .. " = " .. tostring(speed) )
                    elseif url then
                        loadstring(game:HttpGet(url))()
                        notify(Translator:t(key) .. " เปิดใช้งานแล้ว!")
                    end
                end
            })
        end

        -- สร้างปุ่มโดยส่ง key ดั้งเดิม (อังกฤษ)
        addFunctionButton("Increase Speed", nil, 50)
        addFunctionButton("Fly", "https://rawscripts.net/raw/Universal-Script-Gui-Fly-v3-37111")
        addFunctionButton("God Mode (Immortal)", "https://raw.githubusercontent.com/Rawbr10/Roblox-Scripts/refs/heads/main/God%20Mode%20Script%20Universal")
        addFunctionButton("Invisible", "https://pastebin.com/raw/3Rnd9rHf")
        addFunctionButton("Spawn Clone", "https://raw.githubusercontent.com/0Ben1/fe/main/obf_11l7Y131YqJjZ31QmV5L8pI23V02b3191sEg26E75472Wl78Vi8870jRv5txZyL1.lua.txt")
        addFunctionButton("Noclip (Walk Through Walls)", "https://pastebin.com/raw/u0nS8wq2")
        addFunctionButton("Black Hole", "https://pastebin.com/raw/zgSEcs5E")

        -- ===== Tab3 =====
        local Tab3 = Window:MakeTab({
            Name = Translator:t("Tab3"),
            Icon = "rbxassetid://103308551113442"
        })

        Tab3:AddSlider({
            Name = Translator:t("Speed"),
            Min = 1,
            Max = 100,
            Increase = 1,
            Default = 16,
            Callback = function(Value)
                local plr = game.Players.LocalPlayer
                if plr.Character and plr.Character:FindFirstChild("Humanoid") then
                    plr.Character.Humanoid.WalkSpeed = Value
                end
            end
        })

        -- ===== Settings Tab (เพิ่ม Toggle ควบคุม Translator และโหมดภาษา) =====
        local SettingsTab = Window:MakeTab({
            Name = Translator:t("Settings"),
            Icon = "rbxassetid://103308551113442"
        })

        SettingsTab:AddToggle({
            Name = Translator:t("Enable Translator"),
            Default = Translator.Enabled,
            Callback = function(v)
                Translator.Enabled = v
                -- รีเฟรช UI อาจต้องปิดแล้วเปิดใหม่บาง element ตาม RedzLib
                notify( v and "Translator enabled" or "Translator disabled" )
            end
        })

        SettingsTab:AddDropdown({
            Name = Translator:t("Language Mode"),
            Default = Translator.Mode,
            Options = {"Dual","EN","TH"},
            Callback = function(val)
                Translator.Mode = val
                notify("Language mode: "..tostring(val))
            end
        })

        -- แจ้งเตือนว่าโหลดเสร็จ
        local game_name = pcall(function() return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name end)
        local gname = ""
        if game_name then
            -- pcall returned true, but above is not properly stored; just try again safe
            local ok, nm = pcall(function() return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name end)
            if ok then gname = nm else gname = "Game" end
        else
            gname = "Game"
        end

        pcall(function()
            game.StarterGui:SetCore("SendNotification", {
                Title = Translator:t("KENHub Loaded!"),
                Text = gname .. " " .. Translator:t("Script Loaded!"),
                Icon = "rbxassetid://103308551113442",
                Duration = 5
            })
        end)
    else
        notify(Translator:t("Invalid Key! Press GET KEY to obtain."))
    end
end)
