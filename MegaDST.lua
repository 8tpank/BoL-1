local version = "1.8"
--By Tc2r
--Framework From Rmoises
local deathDelay = 120
local talkDelay = 760
local congdelay = 0
local pausedelay = 0
local wardsdelay = 0
Endgame = 0
game = nil
welldone = false
allies = {}
playchampname = {}
akills = {}
awards = {}
akwards = {}

local AutoUpdate = true
local SELF = SCRIPT_PATH..GetCurrentEnv().FILE_NAME
local URL = "https://raw.githubusercontent.com/Tc2r/BoL/master/MegaDST.lua?"..math.random(100)
local UPDATE_TMP_FILE = LIB_PATH.."dsjtsdst.txt"
local versionmessage = "Added Champion Name Recognition and usage!"

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
            tmp, sstart = string.find(content, "local version = \"")
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
                    PrintChat("<font color=\"#995599\" >MegaDST_Coopmode</font> <font color=\"#00FF00\">Successfully updated to: v"..Version..". Please reload the script with F9.</font>")
                else
                    PrintChat("<font color=\"#995599\" >MegaDST_Coopmode</font> <font color=\"#FF0000\">Error updating to new version (v"..Version..")</font>")
                end
            elseif (Version ~= nil) and (Version == tonumber(version)) then
                    PrintChat("<font color=\"#995599\" >MegaDST_Coopmode</font> <font color=\"#00FF00\">No updates found, latest version: v"..Version.." </font>")
            end
        end
    end
end


local TempFix = {'who should we jump on?','who should initiate for us next time?','who should we focus next time?','what should I build ?','where should we ward?','think we can get the next dragon?','can we win if we group?','what must we do to win this?','think we can split push or team up?','goodjob guys','goodjob guys, we have a chance','we got this :D','we got this^_^','we got this:)','we got this:-D','we got this 8)','we got this :P','play smart','dont fight each other','I like this team','nice plays, we can win this','play smart, we winning','few mistakes but well win','You guys kick ass!','you are really good at this','you are such a good teammate :D','I love your mechanics','you must practice a ton','Wow nice cs','Man youre impressive','youre talented','Im glad youre on my team','I<3you', 'i<3U',':D <3','Dang youre good at laning','good plays guys','lol we got this','what are you guys going to build?','should we push mid or split push?' ,'this is my team, I like yall, keep going','good effort', 'great warding','I like your style', 'well done!', 'Nice positioning controls','nice energy', 'great item build :D','I feel confident','that was brave','we can do this!','I believe','you can do it','that wasnt funny, i dont know any jokes','you guys are beautiful','lets not argue','way to go!','lets keep trying','that was really smart!','careful we dont throw our lead ^.~','dont be afraid, team fight','s okay no worries','it will be worth it!','they throwing lol, see!','we CAN do this','just have fun, we got this','I love you!<3','Anything is possible','nj ','he flashed?','ty','>_<',':0 whoa!',':)','gg wll win','nice','<3','still got my nike boots!','our team fights are crushing themr','gj','lets have a good game!','thanks','dont be too risky','lets win this','=D','gjgj','we need to group','stay grouped and we win','only fight as a team','push towers quick','drag warded','dont worry this is easy we will win', 'we got this', 'we will be fine', 'we out scale them dont worry', 'our team fight is amazing', 'we secure dragons and we will win.', 'keep it up we got this.', 'we are winning' ,'no worries we will win','i know we are better then them', 'these kids are bad we got this','we will poop on them','keep things warded and we should be fine','We are really op','This champion is fun','Lol, these kids cant keep up, we will win!','XD','good deal', 'late game is ours', 'their scaling sucks', 'they have no organization', 'they arent going for objectives', 'lets rock them', 'i believe','their team is horrible ^_~ ', 'They play like wood 3 elo, we got this','turn down for what?','wards wards good for the heart?','you are rly good','lets group and win','thanks for carrying me','great awareness guys','hang in there','we should ward our jungle, might make them throw','what should we do now?','who should initiate for us next time?','who should we focus next time?','what should I build next?','where should we ward?','think we can get the next dragon?','can we win if we group?','what must we do to win this?','should we split push or team up?','lets go out fighting', 'they can still throw',' we will make a comeback','this isnt over','this is still winnable','this IS still winnable','we will recover','we can recover','just chill, we got late game','we got late game','hold out, they will throw','hold out, we will come back','hold out, this isnt over','hold out, this is still winnable','hold out, we can savage this game','hold out, they will make mistakes','hold out, everyone ward','hold out, play smarter','dont give up just yet, they will throw','dont give up, we will come back','dont give up, this isnt over','dont give up, they can make mistakes','dont give up, we still have a chance','dont give up, we can recover','dont give up, everyone place wards','dont give up, play smarter','dont give up','few mistakes but we will win','lets keep tryin, no point in giving up','we outscale them dont worry','should we push mid or split push?','good effort, dont give up','dont argue, focus on winning','careful we dont overextend ^.~','we CAN do this', 'lets keep tryin', 'we crush them in teamfights','we will be fine', 'we outscale them dont worry', 'our teamfight is amazing','keep it up we got this.', 'we can win' ,'no worries we will win','keep things warded and we should be fine','we are really op late game','we secure the next dragon and we will win.','late game is ours', 'their scaling sucks', 'they have no organization', 'they arent going for objectives','we are still in this','if we focus the squishes i think we got this'}

