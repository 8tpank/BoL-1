local version = "1.04"
local SCRIPT_NAME = "TheRakaReturns"

require 'VPrediction'
--require "spellList"
AvoidBugsplats = false
AvoidBugsplats = not AvoidBugsplats
----------------------------------------------
----------------------------------------------
--             THE RAKA RETURNS             --
--             THE RAKA RETURNS             --
--             "This is my path."           --
--             By Tc2r                      --
--             With Help and base           --
--             From VictorGrego             --
--             THE RAKA RETURNS             --
----------------------------------------------
----------------------------------------------
--  Features:                               --
--         Auto Level Abilities             --
--         Auto Starcall (Q)                --
--        *Auto Heal (W)                    --
--         Auto Equinox (E)                 --
--         Auto Ult [M]                     --
--        *Auto Warding                     --
--         Avoid hitting enemy under turret --
--        *Auto Buy items                   --
--         6 different itemization builds   --
--        *Auto potion usage                --
--        *Auto Enemy avoidance             --
--        *Auto Farming                     --
--        (Wave Clear and last hitting)     --
--        *Greetings                        --
----------------------------------------------
----------------------------------------------
-- The Raka Returns is a script used to     --
-- automate all of soraka's actions based on-- 
-- conditions, allowing for easy            --
-- afk leveling, autoleveling and referral  --
-- botting.                                 --
-- The Raka Returns can be used manually    --  
-- by fine tuning the options presented in  --
-- the menu.                                --
-- The Default settings are the optimal     --
-- options for afk autoleveling.            --
----------------------------------------------
----------------------------------------------
--  Menu Controls                           --
--  
--  HealMode 1-3
-- If Healmode 1 then just heal any ally who is hurt, period, allow space for minion damage - Norm
-- If Healmode 2 then heal whenever ally is at HEAL_Threshhold % alive and it would fully heal him. - Smart
-- If Healmode 3 then heal whenever anyone allies health falls below the HEAL_threshold, period. - Safe
----------------------------------------------
--  UltMode 1-2
-- If UltMode 1 Soraka Only Ults When A Nearby Ally Is Hurt
-- If UltMode 2 Soraka Heals anyone below the Ult Threshold Globally
----------------------------------------------
-- Autofarm 1-2
-- If Last hit the bot will attempt to take minions of which soraka's autoattack could kill
-- If Waveclear the bot will attempt to take minions of which soraka's autoattack*3 could kill
-- Simulation mode Makes the bot randomly move around like a player, as well as fleeing from enemies who are "too close"
-- (Perfect for convincing coop allies you're not a bot), (turn off sim mode if you are using it manually)
----------------------------------------------
--Changelog:

---------------------------
--[[ MENU AND INITATIONS]]--


--[[ MENUS AND INITATIONS]]--
---------------------------
_G.DEFAULT_AUTO_BUYITEMS = true -- buy items auto
_G.DEFAULT_AUTO_LEVEL = true -- automatically lvl up
_G.DEFAULT_AUTO_Q = true -- Auto Use Spell
_G.DEFAULT_AUTO_W = true -- Auto Use Spell
_G.DEFAULT_AUTO_E = true -- Auto Use Spell
_G.DEFAULT_AUTO_R = true -- Auto Use Spell
_G.DEFAULT_EVILRAKA = true -- Soraka Torments her enemies with taunts/laughs/insults/comments(future update)


--[[ Amount of mana, hp soraka must have before using Infusion to Heal, Healmode is amount of life her target must be at]]
--[[ Heal Mode determines how Soraka will use allies. ]]
--Heal Mode 1 means Soraka will heal anyone who is below full life.
--Heal Mode 2 means soraka will heal with a priority on who needs it more
--heal Mode 3 means that Soraka will only heal when someoen is below the threshhold
_G.DEFAULT_HEAL_MODE = 3
_G.DEFAULT_HEAL_THRESHOLD = 60 -- for healMode 3, default 60 (60%)
_G.DEFAULT_HEALHP_THRESHOLD = 45 -- The percent of hp soraka must have to use heal
_G.DEFAULT_HEALMANA_THRESHOLD = 20 -- the percent of mana soraka must have to use heal
--[[Starcall Amount of mana soraka must have before using starcall to harasss]]

_G.DEFAULT_ULT_ENABLE = true -- 
_G.DEFAULT_ULT_MODE = 1 -- 1 = lane partner, 2 = any ally
_G.DEFAULT_ULT_THRESHOLD = 10 --percentage of hp soraka/ally/team must be at or missing for ult, eg 10 (10%)

--AUTO FARMING OPTIONS
_G.DEFAULT_AUTO_FARM = true -- Auto Farm Minions?
_G.DEFAULT_FARM_MODE = 1 --Default Farm mode, Last Hit Only = 1, Wave Clear = 2, Sololane = 3
_G.DEFAULT_FARM_SIMS = true -- True = she random clicks and flees from enemies on her on.


_G.DEFAULT_DRINK_HPPOT = true --Will she drink health potions?
_G.DEFAULT_DRINK_HPPERCENT = 55 --at what percent of hp will she drink
_G.DEFAULT_DRINK_MPPOT = true --Will she drink health potions?
_G.DEFAULT_DRINK_MPPERCENT = 60 --at what percentage consume potion

--Starcall Amount of mana soraka must have before using starcall to harasss
_G.DEFAULT_STARCALL_ENABLE = true --Will she auto harass with starcall?
_G.DEFAULT_STARCALL_UNDERTOWER = true -- will she harass enemies under their tower
_G.DEFAULT_STARCALL_MIN_MANA = 10 --Starcall will not be cast if mana is below this Percent

-- ENABLE EQUINOX, HOW MUCH MANA LEFT BEFORE NOT USING IT
_G.DEFAULT_EQUINOX_ENABLE = true --Will she auto harass with starcall?
_G.DEFAULT_EQUINOX_MIN_MANA = 20 -- Equinox will not be cast if mana is below this Percent
_G.DEFAULT_EQUINOX_UNDERTOWER = true -- Will she harass enemies under their tower
-- SUMMONER SPELL SPECIFICS

_G.DEFAULT_AUTOHEAL = true --Will she use summoner Heal
_G.DEFAULT_HEALTH_HEAL = 17 --Minimal % of hp to cast Heal

_G.DEFAULT_AUTOBARRIER = true --Will she use summoner Barrier
_G.DEFAULT_HEALTH_BARRIER = 19 --Minimal % of hp to cast Heal


_G.DEFAULT_AUTOCLARITY = true --Will she auto harass with starcall?
_G.DEFAULT_MANA_CLARITY = 30 -- Minimal % of mana to cast Clarity

_G.DEFAULT_AUTOGHOST = true --Will she auto harass with starcall?

_G.DEFAULT_AUTOIGNITE = true --Will she auto harass with starcall?

_G.DEFAULT_AUTOCLENSE = true --Will she auto harass with starcall?

_G.DEFAULT_AUTOPROMOTE = true --Will she auto harass with starcall?

_G.DEFAULT_AUTOCLAIR = true --Will she auto harass with starcall?

_G.DEFAULT_AUTOEXHAUST = true --Will she auto harass with starcall?
_G.DEFAULT_HEALTH_EXHAUST = 15 --Minimal % of hp of enemy to cast exhaust


---THIS CONTROLS WHAT SORAKA WILL AUTOLVL WHEN AUTOLEVEL IS SET TO TRUE
_G.levelSequence = {_W,_Q,_E,_W,_W,_R,_Q,_E,_W,_E,_R,_E,_E,_W,_Q,_R,_Q,_Q,}

--She will NOT buy 2 of the same items in a rowput your custom shop list here if thats what you want
-- GO TO http://loldevelopers.de.vu/   FOR ITEM ID NUMBERS.
_G.DEFAULT_CUSTOMBUY = false
_G.customShopList = {
        3303, -- spellthiefedge
        2003, -- health potion
        3340, -- warding trinklet
        2003, -- health potion
        2004, -- mana potion
        2003, -- health potion
		1004, -- WHY YOU KEEP CRYING
		1027, -- IF YOU DONT STOP SPANKING!
		3070, -- OH GOD NOW YOU CRY LOUDER
		1027, -- WTF MAN YOU FLOODING MY PLACE
		1004, --
		1001, --bootsofspeed
		3009, --Swiftness Boots
		3211, --Cowl
		3065, --Spirit Visage
		3504, --Ardent Censer
		1057, --Negatron Cloak
		3001, --Abyssal Scepter
		3026, --Guardian Angel
	
	}
-- _G.DQUOTES is the time between kills in which soraka will say something to enemy team
-- You may add your own lines of comments /insults here, just make sure to put a proper ',' between them. 
_G._G.DQUOTES = 60 
_G.KillQuotes = {'/all I have lived for centuries, I will live past your attack.','/all you should have listened to the stars.','/all the stars scream of your ignorance.','/all idiot, did you think you could stand to my divine radiance.','/all like the stars, I can no longer hear your heart.','/all I could heal you, but I dont feel like it. ','/all pray we do not cross paths again, Pray to me!','/all your cruelty ends today.','/all you will go no further.','/all be at peace, fool.','/all such ugly in your hearts.','/all I will carry this.','/all you probably need an infusion.','/all run over by the wambulance.','/all death by banana.','/all no one expects the banana.','/all do you always fight so poorly? ','/all you do always fight so poorly?','/all do you always fight so poorly?','/all you do always fight so poorly?','/all so poorly?','/all always fight so poorly?','/all always fight so poorly?','/all I dont think ill save you.','/all I will not save you.','/all GG!','/all gg!','/all gg','/all there is no hope for you.','/all It is not in my nature to kill, but you were an exception.','/all that star few for thousands of years, just to kill you.','/all you overstep your boundaries, I am a God!','/all you will fall, like the stars, before me.','/all your star has fallen.','/all do you WISH to try me again?','/all your futile attempts amuse me.','/all give up now and I will tend your wounds.','/all you need a savior, instead you face one.','/all did you think you would escape?','/all get rakaed!'}

--------------------------
-- Encrypt Below Here Please --
local SOURCELIB_URL = "https://raw.github.com/TheRealSource/public/master/common/SourceLib.lua"
local SOURCELIB_PATH = LIB_PATH.."SourceLib.lua"
if FileExist(SOURCELIB_PATH) then
require("SourceLib")
else
DOWNLOADING_SOURCELIB = true
DownloadFile(SOURCELIB_URL, SOURCELIB_PATH, function() print("Required libraries downloaded successfully, please reload") end)
end
if DOWNLOADING_SOURCELIB then print("Downloading required libraries, please wait...") return end
if AUTOUPDATE then
SourceUpdater(SCRIPT_NAME, version, "http://pastebin.com/raw.php?i=", "5mCDCXra", SCRIPT_PATH .. GetCurrentEnv().FILE_NAME, "5mCDCXra"):CheckUpdate()
end
local RequireI = Require("SourceLib")
RequireI:Add("vPrediction", "https://raw.github.com/honda7/BoL/master/Common/VPrediction.lua")
--RequireI:Add("SOW", "https://raw.github.com/honda7/BoL/master/Common/SOW.lua")
RequireI:Check()
if RequireI.downloadNeeded == true then return end---------------------------


--[[
--UPDATE SETTINGS
local AutoUpdate = true
local SELF = SCRIPT_PATH..GetCurrentEnv().FILE_NAME
local URL = "http://pastebin.com/raw.php?i=5mCDCXra"..math.random(100)
local UPDATE_TMP_FILE = LIB_PATH.."TRRTemp.txt"
local versionmessage = "<font color=\"#81BEF7\" >Changelog:Minor optimizations</font>"
function Update()
DownloadFile(URL, UPDATE_TMP_FILE, UpdateCallback)
end
function UpdateCallback()
file = io.open(UPDATE_TMP_FILE, "rb")
if file ~= nil then
content = file:read("*all")
file:close()
os.remove(UPDATE_TMP_FILE)
if content then
tmp, sstart = string.find(content, "_G.version = \"")
if sstart then
send, tmp = string.find(content, "\"", sstart+1)
end
if send then
Version = tonumber(string.sub(content, sstart+1, send-1))
end
if (Version ~= nil) and (Version > tonumber(version)) and content:find("--EOS--") then
file = io.open(SELF, "w")
if file then
file:write(content)
file:flush()
file:close()
PrintChat("<font color=\"#6C2DC7\" >TheRakaReturns:</font> <font color=\"#00FF00\">Successfully updated to: v"..Version..". Please reload the script with F9.</font>")
else
PrintChat("<font color=\"#6C2DC7\" >TheRakaReturns:</font> <font color=\"#FF0000\">Error updating to new version (v"..Version..")</font>")
end
elseif (Version ~= nil) and (Version == tonumber(version)) then
PrintChat("<font color=\"#6C2DC7\" >TheRakaReturns:</font> <font color=\"#00FF00\">No updates found, latest version: v"..Version.." </font>")
end
end
end
end
]]

-- Champion Check
if myHero.charName ~= "Soraka" then return end
nBI = 1
lBy = 0
sBy = 1
bOrd = 0
pBld  = 0
bDly = 1000 --Buys an item every second
-- avoid spells
--UPDATE SETTINGS
local AutoUpdate = false
--function Update()
--DownloadFile(URL, UPDATE_TMP_FILE, UpdateCallback)
--end

function UpdateCallback()
end
-- Default Automode Controls, can be changed here or in game: 


local GLOBAL_RANGE = 0
local NO_RESOURCE = 0
local MAX_PLAYER_AA_RANGE = 850
local HEAL_DISTANCE = 1050
local HealthPotSlot
local ManaPotSlot
local FlaskSlot	
local farm = true
local dontfarm = false
local aaRange = 550
local qRange = 970
local QTimer = 0
local eRange = 925
local enemyMinions
local aaTick = 0 -- the timer of her auto attacks
local wardRange = 600 --Ward range is 600.
local scriptActive = true
local wardTimer = 0
local wardSlot = nil
local wardMatrix = {}
local wardDetectedFlag = {}
local lastWard = 0

local closeTower = nil
--Summoner Spells
local HL_Slot = myHero:GetSpellData(SUMMONER_1).name:find("summonerheal") and SUMMONER_1 or myHero:GetSpellData(SUMMONER_2).name:find("summonerheal") and SUMMONER_2
local BR_Slot = myHero:GetSpellData(SUMMONER_1).name:find("summonerbarrier") and SUMMONER_1 or myHero:GetSpellData(SUMMONER_2).name:find("summonerbarrier") and SUMMONER_2
local IG_Slot = myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") and SUMMONER_1 or myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") and SUMMONER_2
local EX_Slot = myHero:GetSpellData(SUMMONER_1).name:find("summonerexhaust") and SUMMONER_1 or myHero:GetSpellData(SUMMONER_2).name:find("summonerexhaust") and SUMMONER_2
local FL_Slot = myHero:GetSpellData(SUMMONER_1).name:find("summonerflash") and SUMMONER_1 or myHero:GetSpellData(SUMMONER_2).name:find("summonerflash") and SUMMONER_2
local CL_Slot = myHero:GetSpellData(SUMMONER_1).name:find("summonermana") and SUMMONER_1 or myHero:GetSpellData(SUMMONER_2).name:find("summonermana") and SUMMONER_2
local CS_Slot = myHero:GetSpellData(SUMMONER_1).name:find("summonerboost") and SUMMONER_1 or myHero:GetSpellData(SUMMONER_2).name:find("summonerboost") and SUMMONER_2
local GH_Slot = myHero:GetSpellData(SUMMONER_1).name:find("summonerhaste") and SUMMONER_1 or myHero:GetSpellData(SUMMONER_2).name:find("summonerhaste") and SUMMONER_2
local CV_Slot = myHero:GetSpellData(SUMMONER_1).name:find("summonerclairvoyance") and SUMMONER_1 or myHero:GetSpellData(SUMMONER_2).name:find("summonerclairvoyance") and SUMMONER_2
local PR_Slot = myHero:GetSpellData(SUMMONER_1).name:find("summonerpromoteSR") and SUMMONER_1 or myHero:GetSpellData(SUMMONER_2).name:find("summonerpromoteSR") and SUMMONER_2
-- Auto Heal (W) - Soraka heals the nearest injured ally champion
local RAW_HEAL_AMOUNT = {110, 140, 170, 200, 230}
local RAW_HEAL_RATIO = 0.4
local HEAL_RANGE = 700
local HEAL_MIN_HP = 0.05
local scriptActive = true
--Target Selector
ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 1700, DAMAGE_MAGIC, true)
--Warding Matrix
local wardTimer = 0
local wardSlot = nil
local wardMatrix = {}
local wardDetectedFlag = {}
local lastWard = 0
local QuoteTime = 0
local RakaPastKill = 0
wardMatrix[1] = {12261,12995,2823.37,7422,10148,6269,7151.64,4354.54,4728,6762.52,11217.39,6610.35,3883,7775,6867.68,9720.86,9233.13,7282.69,10180.18,8875.13,3920.88,5017.27}
wardMatrix[2] = {1575,2411,7617.03,3282,2839,4445,4719.66,7079.51,8336,2918.75,6841.89,11064.61,11577,10046.49,9567.63,7501.50,6094.48,11482.53,4969.32,5390.57,9477.78,8954.09}
wardMatrix[3] = {}
for i = 1, 22 do
--Ward present nearby ?
wardMatrix[3][i] = false
wardDetectedFlag[i] = false
end
aaDelay = 1000 -- the delay between auto attacks
allySpawn = nil
enemySpawn = nil
wardBought = 0
potsBought = 0
hpPot = 0 
mpPot = 0
firstBought = false	
rakaMove = {}
rakaMove.tick = nil
rakaMove.timer = 10000
--------------PRIORITY SETTINGS
--------------PRIORITY SETTINGS
function SetPriority(table, hero, priority)
    for i=1, #table, 1 do
        if hero.charName:find(table[i]) ~= nil then
            TS_SetHeroPriority(priority, hero.charName)
        end
    end
