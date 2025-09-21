local allowedPlaceIds = {
    [79546208627805] = true,
    [126509999114328] = true,
    [18668065416] = true,

    [2753915549] = true,
    [4442272183] = true,
    [7449423635] = true,

    [103754275310547] = true,
    [86076978383613] = true
}

if allowedPlaceIds[game.PlaceId] then
    if game.PlaceId == 2753915549 then
        loadstring(game:HttpGet("https://cdn.jsdelivr.net/gh/AAwful/KEN_Hub@0/b1"))()
    elseif game.PlaceId == 4442272183 then
         loadstring(game:HttpGet("https://cdn.jsdelivr.net/gh/AAwful/KEN_Hub@0/b2"))()
    elseif game.PlaceId == 7449423635 then
         loadstring(game:HttpGet("https://cdn.jsdelivr.net/gh/AAwful/KEN_Hub@0/b3f"))()
    elseif game.PlaceId == 18668065416 then
         loadstring(game:HttpGet("https://cdn.jsdelivr.net/gh/AAwful/KEN_Hub@0/BlueLockRivals"))()
     elseif game.PlaceId == 103754275310547 or game.PlaceId == 86076978383613 then
         loadstring(game:HttpGet("https://cdn.jsdelivr.net/gh/AAwful/KEN_Hub@0/huntyzombie"))()
    elseif getgenv().V == "Kaitundiamond" then
        loadstring(game:HttpGet("https://cdn.jsdelivr.net/gh/AAwful/KEN_Hub@0/99nightFarmDiamond"))()
    elseif getgenv().V == "OldKaitundiamond" then
        loadstring(game:HttpGet("https://cdn.jsdelivr.net/gh/AAwful/KEN_Hub@0/99nightFarmDiamondold"))()
    else
        loadstring(game:HttpGet("https://cdn.jsdelivr.net/gh/AAwful/KEN_Hub@0/99night"))()
    end
else
loadstring(game:HttpGet("https://cdn.jsdelivr.net/gh/AAwful/KEN_Hub@0/99night"))()
    --game:GetService("TeleportService"):Teleport(game.PlaceId,game.Players.LocalPlayer)
end
