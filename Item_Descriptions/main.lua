local	EID = RegisterMod( "EID" ,1 );
local filepath= ""
local config={
-- Change language of the mod. 
-- Currently Supported: 	English = "enUS" (Default) 
	-- Currently UNUSED["Language"]="enUS",
	-- If you want to make a translation of it, please contact me :)
	
-- Change Width of the info boxes. (In characters)
-- Default = 18
	["TextboxWidth"]="18",
-- Set transparency of the background. Range: [0,...,1]
-- Default = 0.75
	["Transparency"]="0.75",
	-- Set X Position (Width) of the descriptiontext
	-- Default = 50
	["XPosition"]="50",
	-- Set Y Position (Height) of the descriptiontext
	-- Default = 50
	["YPosition"]="30",
	-- Display informations when the floor has curse of the blind ( ? - Items)
	-- Default = false
	["EnableOnCurse"]="false",
	-- Set the distance to an item in which informations will be displayed (in Tiles)
	-- Default = 5
	["MaxDistance"]="5",
	-- Toggle Display of Transformation icons
	-- Default = true
	["TransformationIcons"]="true",
	-- Toggle Display of Transformation text
	-- Default = true
	["TransformationText"]="true",
	-- Toggle Display of Card / Rune descriptions
	-- Default = false
	["DisplayCardInfo"]="false",
	-- Toggle Display of Card / Rune descriptions when its a shop item
	-- Default = false
	["DisplayCardInfoShop"]="false"
	}
	
