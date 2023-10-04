
local _,_,_,_,_,npcId,_= strsplit("-", sourceGUID)

--npcId == "36855" and spellId == 71420
if aura_env.specificNPC[npcId][spellId] then

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
-------------------------------
