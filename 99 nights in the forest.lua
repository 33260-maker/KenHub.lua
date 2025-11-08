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


---

-- 🎯 TAB 1: ระบบหลักทั้งหมด

local Tab1 = Window:MakeTab({"⚙️ ระบบหลัก", "cherry"})
Tab1:AddSection({"รวมระบบทั้งหมดในแท็บเดียว"})


---

-- ⚔️ KILL AURA

local ToggleKillAura = Tab1:AddToggle({
Name = "⚔️ Kill Aura (ตีมอนใกล้ตัว)",
Description = "ตรวจจับมอนในระยะ 2000 studs แล้วโจมตีอัตโนมัติ (ไม่ต้องถือขวาน)",
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
            task.wait(0.1)  
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
                    if d < dist and d <= 2000 then  
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


---

-- 🌳 AUTO TREE (ตัดต้นไม้)

local ToggleAutoTree = Tab1:AddToggle({
Name = "🌲 Auto Tree (ตัดต้นไม้)",
Description = "ตรวจหาต้นไม้ Small Tree รอบตัว 2000 studs แล้วตัดอัตโนมัติ (ไม่ต้องถือขวาน)",
Default = false
})

local AUTO_TREE = false
ToggleAutoTree:Callback(function(state)
AUTO_TREE = state

local function createHPBar(tree)  
    if tree:FindFirstChild("HPBar") then return end  
    local hpBar = Instance.new("BillboardGui")  
    hpBar.Name = "HPBar"  
    hpBar.Size = UDim2.new(4, 0, 0.4, 0)  
    hpBar.AlwaysOnTop = true  
    hpBar.StudsOffset = Vector3.new(0, 6, 0)  
    hpBar.Enabled = false  
    hpBar.Parent = tree  

    local bg = Instance.new("Frame")  
    bg.Size = UDim2.new(1, 0, 1, 0)  
    bg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)  
    bg.BorderSizePixel = 0  
    bg.Parent = hpBar  

    local fill = Instance.new("Frame")  
    fill.Name = "Fill"  
    fill.Size = UDim2.new(1, 0, 1, 0)  
    fill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)  
    fill.BorderSizePixel = 0  
    fill.Parent = bg  
end  

task.spawn(function()  
    local player = game:GetService("Players").LocalPlayer  
    local foliage = workspace:WaitForChild("Map"):WaitForChild("Foliage")  

    for _, tree in pairs(foliage:GetChildren()) do  
        if tree:IsA("Model") and tree.Name == "Small Tree" then  
            createHPBar(tree)  
        end  
    end  

    while AUTO_TREE do  
        task.wait(0.1)  
        local char = player.Character or player.CharacterAdded:Wait()  
        local root = char:FindFirstChild("HumanoidRootPart")  
        if not root then continue end  

        for _, tree in pairs(foliage:GetChildren()) do  
            if tree:IsA("Model") and tree:FindFirstChild("HPBar") then  
                local primary = tree.PrimaryPart or tree:FindFirstChildWhichIsA("BasePart")  
                if primary then  
                    local dist = (primary.Position - root.Position).Magnitude  
                    tree.HPBar.Enabled = (dist <= 2000)  
                end  
            end  
        end  
    end  
end)  

if AUTO_TREE then  
    task.spawn(function()  
        local TREE_NAME = "Small Tree"  
        local ATTACK_DISTANCE = 2000  
        local ATTACK_DELAY = 0.1  

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
            for _, tree in pairs(foliage:GetChildren()) do  
                if tree:IsA("Model") and tree.Name == TREE_NAME then  
                    local primary = tree.PrimaryPart or tree:FindFirstChildWhichIsA("BasePart")  
                    if primary and (primary.Position - root.Position).Magnitude <= ATTACK_DISTANCE then  
                        local args = {tree, tool, "1_4478233043", primary.CFrame}  
                        remote:InvokeServer(unpack(args))  
                    end  
                end  
            end  
        end  
    end)  
end

end)


---

-- 🔥 AUTO BURN FUEL

local ToggleBurn = Tab1:AddToggle({
Name = "🔥 Auto Burn Fuel (เผาเชื้อเพลิง)",
Description = "เผา Coal / Wood Log รอบตัวภายใน 2000 studs",
Default = false
})

local AUTO_BURN = false
ToggleBurn:Callback(function(state)
AUTO_BURN = state
if AUTO_BURN then
task.spawn(function()
local player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remote = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("RequestBurnItem")
local fire = workspace:WaitForChild("Map"):WaitForChild("Campground"):FindFirstChild("MainFire")
local itemsFolder = workspace:FindFirstChild("RuntimeItems") or workspace:FindFirstChild("Items")
local BURN_RADIUS = 2000

while AUTO_BURN do  
            task.wait(1)  
            local char = player.Character or player.CharacterAdded:Wait()  
            local root = char:FindFirstChild("HumanoidRootPart")  
            if not root then continue end  

            for _, item in pairs(itemsFolder:GetChildren()) do  
                if item:IsA("Model") or item:IsA("Part") then  
                    if item.Name == "Coal" or item.Name == "Wood Log" then  
                        local primary = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")  
                        if primary and (primary.Position - root.Position).Magnitude <= BURN_RADIUS then  
                            pcall(function()  
                                remote:FireServer(fire, item)  
                            end)  
                            task.wait(0.1)  
                        end  
                    end  
                end  
            end  
        end  
    end)

local ToggleImmortal = Tab1:AddToggle({
Name = "🛡️ Immortal (เลือดไม่ลด)",
Description = "ทำให้ผู้เล่นไม่เสียเลือดเมื่อถูกโจมตีหรือจากความเสียหายอื่น ๆ",
Default = false
})

local IMMORTAL = false
ToggleImmortal:Callback(function(state)
IMMORTAL = state
if IMMORTAL then
task.spawn(function()
local Players = game:GetService("Players")
local player = Players.LocalPlayer
while IMMORTAL do
task.wait(0.1)
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:FindFirstChildOfClass("Humanoid")
if humanoid then
-- คืนเลือดเป็น 100 ตลอดเวลา
humanoid.Health = humanoid.MaxHealth
-- ป้องกันการตาย
humanoid:GetPropertyChangedSignal("Health"):Connect(function()
if IMMORTAL and humanoid.Health < humanoid.MaxHealth then
humanoid.Health = humanoid.MaxHealth
end
end)
end
end
end)
end
end)


---

-- ⚙️ ตั้งค่าธีม

redzlib:SetTheme("Darker")
Window:SelectTab(Tab1)
