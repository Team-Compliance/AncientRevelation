AncientRevelation = RegisterMod("Ancient Revelation", 1)
local mod = AncientRevelation

CollectibleType.COLLECTIBLE_ANCIENT_REVELATION = Isaac.GetItemIdByName("Ancient Revelation")

function mod:EvaluateCache(player, cacheFlag)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_ANCIENT_REVELATION) then
		if cacheFlag == CacheFlag.CACHE_FLYING then
			player.CanFly = true
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.EvaluateCache)