--- Quotes to say at game end
local Farewell = {'I am going to honor everyone', 'great game guys, honor for all', 'honoring you guys, awesome time','best team Ive seen in awhile, im honoring you guys','thanks for carrying me, ill honor you guys','definitely honoring this team','fun game, what type of honor do you want?','honors please','ggwp honors please','gg honors please','fun game, honors please','honors','ggwp honors','gg honors','fun game, honors','helpful honors please','ggwp helpful honors please','gg helpful honors please','fun game, helpful honors pleasee',}

--- Quotes to say when Winning
local WinningQuotes  = {'lets finish this game','we should ward their jungle, so that they throw','what should we do with our lead?','who should we jump on?','who should initate for us next time?','who should we focus next time?','what should I build now to push the advantage?','where should we ward?','think we can get the next dragon with our lead?','since were winning,can we win if we group?','what must we do to win this?','should we use our lead to split push or team up?','goodjob guys, lets bring it home','goodjob guys, lets finish it','we got this :D','we got this^_^','we got this:)','we got this:-D','we got this 8)','we got this :P','play smart, we winning :D','play smart, we winning ^_^','we are winning, play smart:)','play smart, we winning :-D','play smart, we winning 8)','play smart, we winning :P','objectives','objectives ^_^','objectives :)',' objectives :D','they are throwing','they are throwing :D','they are throwing ^_^',' they are throwing :P','dont fight each other','I like this team','nice plays, we can win this','play smart, we winning','few mistakes but well win','You guys kick ass!','you are really good at this','you are such a good teammate :D','I love your mechanics','you must practice a ton','Wow nice cs','Man youre impressive','youre talented','Im glad youre on my team','I<3you', 'i<3U',':D <3','Dang youre good at laning','good plays guys','lol we got this','what are you guys going to build?','should we push mid or split push?' ,'this is my team, I like yall, lets finish it','good effort', 'great warding','I like your style', 'well done!', 'Nice positioning controls','nice energy', 'great item build :D','I feel confident','that was brave','we can do this!','I believe','you can do it','that wasnt funny, i dont know any jokes','you guys are beautiful','a fun match? this is a blessing','lets not argue','way to go!','lets keep tryin','that was really smart!','careful we dont throw our lead ^.~','dont be afraid, teamfight','s okay no worries','it will be worth it!','they throwing lol, see!','we CAN do this','just have fun, we got this','I love you!<3','Anything is possible','nj ','he flashed?','ty','>_<',':0 whoa!',':)','gg wll win','nice','<3','still got my nike boots!','our teamfights are crushing them','gj','lets have a good game!','thanks','dont be risky','lets win this','=D','gjgj','we need to group','stay grouped and we win','only fight as a team','push towers quick','drag warded','dont worry this is easy we will win', 'we got this', 'we will be fine', 'we outscale them dont worry', 'our teamfight is amazing', 'we secure dragons and we will win.', 'keep it up we got this.', 'we are winning' ,'no worries we will win','i know we are better then them', 'these kids are bad we got this','we will poop on them','keep things warded and we should be fine','We are really op','This champion is fun','Lol, these kids cant keep up, we will win!','XD','good deal', 'great rotation!', 'late game is ours', 'their scaling sucks', 'they have no organization', 'they arent going for objectives', 'lets rock them', 'i believe','their team is horrible ^_~ ', 'They play like wood 3 elo, we got this','turn down for what?','wards wards good for the heart?','you are rly good','lets group and win','thanks for carrying me','great awareness guys'}

