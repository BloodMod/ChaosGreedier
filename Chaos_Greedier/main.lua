--Settings
local swapItemKey = Keyboard.KEY_LEFT_SHIFT --Which keyboard key swaps items
local controllerMode = false --Changing this to true changes input to the item drop button (finnicky)

local ChaosGreed = RegisterMod("ChaosGreed", 1)

-- 아이템 등록
local morphine_item = Isaac.GetItemIdByName("Morphine")
local lucifer_wings_item = Isaac.GetItemIdByName("Lucifer's Wings")
local tramp_champ_item = Isaac.GetItemIdByName("Tramp of Babylon")
local protection_item = Isaac.GetItemIdByName("Dad's Balloon")
local adra_blessing_item = Isaac.GetItemIdByName("Adramolech's Blessing")
local divine_item = Isaac.GetItemIdByName("Divine Approval")
local fuzzydice_item = Isaac.GetItemIdByName("Fuzzy Dice")
local cans_item = Isaac.GetItemIdByName("Pair of Cans")
local heartarrest_item = Isaac.GetItemIdByName("Heart Arrest")
local burntdiary_item = Isaac.GetItemIdByName("Burnt Diary")
local bloodpudding_item = Isaac.GetItemIdByName("Blood Pudding")
local sugar_item = Isaac.GetItemIdByName("Sugar")
local cooler_item = Isaac.GetItemIdByName("Angry Apple Juice")
local chiggers_item = Isaac.GetItemIdByName("Larval Therapy")
local marsh_scarf_item = Isaac.GetItemIdByName("Marshall Scarf")
local brainworm_item = Isaac.GetItemIdByName("Taenia")
local hushcannon_item = Isaac.GetItemIdByName("Anguish Jar")
local holychalice_item = Isaac.GetItemIdByName("Holy Chalice")
local ironglove_item = Isaac.GetItemIdByName("Iron Enhancement")

-- 아래 방식으로 위 변경
ChaosGreed.COLLECTIBLE_BACKPACK = Isaac.GetItemIdByName("Backpack")

local hermit_stars_card = Isaac.GetCardIdByName("HermitStars")

local hasMorphine = false

-- 코스튬 등록
local morphine_costume = Isaac.GetCostumeIdByPath("gfx/characters/costumes/morphine.anm2")
local tramp_costume = Isaac.GetCostumeIdByPath("gfx/characters/costumes/tramp_of_babylon.anm2")

local hasBackpack = false
local heldItem = 0
local heldItemCharge = 0
local storedItem = 0
local storedItemCharge = 0
local batteryCharge = 0

local swapBuffer = 0
local useItemFrame = 0

local config = Isaac.GetItemConfig()
local storedItemSprite = Sprite()
storedItemSprite:Load("backpack_storeditem.anm2")
storedItemSprite:Play("Idle")

function getFlag(arr, currentFlag) -- 눈물 상태 함수
    number = currentFlag;
   
    for i = 1, #arr do
        number = number | 2^(arr[i] - 1);
    end
   
    return number;
end