-- Transformations: 0=none, 1=guppy,2=mushroom,3=lord of the flies, 4=conjoined,5= junkie(Spun),6=mom,7=poopboy(oh crap),8=bob,9=leviathan,10=Seraphim,11=super bum,-1=Custom transformation
-- ID| transformationid| Descriptiontext 
-- Example:  69|1|+1.0 Tears up  
-- '#' = starts new line of text
local descriptarray={{"1","0","+0.7 Tears up"},
{"2","0","Triple shot#Tears down"},
{"3","0","Homing tears"},
{"4","0","+0.5 Damage Up#+50% Damage Multiplier #+ knockback"},
{"5","0","Gives tears a boomerang effect#+1.5 Range Up#+0.6 Shot Speed Up#+1 Tear Height"},
{"6","0","+1.5 Tears Up#-15.78 Range Down#+0.45 Tear Height"},
{"7","0","+1.0 Damage Up#+50% if you have Book of Belial"},
{"8","4","Has normal tears"},
{"9","3","All fly enemies are friendly"},
{"10","3","+2 fly orbitals"},
{"11","2","+1 life#Respawn with full health"},
{"12","2","+1 Health Up#+0.3 Damage Up#+50% Damage Multiplier#+5.25 Range Up#+0.3 Speed Up#+0.5 Tear Height#Full health!"},
{"13","5","Poison touch#-0.1 Speed Down#Enemies can drop black hearts if poisoned"},
{"14","5","+0.6 Speed Up#+5.25 Range Up#+0.5 Shot Height"},
{"15","0","+1 Health Up#Full health"},
{"16","0","+2 Health Up#Full health"},
{"17","0","+99 Keys"},
{"18","0","+99 Coins"},
{"19","0","+10 Bombs"},
{"20","0","Flight!"},
{"21","0","Unveils all icons on the map#Does not show the layout of the map"},
{"22","0","+1 Health Up"},
{"23","0","+1 Health Up"},
{"24","0","+1 Health Up"},
{"25","0","+1 Health Up"},
{"26","0","+1 Health Up"},
{"27","0","+0.3 Speed Up"},
{"28","0","+0.3 Speed Up"},
{"29","6","+5.25 Range Up#+0.5 Tear Height"},
{"30","6","+5.25 Range Up#+0.5 Tear Height"},
{"31","6","+5.25 Range Up#+0.5 Tear Height"},
{"32","0","+0.7 Tears Up"},
{"33","12","Flight for current room#Kills mom instantly#Instantly kills you when used on Satan!"},
{"34","12","+2 Damage Up#+50% Damage Multiplier if you have Blood of the Martyr#+12.5% devil deal chance"},
{"35","12","Deal 40 damage to everything in the room"},
{"36","7","Drop a poop on the floor#Can be placed next to a pit and destroyed to make a bridge"},
{"37","0","Drops a large bomb below the player which deals 110 damage"},
{"38","0","Fires 10 tears in a circle around Isaac"},
{"39","6","Freeze all enemies in the current room"},
{"40","0","Causes an explosion near the player"},
{"41","6","Fear effect to all enemies in the current room "},
{"42","8","Throwable poison bomb"},
{"43","0","<item does not exist>"},
{"44","0","Teleports Isaac into a random room"},
{"45","0","Heal 1 red heart"},
{"46","0","+1.0 Luck Up#Better chance to win while gambling"},
{"47","0","Epic Fetus on demand!"},
{"48","0","Piercing tears"},
{"49","0","High damage brimstone laser"},
{"50","0","+1 Damage Up"},
{"51","9","+1.0 Damage Up#Higher chance for Devil Deals(Approximately +20%)"},
{"52","0","Bomb tears!"},
{"53","0","Pulls Pick-ups towards the player"},
{"54","0","Unveals the map-layout"},
{"55","6","Random chance to shoot a tear backwards"},
{"56","0","Drop a pool of lemonade"},
{"57","3","Mid range fly orbital"},
{"58","12","Invincibility "},
{"59","0","<item does not exist>"},
{"60","0","Walk over small gaps"},
{"61","0","<item does not exist>"},
{"62","0","Heals half a heart every 13 enemies killed"},
{"63","0","Spacebar items can now be charged up twice"},
{"64","0","-50% on shop items#Getting two will make everything for free"},
{"65","12","Spawn troll bombs at random locations around the room"},
{"66","0","Slow down enemies"},
{"67","4","Normal tear familiar"},
{"68","0","Tears are now lasers"},
{"69","0","Chargeable tears"},
{"70","5","+1.0 Damage Up#+0.4 Speed Up"},
{"71","2","+0.3 Speed Up#Range up"},
{"72","10","+3 Soul Hearts#Bible is more common"},
{"73","0","LVL 1: Orbital#LVL2: Shooting orbital#LVL3: Meat boy LVL 1#LVL4: Meat boy LVL 2!"},
{"74","0","+25 coins"},
{"75","0","Better pills# +1 pill"},
{"76","0","Reveals secret rooms"},
{"77","0","Invincibility+ contact damage"},
{"78","12","+1 Soulheart#Higher horsemen chance#+17.5% devil deal chance"},
{"79","9","+1.0 Damage Up#+0.2 Speed Up#+1 Soul Heart"},
{"80","9","+0.5 Damage Up#+0.7 Tears Up#+2 Soul Hearts"},
{"81","1","+9 Lives#Respawn with 1 Heart"},
{"82","9","Flight#+0.3 Speed up"},
{"83","9","+1 Soul heart#+0.7 Damage up#-0.18 Speed down#Crush rocks"},
{"84","0","Spawn a trapdoor to skip the floor#10% chance for black market"},
{"85","0","Spawn 1 Card"},
{"86","0","Summon Monstro for one stomp"},
{"87","0","Chance to fire in 4 directions"},
{"88","0","Charges forwards"},
{"89","13","Slow down enemies"},
{"90","0","+1 Damage up"},
{"91","0","Reveals what`s behind the door"},
{"92","0","+1 Red heart#+2 Soul heart"},
{"93","0","Invincibility +contact damage#eating an enemy regenerates health"},
{"94","0","Drops random coin every 2 rooms"},
{"95","0","Laser tears"},
{"96","0","Drops half a heart every 3 rooms"},
{"97","12","Spawn random Pick-Up"},
{"98","0","Spawns 1 Soul heart every 4 rooms"},
{"99","0","Slowing tears"},
{"100","4","Homing tears"},
{"101","10","+1 Health Up#+0.3 Damage Up#+0.2 Tears Up#+0.25 Range Up#+0.3 Speed Up#+0.5 Tear Height"},
{"102","6","Spawns 1 Pill"},
{"103","0","Poison tears (random)"},
{"104","0","Tears split up on contact"},
{"105","0","Reroll pedestals in current room"},
{"106","0","Bomb damage x2.25#+5 Bombs"},
{"107","0","Flight#Body attacks enemies"},
{"108","0","All damage taken is reduced to half a heart"},
{"109","0","+0.04 Damage Up for every coin you have"},
{"110","6","Freeze Tears"},
{"111","0","Poison fart"},
{"112","10","Orbital#Speeds up all orbitals"},
{"113","0","Auto-firing turret"},
{"114","6","Stab Stab Stab!"},
{"115","0","Spectral tears"},
{"116","0","-1 Charge for active items#Fully charges current item"},
{"117","0","Spawns a bird when you get hit"},
{"118","9","Charge a blood laser that deals constant damage"},
{"119","0","+1 Heart#+0.3 Speed up# Heals 5 Hearts"},
{"120","2","+1.7 Tears Up#+0.3 Speed Up#Damage Down"},
{"121","2","+1 Empty Heart container#+0.3 Damage up#+0.25 Range up#-0.1 Speed down#+0.5 Tear Height"},
{"122","0","When on Half a heart or less:#+1.5 Damage up#+0.3 Speed up"},
{"123","0","Random familiar for current room"},
{"124","0","Random active item effect"},
{"125","0","Homing bombs#+5 Bombs"},
{"126","0","+1.2 Damage up#-1 Red heart"},
{"127","0","ONE TIME USAGE!#Reroll entire floor"},
{"128","3","Fly orbital#Far away"},
{"129","0","+2 Health Up#-0.2 Speed Down#Heals half a heart"},
{"130","0","Flight#dash in a direction"},
{"131","0","Drops 1 Bomb every 2 rooms"},
{"132","0","More Damage based on traveled distance of the tear"},
{"133","1","Convert:#1Red heart to 3 Soul hearts"},
{"134","1","More chests appear"},
{"135","0","Portable bloodbank#Half a heart = 1 Coin"},
{"136","0","Exploding Dummy#Attracts enemies"},
{"137","0","Detonate bombs on demand#+5 bombs"},
{"138","0","+1 Health Up#+0.3 Damage Up"},
{"139","6","You can now hold 2 trinkets"},
{"140","8","Poison bombs#+5 bombs"},
{"141","0","Spawns 7 random coins"},
{"142","0","When damaged down to half a heart, you gain 1 Soul heart#(Once per room)"},
{"143","5","+0.3 Speed Up#+0.2 Shot Speed Up"},
{"144","11","Converts Coins into Pick-ups"},
{"145","1","Spawns 2-4 blue flies"},
{"146","0","+1 eternal heart"},
{"147","0","Break rocks in current room"},
{"148","3","Spawn flies when you get hit"},
{"149","8","Explosive tears"},
{"150","0","Chance to fire teeth"},
{"151","3","1/6 chance to spawn a fly when tears hit an enemy"},
{"152","0","Permanent laser!#-35% Damage down"},
{"153","13","Quad Shot!#Tears down"},
{"154","0","+2 Damage Up for left eye"},
{"155","0","Floats around the room#Deals contact damage"},
{"156","0","+1 Charge when you get hit"},
{"157","0","Damage up when you get hit#Lasts for whole floor"},
{"158","0","Reveal full map#Drops random Card or soul heart"},
{"159","9","Flight#Spectral tears"},
{"160","0","Lightbeams from the sky!"},
{"161","0","Respawn as ??? (Blue Baby)"},
{"162","0","Chance for invincibility when Isaac get hit"},
{"163","0","Has spectral tears"},
{"164","0","Spawn a blue fire"},
{"165","0","+1 Damage up#+0.23 Shoot speed up"},
{"166","0","Reroll Pick-ups"},
{"167","4","Shoots two tears in a V-shaped pattern"},
{"168","0","Epic Fetus!!"},
{"169","0","Mega Tears!#Damage up#Tears down"},
{"170","0","Stomps on enemies"},
{"171","13","Slows down enemies#Damages all enemies"},
{"172","0","Orbital knife"},
{"173","10","Higher chance to find soul hearts"},
{"174","0","Shoots random tears"},
{"175","0","Opens all doors in the current room, including secret rooms"},
{"176","0","+1 Health Up#+0.16 Shot Speed Up"},
{"177","0","Portable slot machine"},
{"178","0","Leaves pool of creep when you get hit"},
{"179","0","+1 eternal heart#Flight"},
{"180","0","Fart when touched"},
{"181","0","Flight#Holy Dash"},
{"182","0","Homing tears#+1 Health up#Damage way up#-0.4 Tears Down#-0.25 Shot Speed Down#+0.375 Range Up"},
{"183","0","+0.7 Tears Up.#+0.16 Shot Speed Up"},
{"184","10","Flight#+1 Health up"},
{"185","10","Flight#Spectral tears"},
{"186","0","Deal 40 Damage to every enemy#-1 red heart when used"},
{"187","1","Growing hairball#Swings around you"},
{"188","0","Mirrors your movement#Shoots towards isaac"},
{"189","0","+1 Health Up#+0.3 Damage Up#+0.2 Tears Up#+0.5 Range Up#+0.2 Speed Up#+1.0 Tear Height#Full health"},
{"190","0","+99 Bombs"},
{"191","0","Random tear effect"},
{"192","12","Homing tears for current room"},
{"193","0","+1 Health up#+0.3 Damage up"},
{"194","0","+0.16 Shoot speed up#+1 card"},
{"195","6","Drops 4 Pills"},
{"196","0","+2 Soul hearts#+0.4 Tears up"},
{"197","0","+0.5 Damage Up#+0.25 Range Up.#+0.5 Tear Height"},
{"198","0","Spawns 1 pickup of each kind"},
{"199","6","+2 Keys#More drops from chests"},
{"200","6","Charming tears"},
{"201","0","+0.3 Damage up#Concuss enemies"},
{"202","0","Turn enemies into gold on touch#Golden enemies drop coins"},
{"203","0","Doubles all pickups"},
{"204","0","Drop a random pickup when you get hit"},
{"205","0","-2 Hearts = Fully charges item when pressing space#Only works when item is not charged!"},
{"206","0","+1 Damage up#Tears up#Your Head is now an orbital#You will shoot from the head"},
{"207","0","LVL1: Orbital#LVL2: Shooting orbital#LVL3: Bandage girl#LVL4: Bandage girl LVL2!!"},
{"208","0","+1 Damage up#More champions appear"},
{"209","7","+5 Bombs#Damages every enemy in the room"},
{"210","0","Invincible when standing still for 1 second"},
{"211","13","Spawn spiders when getting hit"},
{"212","1","50% reviving chance"},
{"213","0","Shielded tears"},
{"214","0","+5 Range up#Leave creep on floor when getting hit"},
{"215","0","100% chance for Devil/Angel rooms"},
{"216","0","+1 Damage up#+3 Black hearts"},
{"217","6","Random chance to spawn blue spider when shooting tears"},
{"218","0","Regenerate health slowly#+1 health up"},
{"219","0","+1 empty heart container#Random chance to drop hearts when getting hit"},
{"220","0","Tear explosion!#+5 Bombs"},
{"221","0","Bouncing tears"},
{"222","0","Tears up#Anti-Gravity tears"},
{"223","0","Explosions heal you!#+5 Bombs"},
{"224","0","-1 Tear Delay (Tears Up)#-10.0 Range Down#Tears split up in 4 on hit"},
{"225","0","Chance to drop Soul/Black heart when getting hit"},
{"226","0","+1 Health up#+1 Soul heart#+1 Black heart"},
{"227","0","+3 Coins#drop a coin when getting hit"},
{"228","6","Fear shots#Tears up"},
{"229","0","Tears can now be charged and released in a shotgun style attack"},
{"230","9","+1.5 Damage up#+0.2 Speed up#Fear tears#Removes all red hearts#+6Black hearts"},
{"231","0","Leave slowing creep#slowing tears"},
{"232","0","Permanent slow effect (activated when getting hit)"},
{"233","0","Tears orbit around isaac#+7.0 Tear Height"},
{"234","0","Spawn spiders when you kill an enemy"},
{"235","0","<item does not exist>"},
{"236","7","On touch, turns the enemy into poop"},
{"237","0","Scythe tears!#+1.5 Damage up#-0.3 Tears down"},
{"238","0","Key piece for Mega satan door!#More angel rooms appear"},
{"239","0","Key piece for Mega satan door!#More angel rooms appear"},
{"240","5","All Stats +/- a random number"},
{"241","0","Doubles all pickup drops"},
{"242","0","Chance to block tears"},
{"243","0","Tear blocking shield"},
{"244","0","Fire random laser-type tears"},
{"245","0","Doubles your shots"},
{"246","0","Reveals secret rooms"},
{"247","0","Your familiars deal more damage"},
{"248","3","Blue Spiders/flies deal double the damage"},
{"249","0","2 Boss items spawn instead of 1#Only one can be taken"},
{"250","0","Double all bomb-drops"},
{"251","0","You can carry 2 Cards#Turns all Pills into Cards"},
{"252","0","You can carry 2 Pills#Turns all Cards into Pills"},
{"253","0","+1 Luck up#+1 Health up"},
{"254","0","+1 Damage up#+5 Range up#Applies only for the left eye"},
{"255","0","+0.5 Tears up#+0.2 Shoot Speed up"},
{"256","0","Burning bombs#+5 Bombs"},
{"257","0","Tears are on fire#Chance for exploding tears"},
{"258","0","Rerolls all your items everytime you change the floor"},
{"259","0","+1 Damage up#Fearing shots"},
{"260","0","Immunity to Curses#+1 Black heart"},
{"261","0","+100% Damage up#Dealt damage decreases for traveled distance of the tear"},
{"262","0","+1 black heart#When down to 1.5 Hearts, damages all enemies in the room"},
{"263","0","<item does not exist>"},
{"264","3","Orbital that can charge at enemies"},
{"265","0","When hit by enemy tears, can damage all enemies in the room"},
{"266","0","Leaves slowing creep"},
{"267","0","Shoots lasers"},
{"268","4","Spawns blue flies"},
{"269","4","Leaves creep"},
{"270","0","Heals half a heart when it kills an enemy"},
{"271","0","Drops random pickups"},
{"272","3","Friendly exploding fly"},
{"273","8","Throwable bomb familiar"},
{"274","3","When getting hit, spawns as an orbital"},
{"275","0","Shoots a brimstone laser"},
{"276","0","Gain an invulnerable body#When the heart familiar gets hit you take damage"},
{"277","0","Friendly ghost familiar"},
{"278","11","Converts:#1,5 Red hearts into 1 soul heart"},
{"279","3","Big fat orbital"},
{"280","0","Spawns blue spiders"},
{"281","0","Enemies will target him instead"},
{"282","12","Allows you to jump"},
{"283","0","Reroll all pickups, pedestals and all your held items"},
{"284","0","Reroll all your held items"},
{"285","0","Reroll all enemies in the room"},
{"286","0","Mimic effect of your held card"},
{"287","12","Reveals parts of the map"},
{"288","13","Spawn 2-4 blue spiders"},
{"289","0","Throw red fire"},
{"290","0","Can store up to 4 Red hearts"},
{"291","7","Insta kills Poop enemies!#Turns enemies into poop"},
{"292","12","+1 Black heart"},
{"293","0","Shoot a brimstone laser in all 4 directions"},
{"294","0","Knocks back nearby enemies"},
{"295","0","Damage the whole room#Price: 1 coin"},
{"296","0","Converts:#2 Soul/Black hearts into 1 red heart"},
{"297","0","SINGLE USE! Based on current floor, drops:#B1: 2 Soul Hearts#B2:2 keys and bombs#C1: 1 Boss item#C2: B1+C1#D1:4 Soul hearts#D2: 30 Coins#W1:2 Boss items#W2: Bible#Sh: 1 Devil item+Black heart#Cat: 1 Angel item+Soul heart#Chest: 1 Coin"},
{"298","0","Temporary invincibility and speed up"},
{"299","0","Get faster in hostile rooms!#Invincibility when fast enough"},
{"300","0","+0.25 Speed up#Touching enemies hurts them"},
{"301","0","+3 Soul hearts#Halfs taken damage in room when you already got hit"},
{"302","0","Crush rocks!"},
{"303","0","Chance to get invinciblity when hit"},
{"304","0","+6 Coins / Keys / Bombs#Balances your stats!"},
{"305","0","Poison tears"},
{"306","0","+0.2 Speed up#Penetrative tears"},
{"307","0","+1 Health / Key / Bomb / Coin#+0.5 Damage up#+0.1 Speed up#+1.5 Range up"},
{"308","0","Leave trail of creep"},
{"309","0","Tears up#Knockback tears"},
{"310","0","Damage X 2#Tears down#Shoot speed down"},
{"311","0","When dead, respawn as Black judas#(Damage X 2)"},
{"312","0","+1 Health up#All red hearts now heal 2 containers"},
{"313","10","Ignore the first hit in every room"},
{"314","0","+1 Health up#-0.4 Speed down#You can crush rocks!"},
{"315","0","Magnetic tears"},
{"316","0","Charged wave of tears#When charging and getting hit, teleports you to a random room"},
{"317","0","Tears leave creep"},
{"318","0","Close combat familiar"},
{"319","0","Bounces around the room#Shoots towards isaac#His damage = yours"},
{"320","3","Controllable Fly"},
{"321","0","Chain + Ball#Can destroy rocks and hurt enemies"},
{"322","4","Copies the effect of one of your familiars"},
{"323","0","Tear burst#Charges when shooting"},
{"324","0","Teleports you to:#Secret / Error / Item rooms"},
{"325","0","Cut off your head#Head is stationary#Control your body seperately"},
{"326","0","Hold down space till chargebar is empty for invincibility#Dont hold for to long!"},
{"327","0","Invincibility when getting hit and at half a heart"},
{"328","0","Necronomicon effect when getting hit and at half a heart"},
{"329","0","Controllable Tear"},
{"330","0","Very high Tears Up: (delay /4) - 2#-80% Damage Down"},
{"331","0","Homing tears#+0.5 Damage Up#+1.2 Range Up#-0.3 Tears Down#-0.3 Shot Speed Down#+0.8 Tear Height"},
{"332","0","When dead, revive as Lazarus +1 extra item"},
{"333","0","Full mapping effect"},
{"334","0","+3 Health Up"},
{"335","0","+2 Soul Hearts#Projectiles will now curve away from Isaac and avoid hitting him"},
{"336","0","Piercing + spectral tears#-0.25 Range down#-0.4 Shot Speed down"},
{"337","0","Slows down or speeds up rooms"},
{"338","0","Stuns enemies#Can grab items"},
{"339","0","+5.25 Range Up#+0.16 Shot Speed Up#+1 Black Heart#+0.5 Tear Height"},
{"340","0","+0.3 Speed Up#Player Size Down#Gives you a random pill when picked up"},
{"341","0","+0.7 Tears Up#+0.16 Shot Speed Up"},
{"342","0","+1 Health Up#+0.7 Tears Up#-0.16 Shot Speed Down"},
{"343","0","+1 Luck Up#+1 Soul Heart#Spawns 2 keys"},
{"344","0","+1 Black Heart#+3 Bombs"},
{"345","0","+1.0 Damage Up#+5.25 Range Up#+0.5 Tear Height"},
{"346","0","+1 Health Up"},
{"347","0","SINGLE USE!#Duplicates any pedestals/ consumables in the current room"},
{"348","0","Copies the effect of the pill you are currently holding"},
{"349","0","50% chance to drop a random coin"},
{"350","0","At the start of every room every enemy gets a poison effect"},
{"351","0","Freeze all enemies in the current room#deal damage and poison any enemies nearby#sends wave of spikes across the room#Can be used to open secret rooms"},
{"352","0","Reduces your health to half a heart#Fires one large piercing spectral tear ((DMG+1) X 10)"},
{"353","0","+5 bombs#Bombs will now explode in a cross-shaped pattern"},
{"354","0","+1 Health Up#Spawns random trinket on the floor"},
{"355","0","+1.25 Range Up#+0.5 Tear Height#+1 Luck Up"},
{"356","0","Causes your spacebar item to activate twice when used"},
{"357","0","Duplicate your familiars temporarily for the current room"},
{"358","0","Fire 2 tears at once diagonally, similar to R U A WIZARD#Spectral tears"},
{"359","0","+1.5 Damage Up#Increases knockback"},
{"360","0","Shoots tears exactly the same as Isaac's in terms of damage, stats and effects"},
{"361","0","Fires tears and copies your tear damage"},
{"362","0","Drops a random pickup every few rooms"},
{"363","0","Deals contact damage#blocks and attracts bullets#blocking a tear can drop an eternal heart"},
{"364","0","Deals contact damage"},
{"365","0","Moves along walls/obstacles in the room#deals contact damage"},
{"366","0","+5 bombs#Causes your bombs to explode into 4 tiny bombs"},
{"367","0","When a bomb kills an enemy, it spawns blue spiders#Causes your bombs to stick to enemies"},
{"368","0","Shooting in one direction increases your fire rate"},
{"369","0","+2.25 Range Up#+1.5 Tear Height#Tears travel through walls and appear out of the opposite wall"},
{"370","0","+0.7 Tears Up##5.25 Range Up#+0.5 Tear Height#Spawns 3 random hearts when picked up"},
{"371","0","Spawn 6 troll bombs every time you get hit#These are effected by bomb items"},
{"372","0","Random chance to drop a battery or freeze all enemies in the room#chance to add one charge to your spacebar item"},
{"373","0","+25% damage up for every tear that successfully hits an enemy(max. +100%)"},
{"374","0","Random chance to fire a Holy tear, which will spawn a Crack the Sky light beam on hit"},
{"375","0","Random chance to deflect tears#Get immune to explosions/Stomps from mom's foot"},
{"376","0","Shops instantly restock their items when you buy them"},
{"377","0","Spider enemies no longer target or deal contact damage to Isaac"},
{"378","0","Firing tears for 3 seconds drops a Butt Bomb"},
{"379","0","Tears have a much larger hitbox#+spectral tears"},
{"380","0","+5 coins#You can open doors with coins instead of keys"},
{"381","0","+0.7 Tears Up#Gives you a random item at the start of your next run"},
{"382","0","Can be thrown at enemies to capture them#Next usage will re-spawn the same enemy as a friendly companion"},
{"383","0","Detonate any tears currently on the screen and cause each one to split into 6 more tears which will fire in a circle"},
{"384","0","Will charge around the room dealing contact damage to enemies"},
{"385","0","Picks up any near-by coins. Every 6 coins it levels up, except for level 4 which takes 12 coins#Level 2: can drop random pickups#Level 3: It now fires tears in the same direction as Isaac#Level 4: no longer fires tears but will chase enemies. will also randomly drop bombs#after Level 4: will continue collect coins and drop random pickups"},
{"386","0","Re-rolls any rocks into another random type of object (e.g. poop, pots, TNT, red poop, stone blocks etc.)"},
{"387","0","Creates a huge aura of light that slows down enemies inside of it"},
{"388","11","Collects keys, giving random chests in return"},
{"389","0","Drops a random rune every 3 rooms"},
{"390","0","Fires Sacred Heart tears"},
{"391","0","Every time Isaac takes damage, a charm effect is applied to every enemy in the room"},
{"392","0","Will give you a random zodiac item effect that changes after every floor"},
{"393","0","Random chance to poison enemies#deal poison damage on contact#Enemies that were poisoned have a chance to drop a black heart on death"},
{"394","0","Fire tears automatically directed at a red target on the ground which is controlled by the player#+0.7 Tears Up#+0.3 Tear Height#+3.15 Range Up"},
{"395","0","Gain the ability to charge and fire a laser ring that travels across the room"},
{"396","0","Creates up to two portals to travel between them"},
{"397","0","Isaac's tears now travel directly forwards following a beam of light, but will also move sideways based on your player movement#+0.5 Tears Up#+5.25 Range Up#+0.16 Shot Speed Up#+0.5 Tear Height"},
{"398","0","Tears now have a chance to apply a shrinking effect#Shrunk enemies can be crushed and killed by walking over them"},
{"399","0","+1.0 Damage Up#+0.5 Tear Height#After firing tears for 3 seconds, a red cross appears on Isaac's head that, upon releasing the fire button, creates a black ring dealing damage to enemies inside it# Enemies killed with the black ring have a chance to drop Black hearts"},
{"400","0","Spawns a spear in front of you which deals damage equal to 2 times your tear damage"},
{"401","0","Tears now have a chance to become sticky bombs, which will attach to enemies and explode after a few seconds"},
{"402","0","Pedestals will now be choosen from random itempools# On pick up also drops 1-6 random pickups"},
{"403","13","Allows you to see your tear damage and the health bars of all enemies#Inflicts a random status effect on contact#Will randomly drop batteries"},
{"404","0","Blocks tears#If a tear hits it, it will fart, which deals damage to nearby enemies and charms them"},
{"405","0","Applies a random status effect to any enemies it comes into contact with"},
{"406","0","Rerolls your stats#Will only effect damage, tears, range and speed stats"},
{"407","0","Purity will boost one of Isaac's stats depending on the colour of the aura around him#When you take damage,you will get a new aura#Red = +4.0 Damage#Blue = -4 Tear Delay#Yellow = +0.5 Speed Up#Orange = +7.5 Range Up"},
{"408","0","When you take damage, a black ring will appear around Isaac that damages any enemies in contact with it#Enemies killed with it have a chance to drop a black heart"},
{"409","0","+2 Black Hearts#When Isaac has no red hearts, this item gives Isaac the ability to fly and chance to trigger a shield"},
{"410","0","While firing tears this item gives you a chance to fire an eye across the screen which fires tears in the same direction as Isaac"},
{"411","0","Each time Isaac kills an enemy, temporary damage up for the current room#maximum of +5 Damage Up after 9 kills"},
{"412","0","After taking enough damage, Isaac gains a permanent demon familiar"},
{"413","0","After picking up enough hearts, Isaac gains a permanent angelic familiar"},
{"414","0","Two items now spawn in each of the item rooms. You can only choose one."},
{"415","0","+2 Soul Hearts#Damage X 2 if you don't have any empty red heart containers"},
{"416","0","Allows you to carry two cards/pills/runes"},
{"417","0","Bounces around the room with a damaging aura, dealing damage to any enemies inside#While standing in the aura, +50% damage multiplier"},
{"418","0","Gives you a different tear effect with every tear that you fire"},
{"419","0","Teleports you to another random room that has not been explored yet#Hirarchy: Normal Rooms,Super Secret Room, Shop, Item Room, Secret Room, Curse Room, Sacrifice Room, Devil/Angel Room, I Am Error"},
{"420","0","Walking in a circle will spawn a pentagram symbol on the floor, which deals 10 damage per tick"},
{"421","0","Applies charm effect to any enemies in close range"},
{"422","0","Rewind time and put you back in the previous room, in the same state you were in at that moment"},
{"423","0","Gives Isaac a large halo around him, deals contact damage#Chance to reflect enemy bullets"},
{"424","0","All pickups have a chance to be replaced with a sack"},
{"425","0","Gives Isaac a cone of light in front of him that slows any enemies inside it and their tears"},
{"426","0","Follows your exact movement on a 3 second delay#deals contact damage to enemies"},
{"427","0","Places a pushable TNT barrel#If used a second time in the same room while the last TNT barrel is still there, it will remotely explode the TNT"},
{"428","0","+4 Soul Hearts#Fully restores your red health"},
{"429","0","Tears have a chance to drop pennies on the floor upon successfully hitting an enemy"},
{"430","0","Follows your movement pattern on a 3 second delay#fires tears at nearby enemies that deal damage equal to Isaac's tear damage"},
{"431","0","Follows your movement pattern on a 3 second delay#Isaac's tears that pass through the baby will double up and increase in damage"},
{"432","0","Bombs drop random pickups when they explode (e.g. keys, coins, bombs)"},
{"433","0","Each time you take damage, My Shadow will apply a fear effect to all enemies in the room and spawn a familiar black charger that will attack for you#The charger will be killed if it is damaged too much"},
{"434","0","Every time you kill an enemy a blue fly will be added to the Jar#stacks up to 20 flies#Using the Jar of Flies will release all the flies"},
{"435","0","Shoots 4 tears in a cross pattern"},
{"436","0","After taking damage, the milk gives you a Tears Up for the rest of the room"},
{"437","0","Respawn all enemies, enabling you to farm rewards that spawn after beating the room# If used in a greed fight, it can be used to reroll the room into a Shop"},
{"438","0","+1 Soul heart#+0.7 Tears Up#Makes Isaac very small, reducing his hitbox size"},
{"439","0","Will drop a random trinket on the ground#+1 Luck while held#While held, doubles the effect of trinkets"},
{"440","0","Randomly while firing you will stop firinf and release a burst of tears and a kidney stone#-0.2 Speed Down#-15 Range Down#+2.0 Tear height"},
{"441","0","Fires a huge Mega Satan laser for 15 seconds# The laser persists for the entire 15 seconds even between rooms and floors"},
{"442","0","While at 1 full red heart, you get double damage"},
{"443","0","Randomly fire razor blades which deal 400% damage#+0.4 Tears Up"},
{"444","0","Every 15 tears fired, you fire a cluster of tears#Each tear in the cluster deals double damage"},
{"445","0","+0.3 Damage Up#+0.1 Speed Up#A wolf howls, if you enter a room next to a secret room or with a trapdoor in it"},
{"446","0","While firing, you get a green aura that poisons any enemies in it"},
{"447","0","While firing, randomly spawns a poop cloud"},
{"448","0","When taking damage, chance to get +5 Range and leave a trail of blood creep"},
{"449","0","+1 Soul Heart#Enemy bullets have a chance to be deflected"},
{"450","0","Tears can turn enemies into gold"},
{"451","0","Drops random card or rune on pickup#Doubles the use of any tarot card used"},
{"452","0","Every time you take damage fire 10 high damage tears in a circle around you"},
{"453","0","Bone tears#Tears shatter into 1-3 smaller bone shards upon hitting anything#+1.5 Range Up"},
{"454","0","You can carry two cards, runes or pills#Drops random card, pill or rune on pickup"},
{"455","0","+1.5 Range Up#Drops a lucky penny"},
{"456","0","+1 Health Up"},
{"457","0","+1 Soul Heart#Chance to ignore damage"},
{"458","0","Drops one random trinket on pickup#+Extra trinket slot"},
{"459","0","Sticky poison Tearsuntil they die"},
{"460","0","Chance to fire Concussive tears"},
{"461","0","Chance to fire sticky slowing tears#spawns blue spider/fly on hit"},
{"462","0","Chance to fire piercing tears##After hitting the first enemy, the tear deals double damage and gains a homing effect"},
{"463","0","+0.3 Damage Up#Chance to fire rock destroying tears"},
{"464","0","+2 Soul Hearts#[Effect unknown]"},
{"465","0","-2 Tear Delay (Tears up)#Allows you to fire tears diagonally by fireing in two directions"},
{"466","0","First killed enemy in the room will explode and poison all nearby enemies"},
{"467","0","Deals constant low damage to enemies in the same direction"},
{"468","0","Follows your movement#delayed by 3 seconds#deal contact damage"},
{"469","0","Leaves Trail of tears#Enemies touching the cloud can activate the Crack the Sky effect"},
{"470","0","Bounces around the room#deals contact damage#While firing tears it will stop moving"},
{"471","0","Charges its shots#Shotgun attack#(Similar to monstros lung)"},
{"472","0","Other familiars follow it#Stops moving while  firing tears#Will teleport back to you when you stop firing"},
{"473","0","Charges forwards very slow#deals contact damage"},
{"474","0","[Effect unknown]"},
{"475","0","SINGLE USE!#Deals 9,999,999 damage to all enemies and kills you 3 seconds later"},
{"476","0","Spawns 1-3 friendly blue flies/spiders#Rerolls pickups into blue flies/spiders"},
{"477","0","When used, consume any pedestal items in the room#Active item: Its effect will be added to Void's effect (Stacking the effects)#Passive item: Small stat upgrade to random stat"},
{"478","0","Freezes all enemies in the room until you press the fire button again#Touching a frozen enemy will hurt you"},
{"479","0","Consumes your trinket and gives you the effect permanently"},
{"480","0","Spawns 1 blue fly/spider for every pickup in the room"},
{"481","0","When used, +/- small amount on random stat#Random tear effect for current room#Fucks up all sprites"},
{"482","0","Changes you into a random Character#50% Chance to loose most recent item"},
{"483","0","SINGLE USE!#Affects whole floor#Explodes all objects#Deals 200 damage to all enemies#opens boss rush / hush door / secret rooms"},
{"484","0","Upon use, pushes enemies away and causes a wave of rocks"},
{"485","0","50% chance to double all items, consumables and chests in room#50% chance to remove items / pickups in room (spawns 1 coin)"},
{"486","0","Hurts you without damaging you#Can trigger itemeffects"},
{"487","0","Removes one red heart container and gives you +0.2 Damage Up and Cube of Meat"},
{"488","0","Gives you random a itemeffect for the room"},
{"489","0","Random Diceeffect"},
{"490","0","SINGLE USE!#spawns 2 random item pedestals"},
{"491","0","Drops a random pill every 2 rooms#Using a pill damages enemies"},
{"492","0","+1 Luck Up#Highlight the location secret room, tinted rocks or trapdoors"},
{"493","0","For every empty heart container gain +0.2 Damage Up"},
{"494","0","Electric tears#Spawns 1-2 sparks of electricty on hit"},
{"495","0","Chance to shoot Fire instead of tears"},
{"496","0","Chance to fire needles"},
{"497","0","Get camouflaged when entering a room until you fire tears"},
{"498","0","Spawns Devil AND Angelroom doors#When entering one, the other disappears"},
{"499","0","100% chance to find an Angel Room"},
{"500","0","Randomly drops a sack"},
{"501","0","Gives you 1 heart container for every 25 coins"},
{"502","0","Chance to fire a Creep leaving tear"},
{"503","0","Chance to fire tears that instantly kill enemies"},
{"504","0","Spawns a fly turret that shoots at enemies"},
{"505","0","Randomly spawns a charmed enemy when entering a hostile room"},
{"506","0","Tears can cause a bleeding, which deals 10% damage of the enemys total health every 5 seconds."},
{"507","0","Deals 25% damage of their maximum life to all enemies"},
{"508","0","Orbital that causes bleeding, which deals 10% damage of the enemys total health every 5 seconds."},
{"509","0","Shoots a tear every 2 seconds in random direction"},
{"510","0","Spawns a white delirium version of a boss for current room"},
{"511","0","Orbits around a random enemy until that enemy dies#Deals contact damage"},
{"512","0","Throwable black hole, which sucks in everything"},
{"513","0","+0.1 Damage Up#+1 Soul Heart#Random chance to charm/fear an enemy#Random chance to spawn a rainbow poop upon taking damage"},
{"514","0","Causes random enemies to 'lag' at random intervals, causing them to shortly freeze in place"},
{"515","0","SINGLE USE!#Spawns a random item from the current room's item pool#Chance to spawn Lump of Coal or The Poop instead"},
{"516","0","Spawns a Sprinkler that rotates in a circle, spraying tears in all directions"},
{"517","0","+7 Bombs#Allows you to rapidly place bombs on the ground"},
{"518","0","Gives you a random familiar which looks like a random coop Baby#Will be randomized again every floor"},
{"519","0","A familiar that transforms into other random familiars every 10 secs"}
}