end     
function arrangePrioritys(enemies)
    local priorityOrder = {
        [2] = {1,1,2,2,2},
        [3] = {1,1,2,3,3},
        [4] = {1,2,3,4,4},
        [5] = {1,2,3,4,5},
    }
    for i, enemy in ipairs(GetEnemyHeroes()) do
        SetPriority(priorityTable.AD_Carry, enemy, priorityOrder[enemies][1])
        SetPriority(priorityTable.AP,       enemy, priorityOrder[enemies][2])
        SetPriority(priorityTable.Support,  enemy, priorityOrder[enemies][3])
        SetPriority(priorityTable.Bruiser,  enemy, priorityOrder[enemies][4])
        SetPriority(priorityTable.Tank,     enemy, priorityOrder[enemies][5])
    end
end
 
function LoadTargets()
    if #GetEnemyHeroes() <= 1 then
        --PrintChat("Not enough enemies, can't arrange priority's!")
    else
        arrangePrioritys(#GetEnemyHeroes())
        --PrintChat(" >> Arranged priority's!")
    end
end
 
priorityTable = {
    AP = {
        "Azir","Ahri", "Akali", "Anivia", "Annie", "Brand", "Cassiopeia", "Diana", "Evelynn", "FiddleSticks", "Fizz", "Gragas", "Heimerdinger", "Karthus",
        "Kassadin", "Katarina", "Kayle", "Kennen", "Leblanc", "Lissandra", "Lux", "Malzahar", "Mordekaiser", "Morgana", "Nidalee", "Orianna",
        "Rumble", "Ryze", "Sion", "Swain", "Syndra", "Teemo", "TwistedFate", "Veigar", "Viktor", "Vladimir", "Xerath", "Ziggs", "Zyra",
    },
    Support = {
        "Blitzcrank", "Janna", "Karma", "Lulu", "Nami", "Sona", "Soraka", "Thresh", "Zilean",
    },
     
    Tank = {
        "Braum","Amumu", "Chogath", "DrMundo", "Galio", "Hecarim", "Malphite", "Maokai", "Nasus", "Rammus", "Sejuani", "Shen", "Singed", "Skarner", "Volibear",
        "Warwick", "Yorick", "Zac", "Nunu", "Taric", "Alistar", "Leona",
    },
     
    AD_Carry = {
        "Ashe", "Caitlyn", "Corki", "Draven", "Ezreal", "Graves", "Jayce", "Jinx", "KogMaw", "Lucian", "MissFortune", "Pantheon", "Quinn", "Shaco", "Sivir",
        "Talon", "Tristana", "Twitch", "Urgot", "Varus", "Vayne", "Zed", "MasterYi", "Yasuo",
    },
     
    Bruiser = {
        "Gnar","Darius", "Elise", "Fiora", "Gangplank", "Garen", "Irelia", "JarvanIV", "Jax", "Khazix", "LeeSin", "Nautilus", "Nocturne", "Olaf", "Poppy",
        "Renekton", "Rengar", "Riven", "Shyvana", "Trundle", "Tryndamere", "Udyr", "Vi", "MonkeyKing", "XinZhao", "Aatrox",
    },
}
--------------PRIORITY SETTINGS
--------------PRIORITY SETTINGS

-- numerate spawn
function detectSpawnPoints()
	for i=1, objManager.maxObjects, 1 do
	local candidate = objManager:getObject(i)
		if candidate ~= nil and candidate.valid and candidate.type == "obj_SpawnPoint" then
			if candidate.x < 3000 then
				if player.team == TEAM_BLUE then allySpawn = candidate else enemySpawn = candidate end
			else
				if player.team == TEAM_BLUE then enemySpawn = candidate else allySpawn = candidate end
			end
		end
	end
end
---------------------------
--[[ Warding,     Wards]]--


--[[ Warding,     Wards]]--
function wardUpdate()
	for i = 1, 22 do
		wardDetectedFlag[i] = false
	end
	for k = 1, objManager.maxObjects do
		local object = objManager:GetObject(k)
		if object ~= nil and (string.find(object.name, "Ward") ~= nil or string.find(object.name, "Wriggle") ~= nil) then
			for i = 1, 22 do
				if math.sqrt((wardMatrix[1][i] - object.x)*(wardMatrix[1][i] - object.x) + (wardMatrix[2][i] - object.z)*(wardMatrix[2][i] - object.z)) < 1100 then
					wardDetectedFlag[i] = true
					wardMatrix[3][i] = true
				end
			end
		end
		for i = 1, 22 do
			if wardDetectedFlag[i] == false then
				wardMatrix[3][i] = false
			end
		end
	end
	wardTimer = GetTickCount()
end
---------------------------
--[[ SPELLS      SPELLS]]--


--[[ SPELLS     SPELLS ]]--
---------------------------
--########################## SUMMONERS ##################
function doSummoners()

--print(myHero:GetSpellData(SUMMONER_2).name)
--print(myHero:GetSpellData(SUMMONER_1).name)


-- Promote (just in case they put this back
	if (PR_Slot ~= nil and player:CanUseSpell(PR_Slot) == READY) and config.autoSum.PRenabled == true then 
		CastSpell(PR_Slot)
	end 
-- Heal
	if (HL_Slot ~= nil) and	player:CanUseSpell(HL_Slot) == READY and config.autoSum.HLenabled == true then 
		for j = 1, heroManager.iCount do
        	local target = heroManager:GetHero(j)
			if target ~= nil and target.visible == true and target.team == player.team and target.dead == false and player:GetDistance(target) < 300 then
				--PrintChat("Almost")
				if target.health/target.maxHealth < config.autoSum.Heal/100 then
					--PrintChat("Cast!")
					CastSpell(HL_Slot)
				end
			end
		end
	end
    
-- Barrier
	if (BR_Slot ~= nil and player:CanUseSpell(BR_Slot) == READY) and config.autoSum.BRenabled == true then 
		
 		if myHero.visible == true and myHero.dead == false then
			--PrintChat("Almost")
			if myHero.health/myHero.maxHealth < config.autoSum.Barrier/100 then
			--PrintChat("Cast!")
				CastSpell(BR_Slot)
			end
			
		end
	end
-- Clarity
	if (CL_Slot ~= nil and player:CanUseSpell(CL_Slot) == READY) and config.autoSum.CLenabled == true then 
		for j = 1, heroManager.iCount do
        	local target = heroManager:GetHero(j)
			if target ~= nil and target.visible == true and target.team == player.team and target.dead == false and player:GetDistance(target) < 300 then
				--PrintChat("Almost")
				if target.mana/target.maxMana < config.autoSum.Clarity/100 then
					--PrintChat("Cast!")
					CastSpell(CL_Slot, target)
				end
			end
		end
	end
--Ignite
	if (IG_Slot ~= nil and player:CanUseSpell(IG_Slot) == READY) and config.autoSum.IGenabled == true then 
		local ignitedmg = 0    
		for i = 1, heroManager.iCount, 1 do
			local enemyhero = heroManager:getHero(i)
			if ValidTarget(enemyhero,600) then
				ignitedmg = 50 + 20 * myHero.level
				if enemyhero.health <= ignitedmg then
					CastSpell(IG_Slot, enemyhero)
				end
			end
		end
	end
--Cleanse
	cleanseList = {"stun", "Stun", "Fear", "taunt", "LuxLightBindingMis", "Wither", "SonaCrescendo", "RunePrison", 
			"DarkBindingMissile", "caitlynyordletrapdebuff", "EnchantedCrystalArrow", "CurseoftheSadMummy", "LuluWTwo", "fizzmarinerdoombomb"
		 	}
	if (CS_Slot ~= nil and player:CanUseSpell(CS_Slot) == READY) and config.autoSum.CSenabled == true then 
		for k = 1, player.buffCount, 1 do
			for j = 1, #cleanseList, 1 do
				if player:getBuff(k) == cleanseList[j] then
					CastSpell(CS_Slot)
				end
			end
		end
	end
--Exhaust
	if (EX_Slot ~= nil and player:CanUseSpell(EX_Slot) == READY) and config.autoSum.EXenabled == true then 
		for j = 1, heroManager.iCount do
           	local target = heroManager:GetHero(j)
			if target ~= nil and target.visible == true and target.team ~= player.team and target.dead == false and player:GetDistance(target) < 550 then
				if target.health/target.maxHealth < .25 then
					for k = 1, heroManager.iCount do
						local target2 = heroManager:GetHero(k)
						if target2 ~= nil and target2.visible == true and target2.team == player.team and target2.dead == false and player:GetDistance(target2) < 550 then
							CastSpell(EX_Slot, target)
						end
					end
				end
			end
		end
	end
--Ghost
	if (GH_Slot ~= nil and player:CanUseSpell(GH_Slot) == READY) and config.autoSum.GHenabled == true then 
		for j = 1, heroManager.iCount do
           	local target = heroManager:GetHero(j)
			if target ~= nil and target.visible == true and target.team ~= player.team and target.dead == false and player:GetDistance(target) < 850 then
				if target.health/target.maxHealth > player.health*1.66/player.maxHealth then
					ghostFlag = false
					for k = 1, heroManager.iCount do
						local target2 = heroManager:GetHero(k)
						if target2 ~= nil and target2.visible == true and target2.team == player.team and target2.dead == false and player:GetDistance(target2) < 600 then
						else
							ghostFlag = true
						end
					end
					if ghostFlag then
						CastSpell(GH_Slot)
					end
				end
			end
		end
	end
	
--Clairvoyance
	if (CV_Slot ~= nil and player:CanUseSpell(CV_Slot) == READY) and config.autoSum.CVenabled == true then 
		visibleFlag = false
		for j = 1, heroManager.iCount do
	       	local target = heroManager:GetHero(j)
			if target ~= nil and target.visible == true and target.team ~= player.team and target.dead == false then
				visibleFlag = true
			end
		end
		if visibleFlag == false then
			CastSpell(CV_Slot, 4835, 9591) --baron
		end
		for j = 1, heroManager.iCount do
	   		local target = heroManager:GetHero(j)
   			if target ~= nil and target.team ~= player.team and target.dead == false and target.visible == false then
	       		CastSpell(CV_Slot, target.x, target.z)
   			end
   		end
	end


end


-- Soraka performs starcall to help push/farm a lane or harrass enemy champions (or both)
--############################QQQQQQQQQQQQQQQQQQQQQQQQQQ##############
function doSorakaStarcall()
	if not ts.target then return end  
	if myHero.level < 6 then
		ts.mode = TARGET_MOST_AD
		ts.range = qRange
		ts:update()
	else
		ts.mode = TARGET_LOW_HP_PRIORITY
		ts.range = qRange
		ts:update()
	end
	
	local pos, info, hitchance
	if ts.target ~= nil then

		pos, hitchance = VP:GetPredictedPos(ts.target, 0.28, 1750, player, true)
	

		if config.autoStarcall.starcallTowerDive == false and UnderTurret(player, true) == true and info ~= nil and (info.hitchance ~=0 or hitchance ~= 0) then 
			return 
		end
		if GetDistance(pos) < (qRange) then
			if hitchance > 1  then
					evilRaka(2)
					CastSpell(_Q, pos.x, pos.z)
			end
		end
		if os.clock() > QTimer then
			if GetDistance(pos) < (qRange)+50 then
				if hitchance ~= 0  then
					targetAttack = 1 - ((GetDistance(pos) / 1025)*.90)
					manaAttack =  (myHero.mana / myHero.maxMana)*.95
					chance = (targetAttack + manaAttack)* .75
					if chance > math.random(0,1) then
					
						evilRaka(2)
						CastSpell(_Q, pos.x, pos.z)
					
					end
				end
			end    
			QTimer = os.clock() + math.random(.6, 1.8)
		end
		
	end
end

--########################## WWWWWWWWWWWWWWWWWWWW ##################
-- Soraka Heals the nearby most injured ally or herself, assumes heal is ready to be used
function doSorakaHeal()
	for i, ally in ipairs(GetAllyHeroes()) do
		if ally ~= nil then
			if GetDistance(ally) < 950 and ((player.health / player.maxHealth) > (_G.DEFAULT_HEALHP_THRESHOLD / 100)) and ((player.mana / player.maxMana) > (_G.DEFAULT_HEALMANA_THRESHOLD / 100)) then
				local totalHealAmount = RAW_HEAL_AMOUNT[player:GetSpellData(_W).level] + (RAW_HEAL_RATIO * player.ap)
				-- If Healmode 1 then just heal any ally who is hurt, period, allow space for minion damage
			if config.autoHeal.healMode == 1 then
				if ally ~= nil and (ally.health < ally.maxHealth *.9) or (ally.maxHealth - ally.health > totalHealAmount) then
					CastSpell(_W, ally)				
			end
			elseif config.autoHeal.healMode == 2 then
				--If Healmode 2 then heal whenever ally is at HEAL_Threshhold % alive and it would fully heal him.
				if ally ~= nil and ally.health < (ally.maxHealth - totalHealAmount) then
					CastSpell(_W, ally)
				end
			elseif config.autoHeal.healMode == 3 then
			--If Healmode 3 then heal whenever anyone allies health falls below the threshold, period.
				if ally ~= nil and (ally.health/ally.maxHealth) < (config.autoHeal.healThreshold / 100) then
					CastSpell(_W, ally)
				end
		end
	end
end
	end
end

--########################## EEEEEEEEE ##################
function doSorakaEquinox()
    if not ts.target then return end  
	if myHero.level < 6 then
		ts.mode = TARGET_MOST_AD
		ts.range = 1700
		ts:update()
	else
		ts.mode = TARGET_LOW_HP_PRIORITY
		ts.range = eRange
		ts:update()
	end	

    if ts.target ~= nil then
	   local pos, info, hitchance
       pos, hitchance = VP:GetPredictedPos(ts.target, 0.05, 2000, player, false)

        if config.autoStarcall.starcallTowerDive == false and UnderTurret(player, true) == true and (hitchance ~= 0) and GetDistance(pos) < 895 then return end
		
		if GetDistance(pos) < (eRange) -50 and pos.type ~= "obj_AI_Minion" then
			if hitchance ~= 0 then
				evilRaka(2)
				CastSpell(_E, pos.x, pos.z)		
			end
		end
	end	
end
--########################## RRRRRRRRR ##################
function doSorakaUlt()
   

    if (myHero.health /myHero.maxHealth) <= (config.autoUlt.ultThreshold / 100) and myHero.isrecalling ~= true then
        if (myHero:GetDistance(allySpawn)) > 1300 then
            CastSpell(_R, myHero)
            print("I will not die this day summoner.")
        end
    end

 --Ult based on ultMode
	if config.autoUlt.ultMode == 1 then

	-- Mode 1 Soraka Only Ults When A Nearby Ally Is Hurt
		for i, allyult in ipairs(GetAllyHeroes()) do
			if allyult ~= nil and (allyult.health /allyult.maxHealth) <= (config.autoUlt.ultThreshold / 100) and allyult.isrecalling ~= true then
				if (allyult:GetDistance(allySpawn)) > 1300 and player:GetDistance(allyult) < 2500 then
					CastSpell(_R, myHero)
					print("I will save "..allyult.name)
					
				end                
			end
		end
	end

	if config.autoUlt.ultMode == 2 then
-- Ults any teamamte who is in critical condition, globally
		for i, allyult in ipairs(GetAllyHeroes()) do
			if allyult ~= nil and (allyult.health/allyult.maxHealth) < (config.autoUlt.ultThreshold / 100) and allyult.isrecalling == nil and allyult:GetDistance(allySpawn) > 1300 then
				CastSpell(_R, myHero)
                print("I will save "..allyult.name)				
			end
		end
	end
end

-- Soraka uses ultimate based on user preference
-- Soraka Attacks enemies silencing them to the best of her ability. donating them mana



---------------------------
--[[ SPELLS      SPELLS]]--


--[[ SPELLS     SPELLS ]]--
---------------------------
---------------------------
--[[ POTIONS AND  WARDS]]--


--[[ POTIONS AND  WARDS]]--
---------------------------

function isLow(Name)
	if InFountain() or (isrecalling) then
		return
	end
	if Name == 'Mana' then
		if myHero.mana / myHero.maxMana <= config.Misc.PercentofMana / 100 then
			return true
		else
			return false
		end
	end
	if Name == 'Health' then
		if myHero.health / myHero.maxHealth <= config.Misc.PercentofHealth / 100 then
			return true
		else
			return false
		end
	end
end
function getInventoryPotSlot()
	-- not sure if 2003 is pots or biscuits, you change if I'm wrong
	havePots = GetInventorySlotItem(2003)
	haveBiscuits = GetInventorySlotItem(2010)
	
	-- biscuits have prefference over pots
	if haveBiscuits ~= nil then return haveBiscuits 
	elseif havePots ~= nil then return havePots
	else return nil end
end



---------------------------
--[[ POTIONS AND  WARDS ]]--


--[[ POTIONS AND  WARDS]]--
---------------------------


function sorakaFarm()
	enemyMinions:update()
	-- Code executed every 3-10 seconds here to simulate random movements
	--[[for index1, enemy in ipairs(GetEnemyHeroes()) do
		if ValidTarget(enemy, (qRange + 50)) then
			return
		end
	end]]

	for index2, enemy in ipairs(GetEnemyHeroes()) do
		local fleeX = nil
		local fleeZ = nil
		if player:GetDistance(enemy) < 480 and enemy.visible == true and enemy.dead == false and (enemy.health/enemy.maxHealth > .30) and config.autoFarm.Sim then
			runTo = SafeTower(player, player.team)
			safeX = (allySpawn.x - runTo.x)/(runTo:GetDistance(allySpawn)) * ((600 - 300) / 2 + 300) + runTo.x
    		safeZ = (allySpawn.z - runTo.z)/(runTo:GetDistance(allySpawn)) * ((600 - 300) / 2 + 300) + runTo.z
    		if safeX < player.x then
    			if player:GetDistance(runTo) > 300 then
    				fleeX = player.x - 450
    			end
    		else
    			if player:GetDistance(runTo) > 300 then 
    				fleeX = player.x + 450
    			end
    		end
    		if safeZ < player.z then
    			if player:GetDistance(runTo) > 300 then
    				fleeZ = player.z - 450
    			end
    		else
    			if player:GetDistance(runTo) > 300 then 
    				fleeZ = player.z + 450
    			end
    		end
    		player:MoveTo(fleeX,fleeZ)

		end
        for i, ally in ipairs(GetAllyHeroes()) do
            if ally ~= nil then
                if (myHero:GetDistance(ally) < 1200 or player:GetDistance(enemy) < 1200) and enemy.visible == true and enemy.dead == false then
                    dontfarm = true
                else
                    dontfarm = false
                end
            end
        end

	end

	for index, minion in pairs(enemyMinions.objects) do
		 --randomly makes the player move around to similate real player]
		if rakaMove.tick == nil and GetDistance(minion) <= 410  and config.autoFarm.Sim then
			rakaMove.tick = GetTickCount()
			rakaMove.timer = math.random(4000,10000)
		elseif rakaMove.tick ~= nil and GetTickCount() - rakaMove.tick > rakaMove.timer and config.autoFarm.Sim then
	 		if player.team == TEAM_BLUE then
	 			GetMyHero():MoveTo((GetMyHero().x + math.random(-750,-300)), (GetMyHero().z + (math.random(-850,-650))))
		end
	 		if player.team == TEAM_PURPLE then
	 			GetMyHero():MoveTo((GetMyHero().x + math.random(300,750)), (GetMyHero().z + (math.random(300,750))))
	 		end
	 		rakaMove.tick = nil
	 	end


		
			if config.autoFarm.farmMode == 1 then
				if GetTickCount() - aaTick >= aaDelay and player:GetDistance(minion) < (aaRange + 150) and minion.health <= (getDmg("AD", minion, player)) then
					myHero:Attack(minion)
					aaTick = GetTickCount()
					rakaMove.tick = nil				
				elseif dontfarm == false and player:GetDistance(minion) < (qRange/2 + 100) and minion.health <= (getDmg("AD", minion, player)) and ((player.mana / player.maxMana) > .60) and player.health > 200 and myHero:CanUseSpell(_Q) == READY then
					evilRaka(1)
					CastSpell(_Q, minion)
					--PrintChat ("Farming with Q!")
					Movetick = GetTickCount()
				elseif dontfarm == false and player:GetDistance(minion) >= (qRange/2 + 100) and player:GetDistance(minion) < (qRange + 100) and ((player.mana / player.maxMana) > .60) and player.health > 200 and minion.health <= (getDmg("AD", minion, player) *.7) and myHero:CanUseSpell(_Q) == READY then
					evilRaka(1)
					CastSpell(_Q, minion)
					--PrintChat ("Farming with Q!")
					Movetick = GetTickCount()
				end
			end

        	if config.autoFarm.farmMode == 2 then
				if GetTickCount() - aaTick >= aaDelay and player:GetDistance(minion) < (aaRange + 200) and minion.health <= getDmg("AD", minion, player) + 15 then
					evilRaka(1)
					myHero:Attack(minion)
					aaTick = GetTickCount()
					rakaMove.tick = nil
					return	
				elseif GetTickCount() - aaTick >= aaDelay and player:GetDistance(minion) < (aaRange + 200) and minion.health > (getDmg("AD", minion, player) * 1.5) then
					evilRaka(1)
					myHero:Attack(minion)
					aaTick = GetTickCount()
					rakaMove.tick = nil
					return				
				elseif dontfarm == false and  player:GetDistance(minion) < (qRange/2 + 200) and minion.health <= ((getDmg("Q", minion, myHero)) + ((getDmg("AD", minion, player)*.5) )) and ((player.mana / player.maxMana) > .30) and player.health > 200 and myHero:CanUseSpell(_Q) == READY then
					evilRaka(1)
					CastSpell(_Q, minion)
					myHero:Attack(minion)
					--PrintChat ("Farming with Q!")
					Movetick = GetTickCount()
				elseif dontfarm == false and player:GetDistance(minion) >= (qRange/2 + 200) and player:GetDistance(minion) < (qRange + 200) and ((player.mana / player.maxMana) > .30) and player.health > 200 and minion.health <= ((getDmg("AD", minion, player)*.5)) and ((player.mana / player.maxMana) > .30) and myHero:CanUseSpell(_Q) == READY then
					evilRaka(1)
					CastSpell(_Q, minion)
					myHero:Attack(minion)
					--PrintChat ("Farming with Q!")
					Movetick = GetTickCount()
				elseif dontfarm == false and GetDistance(minion) < (qRange + 200) and ((player.mana / player.maxMana) > .30) and player.health > 200 and minion.health/minion.maxHealth > .60 and myHero:CanUseSpell(_Q) == READY then
					evilRaka(1)
					CastSpell(_Q, minion)
					myHero:Attack(minion)
					Movetick = GetTickCount()
				end
			end
            
			if config.autoFarm.farmMode == 3 then
				if GetTickCount() - aaTick >= aaDelay  and player:GetDistance(minion) < (aaRange + 150) and minion.health <= (getDmg("AD", minion, player) + 15) then
					myHero:Attack(minion)
					aaTick = GetTickCount()
					rakaMove.tick = nil				
				elseif player:GetDistance(minion) < (qRange/2 + 100) and minion.health <= (getDmg("Q", minion, player)*.9) and ((player.mana / player.maxMana) > .50) and player.health > 200 and myHero:CanUseSpell(_Q) == READY then
					evilRaka(1)
					CastSpell(_Q, minion)
					--PrintChat ("Farming with Q!")
					Movetick = GetTickCount()
				elseif player:GetDistance(minion) >= (qRange/2 + 100) and player:GetDistance(minion) < (qRange) and ((player.mana / player.maxMana) > .50) and player.health > 200 and minion.health <= (getDmg("Q", minion, player)*.9 ) and myHero:CanUseSpell(_Q) == READY then
					evilRaka(1)
					CastSpell(_Q, minion)
					--PrintChat ("Farming with Q!")
					Movetick = GetTickCount()
				end
			end

		
	end
end	

function buy()
	if InFountain() or player.dead then
				-- Item purchases
		if firstBought == false and GetTickCount() - startingTime > 4000 then
			local Greeting  = {'Sup','Hey','Yo','Hi', 'hi','Hiya','lets go for an early dragon','how we gonna do this?','sup guys','whats cracking','whats good','been a while since I seen that skin','Nice skin','nice skin','Hey, Whats up','I like this team','I lik R team','I like our team','I <3 this team','I <3 our team', 'we will win this','we wll win this', 'we got this', 'we got thiz', 'play smart, we scale better', 'yo play smart we scale more', 'yo play smart, we scale harder','play smart we have a better late game', 'Hi team', 'HI team', 'HI tea', 'Hiya guys', 'its playtime', 'time to rock and roll', 'time to lose control', 'lets go!','lets do this ^_^', 'goodluck', 'lets win', 'lets do our best', 'guard jungle', 'help jungelr', 'grd jungle', 'help jungle','leash?', 'think we can win?', 'have fun','hey guys', 'nice skin', 'lol we got this','ping for ult','GL HF','GL HF','GL HF','Gl Hf','gl hf','glhf','glhf <3',}
			SendChat( Greeting[ math.random( #Greeting ) ] )
			firstBought = true
			BuyItem(3340) --warding trinklet
  			BuyItem(2004) -- mana potion
  			BuyItem(2003) -- health potion
            BuyItem(2003) -- health potion
  		
		end
		if GetTickCount() - startingTime > 5000 then
			if GetTickCount() > lBy + bDly then
				if GetInventorySlotItem(shopList[nBI]) ~= nil then
					--Last Buy successful
					sBy = 1
					nBI = nBI + 1
				else
					--Last Buy unsuccessful (buy again)
					BuyItem(shopList[nBI])
					lBy = GetTickCount()
				end
			end
		end
		-- Continuous potion purchases
		if sBy ~= nil and _G.DEFAULT_CUSTOMBUY == false then
			if GetTickCount() - hpPot > 12000 and GetTickCount() - startingTime > 8000  then
				if getInventoryPotSlot() == nil then
			 		if GetTickCount() - startingTime < 50000 then
						BuyItem(2003) -- health potion 
						hpPot = GetTickCount()
					end
					if GetTickCount() - startingTime >= 50000 then
						BuyItem(2003) -- health potion 
						hpPot = GetTickCount()
					end
				end
			end
			if GetTickCount() - mpPot > 12000 and GetTickCount() - startingTime > 8000 then 
				if GetInventorySlotItem(2004) == nil then
		 			if GetTickCount() - startingTime < 50000 then
						BuyItem(2004) -- mana potion
						mpPot = GetTickCount()
					end
					if GetTickCount() - startingTime >= 50000 and GetInventorySlotItem(3028) == nil then
						BuyItem(2003) -- health potion 
						mpPot = GetTickCount()
					end
				end
			end
			if GetTickCount() - wardBought > 30000 and GetTickCount() - startingTime > 8000 and GetInventorySlotItem(2045) == nil and GetInventorySlotItem(2049) == nil and GetInventorySlotItem(2044) == nil then
				BuyItem(2044) -- stealth ward (green)
				wardBought = GetTickCount()
			end
	


		end
			local trinkSlot = GetInventorySlotItem(3340)

			if GetInventorySlotItem(2045) ~= nil and trinkSlot ~= nil then 
				SellItem(trinkSlot)
				--print((myHero:getInventorySlot(trinkSlot)))
				BuyItem(3341)
			end 
			sBy = nil
	end
end


---------------------------
--[[ Helper Functions ]]--


--[[ Helper Functions ]]--
---------------------------
-- Gets the closest tower to Soraka!

function GetTowers(team)
  local towers = {}
  for i=1, objManager.maxObjects, 1 do
    local tower = objManager:getObject(i)
    if tower ~= nil and tower.valid and tower.type == "obj_AI_Turret" and tower.visible and tower.team == team then
      table.insert(towers,tower)
    end
  end
  if #towers > 0 then
    return towers
  else
    return false
  end
end

function SafeTower(hero, team)
  local towers = GetTowers(team)
  if #towers > 0 then
    local candidate = towers[1]
    for i=2, #towers, 1 do
      if (towers[i].health/towers[i].maxHealth > 0.1) and  hero:GetDistance(candidate) > hero:GetDistance(towers[i]) then candidate = towers[i] end
    end
    return candidate
  else
    return false
  end
end
-- 
-- Return player based on their resource or stat
function GetPlayer(team, includeDead, includeSelf, distanceTo, distanceAmount, resource)
	local target = nil

	for i=1, heroManager.iCount do
		local member = heroManager:GetHero(i)

		if member ~= nil and member.type == "AIHeroClient" and member.team == team and (member.dead ~= true or includeDead) then
			if member.charName ~= player.charName or includeSelf then
				if distanceAmount == GLOBAL_RANGE or member:GetDistance(distanceTo) <= distanceAmount then
					if target == nil then target = member end

					if resource == "health" then --least health
						if member.health < target.health then target = member end
					elseif resource == "mana" then --least mana
						if member.mana < target.mana then target = member end
					elseif resource == "AD" then --highest AD
						if member.totalDamage > target.totalDamage then target = member end
					elseif resource == NO_RESOURCE then
						return member -- as any member is eligible
					end
				end
			end
		end
	end

	return target
end
-- obCreatObj
function OnCreateObj(obj)
	-- Check if player is recalling and set isrecalling
	if obj ~= nil then
		if obj.name:find("TeleportHome.troy") then
			if GetDistance(obj, myHero) <= 70 then
				Recalling = true
			end
		end
		if obj.name:find("Global_Item_HealthPotion.troy") then
			if GetDistance(obj, myHero) <= 70 then
				UsingHealthPot = true
				UsingFlask = true
			end
		end
		if obj.name:find("Global_Item_ManaPotion.troy") then
			if GetDistance(obj, myHero) <= 70 then
				UsingFlask = true
				UsingManaPot = true
			end
		end
	end
end

-- OnDeleteObj
function OnDeleteObj(obj)
		if obj ~= nil then
			if obj.name:find("TeleportHome.troy") then
				Recalling = false
			end
			if obj.name:find("Global_Item_HealthPotion.troy") then
				UsingHealthPot = false
				UsingFlask = false
			end
			if obj.name:find("Global_Item_ManaPotion.troy") then
				UsingManaPot = false
				UsingFlask = false
			end
		end
end
--[[function OnWndMsg(msg, keycode)
	if keycode == 88 and msg == KEY_DOWN then
		for i, ally in ipairs(GetAllyHeroes()) do
			if ally ~= nil then
				if GetDistance(allySpawn, ally) > 1000  then
					PrintChat(tostring(GetDistance(allySpawn, ts.target)))
				--	PrintChat(tostring(player.z))
				end
			end
		end
	end
end
]]--
function evilRaka(emote)
	if config.evilRaka == true and math.random(0,100) > 45 then
		local choice = emote
		--print(choice)
		--print(emote)
		if choice == 1 then
			SendChat("/l")
		end
		if choice == 2 then
			SendChat("/t")
		end
		if choice == 3 then
			SendChat("/d")
		end
	end
	choice = nil 
return
end


---------------------------
--[[ Helper Functions ]]--


--[[ Helper Functions ]]--
---------------------------
--draws Menu
function drawMenu()
	-- Config Menu

	---LOOK HERE LOOK HERE LOOK HERE LOOK HERE ---
	---IT IS HERE THAT YOU MAY SET FEATURES OF T.R.R.--
	---TRUE = ON, FALSE = OFF, (10,0,100, 0) = DEFAULT 10%, RANGE ZERO TO 100, ZER0 DECIMALS
	---
	config = scriptConfig("TheRakaReturns", "TheRakaReturns")	
	
	config:addParam("enableScript", "Enable Script", SCRIPT_PARAM_ONOFF, true)
	config:addParam("autoBuy", "Auto Buy Items", SCRIPT_PARAM_ONOFF, _G.DEFAULT_AUTO_BUYITEMS)
	config:addParam("autoLevel", "Auto Level", SCRIPT_PARAM_ONOFF, _G.DEFAULT_AUTO_LEVEL)
	config:addParam("evilRaka", "Evil Raka?", SCRIPT_PARAM_ONOFF, _G.DEFAULT_EVILRAKA)
	config:addSubMenu("Auto Q?", "autoStarcall", SCRIPT_PARAM_ONOFF, _G.DEFAULT_AUTO_Q)
	config:addSubMenu("Auto W?", "autoHeal", SCRIPT_PARAM_ONOFF, _G.DEFAULT_AUTO_W)
	config:addSubMenu("Auto E?", "autoEquinox", SCRIPT_PARAM_ONOFF, _G.DEFAULT_AUTO_E)
	config:addSubMenu("Auto R?", "autoUlt", SCRIPT_PARAM_ONOFF, _G.DEFAULT_AUTO_R)
	config:addSubMenu("Auto Farm?", "autoFarm", SCRIPT_PARAM_ONOFF, _G.DEFAULT_AUTO_FARM)
	config:addSubMenu("Misc", "Misc", SCRIPT_PARAM_ONOFF, true)
	config:addSubMenu("Auto Summoner?", "autoSum", SCRIPT_PARAM_ONOFF, true)

	--config:addSubMenu("Auto Summoners?","autoSum",SCRIPT_PARAM_ONOFF, true)


	--[[if sheal ~= nil then
		for i=1, heroManager.iCount do
			local teammate = heroManager:GetHero(i)
			if teammate.team == myHero.team then config.auto:addParam("teammatesheal"..i, "Heal "..teammate.charName, SCRIPT_PARAM_ONOFF, false) end
		end
		config.autoSum:addParam("maxPerHp", "Max percent of hp", SCRIPT_PARAM_SLICE, 100, 0, 100, 0)
	end]]--


--Menu for Farming options
--autofarm enabled allows Soraka to use Q and auto attacks to last hit minions
--Simu enabled will make soraka randomly move about like a real player every now and then.
	config.autoFarm:addParam("enabled", "Enable", SCRIPT_PARAM_ONOFF, _G.DEFAULT_AUTO_FARM)
	config.autoFarm:addParam("Sim", "Simulate clicks", SCRIPT_PARAM_ONOFF, _G.DEFAULT_FARM_SIMS)
	config.autoFarm:addParam("farmMode", "Farm Mode?", SCRIPT_PARAM_LIST, _G.DEFAULT_FARM_MODE, { "Last Hit", "Wave Clear","Solo Lane"})


--Menu for Auto Heals
--Heal Mode 1 means Soraka will heal anyone who is below full life.
--Heal Mode 2 means soraka will heal with a priority on who needs it more
--heal Mode 3 means that Soraka will only heal when someoen is below the threshhold
--HP and Mana limits tell Soraka when not to use her W as it takes life from her.
--Heal Threshold, the precentage of max health that is gone before soraka will  heal
	config.autoHeal:addParam("enabled", "Enable", SCRIPT_PARAM_ONOFF, _G.DEFAULT_AUTO_W)
	config.autoHeal:addParam("healMode", "Heal Mode?", SCRIPT_PARAM_LIST, _G.DEFAULT_HEAL_MODE, { "Normal", "Smart", "Safe"})
	config.autoHeal:addParam("HealHPLimit", "(%) Prevent Hp Loss", SCRIPT_PARAM_SLICE, _G.DEFAULT_HEALHP_THRESHOLD, 0, 100, 0)
	config.autoHeal:addParam("HealMPLimit", "(%) Prevent Mana Loss", SCRIPT_PARAM_SLICE, _G.DEFAULT_HEALMANA_THRESHOLD, 0, 100, 0)
	config.autoHeal:addParam("healThreshold", "W Cast Threshold (%)", SCRIPT_PARAM_SLICE, _G.DEFAULT_HEAL_THRESHOLD, 0, 100, 0)

	config.Misc:addParam("rakaKillSpam", "Kill Spam Delay", SCRIPT_PARAM_SLICE, _G.DQUOTES, 10, 900, -1)
	config.Misc:addParam("AutoHealthPots", "Drink Hp Pot?", SCRIPT_PARAM_ONOFF, _G.DEFAULT_DRINK_HPPOT)
	config.Misc:addParam("PercentofHealth", "Drink At%?", SCRIPT_PARAM_SLICE, _G.DEFAULT_DRINK_HPPERCENT, 0, 100, 0)
	config.Misc:addParam("AutoManaPots", "Drink Mp Pot?", SCRIPT_PARAM_ONOFF, _G.DEFAULT_DRINK_MPPOT)
	config.Misc:addParam("PercentofMana", "Drink At%?", SCRIPT_PARAM_SLICE, _G.DEFAULT_DRINK_MPPERCENT, 0, 100, 0)

--Menu for Q and E simply used to set if soraka is to harass with her E and Q
	config.autoStarcall:addParam("enabled", "Enable", SCRIPT_PARAM_ONOFF, _G.DEFAULT_AUTO_Q)
	config.autoStarcall:addParam("starcallMinMana", "Min Mana To Q?", SCRIPT_PARAM_SLICE, _G.DEFAULT_STARCALL_MIN_MANA, 0, 100, 0)
	config.autoStarcall:addParam("starcallTowerDive", "S-Harass Under Towers", SCRIPT_PARAM_ONOFF, _G.DEFAULT_STARCALL_UNDERTOWER)
	
	config.autoEquinox:addParam("enabled", "Enable", SCRIPT_PARAM_ONOFF, _G.DEFAULT_AUTO_E)
	config.autoEquinox:addParam("equinoxMinMana", "Min Mana to E", SCRIPT_PARAM_SLICE, _G.DEFAULT_EQUINOX_MIN_MANA, 0, 100, 0)
	config.autoEquinox:addParam("equinoxTowerDive", "E-Harass Under Towers", SCRIPT_PARAM_ONOFF, _G.DEFAULT_EQUINOX_UNDERTOWER)

-- Menu for using ultimate.
	config.autoUlt:addParam("enabled", "Enable", SCRIPT_PARAM_ONOFF, _G.DEFAULT_AUTO_R)
	config.autoUlt:addParam("ultThreshold", "Ult Threshold (%)", SCRIPT_PARAM_SLICE, _G.DEFAULT_ULT_THRESHOLD, 0, 100, 0)
	config.autoUlt:addParam("ultMode", "Ultimate Mode", SCRIPT_PARAM_LIST, _G.DEFAULT_ULT_MODE, {"Lane Partner", "Any Ally"})

--Menu for using Auto Summoners
	if HL_Slot ~= nil then
		config.autoSum:addParam("HLenabled", "Auto Use Heal", SCRIPT_PARAM_ONOFF, _G.DEFAULT_AUTOHEAL)
		config.autoSum:addParam("Heal", "Heal Threshold (%)", SCRIPT_PARAM_SLICE, _G.DEFAULT_HEALTH_HEAL, 0, 100, 0)
	end
	if BR_Slot ~= nil then
		config.autoSum:addParam("BRenabled", "Auto Use Barrier", SCRIPT_PARAM_ONOFF, _G.DEFAULT_AUTOBARRIER)
		config.autoSum:addParam("Barrier", "Barrier Threshold (%)", SCRIPT_PARAM_SLICE, _G.DEFAULT_HEALTH_BARRIER, 0, 100, 0)
	end
	if CL_Slot ~= nil then
		config.autoSum:addParam("CLenabled", "Auto Use Clarity", SCRIPT_PARAM_ONOFF, _G.DEFAULT_AUTOCLARITY)
		config.autoSum:addParam("Clarity", "Clarity Threshold (%)", SCRIPT_PARAM_SLICE, _G.DEFAULT_MANA_CLARITY, 0, 100, 0)
	end
	if GH_Slot ~= nil then
		config.autoSum:addParam("GHenabled", "Auto Use Ghost", SCRIPT_PARAM_ONOFF, _G.DEFAULT_AUTOGHOST) --uses ghost when you are very low.
	end
	if IG_Slot ~= nil then
		config.autoSum:addParam("IGenabled", "Auto Use Ignite", SCRIPT_PARAM_ONOFF, _G.DEFAULT_AUTOIGNITE)
	end
	if CS_Slot ~= nil then
		config.autoSum:addParam("CSenabled", "Auto Use Clense", SCRIPT_PARAM_ONOFF, _G.DEFAULT_AUTOCLENSE)
	end
	if CV_Slot ~= nil then
		config.autoSum:addParam("CVenabled", "Auto Use Clairvoyance", SCRIPT_PARAM_ONOFF, _G.DEFAULT_AUTOCLAIR)
	end
	if PR_Slot ~= nil then
		config.autoSum:addParam("PRenabled", "Auto Use Promote", SCRIPT_PARAM_ONOFF, _G.DEFAULT_AUTOPROMOTE)
	end
	if EX_Slot ~= nil then
		config.autoSum:addParam("EXenabled", "Auto Use Exhaust", SCRIPT_PARAM_ONOFF, _G.DEFAULT_AUTOEXHAUST)
		config.autoSum:addParam("Exhaust", "Exhaust Threshold (%)", SCRIPT_PARAM_SLICE, _G.DEFAULT_HEALTH_EXHAUST, 0, 100, 0)
	end
end
---------------------------
--[[ MENU AND INITATIONS]]--


--[[ MENUS AND INITATIONS]]--





---------------------------
--[[ TICK AND LOAD ]]--


--[[ TICK AND LOAD ]]--
---------------------------

function OnTick()
	-- Check if script should be run 

	if not config.enableScript then return end
	ts:update()
	--if(ts.target) then print(ts.target.charName) end
	-- Auto Level
	if config.autoLevel and player.level > GetHeroLeveled() then
		LevelSpell(_G.levelSequence[GetHeroLeveled() + 1])
	end
	-- Recall Check
	if Recalling then -- Recalling check to waste pots if we're backing
		return
	end
		HealthPotSlot = getInventoryPotSlot()
		ManaPotSlot = GetInventorySlotItem(2004)
		FlaskSlot = GetInventorySlotItem(2041)
	
	if (isRecalling) then
		return -- Don't perform recall canceling actions
	end
------------------------------
---------- Warding
------------------------------
	if scriptActive and GetTickCount() - startingTime > 210000 then
		if GetTickCount() - wardTimer > 10000 then
			wardUpdate()
		end	
		if (myHero:CanUseSpell(ITEM_7) == READY and myHero:getItem(ITEM_7).id == 3340) then
			wardSlot = GetInventorySlotItem(3340)
		elseif (myHero:CanUseSpell(ITEM_7) == READY and myHero:getItem(ITEM_7).id == 3350) then
			wardSlot = GetInventorySlotItem(3350)
		elseif GetInventorySlotItem(2044) ~= nil then
			wardSlot = GetInventorySlotItem(2044)
		elseif GetInventorySlotItem(2043) ~= nil then
			wardSlot = GetInventorySlotItem(2043)
		elseif GetInventorySlotItem(2049) ~= nil then
			wardSlot = GetInventorySlotItem(2049)
	else
		wardSlot = nil
	end
	for i = 1, 12 do
		if wardSlot ~= nil and GetTickCount() - lastWard > 2000 then
			if math.sqrt((wardMatrix[1][i] - player.x)*(wardMatrix[1][i] - player.x) + (wardMatrix[2][i] - player.z)*(wardMatrix[2][i] - player.z)) < 800 and wardMatrix[3][i] == false then
				CastSpell( wardSlot, wardMatrix[1][i], wardMatrix[2][i] )
				--PrintChat(wardMatrix[1][i],", ", wardMatrix[2][i] )
				lastWard = GetTickCount()
				wardMatrix[3][i] = true
				break
			end
		end
	end
	end
	-- cALL aCTIONS!
	if config.autoUlt.enabled and player:CanUseSpell(_R) == READY then	doSorakaUlt() end
	if config.autoBuy then buy() end 
	-- Only perform following tasks if not in fountain 
	if not InFountain() then
		doSummoners()
            if config.Misc.AutoHealthPots and isLow('Health') then
        if FlaskSlot ~= nil and not (UsingHealthPot or UsingFlask) then 
           CastSpell(FlaskSlot) end
        if HealthPotSlot ~= nil and not (UsingHealthPot or UsingFlask) then 
            CastSpell(HealthPotSlot) 
        end
    end
    
    if config.Misc.AutoManaPots and isLow('Mana') then
        if FlaskSlot ~= nil and not (UsingManaPot or UsingFlask) then CastSpell(FlaskSlot) end
        if ManaPotSlot ~= nil and not (UsingManaPot or UsingFlask) then CastSpell(ManaPotSlot) end
    end
		-- Auto Heal and Silence (W)
		if player:CanUseSpell(_W) == READY and config.autoHeal.enabled  then
			doSorakaHeal()
		end		
		--Auto Equinox (w)
		if player:CanUseSpell(_Q) == READY and config.autoEquinox.enabled and player.mana > config.autoEquinox.equinoxMinMana then
			doSorakaEquinox()
		end
		-- Auto StarCall (Q)
		if config.autoStarcall.enabled and player:CanUseSpell(_Q) == READY and player.mana > config.autoStarcall.starcallMinMana then
			doSorakaStarcall()
		end		
		if config.autoFarm.enabled then	sorakaFarm() end
	end
	if os.clock() > QuoteTime and RakaPastKills <= myHero.kills then    
    	SendChat(_G.KillQuotes[ math.random( #_G.KillQuotes ) ])
     	RakaPastKills = myHero.kills + 1
		QuoteTime = os.clock() + config.Misc.rakaKillSpam
	end




end


function OnLoad()
	PrintChat("<font color='#6C2DC7'> * / / *The R*ka Retu/rns/*/./ </font>")
	player = GetMyHero()
	startingTime = GetTickCount()
	QuoteTime = os.clock() + 60
	QTimer = os.clock() + math.random(.6,1.8)
	RakaPastKills = myHero.kills + 1
	UsingHealthPot, UsingManaPot, UsingFlask, Recalling = false, false, false, false
	drawMenu()
	enemyMinions = minionManager(MINION_ENEMY, 950, player)
	detectSpawnPoints()
	if _G.DEFAULT_CUSTOMBUY == true then
		shopList = {}
		shopList = table.copy(_G.customShopList, true)
		print("<font color='#6C2DC7'>Initalizing Custom Shop List</font>")
		local Greeting  = {'Sup','Hey','Yo','Hi', 'hi','Hiya','lets go for an early dragon','how we gonna do this?','sup guys','whats cracking','whats good','been a while since I seen that skin','Nice skin','nice skin','Hey, Whats up','I like this team','I lik R team','I like our team','I <3 this team','I <3 our team', 'we will win this','we wll win this', 'we got this', 'we got thiz', 'play smart, we scale better', 'yo play smart we scale more', 'yo play smart, we scale harder','play smart we have a better late game', 'Hi team', 'HI team', 'HI tea', 'Hiya guys', 'its playtime', 'time to rock and roll', 'time to lose control', 'lets go!','lets do this ^_^', 'goodluck', 'lets win', 'lets do our best', 'guard jungle', 'help jungelr', 'grd jungle', 'help jungle','leash?', 'think we can win?', 'have fun','hey guys', 'nice skin', 'lol we got this','ping for ult','GL HF','GL HF','GL HF','Gl Hf','gl hf','glhf','glhf <3',}
		SendChat( Greeting[ math.random( #Greeting ) ] )
		firstBought = true
	else 
		if pBld == 0 and bOrd == 0 then
			bOrd = math.random(1, 6)
			--PrintChat(tostring(bOrd))
			pBld = 1
		end
	end
	if GetInventorySlotIsEmpty(ITEM_1) == false then
		firstBought = true
	end
	VP = VPrediction()
	-- Support Frost Queen
if bOrd == 1 then
shopList = {
	3303, -- spellthiefedge
	1004, -- fairie charm
	3098, --FrostFang
	1001, --bootsofspeed
	1004, -- fairie charm
	2049, --sightstone
	3028, --Chalice
	3092, --froznefinalthingy
	3114, --forbiddenidol
	3222, --Mikael cru
	3067, --kindlegem	
	3117, --mobility
	1057, --Negatroncloak
	3190, --locket
}
end
if bOrd == 2 then
-- Support Talismen passive
shopList = {
	3301, -- Ancient Coin
	1004, -- faerie charm
	3096, -- Nomads Medallion
	2049, -- sightstone
	1001, -- bootsofspeed
	3028, --Chalice
	3117, --mobility	
	3114, --forbidden idol
	3069, --Talisment of Ascension
	3211, --Cowl
	3065, --Spirit Visage
	3108, --fiendish codex
	3174, --Unholy Grail
	1057, --Negatroncloak
	3190, --locket
	3022, --Frozen Heart
}
end

if bOrd == 3 then
--AP Support Tank
shopList = {
	3303, --spellthiefedge
	1027, --Sapphire Crystal
	3098, --FrostFang
	1028, --Ruby Crystal
	3010, --Catalyst
	1026, --Blasting Rod
	3027, --Rod Of Ages
	1001, --bootsofspeed
	2049, --sightstone
	3028, --Chalice
	3108, --fiendish codex
	3092, --Frost Queens Claim
	1052, --amplifying tome
	3136, --Haunting Guise
	3131, --Liandry's Torment
	1011, --Giant's belt
	3116, --Rylai's Crystal Scepter
}
end
if bOrd == 4 then
--Ap CDR Support
shopList = {
	3303, --spellthiefedge
	1004, --fairie charm
	3098, --FrostFang
	1004, --fairie charm
	3114, --forbidden idol
	2049, --sightstone
	3092, --froznefinalthingy
	3504, --Ardent Censer
	1001, --bootsofspeed
	3009, --Swiftness Boots
	3211, --Cowl
	3065, --Spirit Visage
	1057, --Negatron Cloak
	3001, --Abyssal Scepter
	3026, --Guardian Angel
}
end
if bOrd == 5 then
	--Ap Dps Support
	shopList = {
	3303, -- spellthiefedge
	1004, -- fairie charm
	3070, -- Tear of the Goddess
	3098, -- FrostFang
	2049, -- sightstone
	3092, -- froznefinalthingy
	3003, -- aRCHaNGEL'S Staff
	1001, -- bootsofspeed
	1058, -- Needlessly Large Rod
	3157, -- Zhonya's Hourglass
	3020, -- Sorcerer's Shoes
	1029, -- cloth armor
	3024, -- Glacial Shroud
	3110, -- Frozen Heart
	3116, -- Rylai's Crystal Scepter
}
end
	if bOrd == 6 then
	--Ful Tank Support
		shopList = {
		3301, -- Ancient Coin
		3096, -- Nomads Medallion
		1001, -- bootsofspeed
		2049, -- sightstone
		3024, -- Glacial Shroud
		3211, -- Cowl
		3065, -- Spirit Visage
		3110, -- Frozen Heart
		1011, -- Giant's belt
		3083, -- Warmogs
		3069, -- Talisment of Ascension
		
		}
	end
		if AutoUpdate then
			Update()
		end
end