function ChaosGreed:Item1(player, cacheFlag) -- items.xml의 cacheFlag를 불러오는 과정
	local player = Isaac.GetPlayer(0)

	if (cacheFlag == CacheFlag.CACHE_DAMAGE) then -- 아이템 획득 시 cacheFlag가 데미지면
		if player:HasCollectible(22) then -- 22를 획득했을 시
			player.Damage = player.Damage + 3 -- 데미지 +3
		end
		if player:HasCollectible(241) then -- 241를 획득했을 시
			player.Damage = player.Damage + 4 -- 데미지 +4
		end
		if player:HasCollectible(249) then -- 249 획득했을 시
			player.Damage = player.Damage + 4 -- 데미지 +4
		end
		if player:HasCollectible(255) then -- 255 획득했을 시
			player.Damage = player.Damage + 4 -- 데미지 +4
		end
		if player:HasCollectible(176) then -- 176 획득했을 시
			player.Damage = player.Damage + 9.99 -- 데미지 +9.99
		end
		if player:HasCollectible(25) then -- 25를 획득했을 시
			player.Damage = player.Damage + (2 * player:GetCollectibleNum(25)) -- 2의 데미지를 25를 획득한 수 만큼 증가
		end
		if player:HasCollectible(241) and player:HasCollectible(249) and player:HasCollectible(255) then -- 모두 획득 시
			player.Damage = player.Damage + 12 -- 데미지 +12
		end
		if player:HasCollectible(22) and player:HasCollectible(23) and player:HasCollectible(24) then -- 22 23 24를 모두 획득 시
			if player:HasCollectible(149) then -- 149를 획득했으면
				player.Damage = ((player.Damage-40)*2)+40 -- 40 먼저 빼고 2를 곱해서 다시 40 더한다.
			else -- 아니면
				player.Damage = player.Damage * 2 -- 그냥 2배
			end
		end
		if player:HasCollectible(54) then
			player.Damage = player.Damage + 3
		end
		if player:HasCollectible(21) or player:HasCollectible(26) or player:HasCollectible(54) then
			if player:HasCollectible(149) then
				player.Damage = ((player.Damage-40)*1.4)+40 -- 40 먼저 빼고 1.4를 곱해서 다시 40 더한다.
			else -- 아니면
				player.Damage = player.Damage * 1.4 -- 그냥 1.4배
			end
		end
		if player:HasCollectible(317) then
			player.Damage = player.Damage + 5
		end
	end
	if (cacheFlag == CacheFlag.CACHE_RANGE) then -- 아이템 획득 시 cacheFlag가 사거리면
		if player:HasCollectible(24) then -- 24를 획득했을 시
			player.TearHeight = player.TearHeight - 5.25 -- 사거리를 5.25 증가(마이너스가 될 수록 멀리)
		end
		if player:HasCollectible(26) then -- 26를 획득했을 시
			player.TearHeight = player.TearHeight - 5.25 -- 사거리를 5.25 증가(마이너스가 될 수록 멀리)
		end
	end
	if (cacheFlag == CacheFlag.CACHE_SPEED) then -- 아이템 획득 시 cacheFlag가 스피드면
		if player:HasCollectible(24) then -- 24를 획득했을 시
			player.MoveSpeed = player.MoveSpeed + 0.6 -- 스피드를 0.6 증가
		end
		if player:HasCollectible(25) then -- 25를 획득했을 시
			player.MoveSpeed = player.MoveSpeed + (0.2 * player:GetCollectibleNum(25)) -- 0.2의 스피드를 25를 획득한 수 만큼 증가
		end
		if player:HasCollectible(26) then -- 26를 획득했을 시
			player.MoveSpeed = player.MoveSpeed + 0.6 -- 스피드를 0.6 증가
		end
		if player:HasCollectible(82) then -- 82를 획득했을 시
			player.MoveSpeed = player.MoveSpeed + 0.3 -- 스피드를 0.3 증가
		end
	end
	if (cacheFlag == CacheFlag.CACHE_LUCK) then -- 아이템 획득 시 CacheFlag가 운이면
		if player:HasCollectible(23) then -- 23 획득했을 시
			player.Luck  = player.Luck + 3 -- 럭 3 증가
		end
		if player:HasCollectible(46) then -- 46 획득했을 시
			player.Luck  = player.Luck + 4 -- 럭 4 증가
		end
		if player:HasCollectible(21) then -- 21 획득했을 시
			player.Luck  = player.Luck + 3 -- 럭 3 증가
		end
		if player:HasCollectible(449) then
			player.Luck  = player.Luck + 7
		end
	end
	if (cacheFlag == CacheFlag.CACHE_TEARFLAG) then
		if player:HasCollectible(339) then -- 339 획득
			player.TearFlags = getFlag({38}, player.TearFlags); -- 38번 플래그를 줌
			debug_text = player.TearFlags;
		end
		if player:HasCollectible(401) then -- 401 획득
			player.TearFlags = getFlag({36}, player.TearFlags); -- 36번 플래그를 줌
			debug_text = player.TearFlags;
		end
		if player:HasCollectible(29) then -- 29 획득
			player.TearFlags = getFlag({14}, player.TearFlags); -- 14번 플래그를 줌
			debug_text = player.TearFlags;
		end
		if player:HasCollectible(30) then -- 30 획득
			player.TearFlags = getFlag({21}, player.TearFlags); -- 21번 플래그를 줌
			debug_text = player.TearFlags;
		end
		if player:HasCollectible(148) then 
			player.TearFlags = getFlag({48}, player.TearFlags); 
			debug_text = player.TearFlags;
		end
		if player:HasCollectible(29) or player:HasCollectible(30) or player:HasCollectible(31) then --29,30,31번 중 하나라도 소지 시
			player.TearFlags = getFlag({2}, player.TearFlags); -- 2번 플래그를 줌
			debug_text = player.TearFlags;
		end
		if player:HasCollectible(29) and player:HasCollectible(30) and player:HasCollectible(31) then -- 29,30,31 소지 시
			player.TearFlags = getFlag({33}, player.TearFlags); -- 33번 플래그를 줌
			debug_text = player.TearFlags;
		end
		if player:HasCollectible(428) then 
			player.TearFlags = getFlag({2,3,4,14,15,21}, player.TearFlags); 
			debug_text = player.TearFlags;
		end
	end
	if (cacheFlag == CacheFlag.CACHE_FLYING) then
		if player:HasCollectible(122) then
			player.CanFly = true
		end
	end

	-- 모드 아이템 카피
	if player:HasCollectible(morphine_item) then
        --Check which stat is being changed. The cacheFlag tells what is being changed.
        --The game will recalculate stats separately, so we only want to add the damage when
        --the damage is being recalculated
        if cacheFlag == CacheFlag.CACHE_DAMAGE then
            player:AddNullCostume(morphine_costume)
            player.Damage = player.Damage + 5;
            player:AddMaxHearts(-24)
            player:AddMaxHearts(2)
            player:AddHearts(-24)
            player:AddHearts(1)
            hasMorphine = true
        end
        if cacheFlag == CacheFlag.CACHE_RANGE then
            player.TearHeight = player.TearHeight - 10;
        end
        if cacheFlag == CacheFlag.CACHE_SPEED then
            player.MoveSpeed = player.MoveSpeed * 0.25;
        end
        if cacheFlag == CacheFlag.CACHE_LUCK then
            --Add the damage from this item
            player.Luck = player.Luck + 1;
        end
        if cacheFlag == CacheFlag.CACHE_FIREDELAY then
            --Add the Tear Delay. Can't get it to work though
            player.FireDelay = player.FireDelay - 5;
        end
    end