local trinketdescriptions={{"1","Drop coins when you get hit"},
{"2","More drops from poop"},
{"3","-1 charge needed for spacebar items"},
{"4","Randomly teleports you, when using an item"},
{"5","More champion enemies#higher chance for boss challange rooms"},
{"6","Coin magnet"},
{"7","Higher angel room chances"},
{"8","Chance for Gamekid effect on hit"},
{"9","Wobble tears#Only affects hitbox"},
{"10","Tears move in waves"},
{"11","Tears move in spirals"},
{"12","Bigger tears"},
{"13","One shop item for free"},
{"14","Spikes / Creep don't damage you anymore"},
{"15","Destroying rocks spawns coins"},
{"16","Mom's foot stomps enemies every 60 seconds"},
{"17","More black hearts"},
{"18","More eternal hearts"},
{"19","Unlock golden chests without keys"},
{"20","When on half a heart, spawns a black heart#3 time usage"},
{"21","Imitates Polaroid, the negative and missing page"},
{"22","Convert drops:#Hearts to pickups"},
{"23","Respawn as the lost when dying in sacrifice room"},
{"24","Fart when picking up coins"},
{"25","Randomly spawn poop "},
{"26","Tears move in angular patterns"},
{"27","+0.5 Shot Speed up"},
{"28","Chance to respawn as blue baby"},
{"29","Spawn a blue fly when getting hit"},
{"30","Randomly shoot poison tears"},
{"31","Randomly shoot piercing tears"},
{"32","Random mushroom effect per room"},
{"33","When down to half a heart, you get little steven"},
{"34","More red hearts drop"},
{"35","+2 Damage up"},
{"36","More chests and keys appear"},
{"37","+0.15 Speed up"},
{"38","More soul hearts drop"},
{"39","Tears up"},
{"40","Chance to get +1.8 Damage up when getting hit"},
{"41","More Bombs appear#Removes \"The Tick\""},
{"42","+1 Luck up"},
{"43","When damaged down to half a heart, teleport to last visited room"},
{"44","More pills appear"},
{"45","More cards appear"},
{"46","Chance for healing half a heart after clearing a room"},
{"47","<unused>"},
{"48","When getting hit, chance to get necronomicon effect"},
{"49","Drop half a heart when picking up coins"},
{"50","Drop bombs when picking up coins"},
{"51","Drop keys when picking up coins"},
{"52","Chance to get extra coin when picking up coins"},
{"53","-15% boss-health#Restore 1 red heart when in boss room"},
{"54","Familiar with piercing tears"},
{"55","Get one ethernal heart when starting a new floor"},
{"56","Reduces devil deal prices"},
{"57","Familiar that bounces around the room#shoots in the same direction as the player"},
{"58","Chance for +0.5 Damage up when killing an enemy"},
{"59","25% chance to reveal map icons at start of new floor"},
{"60","Chance to spawn a dead bird when killing an enemy"},
{"61","Turns chests into red chests"},
{"62","Crawlspace rocks and tinted rocks blink every 60 secs"},
{"63","Turns troll bombs into bombs"},
{"64","Random worm effect"},
{"65","Range X 2"},
{"66","-0.4 Shoot Speed down#+4 Range up"},
{"67","Random dice effect when getting hit"},
{"68","Magnet for pickups"},
{"69","Randomly camouflages player#confuses enemies"},
{"70","Chance to spawn a spider while in a hostile room"},
{"71","Bombs leave creep"},
{"72","More batteries drop"},
{"73","Exploding bombs can drop bombs"},
{"74","More Crawspaces appear"},
{"75","Random trinket effect every room"},
{"76","50/50 chance for extra pickups OR nothing/enemy from chests"},
{"77","Increases knockback"},
{"78","Longer status effects"},
{"79","Chance when using pills/cards to drop a copy of the pill/card"},
{"80","+0.2 Damage up for each evil item held"},
{"81","Invincibility lasts longer"},
{"82","+15% to get double item room on next floor"},
{"83","Opens shops for free"},
{"84","Greed/Super Greed no longer appear in shops"},
{"85","Using a Donation machine can heal you or spawn a beggar"},
{"86","Destroying poop spawns a blue fly"},
{"87","Heal half a heart when you use keys#Half hearts spawn as full hearts"},
{"88","Very low chance for spacebar items in item rooms"},
{"89","Familiars get closer together"},
{"90","Poop explodes when destroyed"},
{"91","Increases chance for Black Poops to spawn"},
{"92","Random stat increases while held"},
{"93","Fly enemies are friendly"},
{"94","Doubles all blue Fly / Spider spawns"},
{"95","Randomly shoot poison Tooth tears"},
{"96","Tears move quickly in a spiral pattern"},
{"97","Chance to get a familiar when getting damaged#Up to +2 Familiars possible"},
{"98","Chance to shoot sticky poison tears"},
{"99","Chance to shoot bouncy tears"},
{"100","+1 to all stats while holding a fully charged active item"},
{"101","+0.5 Speed, +1.5 Range, +0.3 Shot Speed, +0.4 Tears, +1.5 Damage when holding an uncharged active item"},
{"102","+1 extra secret room per floor while held"},
{"103","Half consumables can turn into full ones"},
{"104","Chance to spawn a pedestal item when getting hit#Gets destroyed afterwards"},
{"105","Chance to spawn a health up item when getting hit#Gets destroyed afterwards"},
{"106","Increases the radius of any creep you produce"},
{"107","Damage taken will ignore spirit / black hearts, causing your red heart containers to be depleted first"},
{"108","Drops random pickup / trinket when getting hit#Gets destroyed afterwards"},
{"109","Causes any orbitals you have to stop moving"},
{"110","Shops will now appear in the womb"},
{"111","Item rooms now appear in the womb"},
{"112","Restock boxes will always spawn in item rooms"},
{"113","Spawn an exploding attack fly when entering a hostile room"},
{"114","Spawn a poisioning attack fly when entering a hostile room"},
{"115","Spawn a slowing attack fly when entering a hostile room"},
{"116","Spawn an attack fly that deals double your damage when entering a hostile room"},
{"117","Spawn an attack fly that deals double your damage when entering a hostile room"},
{"118","Chance to grow wings after taking damage#Persists for the rest of the room"},
{"119","Heals half a heart after travelling down to the next floor"},
{"120","Fully recharges your active item at the start of a boss fight"},
{"121","Protects you from the first damage you take for every floor"},
{"122","Using your active item will drop it back on a pedestal on the ground"}
}

