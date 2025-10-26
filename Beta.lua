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
    ["Increase Speed"] = "เพิ่มความเร็ว",
    ["Fly"] = "บิน",
    ["God Mode (Immortal)"] = "โหมดอมตะ",
    ["Invisible"] = "ล่องหน",
    ["Spawn Clone"] = "สร้างร่างแยก",
    ["Noclip (Walk Through Walls)"] = "ทะลุกำแพง",
    ["Black Hole"] = "หลุมดำ",
    ["AirWalk (Walk on Air)"] = "เดินบนอากาศ",
    ["Functions"] = "ฟังก์ชัน",
    ["Main"] = "หน้าหลัก",
    ["Tab3"] = "ตั้งค่าเพิ่มเติม",
    ["Speed"] = "ความเร็ว",
    ["Group Server"] = "กลุ่ม Discord",
    ["Join server"] = "เข้าร่วมเซิร์ฟเวอร์",
    ["KENHub Loaded!"] = "โหลด KEN HUB สำเร็จ!",
    ["Script Loaded!"] = "สคริปต์ถูกโหลดแล้ว!"
}
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
        Tab2:AddButton({
    Name = Translator:t("AirWalk (Walk on Air)"),
    Callback = function()
        local plr = game.Players.LocalPlayer
        local char = plr.Character or plr.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")

        local airPart = Instance.new("Part")
        airPart.Size = Vector3.new(10,1,10)
        airPart.Anchored = true
        airPart.CanCollide = true
        airPart.Transparency = 0.5
        airPart.Material = Enum.Material.Neon
        airPart.Color = Color3.fromRGB(0,255,255)
        airPart.Parent = workspace

        local on = true
        local height = 5
        notify("กดปุ่ม F เพื่อเปิด/ปิด AirWalk")

        local run = game:GetService("RunService")
        local input = game:GetService("UserInputService")

        run.RenderStepped:Connect(function()
            if on and hrp and airPart then
                airPart.Position = hrp.Position - Vector3.new(0,height,0)
            end
        end)

        input.InputBegan:Connect(function(key,proc)
            if proc then return end
            if key.KeyCode == Enum.KeyCode.F then
                on = not on
                notify(on and "✅ เปิด AirWalk แล้ว" or "❌ ปิด AirWalk แล้ว")
            end
        end)
    end
})

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
