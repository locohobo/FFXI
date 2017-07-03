-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
     
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end
 
 
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Footwork = buffactive.Footwork or false
    state.Buff.Impetus = buffactive.Impetus or false
 
    state.FootworkWS = M(false, 'Footwork on WS')
 
    info.impetus_hit_count = 0
    windower.raw_register_event('action', on_action_for_impetus)
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal')
    state.HybridMode:options('Normal', 'PDT')
    state.PhysicalDefenseMode:options('PDT')
 
    update_combat_form()
    update_melee_groups()
 
    --select_default_macro_book()
end
 
 
-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
     
    -- Precast Sets
     
    -- Precast sets to enhance JAs on use
    sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose +1"}
    sets.precast.JA['Boost'] = {hands="Anchorite's Gloves +1"}
    sets.precast.JA['Dodge'] = {feet="Anchorite's Gaiters +1"}
    sets.precast.JA['Focus'] = {head="Anchorite's Crown +1"}

    sets.precast.JA['Counterstance'] = {feet="Hesychast's Gaiters +1"}
    sets.precast.JA['Footwork'] = {feet="Shukuyu Sune-Ate",}
    sets.precast.JA['Formless Strikes'] = {}
    sets.precast.JA['Mantra'] = {feet="Hesychast's Gaiters +1"}
 
    sets.precast.JA['Chi Blast'] = {}
 
    sets.precast.JA['Chakra'] = {head="Genmei Kabuto",
                body="Anch. Cyclas +1",
                hands={ name="Hes. Gloves +1", augments={'Enhances "Invigorate" effect',}},
                legs="Hiza. Hizayoroi +1",
                feet="Bhikku Gaiters +1",
                right_ear="Genmei Earring",
                left_ring={ name="Dark Ring", augments={'Enemy crit. hit rate -3','Phys. dmg. taken -6%','Breath dmg. taken -3%',}},
                right_ring={ name="Dark Ring", augments={'Breath dmg. taken -4%','Magic dmg. taken -5%','Phys. dmg. taken -4%',}}}
 
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
         
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
 
    sets.precast.Step = {}
    sets.precast.Flourish1 = {}
 
 
    -- Fast cast sets for spells
     
    sets.precast.FC = {}
 
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})
 
        
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Ginsen",
                    head="Dampening Tam",
    body="Adhemar Jacket",
    hands="Adhemar Wristbands",
    legs="Samnuha Tights",
    feet={ name="Herculean Boots", augments={'Attack+8','"Triple Atk."+1','STR+7','Accuracy+9',}},
    neck="Combatant's Torque",
    waist="Grunfield Rope",
    left_ear="Brutal Earring",
    right_ear="Mache Earring",
    left_ring="Hetairoi Ring",
    right_ring="Epona's Ring"}
    sets.precast.WSAcc = {}
    sets.precast.WSMod = {}
    sets.precast.MaxTP = {ear1="Bladeborn Earring",ear2="Steelflash Earring"}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, sets.precast.WSAcc)
    sets.precast.WS.Mod = set_combine(sets.precast.WS, sets.precast.WSMod)
 
    -- Specific weaponskill sets.
     
 
    sets.precast.WS['Raging Fists']    = set_combine(sets.precast.WS, {})
    sets.precast.WS['Howling Fist']    = set_combine(sets.precast.WS, {})
    sets.precast.WS['Asuran Fists']    = set_combine(sets.precast.WS, {})
    sets.precast.WS["Ascetic's Fury"]  = set_combine(sets.precast.WS, {})
    sets.precast.WS["Victory Smite"]   = set_combine(sets.precast.WS, {ammo="Ginsen",
                                                                        head={ name="Rao Kabuto", augments={'STR+10','DEX+10','Attack+15',}},
                                                                        body={ name="Herculean Vest", augments={'Attack+28','Crit.hit rate+4','DEX+9','Accuracy+4',}},
                                                                        hands="Adhemar Wristbands",
                                                                        legs="Hiza. Hizayoroi +1",
                                                                        feet={ name="Herculean Boots", augments={'Attack+8','"Triple Atk."+1','STR+7','Accuracy+9',}},
                                                                        neck="Fotia Gorget",
                                                                        waist="Fotia Belt",
                                                                        left_ear="Brutal Earring",
                                                                        right_ear={ name="Moonshade Earring", augments={'MP+25','TP Bonus +25',}},
                                                                        left_ring="Aptate Ring",
                                                                        right_ring="Epona's Ring",
                                                                        back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}})
    sets.precast.WS['Shijin Spiral']   = set_combine(sets.precast.WS, {ammo="Ginsen",
                                                                        head={ name="Rao Kabuto", augments={'STR+10','DEX+10','Attack+15',}},
                                                                        body={ name="Herculean Vest", augments={'Attack+28','Crit.hit rate+4','DEX+9','Accuracy+4',}},
                                                                        hands="Adhemar Wristbands",
                                                                        legs="Hiza. Hizayoroi +1",
                                                                        feet={ name="Herculean Boots", augments={'DEX+7','Accuracy+11','STR+6 DEX+6','Accuracy+11 Attack+11',}},
                                                                        neck="Fotia Gorget",
                                                                        waist="Fotia Belt",
                                                                        left_ear="Bladeborn Earring",
                                                                        right_ear="Steelflash Earring",
                                                                        left_ring="Ramuh Ring +1",
                                                                        right_ring="Epona's Ring",
                                                                        back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}})
    sets.precast.WS['Dragon Kick']     = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tornado Kick']    = set_combine(sets.precast.WS, {})
    sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {})
 
    sets.precast.WS["Raging Fists"].Acc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSAcc)
    sets.precast.WS["Howling Fist"].Acc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSAcc)
    sets.precast.WS["Asuran Fists"].Acc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSAcc)
    sets.precast.WS["Ascetic's Fury"].Acc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSAcc)
    sets.precast.WS["Victory Smite"].Acc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSAcc)
    sets.precast.WS["Shijin Spiral"].Acc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSAcc)
    sets.precast.WS["Dragon Kick"].Acc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSAcc)
    sets.precast.WS["Tornado Kick"].Acc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSAcc)
 
    sets.precast.WS["Raging Fists"].Mod = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSMod)
    sets.precast.WS["Howling Fist"].Mod = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSMod)
    sets.precast.WS["Asuran Fists"].Mod = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSMod)
    sets.precast.WS["Ascetic's Fury"].Mod = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSMod)
    sets.precast.WS["Victory Smite"].Mod = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSMod)
    sets.precast.WS["Shijin Spiral"].Mod = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSMod)
    sets.precast.WS["Dragon Kick"].Mod = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSMod)
    sets.precast.WS["Tornado Kick"].Mod = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSMod)
 
 
    sets.precast.WS['Cataclysm'] = {}
     
     
    -- Midcast Sets
    sets.midcast.FastRecast = {}
         
    -- Specific spells
    sets.midcast.Utsusemi = {}
 
     
    -- Sets to return to when not performing an action.
     
    -- Resting sets
    sets.resting = {}
     
 
    -- Idle sets
    sets.idle = {ammo="Vanir Battery",
                head="Genmei Kabuto",
                body="Emet Harness",
                hands={ name="Otronif Gloves +1", augments={'Phys. dmg. taken -3%','Accuracy+4',}},
                legs={ name="Otronif Brais +1", augments={'Phys. dmg. taken -3%','"Dbl.Atk."+1',}},
                feet="Ahosi Leggings",
                neck="Loricate Torque +1",
                waist="Windbuffet Belt +1",
                left_ear="Sanare Earring",
                right_ear="Genmei Earring",
                left_ring="Defending Ring",
                right_ring={ name="Dark Ring", augments={'Breath dmg. taken -4%','Magic dmg. taken -5%','Phys. dmg. taken -4%',}},
                back="Solemnity Cape"}
 
     
  
     
    -- Defense sets
    sets.defense.PDT = {ammo="Vanir Battery",
                head="Genmei Kabuto",
                body="Emet Harness",
                hands={ name="Otronif Gloves +1", augments={'Phys. dmg. taken -3%','Accuracy+4',}},
                legs={ name="Otronif Brais +1", augments={'Phys. dmg. taken -3%','"Dbl.Atk."+1',}},
                feet="Ahosi Leggings",
                neck="Loricate Torque +1",
                waist="Black Belt",
                left_ear="Sanare Earring",
                right_ear="Genmei Earring",
                left_ring="Defending Ring",
                right_ring={ name="Dark Ring", augments={'Breath dmg. taken -4%','Magic dmg. taken -5%','Phys. dmg. taken -4%',}},
                back="Solemnity Cape"}
 
    sets.defense.HP = {}
 
    sets.defense.MDT = {ammo="Vanir Battery",
                head="Genmei Kabuto",
                body="Emet Harness",
                hands={ name="Otronif Gloves +1", augments={'Phys. dmg. taken -3%','Accuracy+4',}},
                legs={ name="Otronif Brais +1", augments={'Phys. dmg. taken -3%','"Dbl.Atk."+1',}},
                feet="Ahosi Leggings",
                neck="Loricate Torque +1",
                waist="Black Belt",
                left_ear="Sanare Earring",
                right_ear="Genmei Earring",
                left_ring="Defending Ring",
                right_ring={ name="Dark Ring", augments={'Breath dmg. taken -4%','Magic dmg. taken -5%','Phys. dmg. taken -4%',}},
                back="Solemnity Cape"}
 
    sets.Kiting = {feet="Herald's Gaiters"}
 
    sets.ExtraRegen = {}
 
    -- Engaged sets
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
     
    -- Normal melee sets
    sets.engaged = {head="Dampening Tam",
    body="Adhemar Jacket",
    hands="Adhemar Wristbands",
    legs="Samnuha Tights",
    feet={ name="Herculean Boots", augments={'DEX+7','Accuracy+11','STR+6 DEX+6','Accuracy+11 Attack+11',}},
    neck="Lissome Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Brutal Earring",
    right_ear="Mache Earring",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
                    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Store TP"+10',}}}
    sets.engaged.SomeAcc = {}
    sets.engaged.Acc = {ammo="Honed Tathlum",
                    head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
                    body={ name="Herculean Vest", augments={'Accuracy+21 Attack+21','"Triple Atk."+2','AGI+4','Accuracy+15','Attack+10',}},
                    hands={ name="Herculean Gloves", augments={'Accuracy+25 Attack+25','Weapon skill damage +4%','INT+6','Accuracy+13',}},
                    legs="Hiza. Hizayoroi +1",
                    feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','"Triple Atk."+2','DEX+7','Accuracy+15','Attack+14',}},
                    neck="Subtlety Spec.",
                    waist="Olseni Belt",
                    left_ear="Digni. Earring",
                    right_ear="Zennaroi Earring",
                    left_ring="Ramuh Ring +1",
                    right_ring="Begrudging Ring",
                    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}}
    sets.engaged.Mod = {}
 
    -- Defensive melee hybrid sets
    sets.engaged.PDT = {ammo="Vanir Battery",
                head="Genmei Kabuto",
                body="Emet Harness",
                hands={ name="Otronif Gloves +1", augments={'Phys. dmg. taken -3%','Accuracy+4',}},
                legs={ name="Otronif Brais +1", augments={'Phys. dmg. taken -3%','"Dbl.Atk."+1',}},
                feet="Herald's Gaiters",
                neck="Loricate Torque +1",
                waist="Black Belt",
                left_ear="Sanare Earring",
                right_ear="Genmei Earring",
                left_ring="Defending Ring",
                right_ring={ name="Dark Ring", augments={'Breath dmg. taken -4%','Magic dmg. taken -5%','Phys. dmg. taken -4%',}},
                back="Solemnity Cape"}
    sets.engaged.SomeAcc.PDT = {}
    sets.engaged.Acc.PDT = {}
    sets.engaged.Counter = {}
    sets.engaged.Acc.Counter = {}
 
 
    -- Hundred Fists/Impetus melee set mods
    sets.engaged.HF = set_combine(sets.engaged)
    sets.engaged.HF.Impetus = set_combine(sets.engaged, {body="Bhikku Cyclas +1"})
    sets.engaged.Acc.HF = set_combine(sets.engaged.Acc)
    sets.engaged.Acc.HF.Impetus = set_combine(sets.engaged.Acc, {body="Bhikku Cyclas +1"})
    sets.engaged.Counter.HF = set_combine(sets.engaged.Counter)
    sets.engaged.Counter.HF.Impetus = set_combine(sets.engaged.Counter, {body="Bhikku Cyclas +1"})
    sets.engaged.Acc.Counter.HF = set_combine(sets.engaged.Acc.Counter)
    sets.engaged.Acc.Counter.HF.Impetus = set_combine(sets.engaged.Acc.Counter, {body="Bhikku Cyclas +1"})
 
 
    -- Footwork combat form
    sets.engaged.Footwork = {ammo="Ginsen",
                    head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
                    body={ name="Herculean Vest", augments={'Accuracy+21 Attack+21','"Triple Atk."+2','AGI+4','Accuracy+15','Attack+10',}},
                    hands={ name="Herculean Gloves", augments={'Accuracy+25 Attack+25','Weapon skill damage +4%','INT+6','Accuracy+13',}},
                    legs="Bhikku Hose +1",
                    feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','"Triple Atk."+2','DEX+7','Accuracy+15','Attack+14',}},
                    neck="Clotharius Torque",
                    waist="Windbuffet Belt +1",
                    left_ear="Steelflash Earring",
                    right_ear="Bladeborn Earring",
                    left_ring="Hetairoi Ring",
                    right_ring="Epona's Ring",
                    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}
    sets.engaged.Footwork.Acc = {ammo="Honed Tathlum",
                    head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
                    body={ name="Herculean Vest", augments={'Accuracy+21 Attack+21','"Triple Atk."+2','AGI+4','Accuracy+15','Attack+10',}},
                    hands={ name="Herculean Gloves", augments={'Accuracy+25 Attack+25','Weapon skill damage +4%','INT+6','Accuracy+13',}},
                    legs="Hiza. Hizayoroi +1",
                    feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','"Triple Atk."+2','DEX+7','Accuracy+15','Attack+14',}},
                    neck="Subtlety Spec.",
                    waist="Olseni Belt",
                    left_ear="Digni. Earring",
                    right_ear="Zennaroi Earring",
                    left_ring="Ramuh Ring +1",
                    right_ring="Begrudging Ring",
                    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}
         
    -- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
    sets.impetus_body = {body="Bhikku Cyclas +1"}
    sets.footwork_kick_feet = {}
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Don't gearswap for weaponskills when Defense is on.
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        eventArgs.handled = true
    end