local cardDescriptions={{"1","Teleports you back to the start"},
{"2","Homing tears for current room"},
{"3","Moms Foot stomps on an enemy!"},
{"4","+Damage & +Speed for current room"},
{"5","Teleports you to the bossroom"},
{"6","Drops 2 Soulhearts"},
{"7","Drops 2 red hearts"},
{"8","Invincibility + contact damage"},
{"9","Spawns 1 bomb, 1 key, 1 coin, 1 heart"},
{"10","Teleports you to the shop"},
{"11","Spawns a Slot / Fortune Machine"},
{"12","+1 Health Up#+0.3 Damage Up#+0.3 Speed Up#for current room"},
{"13","Fly for current room"},
{"14","Deals 40 damage to all enemies in the room"},
{"15","Spawns a Blood Donation Machine"},
{"16","+2 damage up for current room"},
{"17","Spawns troll bombs"},
{"18","Teleports you to the item room"},
{"19","Teleports you to the secret room"},
{"20","Deals 100 damage to all enemies#Full heal#reveals entire map"},
{"21","Spawns a beggar"},
{"22","Reveals the map and shows the icons"},
{"23","Duplicate your Bombs"},
{"24","Duplicate your Money"},
{"25","Duplicate your Keys"},
{"26","Duplicate your red hearts"},
{"27","Turns all pickups into Bombs"},
{"28","Turns all pickups into coins"},
{"29","Turns all pickups into keys"},
{"30","Turns all pickups into hearts"},
{"31","Teleports you to the devil / angel room"},
{"32","Destroy all rocks in the room"},
{"33","Duplicate all pickups in room"},
{"34","Spawns a trapdoor"},
{"35","+1 Soul heart#Removes curse effects"},
{"36","Full mapping for this floor"},
{"37","Reroll all pedestal items"},
{"38","Summons 3 blue spiders and 3 blue flies"},
{"39","Invincibility for 30 seconds"},
{"40","Random rune effect"},
{"41","Deals 40 damage to all enemies#Random stat up for every pedestal items in the room#(Destroys all pedestals in room)"},
{"42","Throwable instant kill-card"},
{"43","Removes the price from all items in the current shop or devil deal, making everything free"},
{"44","Displays \"helpful\" tips on use"},
{"45","Fills the whole room with poop"},
{"46","Instantly kills you and spawns 10 pickup / Collectibles on the floor."},
{"47","Open all doors in the current room"},
{"48","Activates your spacebar item for free"},
{"49","Rerolls pedestals and pickups in current room"},
{"50","Two of Mom's Hand come down and grab an enemy"},
{"51","Grants the Holy Mantle effect for one room#(Next damage you take is 0)"},
{"52","+7 Damage Up#+30 Range Up#+Size up#Effect lasts for current room"},
{"53","Spawns 3 random cards when used"},
{"54","Slow down enemies and Isaac's tears and gives a Speed up#Effect lasts for current room"}}