--- Quotes to say when Losing
local LosingQuotes  = {'hang in there','we should ward our jungle, might make them throw','what should we do now?','who should initate for us next time?','who should we focus next time?','what should I build next?','where should we ward?','think we can get the next dragon?','can we win if we group?','what must we do to win this?','should we split push or team up?','lets go out fighting', 'they can still throw',' we will make a comeback','this isnt over','this is still winnable','this IS still winnable','we will recover','we can recover','just chill, we got late game','we got late game','hold out, they will throw','hold out, we will come back','hold out, this isnt over','hold out, this is still winnable','hold out, we can savage this game','hold out, they will make mistakes','hold out, everyone ward','hold out, play smarter','dont give up just yet, they will throw','dont give up, we will come back','dont give up, this isnt over','dont give up, they can make mistakes','dont give up, we still have a chance','dont give up, we can recover','dont give up, everyone place wards','dont give up, play smarter','dont give up','few mistakes but we will win','lets keep tryin, no point in giving up','we outscale them dont worry','should we push mid or split push?','good effort, dont give up','dont argue, focus on winning','careful we dont overextend ^.~','we CAN do this', 'lets keep tryin', 'we crush them in teamfights','we will be fine', 'we outscale them dont worry', 'our teamfight is amazing','keep it up we got this.', 'we can win' ,'no worries we will win','keep things warded and we should be fine','we are really op late game','we secure the next dragon and we will win.','late game is ours', 'their scaling sucks', 'they have no organization', 'they arent going for objectives','we are still in this','if we focus the squishes i think we got this'}

--- Quotes to say when you die
local ThingsDead  = {'oops lol','shit sorry', 'damn my bad','myfault','my fault','ill play better','my mistake','T_T my fault', '>.<','trying, sorry','I wont do that again','sorry guys', 'ewww, I messed up','x_x ill play more safely', 'man down, think i need some help MEDIC','sry','sorry','sorry guys','died, sorry','IM SRY','this is a bit tough on me, sorry','Darn, messed up', 'I will try not to die again','alright, serious mode >.<', 'outplayed, sorry', 'ill be more careful','Ill do better, sorry','how stupid of me, sorry i died','how careless, sorry team','my bad, how stupid of me','should not have died,sorry', 'sorry, thats my fault','sry i died, pls dont be mad at me'}

--- puzzle pieces to form complex chats
local KillBoost = {'great kill', 'damn dude, carry me harder','gjgj ','gj ','gj ','gj ','gj ','gj ','gj ','gj ','gj ','gj ','gj ','gjgjgjgjgjgj ','gjgjgjgjgj ','gjgjgj ','that kill blew my mind','the skill!!! ', 'nice! ','the plays!! ','HELL YEAH!','good deal! ','Goodjob! ','Goodjob:) ','Goodjob ^_^ ','Goodjob =) ','sweetness ','Goodjob :P ','!Goodjob! ','goodjob! ','goodjob:) ','goodjob ^_^ ','goodjob =) ','goodjob :P ','!goodjob! ','Greatjob! ','Great job:) ','Great job ^_^ ','Great job =) ','Great job :P ','Great Job! ','greatjob! ','great job:) ','great job ^_^ ','great job =) ','great job :P ','great Job! ','Gj! ','Gj:) ','Gj ^_^ ','Gj =) ','Gj :P ','GJ! ','Nj! ','NJ:) ','Nj ^_^ ','Nj =) ','Nj :P ','NJ! ','nj! ','nJ:) ','nj ^_^ ','nj =) ','nj :P ','nJ! ','well played! ','well played:) ','well played ^_^ ','well played =) ','well played :P ','WELL PLAYED! '}

--- puzzle pieces to form complex chats
local SpecificBoost = {'carry me ','crry me ','keep it up ','thats the way ','well played ','Playmaker ','Champion ',' challenger lvl ','mster lvl ','Thats My ','This Boss ','This Kingpin ','LCS Lvl ','Keep it up ','Are you smurfing ','This amazing ','good call ','can i ride your shoulders ','good stuff ','nj ','nj ','nj ','nj ','nj ','nj ','nj ','nj ','nj ','nj ','nj ','nj ','nj ','nj ','nj ','nj ','nj ','nj ','nj ','nj ','nj ','nj ','nj ', 'gj ','gj ','gj ','gj ','gj ','gj ','gj ','gj ','gj ','gj ','gj '}

