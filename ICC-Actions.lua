-- Lady Deathwhisper 
-- npcId == "36855" and spellId == 71420
--if aura_env.specificNPC[npcId][spellId] then end

aura_env.specificNPC = {
    ["36855"] = {
        [71420] = true,
    },
}




------------- SETTINGS ----------------
local LibDeflate = LibStub:GetLibrary("LibDeflate")
local LibSerialize = LibStub("LibSerialize")
local AceComm = LibStub:GetLibrary("AceComm-3.0")
local Prefix = "COZ_CD_ASSIGN"

aura_env.sendAssigns = function(data)
    local serialized = LibSerialize:Serialize(data)
    local compressed = LibDeflate:CompressDeflate(serialized)
    local encoded = LibDeflate:EncodeForWoWAddonChannel(compressed)
    AceComm:SendCommMessage(Prefix, encoded, "RAID", nil)
end

------------ VARIABLES ----------------
aura_env.AoL = false
aura_env.pewpew = false
aura_env.newAssigns = ""
aura_env.encID = 0
aura_env.abl_tbl = {}
aura_env.counters = {}

---------- ENCOUNTER ID TABLE ---------
aura_env.encounterIds =
{
    -- Icecrown Citadel
    [845] = true, -- Lord Marrowgar
    [846] = true, -- Lady Deathwhisper
    [847] = true, -- Icecrown Gunship Battle
    [848] = true, -- Deathbringer Saurfang
    [849] = true, -- Festergut
    [850] = true, -- Rotface
    [851] = true, -- Professor Putricide
    [852] = true, -- Blood Prince Council
    [853] = true, -- Blood-Queen Lana'thel
    [854] = true, -- Valithria Dreamwalker
    [855] = true, -- Sindragosa
    [856] = true, -- The Lich King
    
    -- The Ruby Sanctum
    [887] = true, -- Halion
    
    -- Icecrown Citadel
    --["Lord Marrowgar"] = 845,
    --["Lady Deathwhisper"] = 846,
    --["Icecrown Gunship Battle"] = 847,
    --["Deathbringer Saurfang"] = 848,
    --["Festergut"] = 849,
    --["Rotface"] = 850,
    --["Professor Putricide"] = 851,
    --["Blood Prince Council"] = 852,
    --["Blood-Queen Lana'thel"] = 853,
    --["Valithria Dreamwalker"] = 854,
    --["Sindragosa"] = 855,
    --["The Lich King"] = 856,
    -- The Ruby Sanctum
    --["Halion"] = 887,
    --["Baltharus the Warborn"] = 890,
    --["General Zarithrian"] = 893,
    --["Saviana Ragefire"] = 891,
} 

---------- BOSS EMOTE TABLE ---------
aura_env.yellEngageTriggers = {
    -- Lord Marrowgar
    ["The Scourge will wash over this world as a swarm of death and destruction!"] = true, --45 sec until first Blade Storm
    -- Lady Deathwhisper
    ["What is this disturbance?"] = true, -- 7 sec until adds | 30 sec until Dominate Mind on HC 
    -- Icecrown Gunship Battle
    ["Reavers, Sergeants, attack!"] = true, -- Trigger for <ADDS> ALLIANCE - 60 sec until adds & 82 sec to Mage spawn>> Repeat 60 sec & 82 sec
    ["Marines, Sergeants, attack!"] = true, -- Trigger for <ADDS> HORDE - 60 sec until adds
    ["Fire up the engines"] = true, -- Trigger for <WARMUP> ALLIANCE
    ["Rise up, sons and daughters"] = true, -- Trigger for <WARMUP> HORDE
    ["Onward, brothers and sisters"] = true, -- Trigger for <ENCOUNTER END> ALLIANCE
    ["Onward to the Lich King"] = true, -- Trigger for <ENCOUNTER END> HORDE
    -- Deathbringer Saurfang
    ["BY THE MIGHT OF THE LICH KING!"] = true, -- Encounter Start
}