function table.load( sfile )
	local ftables,err = loadfile( sfile )
	if err then return _,err end
	local tables = ftables()
	for idx = 1,#tables do
		local tolinki = {}
		for i,v in pairs( tables[idx] ) do
			if type( v ) == "table" then
				tables[idx][i] = tables[v[1]]
			end
			if type( i ) == "table" and tables[i[1]] then
				table.insert( tolinki,{ i,tables[i[1]] } )
			end
		end
		for _,v in ipairs( tolinki ) do
			tables[idx][v[2]],tables[idx][v[1]] =  tables[idx][v[1]],nil
		end
	end
	return tables[1]
end 
	
function printDescription(desc)
	Description = desc[3]
	textboxWidth=tonumber(config["TextboxWidth"])
	local temp = config["YPosition"]
	if not(desc[2]=="0") then
		if config["TransformationText"]=="true" then
			if config["TransformationIcons"]=="true" then
				Isaac.RenderText(printTransformation(desc[2]), config["XPosition"]+16, temp, 0.5, 0.5, 1, config["Transparency"])
			else
				Isaac.RenderText(printTransformation(desc[2]), config["XPosition"], temp, 0.5, 0.5, 1, config["Transparency"])
			end
		end
		if config["TransformationIcons"]=="true" then
			local sprite = Sprite()
			sprite:Load("gfx/icons.anm2", true)
			sprite:Play(printTransformation(desc[2]))
			sprite:Update()
			sprite:Render(Vector(config["XPosition"]+5,temp+5), Vector(0,0), Vector(0,0))
		end
	temp = temp+10
	end
	for line in string.gmatch(Description, '([^#]+)') do
		local array={}
		local text = ""
		for word in string.gmatch(line, '([^ ]+)') do
			if string.len(text)+string.len(word)<=textboxWidth then
				text = text.." "..word
			else
				table.insert(array, text)
				text = word
			end
		end
		table.insert(array, text)
		for i, v in ipairs(array) do
			if i== 1 then 
					Isaac.RenderText("-"..v, config["XPosition"], temp, 1, 1, 1, config["Transparency"])
			else
					Isaac.RenderText("  "..v, config["XPosition"], temp, 1, 1, 1, config["Transparency"])
			end
			temp = temp +10
		end
	end