--- puzzle pieces to form complex chats
local ProBoost = {'Madlife ','Froggen ','Dade ','Arrow ','xPeke ','Uzi ','Faker ','Insec ','Xiyang ','Voyboy ','Scarra ','Saintvicious ','Doublelift ','Aphromoo ','Patoy ','Wickd ','Diamondprox ','Lamia ','Edward ','Maknoon ','Toyz ','Weixiao ','Pray ','Dyrus ','Stanley ','Wildturtle ','theOddOne ','Trick2G ','Flosd ','Cowsep ',' Bjergsen ','Grossie ','Nightblue ','PhantomLord ','Nyjacky ','Lustboy ','Gleeb ','ninjaken ','MegaZero ','Amazing ','Reginald ','Wingsofdeathx ','Chaox ','TheRainman ','InnoX ','Helios ','Pobelter ','Altec ','Krepo ','Snoopeh ','yellowpete ','DkBnet ','Hai ','Sneaky ','LemonNation ','Yazuki ','otter ','Dinh ','Meyea ','Kez ','KiwiKid ','Heartbeat '}

--- puzzle pieces to form complex chats
local ProComp ={' you remind me of ','you play like ',' your playstyle is close to ',' you play the same as ',' you play similar to ',' are you  ',' are you smurfing ',' smurf ',' playmaker ',' mechanics like  ',' mechanics close to ',' mechanics similar to ',' getting kills like ',' nice kill ',' nice moves ',' comboing the same as ',' positioning close to ',' positioning like ',' positioning reminding me of  ',' attacking like  ',' good focusing ',' show me more plays ',' can i be your student ',' teach me ',' that was tight ',' that was cool ',' that was raw ',' that was fire ',' ice cold  ',' someone call the firemen on our ',' FINISH HIM! Fatality ',' brutality ',' jukes like ',' dodging like ',' you move like ',' carry me  ',' marry me ',' carry me please  ',' marry me please  ',' carry me pls ',' marry me pls ',' have my babies ',' make me babies ',' bare my children ',' good kill ',' awesome kill  ',' fly kill  ',' boss kill ',' badass kill  ',' fire kill',' ice cold kill ',' pimp kill ',' phat kill ',' rad kill ',' sharp kill ',' unreal kill ',' vicious kill ',' wicked kill ',' wick kill ',' wizard ',' sweet action ',' solid ',' gr8 kill ',' epic kill '}

--- puzzle pieces to form complex chats
local ProJection ={'Holy cow ','Jesus ','Daang ','Dang ','Damn ','Omg ','Dear lord ','Wowsers ','Mother of God ','Whoa ','Holy shit ','Hly shit ','What the ??? ','Cool ','so so ','Wicked ','Wicked cool ','Tight ','Killer ','zomfg ','zomg ','hells to the yes ','good looking out ','good call ','holy smokes ','man ','OMLG ','fuck me ','Dats whats up '}

--- puzzle pieces to form complex chats
local WardPlace ={'Nice warding ','Great Vision ','good vision ', 'nice warding','thanks for warding ','nice map control ','gj warding ','gj warding ','gj warding ','nj warding ','nj warding ','these wards! keep up the good work '}

--- puzzle pieces to form complex chats
local Deward ={'great map control ','good map control ','nice map control ','best map control ','good map control ','good map control ','great vision control ',':D kill all the wards '}


function GetPlayers(team, includeDead, includeSelf)
  local players = {}
  local result = {}

  if team == player.team then
    players = GetAllyHeroes()
  else
    players = GetEnemyHeroes()
  end

  for i=1, #players, 1 do
    if players[i].visible and (not players[i].dead or players[i].dead == includeDead) then
      table.insert(result, players[i])
    end
  end

  if includeSelf then table.insert(result, player)
  else
    for i=1, #result, 1 do
      if result[i] == player then
        table.remove(result, i)
        break
      end
    end
  end

  return result
end

