-- ======================
-- ⚡ KEN HUB V3 (RedzLib UI) ⚡
-- ======================

-- 📂 Load RedzLib
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/Library-ui/refs/heads/main/Redzhubui"))()

-- 🪟 Create main window
local Window = redzlib:MakeWindow({
    Title = "KEN Hub",
    SubTitle = "by Ken9999",
    SaveFolder = "KEN_HUB_Config"
})

-- 🔽 Minimize / Expand button
Window:AddMinimizeButton({
    Button = { Image = "rbxassetid://103308551113442", BackgroundTransparency = 0 },
    Corner = { CornerRadius = UDim.new(0, 15) },
})

-- 📑 Main Tab
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

-- 📑 Functions Tab
local Tab2 = Window:MakeTab({
    Name = "Functions",
    Icon = "rbxassetid://103308551113442"
})

-- ======================
-- 🚀 Function Buttons
-- ======================

-- Increase Speed button
Tab2:AddButton({
    Name = "🏃 Increase Speed",
    Callback = function()
        local plr = game.Players.LocalPlayer
        if plr.Character and plr.Character:FindFirstChild("Humanoid") then
            plr.Character.Humanoid.WalkSpeed = 50
        end
    end
})

-- Fly button
Tab2:AddButton({
    Name = "✈️ Fly",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Gui-Fly-v3-37111"))()
    end
})

-- God Mode (Immortal) button
Tab2:AddButton({
    Name = "🛡️ God Mode (Immortal)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Rawbr10/Roblox-Scripts/refs/heads/main/God%20Mode%20Script%20Universal"))()
    end
})

-- Invisible button
Tab2:AddButton({
    Name = "👻 Invisible",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/3Rnd9rHf'))()
    end
})

-- Spawn Clone (Doppelgänger) button
Tab2:AddButton({
    Name = "🧍‍♂️ Spawn Clone",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe/main/obf_11l7Y131YqJjZ31QmV5L8pI23V02b3191sEg26E75472Wl78Vi8870jRv5txZyL1.lua.txt"))()
    end
})

-- ======================
-- 📢 Notification after KEN HUB is loaded
-- ======================
local game_name = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

game.StarterGui:SetCore(
    "SendNotification",
    {
        Title = "KENHub Loaded!",
        Text = game_name .. " Script Loaded!",
        Icon = "rbxassetid://103308551113442",
        Duration = 5
    }
)