end
function printTrinketDescription(desc)
	Description = desc[2]
	textboxWidth=tonumber(config["TextboxWidth"])
	local temp = config["YPosition"]
	for line in string.gmatch(Description, '([^#]+)') do
		local array={}
		local text = ""
		for word in string.gmatch(line, '([^ ]+)') do
			if string.len(text)+string.len(word)<=textboxWidth then
				text = text.." "..word
			else
				table.insert(array, text)
				text = word
			end
		end
		table.insert(array, text)
		for i, v in ipairs(array) do
			if i== 1 then 
					Isaac.RenderText("-"..v, config["XPosition"], temp, 1, 0.8, 0.8, config["Transparency"])
			else
					Isaac.RenderText("  "..v, config["XPosition"], temp, 1, 0.8, 0.8, config["Transparency"])
			end
			temp = temp +10
		end
	end
end
function printTransformation(S)
--Transformations: 0=none, 1=guppy,2=mushroom,3=lord of the flies, 4=conjoined,5= junkie(Spun),6=mom,7=poopboy(oh crap),8=bob,9=leviathan,10=Seraphim,11=super bum,12=bookworm,13=Spider boy,
	local transformations = {"","Guppy","Fun Guy","Lord of the Flies","Conjoined","Spun","Mom","Oh crap","Bob","Leviathan","Seraphim","Super Bum","Bookworm","Spider Baby"}
	local str="Custom";
	for i = 0, #transformations-1 do
		if (tonumber(S)==i) then
			str = tostring(transformations[i+1])
		end
	end
	return str