function OnLoad()
      if AutoUpdate then
       Update()
    end
  game = GetGame()
  deathDelay = os.clock() + deathDelay
  talkDelay = os.clock() + talkDelay
  DST = scriptConfig("Tc2rs D.S.T. CO-OP","DST")
  DST:addParam("Friendly Banter?", "banter", SCRIPT_PARAM_ONOFF, true)
  DST:addParam("Delay", "Banter Delay",SCRIPT_PARAM_SLICE, 400, 100, 3000, -2)
   DST:addParam("CDelay", "Delay Between GJs",SCRIPT_PARAM_SLICE, 120, 20, 3000, -1)
  DST:addSubMenu("Good Job Options!", "goodjob", SCRIPT_PARAM_ONOFF, true)

  DST.goodjob:addParam("Comparison GJs?", "compare", SCRIPT_PARAM_ONOFF, false)
  DST.goodjob:addParam("Personal GJs?", "personal", SCRIPT_PARAM_ONOFF, true)
  DST.goodjob:addParam("Simple GJs", "simple", SCRIPT_PARAM_ONOFF, true)
  DST:addParam("Sorry", "Apologize 4 Deaths?",SCRIPT_PARAM_ONOFF, true)
  if DST.Sorry then
    DST:addParam("SDelay", "Sry 4 Death Delay",SCRIPT_PARAM_SLICE, 700, 300, 4000, -2)
  end
  for i, ally in ipairs(GetAllyHeroes()) do
    local teammate = ally
    if teammate.team == myHero.team then DST:addParam("positiveto"..i, "Positive to "..teammate.charName, SCRIPT_PARAM_ONOFF, true) end
  end
  for i, ally in ipairs(GetAllyHeroes()) do
   DST["positiveto"..i] = true
  end
--DST:addParam("WDelay", "Compliment Warding",SCRIPT_PARAM_SLICE, 60, 10, 1000, -1)

  allies = GetPlayers(myHero.team, true, false)
  for i=1, #allies, 1 do
    akills[i] = allies[i].kills
    if allies[i].charName == "DrMundo" then
      playchampname[i] = "DrMundo"
    elseif allies[i].charName == "JarvanIV" then
      playchampname[i] = "Jarvan"
    elseif allies[i].charName == "MasterYi" then
      playchampname[i] = "Yi"
    elseif allies[i].charName == "MissFortune" then
      playchampname[i] = "Fortune"
    elseif allies[i].charName == "XinZhao" then
      playchampname[i] = "Xin"
    elseif allies[i].charName == "MonkeyKing" then
      playchampname[i] = "Wukong"
    else
      playchampname[i] = allies[i].charName
    end
    playchampname[i] = string.lower(playchampname[i])
  end
end


function CompareTeams()
  local enemykills = 0
  local alliedkills = 0
  local winning = false
  for i, enemy in ipairs(GetEnemyHeroes()) do
    enemykills = enemy.kills + enemykills
    --print(enemy.name.." has "..enemy.kills.."kills")
  end
  for i=1, heroManager.iCount do
    local ally = heroManager:GetHero(i)
    if ally.team == myHero.team then
      alliedkills = ally.kills + alliedkills
    end
  end
  --print("ally kills : "..alliedkills)
  --print("enemy kills : "..enemykills)
  if(enemykills < alliedkills) then
    winning = true
  else
    winning = true -- false once .kills is working again
  end
  return winning
end

