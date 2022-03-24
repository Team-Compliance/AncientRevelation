AncientRevelation = RegisterMod("Ancient Revelation", 1)
local mod = AncientRevelation

CollectibleType.COLLECTIBLE_ANCIENT_REVELATION = Isaac.GetItemIdByName("Ancient Revelation")

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