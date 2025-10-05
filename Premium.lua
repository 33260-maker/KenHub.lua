--[[ควยเอ้ยมาดูโค้ดกูทำไมกูไม่รู้จะจัดการกับพวกมึงยังไงแล้ว]]--
-- ======================
-- ⚡ KEN HUB V3 (RedzLib UI) + Key System ⚡
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
    game.StarterGui:SetCore("SendNotification", {
        Title = "KEN Hub",
        Text = msg,
        Duration = 5
    })
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

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ===== Key UI =====
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
title.Text = "KEN Hub Key System"
title.TextColor3 = Color3.fromRGB(150,200,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.BackgroundTransparency = 1

local inputBox = Instance.new("TextBox", frame)
inputBox.Size = UDim2.new(1, -20, 0, 40)
inputBox.Position = UDim2.new(0, 10, 0, 60)
inputBox.PlaceholderText = "กรอกคีย์..."
inputBox.Font = Enum.Font.Gotham
inputBox.TextSize = 20
inputBox.BackgroundColor3 = Color3.fromRGB(25,25,50)
inputBox.TextColor3 = Color3.fromRGB(255,255,255)

local getKeyBtn = Instance.new("TextButton", frame)
getKeyBtn.Size = UDim2.new(0.45, -5, 0, 40)
getKeyBtn.Position = UDim2.new(0, 10, 0, 120)
getKeyBtn.Text = "GET KEY"
getKeyBtn.Font = Enum.Font.GothamBold
getKeyBtn.TextSize = 20
getKeyBtn.BackgroundColor3 = Color3.fromRGB(40,40,80)
getKeyBtn.TextColor3 = Color3.fromRGB(120,180,255)

local checkKeyBtn = Instance.new("TextButton", frame)
checkKeyBtn.Size = UDim2.new(0.45, -5, 0, 40)
checkKeyBtn.Position = UDim2.new(0.55, 0, 0, 120)
checkKeyBtn.Text = "CHECK KEY"
checkKeyBtn.Font = Enum.Font.GothamBold
checkKeyBtn.TextSize = 20
checkKeyBtn.BackgroundColor3 = Color3.fromRGB(40,40,80)
checkKeyBtn.TextColor3 = Color3.fromRGB(120,255,180)

local saved = safeReadFile(KEY_SAVE_FILE)
if saved and #saved > 0 then inputBox.Text = saved end

getKeyBtn.MouseButton1Click:Connect(function()
    tryOpenLinkOrCopy(GET_KEY_LINK)
end)

checkKeyBtn.MouseButton1Click:Connect(function()
    local key = tostring(inputBox.Text)
    if checkKey(key) then
        notify("คีย์ถูกต้อง! กำลังโหลด KEN Hub ...")
        safeWriteFile(KEY_SAVE_FILE, key)
        screenGui:Destroy()

        -- ======================
        -- ⚡ KEN HUB V3 (RedzLib UI)
        -- ======================
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
            Name = "Main",
            Icon = "rbxassetid://103308551113442"
        })

        Tab1:AddDiscordInvite({
            Name = "กลุ่มแจกโปร",
            Description = "Join server",
            Logo = "rbxassetid://103308551113442",
            Invite = "https://discord.gg/Apn2j9Fez",
        })

        -- ===== Tab2 =====
        local Tab2 = Window:MakeTab({
            Name = "Functions",
            Icon = "rbxassetid://103308551113442"
        })

        local function addFunctionButton(name, url, speed)
            Tab2:AddButton({
                Name = name,
                Callback = function()
                    local plr = game.Players.LocalPlayer
                    if name == "🏃 Increase Speed" and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                        plr.Character.Humanoid.WalkSpeed = speed
                        notify("เพิ่มความเร็วเป็น "..speed.." เรียบร้อย!")
                    elseif url then
                        loadstring(game:HttpGet(url))()
                        notify(name.." เปิดใช้งานแล้ว!")
                    end
                end
            })
        end

        addFunctionButton("🏃 Increase Speed", nil, 50)
        addFunctionButton("✈️ Fly", "https://rawscripts.net/raw/Universal-Script-Gui-Fly-v3-37111")
        addFunctionButton("🛡️ God Mode (Immortal)", "https://raw.githubusercontent.com/Rawbr10/Roblox-Scripts/refs/heads/main/God%20Mode%20Script%20Universal")
        addFunctionButton("👻 Invisible", "https://pastebin.com/raw/3Rnd9rHf")
        addFunctionButton("🧍‍♂️ Spawn Clone", "https://raw.githubusercontent.com/0Ben1/fe/main/obf_11l7Y131YqJjZ31QmV5L8pI23V02b3191sEg26E75472Wl78Vi8870jRv5txZyL1.lua.txt")
        addFunctionButton("🚪 Noclip (Walk Through Walls)", "https://pastebin.com/raw/u0nS8wq2")
        addFunctionButton("🕳️ Black Hole", "https://pastebin.com/raw/zgSEcs5E")

        -- ===== Tab3 =====
        local Tab3 = Window:MakeTab({
            Name = "Tab3",
            Icon = "rbxassetid://103308551113442"
        })

        local Toggle1 = Tab3:AddToggle({
            Name = "Toggle 1",
            Default = false
        })
        Toggle1:Callback(function(Value)
            -- โค้ดเมื่อเปิด/ปิด Toggle1
        end)

        Tab3:AddToggle({
            Name = "Toggle 2",
            Default = false,
            Callback = function(v)
                -- โค้ดเมื่อเปิด/ปิด Toggle2
            end
        })

        Tab3:AddSlider({
            Name = "Speed",
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

        local game_name = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
        game.StarterGui:SetCore("SendNotification", {
            Title = "KENHub Loaded!",
            Text = game_name .. " Script Loaded!",
            Icon = "rbxassetid://103308551113442",
            Duration = 5
        })
    else
        notify("คีย์ไม่ถูกต้อง! กรุณากด GET KEY เพื่อรับคีย์")
    end
end)