end

ChaosGreed:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, ChaosGreed.Item1)

function ChaosGreed:PlayerInit(player)
	hasMorphine = false

	if Game():GetFrameCount() < 5 then
		Isaac.SaveModData(ChaosGreed, "0,0,0")
		Isaac.DebugString("New Run");
		heldItem = 0
		heldItemCharge = 0
		storedItem = 0
		storedItemCharge = 0
		swapBuffer = 0
		useItemFrame = 0
		--Game():Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, player.Position + Vector(0, -1), Vector(0, 0), player, Card.CARD_HERMIT, player.InitSeed)
		--Game():Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, player.Position + Vector(0, 1), Vector(0, 0), player, Card.CARD_STARS, player.InitSeed)
	end
	local saveData = Isaac.LoadModData(ChaosGreed)
	local a, b, c = saveData:match("([^,]+),([^,]+),([^,]+)")
	storedItem = tonumber(a)
	storedItemCharge = tonumber(b)
	batteryCharge = tonumber(c)
	if storedItem ~= 0 then
		storedItemSprite:ReplaceSpritesheet(0, config:GetCollectible(storedItem).GfxFileName)
		storedItemSprite:LoadGraphics()
		Isaac.DebugString("Graphics Loaded");
	end
	Isaac.DebugString("Backpack Loaded");
end

ChaosGreed:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, ChaosGreed.PlayerInit);

