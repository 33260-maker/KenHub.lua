local MAPBF = game.GameId == 994732206
local MAPKL = (game.PlaceId == 4520749081 or game.PlaceId == 6381829480 or game.PlaceId == 5931540094 or game.PlaceId == 6596144663 or game.PlaceId == 15759515082)
local MAPBLADEB = game.CreatorId == 12836673
local MAPAFS = game.PlaceId == 6299805723
local MAPRGH = game.PlaceId == 914010731
local MAPHAZEP = game.PlaceId == 6918802270 or game.PlaceId == 14979402479
local MAPALS = game.CreatorId == 12229756
local DRIVEEMPIRE = game.PlaceId == 3351674303
local SOLRNG = game.PlaceId == 15532962292
local TITAN = game.CreatorId == 17347863
local AD = game.CreatorId == 34121350
local AV = game.CreatorId == 17219742
local Fish = game.CreatorId == 7381705 or game.PlaceId == 16732694052
local AA = game.CreatorId == 10611639
local BL = game.GameId == 6325068386
local AC = game.GameId == 7074860883 or game.PlaceId == 87039211657390
local BS = game.GameId == 7436755782 or game.CreatorId == 33720745
local GAG = game.PlaceId == 126884695634066
local ASTDX = game.GameId == 6057699512
local days99 = game.GameId == 7326934954
local ZOmBie = game.GameId == 7750955984
local FishIt = game.GameId == 121864768012064
local BAZ = game.GameId == 8066283370

repeat wait() until game:IsLoaded();
local CountString = 0
local MainPack
local LoadedBackUp

if MAPBF then
    task.spawn(function()
        repeat task.wait() until LoadedBackUp
        repeat task.wait() until StatusCheckIsBad
        wait()
        if _G.Script_Mode == "PVP" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/CreamSoScute/main/LoadP.lua",true))()
        elseif _G.Script_Language == "Thai" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/CreamSoScute/main/LoadTh.lua",true))()
        elseif getgenv().Script_Mode == "Kaitun_Script" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/CreamSoScute/main/LoadKT.lua",true))()
        else
            loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/CreamSoScute/main/LoadNormal.lua",true))()
        end
    end)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/FIXING/main/ABC.lua"))()
    LoadedBackUp = true
    local ABC, CBA = pcall(function()
        if _G.Script_Mode == "PVP" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/CreamSoScute/main/LoadP.lua",true))()
        elseif _G.Script_Language == "Thai" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/CreamSoScute/main/LoadTh.lua",true))()
        elseif getgenv().Script_Mode == "Kaitun_Script" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/CreamSoScute/main/LoadKT.lua",true))()
        else
            loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/CreamSoScute/main/LoadNormal.lua",true))()
        end
    end)
    if not ABC then
        StatusCheckIsBad = true
    end

elseif MAPKL then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/CreamSoScute/main/LoadKL.lua",true))()

elseif days99 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/33260-maker/KUO_HUB/refs/heads/main/99%20nights%20in%20the%20forest.lua"))()

elseif (MAPBLADEB or MAPAFS or MAPRGH or MAPHAZEP or MAPALS or DRIVEEMPIRE or SOLRNG or TITAN or AV or Fish or AA or BL or AD or AC or BS or GAG or ASTDX or ZOmBie or game.GameId == 6701277882 or BAZ) then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/CreamSoScute/main/LoadAm.lua",true))()

else 
    game.Players.LocalPlayer:Kick("\224\185\132\224\184\161\224\185\136\224\184\158\224\184\154\224\185\129\224\184\161\224\184\158")
    wait(3)
    game:Shutdown()
    wait(3)
    if game then
        while true do end
    end
end