end
 
--modify your melee set based on logic
function customize_melee_set(meleeSet) 
    if info.impetus_hit_count > 6 and buffactive.impetus then
        meleeSet = set_combine(meleeSet,sets.impetus_body)
    end
    return meleeSet
end
 
-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    -- add_to_chat(122,'spell type '..spell.type)
    -- add_to_chat(122,'impetus on '..tostring(state.Buff.Impetus))
    -- add_to_chat(122,'spell english '..spell.english)
    if spell.type == 'WeaponSkill' then
        if state.Buff.Impetus and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
            -- Need 6 hits at capped dDex, or 9 hits if dDex is uncapped, for Tantra to tie or win.
            --if (state.OffenseMode.current == 'Fodder' and info.impetus_hit_count > 5) or (info.impetus_hit_count > 8) then
            if info.impetus_hit_count > 6 then
                equip(sets.impetus_body)
                add_to_chat(122,'Impetus Body Equipped, Hits: '..tostring(info.impetus_hit_counter))
            else
                add_to_chat(122,'Impetus Body Not Equipped, Hits: '..tostring(info.impetus_hit_counter))
            end
        elseif state.Buff.Footwork and (spell.english == "Dragon's Kick" or spell.english == "Tornado Kick") then
            equip(sets.footwork_kick_feet)
        end
         
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp == 3000 then
            equip(sets.precast.MaxTP)
        end
    end
