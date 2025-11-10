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

local Tab1 = Window:MakeTab({"⚙️ ระบบหลัก", "cherry"})
Tab1:AddSection({"รวมระบบทั้งหมดในแท็บเดียว"})

local ToggleKillAura = Tab1:AddToggle({
Name = "⚔️ Kill Aura (ตีมอนใกล้ตัว)",
Description = "ตรวจจับมอนในระยะ 80 studs แล้วโจมตีอัตโนมัติ (ไม่ต้องถือขวาน)",
Default = false
})

ToggleKillAura:Callback(function(state)
local killAura = state
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
            local tool = inv and inv:FindFirstChild("Old Axe")  
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
                local args = { nearest, tool, "1_4478233043", nearest.HumanoidRootPart.CFrame }  
                remote:InvokeServer(unpack(args))  
            end  
        end  
    end)  
end

end)

local ToggleAutoTree = Tab1:AddToggle({
Name = "🌲 Auto Tree (ตัดต้นไม้)",
Description = "ตรวจหาต้นไม้รอบตัว 100 studs แล้วตัดอัตโนมัติ (ไม่ต้องถือขวาน)",
Default = false
})

ToggleAutoTree:Callback(function(state)
local AUTO_TREE = state
if not AUTO_TREE then return end

local player = game:GetService("Players").LocalPlayer  
local ReplicatedStorage = game:GetService("ReplicatedStorage")  
local remote = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("ToolDamageObject")  
local foliage = workspace:WaitForChild("Map"):WaitForChild("Foliage")  

task.spawn(function()  
    while AUTO_TREE do  
        task.wait(0.15)  
        local char = player.Character or player.CharacterAdded:Wait()  
        local root = char:FindFirstChild("HumanoidRootPart")  
        local inv = player:FindFirstChild("Inventory")  
        local tool = inv and inv:FindFirstChild("Old Axe")  
        if not (root and tool) then continue end  

        local nearest, dist = nil, math.huge  
        for _, obj in pairs(foliage:GetChildren()) do  
            if obj:IsA("Model") and obj.Name == "Small Tree" then  
                local part = obj:FindFirstChild("PrimaryPart") or obj:FindFirstChildWhichIsA("BasePart")  
                if part then  
                    local d = (part.Position - root.Position).Magnitude  
                    if d < dist and d <= 100 then  
                        nearest, dist = obj, d  
                    end  
                end  
            end  
        end  

        if nearest then  
            local args = { nearest, tool, "1_4478233043", nearest:GetModelCFrame() }  
            remote:InvokeServer(unpack(args))  
        end  
    end  
end)

end)

local ToggleBurn = Tab1:AddToggle({
Name = "🔥 Auto Burn Fuel (เผาเชื้อเพลิง)",
Description = "เผา Coal / Wood Log รอบตัวภายใน 100 studs",
Default = false
})

ToggleBurn:Callback(function(state)
local AUTO_BURN = state
if not AUTO_BURN then return end

task.spawn(function()  
    local player = game:GetService("Players").LocalPlayer  
    local ReplicatedStorage = game:GetService("ReplicatedStorage")  
    local remote = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("RequestBurnItem")  
    local fire = workspace:WaitForChild("Map"):WaitForChild("Campground"):FindFirstChild("MainFire")  
    local itemsFolder = workspace:FindFirstChild("RuntimeItems") or workspace:FindFirstChild("Items")  

    while AUTO_BURN do  
        task.wait(1)  
        local char = player.Character or player.CharacterAdded:Wait()  
        local root = char:FindFirstChild("HumanoidRootPart")  
        if not root then continue end  

        for _, item in pairs(itemsFolder:GetChildren()) do  
            if item:IsA("Model") or item:IsA("Part") then  
                if item.Name == "Coal" or item.Name == "Wood Log" then  
                    local part = item:FindFirstChild("PrimaryPart") or item:FindFirstChildWhichIsA("BasePart")  
                    if part then  
                        local dist = (part.Position - root.Position).Magnitude  
                        if dist <= 100 then  
                            pcall(function() remote:FireServer(fire, item) end)  
                        end  
                    end  
                end  
            end  
        end  
    end  
end)

end)

local ToggleImmortal = Tab1:AddToggle({
Name = "🛡️ Immortal (เลือดไม่ลด)",
Description = "ทำให้ผู้เล่นไม่เสียเลือดเมื่อถูกโจมตีหรือจากความเสียหายอื่น ๆ",
Default = false
})

loadstring(game:HttpGet("https://raw.githubusercontent.com/ProBaconHub/DATABASE/refs/heads/main/99%20Nights%20in%20the%20Forest/Infinite%20Health.lua"))()

local ToggleEat = Tab1:AddToggle({
Name = "🍗 Auto Eat (กินอาหารอัตโนมัติ)",
Description = "กินอาหารอัตโนมัติเมื่อค่าความหิวต่ำกว่า 100%",
Default = false
})

ToggleEat:Callback(function(state)
local AUTO_EAT = state
if not AUTO_EAT then return end

task.spawn(function()  
    local player = game:GetService("Players").LocalPlayer  
    local ReplicatedStorage = game:GetService("ReplicatedStorage")  
    local remote = ReplicatedStorage:WaitForChild("RemoteEvents"):FindFirstChild("RequestEatItem")  

    while AUTO_EAT do  
        task.wait(2)  
        local stats = player:FindFirstChild("Stats")  
        local hunger = stats and stats:FindFirstChild("Hunger")  
        if hunger and hunger.Value < 100 then  
            local inv = player:FindFirstChild("Inventory")  
            if inv then  
                for _, item in pairs(inv:GetChildren()) do  
                    if item.Name:lower():find("food") or item.Name:lower():find("meat") then  
                        pcall(function()  
                            remote:FireServer(item)  
                        end)  
                        task.wait(1)  
                    end  
                end  
            end  
        end  
    end  
end)

end)

local ToggleFly = Tab1:AddToggle({
Name = "🕊️ Fly (บิน)",
Description = "กดเปิดเพื่อบินได้",
Default = false
})

ToggleFly:Callback(function(state)
local flying = state
local player = game:GetService("Players").LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

if flying then  
    hum.PlatformStand = true  
    local bv = Instance.new("BodyVelocity", root)  
    bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)  
    bv.Velocity = Vector3.zero  

    game:GetService("RunService").RenderStepped:Connect(function()  
        if not flying then bv:Destroy() return end  
        local dir = Vector3.zero  
        local uis = game:GetService("UserInputService")  
        if uis:IsKeyDown(Enum.KeyCode.W) then dir += root.CFrame.LookVector end  
        if uis:IsKeyDown(Enum.KeyCode.S) then dir -= root.CFrame.LookVector end  
        if uis:IsKeyDown(Enum.KeyCode.A) then dir -= root.CFrame.RightVector end  
        if uis:IsKeyDown(Enum.KeyCode.D) then dir += root.CFrame.RightVector end  
        if uis:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end  
        if uis:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0,1,0) end  
        bv.Velocity = dir * 60  
    end)  
else  
    hum.PlatformStand = false  
    for _, bv in pairs(root:GetChildren()) do  
        if bv:IsA("BodyVelocity") then bv:Destroy() end  
    end  
end

end)

redzlib:SetTheme("Darker")
Window:SelectTab(Tab1)
