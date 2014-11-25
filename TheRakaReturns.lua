_G.version = "1.048"

_G.DonatorMode = "PASSWORD"
AvoidBugsplats = false
AvoidBugsplats = not AvoidBugsplats

local spellList_URL = "https://raw.githubusercontent.com/SurfaceS/BoL_Studio/master/Scripts/Common/spellList.lua"
local spellList_PATH = LIB_PATH.."spellList.lua"
if FileExist(spellList_PATH) then
    require("spellList")
else
    DOWNLOADING_spellList = true
    DownloadFile(spellList_URL, spellList_PATH, function() print("Required libraries downloaded successfully, please reload") end)
end
local VPrediction_URL = "https://raw.githubusercontent.com/Hellsing/BoL/master/common/VPrediction.lua"
local VPrediction_PATH = LIB_PATH.."VPrediction.lua"
if FileExist(VPrediction_PATH) then
    require("VPrediction")
else
    DOWNLOADING_VPrediction = true
    DownloadFile(VPrediction_URL, VPrediction_PATH, function() print("Required libraries downloaded successfully, please reload") end)
end
----------------------------------------------
--             THE RAKA RETURNS             --
--             THE RAKA RETURNS             --
--             "This is my path."           --
--             By Tc2r                      --
--             With Help and base           --
--             From VictorGrego             --
--             THE RAKA RETURNS             --
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
--[[Changelog:

ChangeLog: 1.046
- Eqinox's casting formula has been redone to grant better usages of the spell.
- Soraka's Simulater has had its range increased so that she flees from enemies sooner than before.
- Added more ward locations
- Specific ward spots in bot lane based on teams.
- Auto adds required files
- Repaired Greetings to be more random.
]]
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
_G.DEFAULT_EVILRAKA = false -- Soraka Torments her enemies with taunts/laughs/insults/comments(future update)


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
_G.DEFAULT_ULT_THRESHOLD = 20 --percentage of hp soraka/ally/team must be at or missing for ult, eg 10 (10%)

--AUTO FARMING OPTIONS
_G.DEFAULT_AUTO_FARM = true -- Auto Farm Minions?
_G.DEFAULT_FARM_MODE = 1 --Default Farm mode, Last Hit Only = 1, Wave Clear = 2, Sololane = 3
_G.DEFAULT_FARM_SIMS = true -- True = she random clicks and flees from enemies on her on.


_G.DEFAULT_DRINK_HPPOT = true --Will she drink health potions?
_G.DEFAULT_DRINK_HPPERCENT = 70 --at what percent of hp will she drink
_G.DEFAULT_DRINK_MPPOT = true --Will she drink health potions?
_G.DEFAULT_DRINK_MPPERCENT = 70 --at what percentage consume potion

--Starcall Amount of mana soraka must have before using starcall to harasss
_G.DEFAULT_STARCALL_ENABLE = true --Will she auto harass with starcall?
_G.DEFAULT_STARCALL_UNDERTOWER = false -- will she harass enemies under their tower
_G.DEFAULT_STARCALL_MIN_MANA = 10 --Starcall will not be cast if mana is below this Percent

-- ENABLE EQUINOX, HOW MUCH MANA LEFT BEFORE NOT USING IT
_G.DEFAULT_EQUINOX_ENABLE = true --Will she auto harass with starcall?
_G.DEFAULT_EQUINOX_MIN_MANA = 20 -- Equinox will not be cast if mana is below this Percent
_G.DEFAULT_EQUINOX_UNDERTOWER = false -- Will she harass enemies under their tower
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
_G.DEFAULT_HEALTH_EXHAUST = 20 --Minimal % of hp of enemy to cast exhaust


---THIS CONTROLS WHAT SORAKA WILL AUTOLVL WHEN AUTOLEVEL IS SET TO TRUE
_G.levelSequence = {_Q,_W,_E,_Q,_Q,_R,_Q,_W,_Q,_W,_R,_W,_W,_E,_E,_R,_E,_E,}

--She will NOT buy 2 of the same items in a rowput your custom shop list here if thats what you want
-- GO TO http://loldevelopers.de.vu/   FOR ITEM ID NUMBERS.
_G.DEFAULT_CUSTOMBUY = false
_G.customShopList = {
        3340, -- warding trinklet
        3303, -- Spell Thief Edge
        1006, -- rejuevenation bead
        1028, -- ruby crystal
        3105, -- Aegis
        3108, -- fiendish codex
        3060, -- Banner Of Command
        1001, -- bootsofspeed
        3092, -- Frost Queen
        3222, -- Mikaels Crucible
        3023, -- Twin Shadows
        3157, -- Zyhonyas
        3190, -- Locket
        3143, -- Randuins Omen
}