function ChaosGreed:Item2(currentPlayer) -- 패시브 설정용 함수

	local player = Isaac.GetPlayer(0) -- 플레이어 변수 설정
	
	if player:HasCollectible(280)==true and player:GetCollectibleNum(280)<3 then -- 280을 획득했고 3개 이하면(씨씨)
		player:AddCollectible(280,0,true) -- 3개를 얻을 때까지 반복해서 280 획득
	end
	if player:HasCollectible(511)==true and player:GetCollectibleNum(511)<3 then -- 511을 획득했고 3개 이하면(앵그리플라이)
		player:AddCollectible(511,0,true) -- 3개를 얻을 때까지 반복해서 511 획득
	end
	if player:HasCollectible(197)==true and player:GetCollectibleNum(197)<3 then -- 197을 획득했고 3개 이하면(쥬스)
		player:AddCollectible(197,0,true) -- 3개를 얻을 때까지 반복해서 197 획득
	end
	if player:HasCollectible(193)==true and player:GetCollectibleNum(193)<5 then -- 193을 획득했고 5개 이하면(미트)
		player:AddCollectible(193,0,true) -- 5개를 얻을 때까지 반복해서 193 획득
	end
	if player:HasCollectible(138)==true and player:GetCollectibleNum(138)<5 then -- 138을 획득했고 5개 이하면(스티그마)
		player:AddCollectible(138,0,true) -- 5개를 얻을 때까지 반복해서 138 획득
	end
	if player:HasCollectible(68)==true and player:GetCollectibleNum(68)<2 then -- 68을 획득했고 2개 이하면(테크)
		player:AddCollectible(68,0,true) -- 2개를 얻을 때까지 반복해서 68 획득
	end
	if player:HasCollectible(118)==true and player:GetCollectibleNum(118)<2 then -- 118을 획득했고 2개 이하면(혈사)
		player:AddCollectible(118,0,true) -- 2개를 얻을 때까지 반복해서 118 획득
	end
	if player:HasCollectible(493)==true and player:GetCollectibleNum(208)<10 then -- 493을 획득했고 208이 10개 이하면(아드레날린/챔벨)
		player:AddCollectible(208,0,true) -- 10개를 얻을 때까지 반복해서 208 획득
	end
	if player:HasCollectible(417)==true and player:GetCollectibleNum(417)<2 then -- 417을 획득했고 2개 이하면(서큐)
		player:AddCollectible(417,0,true) -- 2개를 얻을 때까지 반복해서 417 획득
	end
	if player:HasCollectible(317)==true and player:GetCollectibleNum(48)<1 then -- 317을 획득했고 48이 1개 이하면(섬창/큐피드)
		player:AddCollectible(48,0,true) -- 1개를 얻을 때까지 반복해서 48 획득
	end
	if player:HasCollectible(201)==true and player:GetCollectibleNum(201)<5 then -- 201을 획득했고 5개 이하면(철괴)
		player:AddCollectible(201,0,true) -- 5개를 얻을 때까지 반복해서 201 획득
	end
	if player:HasCollectible(31)==true and player:GetCollectibleNum(415)<1 then -- 31을 획득했고 415가 1개 이하면(바실리움,왕관)
		player:AddCollectible(415,0,true) -- 1개를 얻을 때까지 반복해서 415 획득
	end
	if player:HasCollectible(207)==true and player:GetCollectibleNum(207)<4 then -- 207을 획득했고 4개 이하면(밴드)
		player:AddCollectible(207,0,true) -- 4개를 얻을 때까지 반복해서 415 획득
	end
	if player:HasCollectible(73)==true and player:GetCollectibleNum(73)<4 then -- 73을 획득했고 4개 이하면(미트)
		player:AddCollectible(73,0,true) -- 4개를 얻을 때까지 반복해서 73 획득
	end
	if player:HasCollectible(155)==true and player:GetCollectibleNum(155)<3 then -- 155을 획득했고 3개 이하면(피퍼)
		player:AddCollectible(155,0,true) -- 3개를 얻을 때까지 반복해서 155 획득
	end
	if player:HasCollectible(405)==true and player:GetCollectibleNum(405)<3 then -- 405을 획득했고 3개 이하면(기가바이트)
		player:AddCollectible(405,0,true) -- 3개를 얻을 때까지 반복해서 405 획득
	end
	if player:HasCollectible(238)==true and player:HasCollectible(239)==true then -- 238과 239를 획득했다면(키피스 1,2)
		if player:HasCollectible(499)==false then --499가 없다면
			player:AddCollectible(499,0,true) -- 499 획득
		end
	end
	if player:HasCollectible(179)==true and player:HasCollectible(82)==true then
		if player:HasCollectible(402)==false then
			player:AddCollectible(402,0,true)
		end
	end
	if player:HasCollectible(29)==true and player:HasCollectible(381)==false then 
		player:AddCollectible(381,0,true) 
	end
	if player:HasCollectible(30)==true and player:HasCollectible(360)==false then 
		player:AddCollectible(360,0,true) 
	end
	if player:HasCollectible(170)==true and player:GetCollectibleNum(170)<2 then 
		player:AddCollectible(170,0,true) 
	end
	if player:HasCollectible(270)==true and player:GetCollectibleNum(270)<2 then 
		player:AddCollectible(270,0,true) 
	end
	if player:HasCollectible(277)==true and player:GetCollectibleNum(277)<2 then 
		player:AddCollectible(277,0,true)
	end
	if player:HasCollectible(318)==true and player:GetCollectibleNum(318)<2 then 
		player:AddCollectible(318,0,true)
	end
	if player:HasCollectible(165)==true and player:GetCollectibleNum(165)<2 then 
		player:AddCollectible(165,0,true)
	end
	if player:HasCollectible(275)==true and player:GetCollectibleNum(275)<3 then 
		player:AddCollectible(275,0,true)
	end
	if player:HasCollectible(508)==true and player:GetCollectibleNum(508)<3 then 
		player:AddCollectible(508,0,true)
	end
	if player:HasCollectible(119)==true then -- 119를 획득하면(앱솔루트 구피)
		if player:HasCollectible(134)==false then -- 134를 획득하지 않았을 때
			player:AddCollectible(134,0,true) -- 134 획득
		end
		if player:HasCollectible(187)==false then -- 이하 반복
			player:AddCollectible(187,0,true)
		end
		if player:HasCollectible(212)==false then
			player:AddCollectible(212,0,true)
		end
	end
	if player:HasCollectible(75)==true then -- 앱솔루트 마약
		if player:HasCollectible(70)==false then
			player:AddCollectible(70,0,true)
		end
		if player:HasCollectible(13)==false then
			player:AddCollectible(13,0,true)
		end
		if player:HasCollectible(143)==false then
			player:AddCollectible(143,0,true)
		end
	end
	if player:HasCollectible(253)==true then -- 앱솔루트 종양
		if player:HasCollectible(322)==false then
			player:AddCollectible(322,0,true)
		end
		if player:HasCollectible(268)==false then
			player:AddCollectible(268,0,true)
		end
		if player:HasCollectible(167)==false then
			player:AddCollectible(167,0,true)
		end
	end
	if player:HasCollectible(329)==true then -- 앱솔루트 유황
		if player:HasCollectible(118)==false then
			player:AddCollectible(118,0,true)
		end
	end
	if player:HasCollectible(52)==true then -- 폭셋
		if player:HasCollectible(220)==false then
			player:AddCollectible(220,0,true)
		end
	end
	if player:HasCollectible(255)==true then -- 정마반
		if player:HasCollectible(260)==false then
			player:AddCollectible(260,0,true)
		end
	end
	if player:HasCollectible(9)==true then -- 앱솔루트 파리셋
		if player:HasCollectible(57)==false then
			player:AddCollectible(57,0,true)
		end
		if player:HasCollectible(128)==false then
			player:AddCollectible(128,0,true)
		end
		if player:HasCollectible(264)==false then
			player:AddCollectible(264,0,true)
		end
		if player:HasCollectible(274)==false then
			player:AddCollectible(274,0,true)
		end
		if player:HasCollectible(279)==false then
			player:AddCollectible(279,0,true)
		end
		if player:HasCollectible(364)==false then
			player:AddCollectible(364,0,true)
		end
		if player:HasCollectible(365)==false then
			player:AddCollectible(365,0,true)
		end
		if player:HasCollectible(426)==false then
			player:AddCollectible(426,0,true)
		end
		if player:HasCollectible(492)==false then
			player:AddCollectible(492,0,true)
		end
		if player:HasCollectible(chiggers_item)==false then
			player:AddCollectible(chiggers_item,0,true)
		end
	end
	if player:HasCollectible(173)==true then -- 앱솔루트 세라핌
		if player:HasCollectible(156)==false then
			player:AddCollectible(156,0,true)
		end
		if player:HasCollectible(72)==false then
			player:AddCollectible(72,0,true)
		end
		if player:HasCollectible(101)==false then
			player:AddCollectible(101,0,true)
		end
		if player:HasCollectible(390)==false then
			player:AddCollectible(390,0,true)
		end
	end
	if player:HasCollectible(346)==true then -- 앱솔루트 레비아탄
		if player:HasCollectible(79)==false then
			player:AddCollectible(79,0,true)
		end
		if player:HasCollectible(80)==false then
			player:AddCollectible(80,0,true)
		end
		if player:HasCollectible(159)==false then
			player:AddCollectible(159,0,true)
		end
	end
	if player:HasCollectible(129)==true then -- 앱솔루트 그혈
		if player:HasCollectible(118)==false then
			player:AddCollectible(118,0,true)
		end
		if player:HasCollectible(222)==false then
			player:AddCollectible(222,0,true)
		end
		if player:HasCollectible(1)==false then
			player:AddCollectible(1,0,true)
		end
		if player:HasCollectible(32)==false then
			player:AddCollectible(32,0,true)
		end
		if player:HasCollectible(341)==false then
			player:AddCollectible(341,0,true)
		end
	end
	if player:HasCollectible(456) then -- 만약 클리너 소지 시
		if player:HasCollectible(52) then -- 닥터 소지 시
			player:RemoveCollectible(52) -- 닥터 제거
		end
		if player:HasCollectible(68) then -- 테크 소지 시
			player:RemoveCollectible(68) -- 테크 제거
			player:RemoveCollectible(68)
		end
		if player:HasCollectible(114) then -- 칼 소지 시
			player:RemoveCollectible(114) -- 칼 제거
		end
		if player:HasCollectible(118) then -- 혈사 소지 시
			player:RemoveCollectible(118) -- 혈사 제거
			player:RemoveCollectible(118)
		end
		if player:HasCollectible(129) then -- 그혈 소지 시
			player:RemoveCollectible(129) -- 그혈 제거
		end
		if player:HasCollectible(149) then -- 구토 소지 시
			player:RemoveCollectible(149) -- 구토 제거
		end
		if player:HasCollectible(152) then -- 테크2 소지 시
			player:RemoveCollectible(152) -- 테크2 제거
		end
		if player:HasCollectible(168) then -- 에픽 소지 시
			player:RemoveCollectible(168) -- 에픽 제거
		end
		if player:HasCollectible(329) then -- 루도비코 소지 시
			player:RemoveCollectible(329) -- 루도비코 제거
		end
		if player:HasCollectible(395) then -- 테크엑스 소지 시
			player:RemoveCollectible(395) -- 테크엑스 제거
		end
		if player:HasCollectible(52) == false and player:HasCollectible(68) == false and player:HasCollectible(114) == false and player:HasCollectible(118) == false and player:HasCollectible(129) == false and player:HasCollectible(149) == false and player:HasCollectible(152) == false and player:HasCollectible(168) == false and player:HasCollectible(329) == false and player:HasCollectible(395) == false then -- 공격 변화 아이템이 없는 경우
			player:RemoveCollectible(456) -- 클리너 제거
		end
	end
	if player:HasCollectible(115) then -- 만약 히오스 소지 시
		if player:HasCollectible(22) then -- 샛별 소지 시
			player:RemoveCollectible(22) -- 샛별 제거
		end
		if player:HasCollectible(23) then -- 향기 소지 시
			player:RemoveCollectible(23) -- 향기 제거
		end
		if player:HasCollectible(24) then -- 물소리 소지 시
			player:RemoveCollectible(24) -- 물소리 제거
		end
		if player:HasCollectible(29) then -- 솔리움 폰스 소지 시
			player:RemoveCollectible(29) --솔리움 폰스 제거
		end
		if player:HasCollectible(30) then -- 테네브레 루스 소지 시
			player:RemoveCollectible(30) -- 테네브레 루스 제거
		end
		if player:HasCollectible(31) then -- 루멘 바실리움 소지 시
			player:RemoveCollectible(31) -- 루멘 바실리움 제거
		end
		if player:HasCollectible(241) then -- 정마팔 소지 시
			player:RemoveCollectible(241) -- 정마팔 제거
		end
		if player:HasCollectible(249) then -- 정마목 소지 시
			player:RemoveCollectible(249) -- 정마목 제거
		end
		if player:HasCollectible(255) then -- 정마반 소지 시
			player:RemoveCollectible(255) -- 정마반 제거
		end
		if player:HasCollectible(22) == false and player:HasCollectible(23) == false and player:HasCollectible(24) == false and player:HasCollectible(29) == false and player:HasCollectible(30) == false and player:HasCollectible(31) == false and player:HasCollectible(241) == false and player:HasCollectible(249) == false and player:HasCollectible(255) == false then -- 세트템이 없는 경우
			player:RemoveCollectible(115) -- 히오스 제거
		end
	end
	if player:GetPlayerType() == 5 and player:HasCollectible(126) then --만약 플레이어가 이브(5)이고 만약 126(면도) 소지 시라면
		player:AddCollectible(485,6,true)
	end
	if player:GetPlayerType() == 5 and player:HasCollectible(356) then 
		player:RemoveCollectible(356)
	end
	if player:GetPlayerType() == 10 and player:HasCollectible(482) then
		player:RemoveCollectible(482)
	end
	if player:GetPlayerType() == 10 and player:HasCollectible(332) then
		player:RemoveCollectible(332)
	end
	if player:GetPlayerType() == 10 and player:HasCollectible(311) then
		player:RemoveCollectible(311)
	end
	if player:GetPlayerType() == 10 and player:HasCollectible(161) then
		player:RemoveCollectible(161)
	end
	if player:GetPlayerType() == 10 and player:GetTrinket(28) then
		player:TryRemoveTrinket(28)
	end
	if player:GetPlayerType() == 14 and player:HasCollectible(482) then
		player:RemoveCollectible(482)
	end
	if player:GetPlayerType() == 14 and player:HasCollectible(332) then
		player:RemoveCollectible(332)
	end
	if player:GetPlayerType() == 14 and player:HasCollectible(311) then
		player:RemoveCollectible(311)
	end
	if player:GetPlayerType() == 14 and player:HasCollectible(161) then
		player:RemoveCollectible(161)
	end
	if player:GetPlayerType() == 14 and player:GetTrinket(23) then
		player:TryRemoveTrinket(23)
	end
	if player:GetPlayerType() == 14 and player:GetTrinket(28) then
		player:TryRemoveTrinket(28)
	end
	if player:GetTrinket(51) then -- 동일
		player:TryRemoveTrinket(51)
	end
	if player:GetTrinket(50) then
		player:TryRemoveTrinket(50)
	end
	if player:GetTrinket(52) then 
		player:TryRemoveTrinket(52)
	end
	if player:GetTrinket(49) then 
		player:TryRemoveTrinket(49)
	end

	-- 갓모드 패시브 아이템
	if hasMorphine then
        player:AddHearts(-24)
        player:AddHearts(2)
    end

    if player:HasCollectible(ChaosGreed.COLLECTIBLE_BACKPACK) then
		if hasBackpack == false then
			player:AddNullCostume(Isaac.GetCostumeIdByPath("gfx/characters/costumes/backpack_costume.anm2"))
			hasBackpack = true
			Isaac.DebugString("Adding Costume");
		end

		-- Picks up an active item when doesn't currently have one
		if heldItem == 0 and player:GetActiveItem() ~= 0 then
			heldItem = player:GetActiveItem()
			heldItemCharge = player:GetActiveCharge()
		end
		-- Picks up an active item when is currently holding one, no stored item
		if heldItem ~= 0 and heldItem ~= player:GetActiveItem() and storedItem == 0 and Game():GetFrameCount() > useItemFrame then
			-- 들고 있던 아이템이 사라졌다면?
			if player:GetActiveItem() == 0 and Game():GetFrameCount() <= useItemFrame + 20 then
				heldItem = 0
				heldItemCharge = 0
			end
			storedItem = heldItem
			storedItemCharge = heldItemCharge
			storedItemSprite:ReplaceSpritesheet(0, config:GetCollectible(storedItem).GfxFileName)
			storedItemSprite:LoadGraphics()
			heldItem = player:GetActiveItem()
			heldItemCharge = player:GetActiveCharge()
			-- Remove pedestal
			for i, entity in pairs(Isaac.GetRoomEntities()) do
				if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE then
					if entity.SubType == storedItem then
						entity:Remove()
					end
				end
			end
		end
		-- Picks up an active item when is currently holding two items
		if heldItem ~= 0 and heldItem ~= player:GetActiveItem() and storedItem ~= 0 then
			heldItem = player:GetActiveItem()
			heldItemCharge = player:GetActiveCharge()
			player:DischargeActiveItem()
			player:SetActiveCharge(heldItemCharge + batteryCharge)
			Isaac.DebugString(player:GetActiveSubCharge());
		end
		-- Presses the swap key and has two items
		if (Input.IsButtonPressed(swapItemKey, player.ControllerIndex) or (controllerMode and Input.IsActionTriggered(ButtonAction.ACTION_DROP, player.ControllerIndex))) and storedItem ~= 0 and Game():GetFrameCount() > swapBuffer then
			swapBuffer = Game():GetFrameCount() + 10
			heldItem = player:GetActiveItem()
			heldItemCharge = player:GetActiveCharge()
			-- Update battery data
			if player:GetActiveCharge() ~= 0 then
				if player:GetBatteryCharge() == heldItemCharge then
					if batteryCharge < player:GetBatteryCharge() then
						batteryCharge = player:GetBatteryCharge()
					end
				else
					batteryCharge = player:GetBatteryCharge()
				end
			end
			-- Swap items
			player:AddCollectible(storedItem, 0, false)
			player:RemoveCollectible(heldItem)
			--player:DischargeActiveItem()
			player:SetActiveCharge(storedItemCharge + batteryCharge)
			storedItem = heldItem
			storedItemCharge = heldItemCharge
			if storedItem ~= 0 then
				storedItemSprite:ReplaceSpritesheet(0, config:GetCollectible(storedItem).GfxFileName)
				storedItemSprite:LoadGraphics()
			end
		end
	end

	-- Save data
	local saveData = storedItem ..",".. storedItemCharge ..",".. batteryCharge
	Isaac.SaveModData(ChaosGreed, saveData)
