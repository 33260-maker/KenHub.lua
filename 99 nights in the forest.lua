-- โหลด UI  
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/Library-ui/refs/heads/main/Redzhubui"))()  

-- สร้างหน้าต่างหลัก  
local Window = redzlib:MakeWindow({  
    Title = "KEN Hub",  
    SubTitle = "by Ken9999",  
    SaveFolder = "KEN_HUB_Config"  
})  

Window:AddMinimizeButton({  
    Button = { Image = "rbxassetid://103308551113442", BackgroundTransparency = 0 },  
    Corner = { CornerRadius = UDim.new(35, 1) },  
})  

------------------------------------------------
-- 🎯 TAB 1: AUTO FARM
------------------------------------------------
local Tab1 = Window:MakeTab({"⚔️ AutoFarm", "cherry"})
Tab1:AddSection({"ระบบฟาร์มแยกการทำงาน"})

------------------------------------------------
-- 🔪 KILL AURA
------------------------------------------------
local ToggleKillAura = Tab1:AddToggle({
    Name = "Kill Aura (ตีมอนใกล้ตัว)",
    Description = "ตรวจจับมอนในระยะ 80 studs แล้วโจมตีอัตโนมัติ (ไม่ต้องถือขวาน)",
    Default = false
})

local killAura = false
ToggleKillAura:Callback(function(state)
    killAura = state
    if killAura then
        task.spawn(function()
            local Players = game:GetService("Players")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local player = Players.LocalPlayer
            local remote = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("ToolDamageObject")

            while killAura do
                task.wait(0.3)
                local char = player.Character or player.CharacterAdded:Wait()
                local root = char:FindFirstChild("HumanoidRootPart")
                if not root then continue end

                local inv = player:FindFirstChild("Inventory")
                if not inv then continue end
                local tool = inv:FindFirstChild("Old Axe")
                if not tool then continue end

                local nearest, dist = nil, math.huge
                for _, mob in pairs(workspace:WaitForChild("Characters"):GetChildren()) do
                    if mob:FindFirstChild("HumanoidRootPart") and mob.Name ~= player.Name then
                        local d = (mob.HumanoidRootPart.Position - root.Position).Magnitude
                        if d < dist and d <= 80 then
                            nearest, dist = mob, d
                        end
                    end
                end

                if nearest then
                    local args = {
                        nearest,
                        tool,
                        "1_4478233043",
                        nearest.HumanoidRootPart.CFrame
                    }
                    remote:InvokeServer(unpack(args))
                end
            end
        end)
    end
end)

------------------------------------------------
-- 🌳 AUTO TREE (ตัดต้นไม้)
------------------------------------------------
local ToggleAutoTree = Tab1:AddToggle({
    Name = "Auto Tree (ตัดต้นไม้)",
    Description = "ตรวจหาต้นไม้ Small Tree รอบตัว 25 studs แล้วตัดอัตโนมัติ (ไม่ต้องถือขวาน)",
    Default = false
})

local AUTO_TREE = false
ToggleAutoTree:Callback(function(state)
    AUTO_TREE = state
    if AUTO_TREE then
        task.spawn(function()
            local TREE_NAME = "Small Tree"
            local ATTACK_DISTANCE = 25
            local ATTACK_DELAY = 0.3

            local Players = game:GetService("Players")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local player = Players.LocalPlayer
            local remote = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("ToolDamageObject")

            while AUTO_TREE do
                task.wait(ATTACK_DELAY)

                local char = player.Character or player.CharacterAdded:Wait()
                local root = char:FindFirstChild("HumanoidRootPart")
                if not root then continue end

                local inv = player:FindFirstChild("Inventory")
                if not inv then continue end
                local tool = inv:FindFirstChild("Old Axe")
                if not tool then continue end

                local foliage = workspace:WaitForChild("Map"):WaitForChild("Foliage")
                local nearest, dist = nil, math.huge

                for _, obj in pairs(foliage:GetChildren()) do
                    if obj.Name == TREE_NAME and obj:IsA("Model") then
                        local primary = obj:FindFirstChild("PrimaryPart") or obj:FindFirstChildWhichIsA("BasePart")
                        if primary then
                            local distance = (primary.Position - root.Position).Magnitude
                            if distance < dist and distance <= ATTACK_DISTANCE then
                                nearest, dist = obj, distance
                            end
                        end
                    end
                end

                if nearest then
                    local primary = nearest:FindFirstChild("PrimaryPart") or nearest:FindFirstChildWhichIsA("BasePart")
                    if primary then
                        local args = {
                            nearest,
                            tool,
                            "1_4478233043",
                            primary.CFrame
                        }
                        remote:InvokeServer(unpack(args))
                    end
                end
            end
        end)
    end
end)

------------------------------------------------
-- 🔥 AUTO BURN FUEL (เผาเชื้อเพลิง)
------------------------------------------------
local ToggleBurn = Tab1:AddToggle({
    Name = "🔥 Auto Burn Fuel (เผาเชื้อเพลิง)",
    Description = "เผา Coal / Wood Log รอบตัวภายใน 100 studs",
    Default = false
})

local AUTO_BURN = false
ToggleBurn:Callback(function(state)
    AUTO_BURN = state
    if AUTO_BURN then
        task.spawn(function()
            local Players = game:GetService("Players")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local player = Players.LocalPlayer
            local remote = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("RequestBurnItem")

            local fire = workspace:WaitForChild("Map"):WaitForChild("Campground"):FindFirstChild("MainFire")
            if not fire then
                warn("❌ ไม่พบกองไฟหลัก (MainFire)")
                return
            end

            local itemsFolder = workspace:FindFirstChild("RuntimeItems") or workspace:FindFirstChild("Items")
            if not itemsFolder then
                warn("❌ ไม่พบโฟลเดอร์เก็บเชื้อเพลิงใน workspace")
                return
            end

            local BURN_RADIUS = 100
            print("🔥 เริ่มเผาเชื้อเพลิงอัตโนมัติ...")

            while AUTO_BURN do
                task.wait(1)
                local char = player.Character or player.CharacterAdded:Wait()
                local root = char:FindFirstChild("HumanoidRootPart")
                if not root then continue end

                for _, item in pairs(itemsFolder:GetChildren()) do
                    if item:IsA("Model") or item:IsA("Part") then
                        if item.Name == "Coal" or item.Name == "Wood Log" then
                            local primary = item:FindFirstChild("PrimaryPart") or item:FindFirstChildWhichIsA("BasePart")
                            if primary then
                                local dist = (primary.Position - root.Position).Magnitude
                                if dist <= BURN_RADIUS then
                                    local success, err = pcall(function()
                                        remote:FireServer(fire, item)
                                    end)
                                    if success then
                                        print("🔥 เผาเชื้อเพลิง:", item.Name, string.format("(%.1f studs)", dist))
                                    else
                                        warn("⚠️ เผาไม่สำเร็จ:", item.Name, err)
                                    end
                                    task.wait(0.2)
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

------------------------------------------------
-- ⚙️ TAB 2: ตั้งค่า
------------------------------------------------
local Tab2 = Window:MakeTab({"⚙️ ตั้งค่า", "cherry"})
Tab2:AddSection({"การตั้งค่า"})
Tab2:AddParagraph({
    "คำแนะนำ",
    "• Kill Aura = โจมตีมอนในระยะ 80 studs\n• Auto Tree = ตัดต้นไม้ในระยะ 25 studs\n• Auto Burn = เผาเชื้อเพลิงใกล้กองไฟ\n• ต้องมี Old Axe อยู่ใน Inventory"
})

redzlib:SetTheme("Darker")
Window:SelectTab(Tab1)