end



--[[ function loadDescriptions()
	file = io.open("enUS-Itemlist.txt", "r")
	--local file = io:open(filepath..config["Language"].."-Itemlist.txt", "r")
	local array = {};
	array[999]={1,2,3}
	for line in file:lines() do
	  if not(string.sub(line, 0,1)=="#") then
		local subarray = {};
		local id = 0;
		local i = 0; 
		for word in string.gmatch(line, '([^|]+)') do
		  -- remove leading space if it exists
		  if string.sub(word, 0,1)==" " then 
			word = string.sub(word, 2)
		  end
		  -- get item ID
		  if i==0 then 
			id= tonumber(word)
		  end
		  -- get transformations
		  subarray[i]=word
		  i=i+1
		end
		array[id]=subarray
	  end
	end
	return array
end]]-- 

function HasCurseBlind()
	local num = Game():GetLevel():GetCurses()
    local t={}
    while num>0 do
        rest=num%2
        t[#t+1]=rest
        num=(num-rest)/2
    end
    
	return #t>6 and t[7]==1 
end

local function onRender(t)
	--Load Itemlist
	--local descriptions = loadDescriptions()

	--printTransformation(descriptarray[answer][1]+1)
	
	--print("Description: ")
	--printDescription(descriptarray[answer][2])
	
	
	
	if HasCurseBlind() and config["EnableOnCurse"]=="false" then
		return
	end
	local player = Isaac.GetPlayer(0)
	local closest = nil;
    local dist = 10000;
	for i, coin in ipairs(Isaac.GetRoomEntities()) do
		if coin.Type == EntityType.ENTITY_PICKUP and (coin.Variant == PickupVariant.PICKUP_COLLECTIBLE or coin.Variant == PickupVariant.PICKUP_TRINKET or coin.Variant == PickupVariant.PICKUP_TAROTCARD) and coin.SubType>0  then
			local diff = coin.Position:__sub(player.Position);
                if diff:Length() < dist then
                    closest = coin;
                    dist = diff:Length();
                end  
		end
    end 
	
	if dist/40>tonumber(config["MaxDistance"]) then
		return
	end
    if closest.Type == EntityType.ENTITY_PICKUP then
		if closest.Variant == PickupVariant.PICKUP_TRINKET then
			if closest.SubType < 123 then
				printTrinketDescription(trinketdescriptions[closest.SubType])
			else
				Isaac.RenderText("[Effect not defined]", config["XPosition"], config["YPosition"], 1, 0.5, 0.5, config["Transparency"])
			end
			
		elseif closest.Variant == PickupVariant.PICKUP_COLLECTIBLE then
			if closest.SubType < 520 then
				printDescription(descriptarray[closest.SubType])
			else
				Isaac.RenderText("[Effect not defined]", config["XPosition"], config["YPosition"], 1, 0.5, 0.5, config["Transparency"])
			end
		elseif closest.Variant == PickupVariant.PICKUP_TAROTCARD then 
			if closest.SubType < 55 then
				if not(config["DisplayCardInfo"]=="false") and not(closest:ToPickup():IsShopItem() and config["DisplayCardInfoShop"]=="false") then
					printTrinketDescription(cardDescriptions[closest.SubType])
					local sprite = Sprite()
					sprite:Load("gfx/cardfronts.anm2", true)
					sprite:Play(tostring(closest.SubType))
					sprite:Update()
					sprite:Render(Vector(config["XPosition"]+2,config["YPosition"]+12), Vector(0,0), Vector(0,0))
				end
			else
				Isaac.RenderText("[Effect not defined]", config["XPosition"], config["YPosition"], 1, 0.5, 0.5, config["Transparency"])
			end
		end
		
	end
end
EID:AddCallback(ModCallbacks.MC_POST_RENDER, onRender)