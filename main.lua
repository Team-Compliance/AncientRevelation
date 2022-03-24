AncientRevelation = RegisterMod("Ancient Revelation", 1)
local mod = AncientRevelation

CollectibleType.COLLECTIBLE_ANCIENT_REVELATION = Isaac.GetItemIdByName("Ancient Revelation")

function mod:EvaluateCache(player, cacheFlag)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_ANCIENT_REVELATION) then
		if ComplianceImmortal then
			local data = player:GetData().ImmortalHeart
			data.ComplianceImmortalHeart = data.ComplianceImmortalHeart + 4
		end
		
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
		
		elseif cacheFlag == CacheFlag.CACHE_FIREDELAY then
		
		elseif cacheFlag == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed + 0.38
		elseif cacheFlag == CacheFlag.CACHE_FLYING then
			player.CanFly = true
		elseif cacheFlag == CacheFlag.CACHE_TEARCOLOR then
		
		elseif cacheFlag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_SPECTRAL
			player.TearFlags = player.TearFlags | TearFlags.TEAR_TURN_HORIZONTAL
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.EvaluateCache)