end

ChaosGreed:AddCallback(ModCallbacks.MC_POST_UPDATE, ChaosGreed.Item2, EntityType.ENTITY_PLAYER)

function ChaosGreed:useItem(collectible, rng)
    local player = Isaac.GetPlayer(0)

    useItemFrame = Game():GetFrameCount() + 10

    if player:GetActiveItem() == protection_item then
        local act = math.random()
        if act < 0.2 then
            local off = math.random() * 360
            for i=0,7 do 
                local ang = math.rad(0 + (360 / 8) * i+off)
                local speed = 12.0 + math.random() * 1
                local vec = Vector(math.cos(ang)*speed, math.sin(ang)*speed)
                local tear = player:FireTear(player.Position,vec,false, true, false)
            end
            return true
        elseif act < 0.4 then
            Game():Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER, player.Position, Vector(0,0),player, 0, player.InitSeed)
            return true
        elseif act < 0.75 then
            local off = math.random() * 360
            for i=0,15 do 
                local ang = math.rad(0 + (360 / 16) * i+off)
                local speed = 8.5 + math.random() * 4
                local vec = Vector(math.cos(ang)*speed, math.sin(ang)*speed)
                local tear = player:FireTear(player.Position,vec,false, true, false)
            end

            return true
        else
            local off = math.random() * 360
            for i=0,3 do 
                local ang = math.rad(0 + (360 / 4) * i+off)
                local speed = 8.5 + math.random() * 4
                local vec = Vector(math.cos(ang)*speed, math.sin(ang)*speed)
                local tear = player:FireTear(player.Position,vec,false, true, false)
            end
            return true
        end
	end