---------- BOSS ABILITY TABLE ---------
aura_env.boss_abilities = {
    -- Icecrown Citadel
    [845] = { -- Lord Marrowgar
        SpellCastStart = {
            [69076] = true, -- Bonestorm - 3 sec cast
            [69057] = true, -- Bone Spike Graveyard - 3 sec cast
            [73142] = true, -- Bone Spike Graveyard - 1 sec cast            
        },
        SpellCastSuccess = {
            [69055] = true, -- Bone Slice
            [69075] = true, -- Bone Storm DMG TICKS - Duration [10M Nrm - 20, HC - ][25M Nrm - 20, HC - 30]            
        },
        SpellAuraAppliedRemoved = {
            [69076] = true, -- Bonestorm
            [69065] = true, -- Impale SEEMS to be the correct one
            [69062] = true, -- Impale ??
            [72669] = true, -- Impale ??
            [72670] = true, -- Impale ??
            [69146] = true, -- Coldflame        },
        },
    },
    [846] = { -- Lady Deathwhisper
        SpellCastStart = {
            [71420] = true, -- Frost Bolt from Lady Deathwhisper (interrupt rotation)
            [71254] = true, -- Shadow Bolt from Lady Deathwhisper
            [70901] = true, -- Dark Empowerment - 2 sec cast - Interrupt this spell
            [70900] = true, -- Dark Transformation - 2.5 sec cast - Interrupt this spell
        },
        SpellCastSuccess = {
            [71001] = true, -- Death and Decay - 10 sec duration - (Might be an Aura?)
            [71426] = true, -- Summon Spirit
        },
        SpellAuraAppliedRemoved = {
            [71001] = true, -- Death and Decay - 10 sec duration - (Might be an Aura?)
            [71289] = true, -- Dominate Mind -- 12 sec duration
            [71204] = true, -- Touch of Insignificance - Tank Debuff (20% reduced Threat per stack) - AURA_APLLIED AND DOSE
            [70768] = true, -- Shroud of the Occult
            [71237] = true, -- Curse of Torpor
            ----- AURA REMOVED -----
            [70842] = true, -- Mana Barrier
        },
    },
    [847] = { -- Icecrown Gunship Battle
        SpellCastStart = {
            [69705] = true, -- Below Zero - 0.5 sec cast 
        },
        SpellCastSuccess = {
            
        },
        SpellAuraAppliedRemoved = {
            [69705] = true, -- Below Zero - AURA_REMOVED >> Start Timer for next Application - 82 seconds to Ice Block and 60 seconds to Adds
        },
    },
    [848] = { -- Deathbringer Saurfang
        SpellCastStart = {
            [72293] = true, -- Mark of the Fallen Champion 1.5 sec cast
        },
        SpellCastSuccess = {
            [72173] = true, -- Call Blood Beast - 40 sec timer on ENCOUNTER_START
        },
        SpellAuraAppliedRemoved = {
            [72371] = true, -- Blood Power - AURA_APLLIED AND DOSE
            [72410] = true, -- Rune of Blood - 20 sec duration
            [72385] = true, -- Boiling Blood - 15 Sec duration
            [72293] = true, -- Mark of the Fallen Champion DEBUFF (Alot of spell id's for this one but this seems correct)
            [72737] = true, -- Frenzy - 30% attack speed for x seconds
        },
    },
    [849] = { -- Festergut
        SpellCastStart = {
            [0] = true, -- 
        },
        SpellCastSuccess = {
            [0] = true, --
        },
        SpellAuraAppliedRemoved = {
            [0] = true, -- 
        },
    },
    [850] = { -- Rotface
        SpellCastStart = {
            [0] = true, -- 
        },
        SpellCastSuccess = {
            [0] = true, --
        },
        SpellAuraAppliedRemoved = {
            [0] = true, -- 
        },
    },
    [851] = { -- Professor Putricide
        SpellCastStart = {
            [0] = true, -- 
        },
        SpellCastSuccess = {
            [0] = true, -- 
        },
        SpellAuraAppliedRemoved = {
            [0] = true, -- 
        },
    },
    [852] = { -- Blood Prince Council
        SpellCastStart = {
            [0] = true, -- 
        },
        SpellCastSuccess = {
            [0] = true, --
        },
        SpellAuraAppliedRemoved = {
            [0] = true, -- 
        },
    },
    [853] = { -- Blood-Queen Lana'thel
        SpellCastStart = {
            [0] = true, -- 
        },
        SpellCastSuccess = {
            [0] = true, --
        },
        SpellAuraAppliedRemoved = {
            [0] = true, -- 
        },
    },
    [854] = { -- Valithria Dreamwalker
        SpellCastStart = {
            [0] = true, -- 
        },
        SpellCastSuccess = {
            [0] = true, --
        },
        SpellAuraAppliedRemoved = {
            [0] = true, -- 
        },
    },
    [855] = { -- Sindragosa
        SpellCastStart = {
            [0] = true, -- 
        },
        SpellCastSuccess = {
            [0] = true, --
        },
        SpellAuraAppliedRemoved = {
            [0] = true, -- 
        },
    },
    [856] = { -- The Lich King
        SpellCastStart = {
            [69780] = true, -- Remorseless Winter - 2 sec cast
            [68981] = true, -- Remorseless Winter - 2.5 sec cast
            [72259] = true, -- Remorseless Winter - 2.5 sec cast
            
            [69242] = true, -- Soul Shriek - 0.5 sec cast
            [70358] = true, -- Summon Drudge Ghouls - 0.5 sec cast
            [70372] = true, -- Summon Shambling Horror - 1 sec cast
            [70541] = true, -- Infest - 2 sec cast
            [72133] = true, -- Pain and Suffering - 0.5 sec cast
            [72143] = true, -- Enrage - 1 sec cast
            [72149] = true, -- Shockwave - 1.25 sec cast
            [72262] = true, -- Quake - 1.5 sec cast
            [72350] = true, -- Fury of Frostmourne - 2.6 sec cast
            [73539] = true, -- Summon Shadow Trap - 0.5 sec cast
        },
        SpellCastSuccess = {
            [69781] = true, -- Remorseless Winter - instant
            [69037] = true, -- Summon Val'kyr
            [69099] = true, -- Ice Pulse
            [69103] = true, -- Summon Ice Sphere
            [69108] = true, -- Ice Burst
            [69200] = true, -- Raging Spirit
            [69409] = true, -- Soul Reaper
            [72754] = true, -- Defile
            [74074] = true, -- Plague Siphon
        },
        SpellAuraAppliedRemoved = {
            [68981] = true, -- Remorseless Winter - 60 sec duration
            [69781] = true, -- Remorseless Winter
            [68983] = true, -- Remorseless Winter
            
            [69242] = true, -- Soul Shriek - 5 sec duration
            [69409] = true, -- Soul Reaper - 5 sec duration
            [70337] = true, -- Necrotic Plague - 15 sec duration
            [70541] = true, -- Infest - ? duration
            [72133] = true, -- Pain and Suffering - 3 sec duration
            [72350] = true, -- Fury of Frostmourne - ? duration
            [74074] = true, -- Plague Siphon - 30 sec duration
        },
    },
    -- The Ruby Sanctum
    ["Baltharus the Warborn"] = {
        SpellCastStart = {
        },
        SpellCastSuccess = {
        },
        SpellAuraAppliedRemoved = {
        },
    },
    
    ["General Zarithrian"] = {
        SpellCastStart = {
        },
        SpellCastSuccess = {
        },
        SpellAuraAppliedRemoved = {
        },
    },
    ["Saviana Ragefire"] = {
        SpellCastStart = {
        },
        SpellCastSuccess = {
        },
        SpellAuraAppliedRemoved = {
        },
    },
    [887] = { -- Halion
        SpellCastStart = {
        },
        SpellCastSuccess = {
        },
        SpellAuraAppliedRemoved = {
        },
    },
}

