--------------
--LIGHT SHOT--
--------------

local lightshotMod = RegisterMod("lightshot",1)
local lightshotItem = Isaac.GetItemIdByName("Lightshot")
local lightshotCostume = Isaac.GetCostumeIdByPath("gfx/characters/lightshot_costume.anm2")

local hasLightshot = false

-- This is for ipecac --
local tears = { }

function lightshotMod:onUpdate()
  
  local player = Isaac.GetPlayer(0)
  
  if hasLightshot == true and not player:HasCollectible(lightshotItem) then
    hasLightshot = false
  end
  if hasLightshot == false and player:HasCollectible(lightshotItem) then
    hasLightshot = true
    player:AddNullCostume(lightshotCostume, 100)
  end
  
  -- Check if the player has Lightshot
  if player:HasCollectible(lightshotItem) then
    
    -- Limit the player max fire delay --
    if player.MaxFireDelay < 7 then
      player.MaxFireDelay = 7
    end
    
    -- Remove the tear sound --
    if SFXManager():IsPlaying(SoundEffect.SOUND_TEARIMPACTS) then
      SFXManager():Stop(SoundEffect.SOUND_TEARIMPACTS)
    end
    if SFXManager():IsPlaying(SoundEffect.SOUND_TEARS_FIRE) then
      SFXManager():Stop(SoundEffect.SOUND_TEARS_FIRE)
    end
    
    -- Check all the tear entities and laser entities --
    local ents = Isaac.GetRoomEntities()
    for k, v in pairs(ents) do
      
      -- Remove laser sounds that come from the player aka brimstone --
      if v.Type == EntityType.ENTITY_LASER and v.SpawnerType == EntityType.ENTITY_PLAYER and v.FrameCount <= 2 and v.Parent ~= nil and v.Parent.Type == EntityType.ENTITY_TEAR then
        if SFXManager():IsPlaying(SoundEffect.SOUND_BLOOD_LASER) then
          SFXManager():Stop(SoundEffect.SOUND_BLOOD_LASER)
        end
        if SFXManager():IsPlaying(SoundEffect.SOUND_BLOOD_LASER_LARGE) then
          SFXManager():Stop(SoundEffect.SOUND_BLOOD_LASER_LARGE)
        end
      end
      
      -- Transform tears into lightshots --
      if v.Type == EntityType.ENTITY_TEAR and v.FrameCount <= 1 and v.Variant ~= 6514 then
        if player:GetName() ~= "Azazel" and not player:HasCollectible(CollectibleType.COLLECTIBLE_BRIMSTONE) then
          if player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_X) then
            return
          end
          v.Position = v.Position + Vector(0,-10)
          v.Variant = 22
          table.insert(tears, v:ToTear())
          local laser = EntityLaser.ShootAngle(3, Vector(-500,-400), v.Velocity:GetAngleDegrees(), 0, Vector(0,-10), player)
          laser:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
          laser:GetSprite():Load("gfx/lightshot.anm2", true)
          laser:GetSprite():Play("LargeRedLaser")
          laser.Parent = v
          laser.Velocity = v.Velocity
          

          laser.ParentOffset = Vector(0,-80)
          
          -- The range is fixed and it only changes if you have brimstone --
          if player:HasCollectible(CollectibleType.COLLECTIBLE_BRIMSTONE) then
            
            laser.MaxDistance = 3000
          elseif player:HasCollectible(CollectibleType.COLLECTIBLE_LUDOVICO_TECHNIQUE) then
            laser.MaxDistance = 1
          else
            laser.MaxDistance = 30
          end
          
          -- Nerf damage because its op as fuck --
          laser.CollisionDamage = player.Damage / 3
          
          -- Color the laser --
          laser.Color = player.TearColor
         
          -- This prevents the laser from dying before the ghost tear dies --
          laser.Timeout = 10000
          
          -- Prevents the ghost tear from doing damage and other stuff --
          v.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
          v.Visible = false
          
          -- Continuum synergy! --
          if player:HasCollectible(CollectibleType.COLLECTIBLE_CONTINUUM) then
            laser.GridHit = false
          end
          
          -- Tear flags and movement speed --
          laser.TearFlags = player.TearFlags
          laser.Velocity = v.Velocity

          -- Lightshot sound --
          --SFXManager():Play(458, 1,0,false, 1)
        end
      end
      
      -- Tech X synergy --
      if v.Type == EntityType.ENTITY_LASER and v.FrameCount <= 1 and v.SpawnerType == EntityType.ENTITY_PLAYER and v.Parent ~= nil and v.Parent.Type ~= EntityType.ENTITY_TEAR and player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_X) then -- 2 and 7
        v:GetSprite():Load("gfx/lightshot.anm2", true)
        v:GetSprite():Play("LargeRedLaser")
        --laser.TearFlags = player.TearFlags
        --local velocity = v.Velocity
        --local tear = player:FireTear(v.Position, velocity, true, false, false)
        --v.Parent = tear
        --v.Velocity = Vector(0,0)
        local velocity = v.Parent.Velocity
        local tear = player:FireTear(v.Position, velocity, true, false, false)
        v.Parent.Parent = tear
        laser.TearFlags = player.TearFlags
        
      end
      -- In case you have a laser and not a tear --
      if v.Type == EntityType.ENTITY_LASER and v.FrameCount <= 1 and v.SpawnerType == EntityType.ENTITY_PLAYER and v.Parent ~= nil and v.Parent.Type ~= EntityType.ENTITY_TEAR and v.Variant ~= 7 then
        if player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_X) then
         -- if v.Variant ~= 2 then
            return
          --end
          --return
        else
          if not v:ToLaser().BounceLaser then
            return
          end
        end
        if v.Parent ~= nil and v.Parent.Type == EntityType.ENTITY_LASER then
          if v.Parent.Parent ~= nil and v.Parent.Parent.Type == EntityType.ENTITY_TEAR then
            return
          end
          if v.Parent.Parent.Parent ~= nil then
            return
          end
        end
        if player:HasCollectible(CollectibleType.COLLECTIBLE_LUDOVICO_TECHNIQUE) then
          return
        end
        -- Gets the player laser --
        local laser2 = v:ToLaser()
        laser2:GetSprite():Load("gfx/lightshot.anm2", true)
        laser2:GetSprite():Play("LargeRedLaser")
        Isaac.DebugString("Angle: " .. tostring(laser2.Angle))
        -- This gets the velocity vector from the angle --
        local velocity = Vector(math.cos(math.rad(laser2.StartAngleDegrees))*((player.ShotSpeed)*15), math.sin(math.rad(laser2.StartAngleDegrees))*((player.ShotSpeed)*15))

        -- Spawns the ghost tear and removes the laser --
        local tear = player:FireTear(v.Position, velocity, true, false, false)--Isaac.Spawn(2, 1, 0, v.Position, Vector(0,0), player):ToTear()
        --local tear = Isaac.Spawn(2, 22, 0, v.Position, velocity, player)
        
        table.insert(tears, tear:ToTear())
        tear.Variant = 22
        tear.Position = v.Position + Vector(0,-10)
        laser2:Remove()
        --if tear ~= nil then
        --  return
        --end
        
        -- Spawns the lightshot and do stuff --
        laser = EntityLaser.ShootAngle(3, Vector(-500,-400), v.Velocity:GetAngleDegrees(), 0, Vector(0,-10), player)
        laser:GetSprite():Load("gfx/lightshot.anm2", true)
        laser:GetSprite():Play("LargeRedLaser")
        laser.Parent = tear
        laser.Velocity = tear.Velocity
        laser.ParentOffset = Vector(0,-80)
        
        -- Check range if you have or not brimstone --
        if player:HasCollectible(CollectibleType.COLLECTIBLE_BRIMSTONE) then
          laser.MaxDistance = 3000
        else
          laser.MaxDistance = 30
        end
        
        -- Same shit than above --
        laser.CollisionDamage = player.Damage / 3
        laser.Color = player.TearColor
        laser.SplatColor = player.TearColor
         
        laser.Timeout = 10000
        tear.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
        if player:HasCollectible(CollectibleType.COLLECTIBLE_CONTINUUM) then
          laser.GridHit = false
        end

        --tear.Visible = false

        laser.TearFlags = player.TearFlags
        laser.Velocity = tear.Velocity
          
        --SFXManager():Play(458, 1,0,false, 1)
      end
      
      -- Check for lightshot impact particles --
      if v.Type == EntityType.ENTITY_EFFECT and v.Variant == EffectVariant.LASER_IMPACT and v.FrameCount <= 1 and v.Parent ~= nil and v.Parent.SpawnerType == EntityType.ENTITY_PLAYER then
        if player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_X) then
          --v.Visible = false
          
          -- LASER CONVERSION --
          --v.Visible = false
          
          --v.Parent = tear
          
         -- v.
          --v.Velocity = Vector(0,0)
          
          return
        end
        v:GetSprite():Load("gfx/lightshot_impact.anm2", true)
        v:GetSprite():Play("Start")
      end
      
      if v.Type == EntityType.ENTITY_LASER and v.Variant == EffectVariant.LASER_IMPACT and player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_X) and v.Parent.SpawnerType == EntityType.ENTITY_PLAYER and v.Variant == 2 then
        v.Position = v.Parent.Position
        v.Velocity = v.Parent.Velocity
      end
      
      if v.Type == EntityType.ENTITY_EFFECT and v.Variant == EffectVariant.LASER_IMPACT and v.FrameCount <= 2 and v.Parent ~= nil and v.Parent.SpawnerType == EntityType.ENTITY_PLAYER then
        if player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_X) then
          
          return
        end
        v:GetSprite():Load("gfx/lightshot_impact.anm2", true)
        v:GetSprite():Play("Start")
      end
      
      -- This updates the laser angle, for example for ludovico --
      if v.Type == EntityType.ENTITY_LASER and v.Parent ~= nil and v.Parent.Type == EntityType.ENTITY_TEAR and v.Parent.SpawnerType == EntityType.ENTITY_PLAYER then
        v:ToLaser().Angle = v.Parent.Velocity:GetAngleDegrees()
       -- if player:HasCollectible(GENESIS_ITEMS.PASSIVE.TETRACHROMACY) then
        --  local ro = math.random(0, 255)
        --  local go = math.random(0, 255)
        --  local bo = math.random(0, 255)
        --  v:ToLaser().Color = Color(ro/255, ro/255, ro/255, ro/255, ro, go, bo)
        --end
      end
      
      -- This removes the laser slowly when the tear dies --
      if v.Type == EntityType.ENTITY_LASER and v.Parent == nil and v:ToLaser().Timeout > 10 then
        v:ToLaser().Timeout = 10
      end
      
      -- Ipecac synergy, first part --
      if v.Type == EntityType.ENTITY_LASER and v.Parent ~= nil then
        if player:HasCollectible(CollectibleType.COLLECTIBLE_IPECAC) then
           
          local value = -30
          --v.Parent.Variant = 5
          value = -30

          v:ToLaser().Parent:ToTear().Height = value
          v:ToLaser().Parent:ToTear().FallingSpeed = 0
          laser.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ENEMIES
        end
      end
      
      -- Ipecac synergy, part two --
      if v.Type == EntityType.ENTITY_TEAR and v.SpawnerType == EntityType.ENTITY_PLAYER then
        if player:HasCollectible(CollectibleType.COLLECTIBLE_IPECAC) then
          
          -- check for all entities, this will be laggy --
          local ients = Isaac.GetRoomEntities()
          for k, e in pairs(ients) do
            if v.Position:Distance(e.Position) < 55 and e:IsEnemy() then
              Isaac.DebugString("EXPLODE DAMN!")
              v:Die()
            end
          end
        end
      end
      
      -- If the laser is from rubber cemment and stuff like that --
      if v.Parent ~= nil then
        if v.Type == EntityType.ENTITY_LASER and v.Parent.Type == EntityType.ENTITY_LASER and v.FrameCount <= 3 then
          v:GetSprite():Load("gfx/lightshot.anm2", true)
          v:GetSprite():Play("LargeRedLaser")
        end
      end
      
      -- Removes the ghost tear particles --
      if v.Type == EntityType.ENTITY_EFFECT then
        if v.Variant == EffectVariant.TEAR_POOF_A or v.Variant == EffectVariant.TEAR_POOF_B or v.Variant == EffectVariant.TEAR_POOF_SMALL or v.Variant == EffectVariant.TEAR_POOF_VERYSMALL then 
          v:Remove()
        end
      end
    end
  end
end


--Callbacks--
lightshotMod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, lightshotMod.onUpdate)