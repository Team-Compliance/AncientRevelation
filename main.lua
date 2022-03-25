AncientRevelation = RegisterMod("Ancient Revelation", 1)
local mod = AncientRevelation

CollectibleType.COLLECTIBLE_ANCIENT_REVELATION = Isaac.GetItemIdByName("Ancient Revelation")

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, function(_, player)
	local data = player:GetData()
	data.ancientWasQueued = false
	data.lastSoulHearts = player:GetSoulHearts()

	local TotPlayers = #Isaac.FindByType(EntityType.ENTITY_PLAYER)
	if TotPlayers == 0 then
		local hearts_en = "{{SoulHeart}} +2 Soul Hearts"
		local hearts_ru = "{{SoulHeart}} +2 синих сердца"
		local hearts_spa = "{{SoulHeart}} +2 Corazones de alma"
		if ComplianceImmortal then
			hearts_en = "{{ImmortalHeart}} +2 Immortal Hearts"
			hearts_ru = "{{ImmortalHeart}} +2 бессмертных сердца"
			hearts_spa = "{{ImmortalHeart}} +2 Corazones inmortales"
		end
		
		if EID then
			EID:addCollectible(CollectibleType.COLLECTIBLE_ANCIENT_REVELATION, "Grants flight#"..hearts_en.."#↑ {{Shotspeed}} +0.48 Shot Speed up#↑ {{Tears}} +1 Fire Rate up#Spectral tears#Tears turn 90 degrees to target enemies that they may have missed", "Ancient Revelation", "en_us")
			EID:addCollectible(CollectibleType.COLLECTIBLE_ANCIENT_REVELATION, "Даёт полёт#"..hearts_ru.."#↑ {{Shotspeed}} +0.48 к скорости полёта слезы#↑ {{Tears}} +1 к скорострельности#Спектральные слёзы#Слёзы поворачиваются на 90 градусов, чтобы попасть во врагов, которых они могли пропустить", "Древнее откровение", "ru")
			EID:addCollectible(CollectibleType.COLLECTIBLE_ANCIENT_REVELATION, "Otorga vuelo#"..hearts_spa.."#↑ {{Shotspeed}} Vel. de tiro +0.48#↑ {{Tears}} Lágrimas +1#Lágrimas espectrales#Las lágrimas girarán en 90 grados hacia un enemigo si es que fallan", "Antigua Revelación", "spa")		
			EID:assignTransformation("collectible", CollectibleType.COLLECTIBLE_ANCIENT_REVELATION, "10") -- Seraphim
		end
	end
end)

function mod:EvaluateCache(player, cacheFlag)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_ANCIENT_REVELATION) then	
		if cacheFlag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = player.MaxFireDelay - 2
		elseif cacheFlag == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed + 0.48
		elseif cacheFlag == CacheFlag.CACHE_FLYING then
			player.CanFly = true
		elseif cacheFlag == CacheFlag.CACHE_TEARCOLOR then
			player.TearColor = Color(player.TearColor.R, player.TearColor.G, player.TearColor.B, player.TearColor.A, 260/255, 250/255, 40/255)
			player.LaserColor = Color(player.LaserColor.R, player.LaserColor.G, player.LaserColor.B, player.LaserColor.A, 260/255, 250/255, 40/255)
		elseif cacheFlag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_SPECTRAL
			player.TearFlags = player.TearFlags | TearFlags.TEAR_TURN_HORIZONTAL
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.EvaluateCache)

function mod:postPlayerUpdate(player)
	if not ComplianceImmortal then return end
	local data = player:GetData()
	local queuedItem = player.QueuedItem
	
	if queuedItem.Item and queuedItem.Item.ID == CollectibleType.COLLECTIBLE_ANCIENT_REVELATION then
		data.ancientWasQueued = true
		data.lastSoulHearts = player:GetSoulHearts()
	end
	
	if player:IsItemQueueEmpty() then
		if data.ancientWasQueued then
			if player:GetSoulHearts() > data.lastSoulHearts then
				data.ImmortalHeart.ComplianceImmortalHeart = data.ImmortalHeart.ComplianceImmortalHeart + 4
				
				data.ancientWasQueued = true
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.postPlayerUpdate)

--Minimap Items Compatibility
if MiniMapiItemsAPI then
    local frame = 1
    local ancientrevelationSprite = Sprite()
    ancientrevelationSprite:Load("gfx/ui/minimapitems/ancientrevelation_icon.anm2", true)
    MiniMapiItemsAPI:AddCollectible(CollectibleType.COLLECTIBLE_ANCIENT_REVELATION, ancientrevelationSprite, "CustomIconAncientRevelation", frame)
end

--Encyclopeida Compatibility
local Wiki = {
  AncientRevelation = {
    { -- Effect
      {str = "Effect", fsize = 2, clr = 3, halign = 0},
      {str = "Grants 2 soul hearts (Or 2 immortal hearts if that mod is installed)"},
      {str = "Grants flight."},
      {str = "Grants spectral tears."},
      {str = "+0.48 Shot Speed up."},
      {str = "+1 Fire Rate up."},
      {str = "Tears turn 90 degrees to target enemies that they may have missed."},
    },
    { -- Mod Compatibility
      {str = "Mod Compatibility", fsize = 2, clr = 3, halign = 0},
      {str = "EID - Shows a description of the item."},
      {str = "Encyclopedia - Shows a description of the item."},
      {str = "Minimap Items - Shows a minimap icon of the item."},
      {str = "Immortal Hearts - Upon pickup, the item gives 2 immortal hearts instead of 2 soul hearts."},
    },
    { -- Trivia
      {str = "Trivia", fsize = 2, clr = 3, halign = 0},
      {str = "This item was what Revelation originally was in the Antibirth mod."},
      {str = "This mod was primarily coded by kittenchilly!"},
    },
  }
}

if Encyclopedia then
	Encyclopedia.AddItem({
	  ID = CollectibleType.COLLECTIBLE_ANCIENT_REVELATION,
	  WikiDesc = Wiki.AncientRevelation,
	  Pools = {
		Encyclopedia.ItemPools.POOL_ANGEL,
		Encyclopedia.ItemPools.POOL_GREED_ANGEL,
	  },
	})
end