end

ChaosGreed:AddCallback(ModCallbacks.MC_USE_ITEM, ChaosGreed.useItem)

function ChaosGreed:useCard(card) 
  local player = Isaac.GetPlayer(0) 
 
  if card == hermit_stars_card then 
	player:AddCard(Card.CARD_HERMIT)
	player:AddCard(Card.CARD_STARS)
	return true 
  end 
end 

ChaosGreed:AddCallback(ModCallbacks.MC_USE_CARD, ChaosGreed.useCard)

function ChaosGreed:npcHit(dmg_target , dmg_amount, dmg_source, dmg_dealer)
    local player = Isaac.GetPlayer(0)
    local flag = false

    if player:HasCollectible(chiggers_item) and dmg_target:IsVulnerableEnemy() then
        if dmg_dealer.Type == EntityType.ENTITY_TEAR and math.random()<0.3 then
            local spd = 5.0 + math.random()
            local ang = math.rad(math.random() * 360)
            local s = Game():Spawn(3, 802, dmg_target.Position+Vector(math.cos(ang)*spd,math.sin(ang)*spd), Vector(math.cos(ang)*spd,math.sin(ang)*spd), player, 0, player.InitSeed)
            s.CollisionDamage = dmg_amount / 15.0
        end
        if dmg_dealer.Type == EntityType.ENTITY_LASER then
            local spd = 5.0 + math.random()
            local ang = math.rad(math.random() * 360)
            local s = Game():Spawn(3, 802, dmg_target.Position+Vector(math.cos(ang)*spd,math.sin(ang)*spd), Vector(math.cos(ang)*spd,math.sin(ang)*spd), player, 0, player.InitSeed)
            s.CollisionDamage = dmg_amount / 5.0
        end
        if dmg_dealer.Type == EntityType.ENTITY_KNIFE and dmg_target.FrameCount % 3 == 0 then
            local spd = 5.0 + math.random()
            local ang = math.rad(math.random() * 360)
            local s = Game():Spawn(3, 802, dmg_target.Position+Vector(math.cos(ang)*spd,math.sin(ang)*spd), Vector(math.cos(ang)*spd,math.sin(ang)*spd), player, 0, player.InitSeed)
            s.CollisionDamage = dmg_amount / 10.0
        end
    end

    if dmg_source == 0 then
        local lvl = Game():GetLevel()
        local amt = dmg_amount
        local l = lvl:GetAbsoluteStage()

        local fin_amt = 1.0 - (l / 12) * 0.4
        --Isaac.DebugString("Original Damage:"..amt..", Reduced Damage:"..(dmg_amount * fin_amt))
        local ref = dmg_target
        --for i=1,#ref do
        --    if Isaac.GetRoomEntities()[i].Index == dmg_target.Index then ref = Isaac.GetRoomEntities()[i] end
        --end

        local d = 1.0

        if player:HasCollectible(chiggers_item) and ref:IsVulnerableEnemy() then
            d = 0.5
        end

        if ref.Type == EntityType.ENTITY_HUSH then fin_amt = 1.5 end

        if ref.Index ~= nil then if ref:IsVulnerableEnemy() then
            ref.HitPoints = ref.HitPoints + (dmg_amount * d) * (1.0-fin_amt)
        end end
    end