-- One Greeting is displayed at start of match
_G.Greeting = {'Sup','Hey','Yo','Hi', 'hi','Hiya','lets go for an early dragon','how we gonna do this?','sup guys','whats cracking','whats good','been a while since I seen that skin','Nice skin','nice skin','Hey, Whats up','I like this team','I lik R team','I like our team','I <3 this team','I <3 our team', 'we will win this','we wll win this', 'we got this', 'we got thiz', 'play smart, we scale better', 'yo play smart we scale more', 'yo play smart, we scale harder','play smart we have a better late game', 'Hi team', 'HI team', 'HI tea', 'Hiya guys', 'its playtime', 'time to rock and roll', 'time to lose control', 'lets go!','lets do this ^_^', 'goodluck', 'lets win', 'lets do our best', 'guard jungle', 'help jungelr', 'grd jungle', 'help jungle','leash?', 'think we can win?', 'have fun','hey guys', 'nice skin', 'lol we got this','ping for ult','GL HF','GL HF','GL HF','Gl Hf','gl hf','glhf','glhf <3',}

_G.Farewell = {'I am going to honor everyone', 'great game guys, honor for all', 'honoring you guys, awesome time','best team ive seen in awhile, im honoring you guys','thanks for carrying me, ill honor you guys','definately honoring this team','fun game, what type of honor do you want?','honors please','ggwp honors please','gg honors please','fun game, honors please','honors','ggwp honors','gg honors','fun game, honors','helpful honors please','ggwp helpful honors please','gg helpful honors please','fun game, helpful honors pleasee',}
-- _G.DQUOTES is the time between kills in which soraka will say something to enemy team
-- You may add your own lines of comments /insults here, just make sure to put a proper ',' between them.
_G.DQUOTES = 10000
_G.KillQuotes = {'/all I have lived for centuries, I will live past your attack.','/all you should have listened to the stars.','/all the stars scream of your ignorance.','/all idiot, did you think you could stand to my divine radiance.','/all like the stars, I can no longer hear your heart.','/all I could heal you, but I dont feel like it. ','/all pray we do not cross paths again, Pray to me!','/all your cruelty ends today.','/all you will go no further.','/all be at peace, fool.','/all such ugly in your hearts.','/all I will carry this.','/all you probably need an infusion.','/all run over by the wambulance.','/all death by banana.','/all no one expects the banana.','/all do you always fight so poorly? ','/all you do always fight so poorly?','/all do you always fight so poorly?','/all you do always fight so poorly?','/all so poorly?','/all always fight so poorly?','/all always fight so poorly?','/all I dont think ill save you.','/all I will not save you.','/all GG!','/all gg!','/all gg','/all there is no hope for you.','/all It is not in my nature to kill, but you were an exception.','/all that star few for thousands of years, just to kill you.','/all you overstep your boundaries, I am a God!','/all you will fall, like the stars, before me.','/all your star has fallen.','/all do you WISH to try me again?','/all your futile attempts amuse me.','/all give up now and I will tend your wounds.','/all you need a savior, instead you face one.','/all did you think you would escape?','/all get rakaed!'}
------ENCRIPT HERE PLEASE-------
------ENCRIPT HERE PLEASE-------
------ENCRIPT HERE PLEASE-------
------ENCRIPT HERE PLEASE-------
--UPDATE SETTINGS

local AutoUpdate = true
local SELF = SCRIPT_PATH..GetCurrentEnv().FILE_NAME
local URL = "https://raw.githubusercontent.com/Tc2r/BoL/master/TheRakaReturns.lua?"..math.random(100)
local UPDATE_TMP_FILE = LIB_PATH.."faeeafase.txt"
local versionmessage = "<font color=\"#5908f9\" >Changelog: Fixed Ult, Refined Clairvoyance </font>"

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
            if (Version ~= nil) and (Version > tonumber(version)) then
                file = io.open(SELF, "w")
                if file then

                    file:write(content)
                    file:flush()
                    file:close()
                    PrintChat("<font color=\"#5908f9\" >TheRakaReturns:</font> <font color=\"#00FF00\">Successfully updated to: v"..Version..". Please reload the script with F9.</font>")
                else
                    PrintChat("<font color=\"#5908f9\" >TheRakaReturns:</font> <font color=\"#FF0000\">Error updating to new version (v"..Version..")</font>")
                end
            elseif (Version ~= nil) and (Version == tonumber(version)) then
                    PrintChat("<font color=\"#5908f9\" >TheRakaReturns:</font> <font color=\"#00FF00\">No updates found, latest version: v"..Version.." </font>")
            end
        end
    end
end

--Dog Poop!!!