---------- SPELL RULES ---------
local PC = 66013 -- Penetrating Cold (Anub'arak)
local LS = 66118 -- LeechingSwarm (Anub'arak)

-- Table to assign all the spells that have special rules to them
aura_env.flaggedSpells = {
    [LS] = true,    
}

-- Setting the flags of the aura_env.flaggedSpells
aura_env.spellFlags = {    
    [LS] = false,  -- Leeching swarm (Anub'arak)    
}

-- Assigning a spell that adheres to the rule of the flagged spells
aura_env.spellRules = {
    [PC] = aura_env.spellFlags[LS]
}

---------------------------------------
-------------- Functions --------------
---------------------------------------
--~~~~~~ SPLIT STRING TO ARRAY ~~~~~~--
local function SplitMSG(msg, d)
    local split_msg = {} 
    for part in msg:gmatch("([^"..d.."]+)") do
        table.insert(split_msg, part)
    end
    return split_msg
end

--~~~~~~ GENERATE THE ADDON MESSAGE ~~~~~~--
aura_env.generateAddonMessage = function(spellId,count)
    local addonMessages = {}      
    for bossSpellId, data in pairs(aura_env.newAssigns) do
        if bossSpellId == spellId then
            local order = data[count]
            if order then
                for _, assigns in ipairs(order) do
                    local assignedPlayer = assigns[1]
                    local spellId = assigns[2]
                    local delay = assigns[3] or 0
                    local amVariant = assigns[4] or 0         
                    local customSound = assigns[5] or "default"
                    local msg = assignedPlayer .. ";" .. spellId .. ";" .. delay .. ";" .. amVariant .. ";".. customSound
                    table.insert(addonMessages, msg)
                end
            end
        end
    end      
    return addonMessages
end
--~~~~~~~~~~ Import Assignments From Sheet ~~~~~~~~~~~--
aura_env.getImportedAssignments = function()
    
    local rawImport = strtrim(aura_env.config.ImportOptions.assignments, " \"\t\r\n")
    --local importString = strtrim(aura_env.config.ImportOptions.assignments, " \"\t\r\n")
    local assignmentsImport = ""
    local countersImport = ""
    local inCounters = false
    
    for line in rawImport:gmatch("[^\r\n]+") do
        if line:match("^%[") then
            inCounters = true
            countersImport = countersImport .. line:sub(2)
        elseif line:match("%]$") then
            inCounters = false
            countersImport = countersImport .. line:sub(1, -2)
        elseif inCounters then
            countersImport = countersImport .. line
        else
            assignmentsImport = assignmentsImport .. line
        end
    end
    
    
    local splitAssignments = SplitMSG(assignmentsImport, ",")
    local splitCounters = SplitMSG(countersImport, ",")
    
    local newAssignments = {}
    local resetCounters = {}
    
    local dataSizeAssigns = 7
    local dataSizeCounters = 2
    
    local numRangesAssigns = math.ceil((#splitAssignments) / dataSizeAssigns)
    local numRangesCounters = math.ceil((#splitCounters) / dataSizeCounters)
    
    if aura_env.config.debug.importController then
        print("|cfffe7a00","[Cozroth's-Sender]:", "|r", "Do the","|cff55d0ff", "BLUE","|r" ,"Numbers Match?")
        print("|cfffe7a00","[Cozroth's-Sender]:", "|r", "Assignments values: ", #splitAssignments, "/", dataSizeAssigns, " = ",
        "|cff55d0ff", #splitAssignments/dataSizeAssigns, "|r", "|","|cff55d0ff", numRangesAssigns,"|r")
        print("|cfffe7a00","[Cozroth's-Sender]:", "|r", "Do the","|cffffee55", "YELLOW", "|r", "Numbers Match?")
        print("|cfffe7a00","[Cozroth's-Sender]:", "|r", "Counter Reset values: ",#splitCounters, "/", dataSizeCounters, " = ",
        "|cffffee55",#splitCounters/dataSizeCounters, "|r", "|","|cffffee55", numRangesCounters, "|r")
        
        if #splitAssignments/dataSizeAssigns == numRangesAssigns and #splitCounters/dataSizeCounters == numRangesCounters then
            print("|cfffe7a00","[Cozroth's-Sender]:", "|r", "|cff77ff55", "Successfully generated Assignments from Imported String","|r")
        else
            print("|cfffe7a00","[Cozroth's-Sender]:", "|r", "|cffff0000", "WARNING!", "|r")
            print("|cfffe7a00","[Cozroth's-Sender]:", "|r","|cffff5555", "Could NOT genereate the Assignments from imported String", "|r")
        end
    end
    
    for i = 1, numRangesAssigns do
        local bossSpellId = tonumber(strtrim(splitAssignments[i * dataSizeAssigns - 6])) or 0
        local order = tonumber(strtrim(splitAssignments[i * dataSizeAssigns - 5])) or 1  
        local player = strtrim(splitAssignments[i * dataSizeAssigns - 4]) or ""
        local spellId = tonumber(strtrim(splitAssignments[i * dataSizeAssigns - 3])) or 0
        local delay = tonumber(strtrim(splitAssignments[i * dataSizeAssigns - 2])) or 1
        local amVariant = tonumber(strtrim(splitAssignments[i * dataSizeAssigns - 1])) or 0
        local customSound = strtrim(splitAssignments[i * dataSizeAssigns - 0]) or "default"
        local assignment = { player, spellId, delay, amVariant, customSound }
        
        if not newAssignments[bossSpellId] then
            newAssignments[bossSpellId] = {}
        end
        
        if not newAssignments[bossSpellId][order] then
            newAssignments[bossSpellId][order] = {}
        end
        
        table.insert(newAssignments[bossSpellId][order], assignment)
    end
    
    for i = 1, numRangesCounters do 
        local bossSpellId = tonumber(strtrim(splitCounters[i * dataSizeCounters - 1])) or 0
        local resetCount = tonumber(strtrim(splitCounters[i * dataSizeCounters - 0])) or 0
        
        if not resetCounters[bossSpellId] then
            resetCounters[bossSpellId] = {}
        end
        
        table.insert(resetCounters[bossSpellId], resetCount)
    end
    return newAssignments, resetCounters
end


--[[

CD SPELL ID's
70940, -- "Divine Sacrifice"
31821, -- "Aura Mastery"
10278, -- "Hand of Protection"
642,   -- "Divine Shield"
64843, -- "Divine Hymn"
64843, -- "Pain Suppression"
6940,  -- "Hand of Sacrifice"
47788, -- "Guardian Spirit"
1766, -- "Kick" > Change based on class in RECIEVER

AURA SPELL ID's
19746, -- Concentration Aura
48947, -- Fire Resistance Aura 
48943, -- Shadow Resistance Aura 
48945, -- Frost Resistance Aura 

Import should look like this

bossSpellId,order,playerName,cdToUse,delay,amVariant,customSound
    bossSpellId = the boss ability spell ID
    order = the Order to use the assignments 1 = the first time the boss uses a spell
    playerName = the name of the character being assigned
    cdToUse = spell ID of the assigned CD that the player should use
    delay = delay in seconds when to use the CD (in seconds), default to 1
    amVariant = IF the cdToUse is Aura Mastery, this should be assigned to the spell ID of the AURA to use with Aura Mastery, otherwise 0
    customSound = the path to the custom sound. This should be set to default if no custom sound are given!

EXAMPLE WITH NO CUSTOM SOUND:
48785,1,Kozroth,70940,1,0,default,
48785,2,Kozroth,10278,1,0,default,
-----------------------------------------

EXAMPLE WITH A CUSTOM SOUND:
48785,2,Kozroth,1766,1,0,Interface\Addons\FolderPathToYourSound\sound\Divine Hymn.ogg,
48782,1,Kozroth,31821,1,19746,Interface\Addons\FolderPathToYourSound\sound\Aura Mastery.ogg,
-----------------------------------------
--]]