end

ChaosGreed:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, ChaosGreed.npcHit)

function ChaosGreed:familiarUpdate(ent)
	local fam = ent:ToFamiliar()
    local player = Isaac.GetPlayer(0)

    if fam.Variant == 802 then
        if fam.FrameCount % 20 == 2 then
            local ents = Isaac.GetRoomEntities()
            for i=1,#ents do
                if ents[i]:IsVulnerableEnemy() then
                    if fam.Target == nil or ents[i].HitPoints > fam.Target.HitPoints then if ents[i].Size > 3 then
                        fam.Target = ents[i]
                    end end
                end
            end
        end
        if fam.FrameCount > 80 then fam:Kill() end
        if fam.Target ~= nil and fam.FrameCount % 2 == 1 or fam.FramCount == 1 then
            fam.Velocity = fam.Velocity + ((fam.Target.Position - fam.Position):Resized(2.65+math.abs(math.cos(fam.FrameCount / 2) * 0.5)))
            fam.Velocity = fam.Velocity * 0.8
        end

        if fam.Target == nil and fam.FrameCount > 30 then fam:Kill() end

        if fam.Velocity:Length() > 8 then fam.Velocity:Resize(8) end

        if fam.FrameCount % 3 == fam.Index % 3 then
            local ents = Isaac.GetRoomEntities()
            for i=1,#ents do
                local off = ents[i].Position - ent.Position
                if ents[i]:IsVulnerableEnemy() and math.abs(off.X) + math.abs(off.Y) < ent.Size+32 and fam.FrameCount > 40 then
                    ent:Kill()
                end
             end
        end
	end
end

ChaosGreed:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, ChaosGreed.familiarUpdate)

function ChaosGreed:Render()
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(ChaosGreed.COLLECTIBLE_BACKPACK) and storedItem ~= 0 then
		storedItemSprite:Render(Vector(0,0), Vector(0,0), Vector(0,0))
	end
end

ChaosGreed:AddCallback(ModCallbacks.MC_POST_RENDER, ChaosGreed.Render);