function KillPos(i)
  math.randomseed(os.time())
  if gameState == true and DST["positiveto"..i] then

    local ranN = math.random(1,100)
    local ranName = math.random(1,100)
    if ranN > 93 and DST.goodjob.compare then
      if ranName > 50 then
        SendChat(ProJection[ math.random( #ProJection ) ]..string.lower(string.sub(allies[i].name, 0,(math.random(5,10))))..ProComp[ math.random( #ProComp ) ]..ProBoost[ math.random( #ProBoost ) ]  )
      else
        SendChat(ProJection[ math.random( #ProJection ) ]..string.lower(string.sub(playchampname[i], 0,(math.random(4,7))))..ProComp[ math.random( #ProComp ) ]..ProBoost[ math.random( #ProBoost ) ]  )
      end
    elseif ranN > 74 and DST.goodjob.personal then
      if ranName > 50 then
        SendChat(SpecificBoost[ math.random( #SpecificBoost ) ]..string.lower(string.sub(allies[i].name, 0,(math.random(5,10)))))
      else
        SendChat(SpecificBoost[ math.random( #SpecificBoost ) ]..string.lower(string.sub(playchampname[i], 0,(math.random(4,7)))))
      end
    elseif ranN > 50 and DST.goodjob.simple then
        SendChat(KillBoost[ math.random( #KillBoost ) ])
    end
  else
    local ranN = math.random(1,100)
    local ranName = math.random(1,100)
    if ranN > 70 and DST.goodjob.compare then
      if ranName > 50 then
        SendChat(SpecificBoost[ math.random( #SpecificBoost ) ]..string.lower(string.sub(allies[i].name, 0,(math.random(5,10))))..", "..LosingQuotes[ math.random( #LosingQuotes ) ])
      else
        SendChat(SpecificBoost[ math.random( #SpecificBoost ) ]..string.lower(string.sub(playchampname[i], 0,(math.random(4,7))))..", "..LosingQuotes[ math.random( #LosingQuotes ) ])
      end
    elseif ranN > 40 and DST.goodjob.personal then
       SendChat(KillBoost[ math.random( #KillBoost ) ]..LosingQuotes[ math.random( #LosingQuotes ) ])
    end
  end
end

function OnTick()
      if game.isOver and Endgame == 0 then
        TempRNG = #Farewell
        SendChat( Farewell[ math.random(TempRNG) ] )
        Endgame = 1
       return
    end
--print(myHero.name.." has "..myHero.minionScore.."kills")
--print(myHero.name.." has "..myHero.minionKill.."kills")

  --[[
  if myHero.wardsUse > 0 then
    print("Somethingworked")
end
  --print(allies[1].wardPlaced)

for i=1, #awards, 1 do

  if awards ~= nil and allies[1].wardPlaced ~= nil  then
    if(allies[i].wardPlaced > awards[1]) then
        SendChat("nice warding!")
      if os.clock() > wardsdelay then
        print("awesome warding!")
        --DelayAction(function() KillPos() end, 3)
        wardsdelay = os.clock() + DST.WDelay
      end
      awards[i] = allies[i].wardPlaced
    end
  end
end
for i=1, #akwards, 1 do
  if akwards ~= nil and allies[i].wardKill ~= nil  then
    if(allies[i].wardKill ~= akwards[i]) then
      if os.clock() > wardsdelay then
        --DelayAction(function() KillPos() end, 3)
        wardsdelay = os.clock() + DST.WDelay
      end
      awards[i] = allies[i].wardKill
    end
  end
end
]]--
CompareTeams()
for i=1, #akills, 1 do
	if akills ~= nil and allies[i].kills ~= nil then
		if(allies[i].kills ~= akills[i]) then
      if os.clock() > congdelay then
        gameState = CompareTeams()
        DelayAction(function() KillPos() end, 3)
				congdelay = os.clock() + DST.CDelay
			end
			akills[i] = allies[i].kills
		end
	end
end
  --welldone = true
  -- TEMP FIX FOR SCRIPT  UNTIL THEY FIX .kill
for j, enemy in ipairs(GetEnemyHeroes()) do
    if InFountain(enemy) ~= true and enemy ~= nil and enemy.visible == true and enemy.dead == true and welldone == false then
        for i, ally in ipairs(GetAllyHeroes()) do
          if (ally:GetDistance(enemy) < 1000) and welldone == false then
          if os.clock() > congdelay then
              gameState = CompareTeams()
              DelayAction(function() KillPos(i) end, 4)
              congdelay = os.clock() + DST.CDelay
              welldone = true
          end
          end
        end
        welldone = false


    end
end



if os.clock() > deathDelay and myHero.dead and DST.Sorry then
	if (math.random(1,100) < 40) then
		SendChat( ThingsDead[ math.random( #ThingsDead ) ] )
	end
	deathDelay = os.clock() + DST.SDelay -- DELAY METHOD VERY IMPORTANT
end

  if os.clock() > talkDelay  then
    gameState = CompareTeams()
    --print(gameState)
    if gameState == true then
       SendChat( TempFix[ math.random( #TempFix ) ] )
  	   --SendChat( WinningQuotes[ math.random( #WinningQuotes ) ] )
    --else
      --SendChat( LosingQuotes[ math.random( #LosingQuotes ) ] )
        --SendChat( LosingQuotes[ math.random( #LosingQuotes ) ] )
	end
talkDelay = os.clock() + math.random((DST.Delay - 30) , (DST.Delay + 30)) -- DELAY METHOD VERY IMPORTANT
end


end