end
 
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and not spell.interrupted and state.FootworkWS and state.Buff.Footwork then
        send_command('cancel Footwork')
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Set Footwork as combat form any time it's active and Hundred Fists is not.
    if buff == 'Footwork' and gain and not buffactive['hundred fists'] then
        state.CombatForm:set('Footwork')
    elseif buff == "Hundred Fists" and not gain and buffactive.footwork then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
     
    -- Hundred Fists and Impetus modify the custom melee groups
    if buff == "Hundred Fists" or buff == "Impetus" then
        classes.CustomMeleeGroups:clear()
         
        if (buff == "Hundred Fists" and gain) or buffactive['hundred fists'] then
            classes.CustomMeleeGroups:append('HF')
        end
         
        if (buff == "Impetus" and gain) or buffactive.impetus then
            classes.CustomMeleeGroups:append('Impetus')
        end
    end
 
    -- Update gear if any of the above changed
    if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" then
        handle_equipping_gear(player.status)
    end
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
function customize_idle_set(idleSet)
    if player.hpp < 75 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end
     
    return idleSet
end
 
-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    update_combat_form()
    update_melee_groups()
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
function update_combat_form()
    if buffactive.footwork and not buffactive['hundred fists'] then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
end
 
function update_melee_groups()
    classes.CustomMeleeGroups:clear()
     
    if buffactive['hundred fists'] then
        classes.CustomMeleeGroups:append('HF')
    end
     
    if buffactive.impetus then
        classes.CustomMeleeGroups:append('Impetus')
    end
