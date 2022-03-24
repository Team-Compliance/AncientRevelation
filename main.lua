AncientRevelation = RegisterMod("Ancient Revelation", 1)
local mod = AncientRevelation

CollectibleType.COLLECTIBLE_ANCIENT_REVELATION = Isaac.GetItemIdByName("Ancient Revelation")

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, function(_, player)
	local TotPlayers = #Isaac.FindByType(EntityType.ENTITY_PLAYER)
	if TotPlayers == 0 then
		local hearts_en = "{{SoulHeart}} +2 Soul Hearts"

		if ComplianceImmortal then
			hearts_en = "{{ImmortalHeart}} +2 Immortal Hearts"
		end
		
		if EID then
			EID:addCollectible(CollectibleType.COLLECTIBLE_ANCIENT_REVELATION, "Grants flight#"..hearts_en.."#↑ {{Shotspeed}} +0.48 Shot Speed up#↑ {{Tears}} +1 Fire Rate up#Spectral tears#Tears turn 90 degrees to target enemies that they may have missed", "Ancient Revelation", "en_us")
			EID:assignTransformation("collectible", CollectibleType.COLLECTIBLE_ANCIENT_REVELATION, "10") -- Seraphim
		end
	end
end)

function mod:EvaluateCache(player, cacheFlag)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_ANCIENT_REVELATION) then	
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			if ComplianceImmortal then
				local data = player:GetData().ImmortalHeart
				data.ComplianceImmortalHeart = data.ComplianceImmortalHeart + 4
			end
		elseif cacheFlag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = player.MaxFireDelay - 2
		elseif cacheFlag == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed + 0.48
		elseif cacheFlag == CacheFlag.CACHE_FLYING then
			player.CanFly = true
		elseif cacheFlag == CacheFlag.CACHE_TEARCOLOR then
			player.TearColor = Color(player.TearColor.R, player.TearColor.G, player.TearColor.B, player.TearColor.A, 260/255, 250/255, 40/255)
		elseif cacheFlag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_SPECTRAL
			player.TearFlags = player.TearFlags | TearFlags.TEAR_TURN_HORIZONTAL
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.EvaluateCache)

--Minimap Items Compatibility
if MiniMapiItemsAPI then
    local frame = 1
    local ancientrevelationSprite = Sprite()
    ancientrevelationSprite:Load("gfx/ui/minimapitems/ancientrevelation_icon.anm2", true)
    MiniMapiItemsAPI:AddCollectible(CollectibleType.COLLECTIBLE_ANCIENT_REVELATION, ancientrevelationSprite, "CustomIconAncientRevelation", frame)
end