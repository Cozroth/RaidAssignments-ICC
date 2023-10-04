function(event,_,subEvent,...)
    if not aura_env.AoL and not aura_env.pewpew then return false end
    if not type(aura_env.newAssigns) == "table" then return false end
    if subEvent == "SPELL_CAST_START" then
        local _, sourceGUID, sourceName, _, _, destGUID, destName, _, _,spellId, spellName = ...
        
        -- print("sourceName: ", sourceName, "\n","destName: ", destName,"\n","spellId: ", spellId,"\n","spellName: ", spellName)
        
        if (aura_env.abl_tbl.SpellCastStart and aura_env.abl_tbl.SpellCastStart[spellId]) then
            
            if aura_env.flaggedSpells[spellId] then aura_env.flaggedSpells[spellId] = true end
            
            if not (aura_env.spellRules[spellId] ~= false) then 
                
                if aura_env.resetCounter[spellId] then
                    if aura_env.counters[spellId] == aura_env.resetCounter[spellId] then
                        aura_env.counters[spellId] = 0
                    end      
                end    
                
                
                if aura_env.counters[spellId] then
                    aura_env.counters[spellId] = aura_env.counters[spellId] + 1    
                end
                
                --print("|CFFff41eb", "SPELL_CAST_START","\nSpell - ", spellName, "[", spellId, "]", " - Counter: ", aura_env.counters[spellId], "|r")
                
                local addonMessages = aura_env.generateAddonMessage(spellId, aura_env.counters[spellId])
                
                for _, msg in ipairs(addonMessages) do
                    -- print("|CFFff41eb","SPELL_CAST_START","\nSending assignments", "|r")
                    aura_env.sendAssigns(msg)
                end
                return true
            end
        end        
    end ------v ADD EVENTS HERE v---------
    
    
    if subEvent == "SPELL_CAST_SUCCESS" then
        local _, sourceGUID, sourceName, _, _, destGUID, destName, _, _,spellId, spellName = ...
        
        --print("sourceName: ", sourceName, "\n","destName: ", destName,"\n","spellId: ", spellId,"\n","spellName: ", spellName)
        
        if (aura_env.abl_tbl.SpellCastSuccess and aura_env.abl_tbl.SpellCastSuccess[spellId]) then
            
            if aura_env.flaggedSpells[spellId] then aura_env.flaggedSpells[spellId] = true end
            
            if not (aura_env.spellRules[spellId] ~= false) then 
                
                if aura_env.resetCounter[spellId] then
                    if aura_env.counters[spellId] == aura_env.resetCounter[spellId] then
                        aura_env.counters[spellId] = 0
                    end      
                end   
                
                if aura_env.counters[spellId] then
                    aura_env.counters[spellId] = aura_env.counters[spellId] + 1 
                end
                
                --print("|CFFff41eb", "SPELL_CAST_SUCCESS","\nSpell - ", spellName, "[", spellId, "]", " - Counter: ", aura_env.counters[spellId], "|r")
                
                local addonMessages = aura_env.generateAddonMessage(spellId,aura_env.counters[spellId])
                
                for _, msg in ipairs(addonMessages) do
                    -- print("|CFFff41eb","SPELL_CAST_SUCCESS","\nSending assignments", "|r")
                    aura_env.sendAssigns(msg)
                end
                return true
            end            
        end
    end ------v ADD EVENTS HERE v---------
    
    
    if subEvent == "SPELL_AURA_APPLIED" or subEvent == "SPELL_AURA_APPLIED_DOSE" then
        local _, sourceGUID, sourceName, _, _, destGUID, destName, _, _,spellId, spellName, _, amount = ...
        
        
        --print("sourceName: ", sourceName, "\n","destName: ", destName,"\n","spellId: ", spellId,"\n","spellName: ", spellName)
        
        if (aura_env.abl_tbl.SpellAuraAppliedRemoved and aura_env.abl_tbl.SpellAuraAppliedRemoved[spellId]) then
            
            if aura_env.flaggedSpells[spellId] then aura_env.flaggedSpells[spellId] = true end
            
            if not (aura_env.spellRules[spellId] ~= false) then 
                
                if aura_env.resetCounter[spellId] then
                    if aura_env.counters[spellId] == aura_env.resetCounter[spellId] then
                        aura_env.counters[spellId] = 0
                    end      
                end   
                
                if aura_env.counters[spellId] then
                    aura_env.counters[spellId] = aura_env.counters[spellId] + 1 
                end
                
                --print("|CFFff41eb", "SPELL_AURA_APPLIED/DOSE","\nSpell - ", spellName, "[", spellId, "]", " - Counter: ", aura_env.counters[spellId], "|r")
                
                local addonMessages = aura_env.generateAddonMessage(spellId,aura_env.counters[spellId])
                
                for _, msg in ipairs(addonMessages) do
                    -- print("|CFFff41eb","SPELL_AURA_APPLIED/DOSE", "\nSending assignments", "|r")
                    aura_env.sendAssigns(msg) 
                end
                return true
            end
        end
    end ------v ADD EVENTS HERE v---------
end