end
 
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(8, 1)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 1)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 1)
    elseif player.sub_job == 'RUN' then
        set_macro_page(1, 1)
    else
        set_macro_page(3, 1)
    end
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Custom event hooks.
-------------------------------------------------------------------------------------------------------------------
 
switched_impetus = 0
unswitched_impetus = 1
-- Keep track of the current hit count while Impetus is up.
function on_action_for_impetus(action)
    if state.Buff.Impetus then
        -- count melee hits by player
        if action.actor_id == player.id then
            if action.category == 1 then
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- Reactions (bitset):
                        -- 1 = evade
                        -- 2 = parry
                        -- 4 = block/guard
                        -- 8 = hit
                        -- 16 = JA/weaponskill?
                        -- If action.reaction has bits 1 or 2 set, it missed or was parried. Reset count.
                        if (action.reaction % 4) > 0 then
                            info.impetus_hit_count = 0
                            switched_impetus = 0
                        else
                            info.impetus_hit_count = info.impetus_hit_count + 1
                        end
                    end
                end
            elseif action.category == 3 then
                -- Missed weaponskill hits will reset the counter.  Can we tell?
                -- Reaction always seems to be 24 (what does this value mean? 8=hit, 16=?)
                -- Can't tell if any hits were missed, so have to assume all hit.
                -- Increment by the minimum number of weaponskill hits: 2.
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- This will only be if the entire weaponskill missed or was parried.
                        if (action.reaction % 4) > 0 then
                            info.impetus_hit_count = 0
                            switched_impetus = 0
                        else
                            info.impetus_hit_count = info.impetus_hit_count + 2
                        end
                    end
                end
            end
        elseif action.actor_id ~= player.id and action.category == 1 then
            -- If mob hits the player, check for counters.
            for _,target in pairs(action.targets) do
                if target.id == player.id then
                    for _,action in pairs(target.actions) do
                        -- Spike effect animation:
                        -- 63 = counter
                        -- ?? = missed counter
                        if action.has_spike_effect then
                            -- spike_effect_message of 592 == missed counter
                            if action.spike_effect_message == 592 then
                                info.impetus_hit_count = 0
                                switched_impetus = 0
                            elseif action.spike_effect_animation == 63 then
                                info.impetus_hit_count = info.impetus_hit_count + 1
                            end
                        end
                    end
                end
            end
        end
         
        --add_to_chat(123,'Current Impetus hit count = ' .. tostring(info.impetus_hit_count))
        if info.impetus_hit_count > 6 and switched_impetus == 0 then
            --switched_impetus = 1
            --add_to_chat(225,"Chugging Impetus Koolaid")
            --handle_equipping_gear(player.status)
            --switched_impetus = 1
            send_command('gs c equip_impetus_body')
        elseif info.impetus_hit_count < 7 then 
            send_command('gs c unequip_impetus_body')
        end
    else
        info.impetus_hit_count = 0
        switched_impetus = 0
    end
end
 
function job_self_command(cmdParams, eventArgs)
    command = cmdParams[1]:lower()
    if command =='equip_impetus_body' then
            add_to_chat(225,"Equipping Impetus Body")
            switched_impetus = 1
            unswitched_impetus = 0
            equip(sets.impetus_body)
    elseif command =='unequip_impetus_body' then
            if unswitched_impetus == 0 then
                add_to_chat(225,"Removing Impetus Body")
                handle_equipping_gear(player.status)
                unswitched_impetus = 1
            end
            switched_impetus = 0
    end
end
