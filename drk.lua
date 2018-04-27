--[[     
=== Features ===
!!!!Make sure you have my User-Globals.lua!!! Do not rename it. It goes in the data folder along side this file.
If you don't use organizer, then remove the include('organizer-lib') in get_sets() and remove sets.Organizer
This lua has a few MODES you can toggle with hotkeys, and there's a few situational RULES that activate without hotkeys
I'd recommend reading and understanding the following information if you plan on using this file.
::MODES::
SouleaterMode: OFF by default. Toggle this with @F9 (window key + F9). 
This mode makes it possible to use Souleater in situations where you would normally avoid using it. When SouleaterMode 
is ON, Souleater will be canceled automatically after the first Weaponskill used, WITH THESE EXCEPTIONS. If Bloodweapon 
is active, or if Drain's HP Boost buff is active, then Souleater will remain active until the next WS used after 
either buff wears off. If you use DRK at events, I'd recommend making this default to ON, as it's damn useful.
LastResortMode: Removed.  In it's place, I'm testing a rule that automatically applies / removes hasso
CapacityMode OFF by default. Toggle with ALT + = 
It will full-time whichever piece of gear you specify in sets.CapacityMantle 
NOTE: You can change the default (true|false) status of any MODE by changing their values in job_setup()
::RULES::
Gavialis Helm will automatically be used for all weaponskills on their respective days of the week. If you don't want
it used for a ws, then you have to add the WS to wsList = {} in job_setup. You also need my User-Globals.lua for this
to even work. 
Ygna's Resolve +1 will automatically be used when you're in a reive. If you have my User-Globals.lua this will work
with all your jobs that use mote's includes. Not just this one! 
Moonshade earring is not used for WS's at 3000 TP. 
You can hit F12 to display custom MODE status as well as the default stuff. 
Single handed weapons are han
::NOTES::
All of the default sets are geared around scythe. There is support for great sword by using 
sets.engaged.GreatSword but you will have to edit gsList in job_setup so that your GS is present. IF you would rather
all the default sets (like sets.engaged, etc.) cater to great sword instead of scyth, then simply remove the great swords 
listed in gsList and ignore sets.engaged.GreatSword. (but dont delete it)  
Set format is as follows: 
sets.engaged.[CombatForm][CombatWeapon][Offense or HybridMode][CustomMeleeGroups]
HybridMode = Normal, PDT
CustomMeleeGroups = AM3, AM
CustomMeleeGroups AM3 will activate when Aftermath lvl 3 is up, and AM will activate when relic Aftermath is up.
--]]
--
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('organizer-lib')
end


-- Setup vars that are user-independent.
function job_setup()
    state.CapacityMode = M(false, 'Capacity Point Mantle')

    state.Buff.Souleater = buffactive.souleater or false
    state.Buff['Last Resort'] = buffactive['Last Resort'] or false
    -- Set the default to false if you'd rather SE always stay acitve
    state.SouleaterMode = M(false, 'Soul Eater Mode')
    state.LastResortMode = M(false, 'Last Resort Mode')
    -- If you have a fully upgraded Apoc, set this to true 
    state.ApocHaste = M(false, 'Apoc Haste Mode')   
    -- Mote has capitalization errors in the default Absorb mappings, so we correct them
    absorbs = S{'Absorb-STR', 'Absorb-DEX', 'Absorb-VIT', 'Absorb-AGI', 'Absorb-INT', 'Absorb-MND', 'Absorb-CHR', 'Absorb-Attri', 'Absorb-ACC', 'Absorb-TP'}

end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Mid', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
    state.CastingMode:options('Normal', 'Acc')
    state.IdleMode:options('Normal')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')

    war_sj = player.sub_job == 'WAR' or false

    -- Additional local binds
    send_command('bind != gs c toggle CapacityMode')
    send_command('bind @f9 gs c toggle SouleaterMode')
    --send_command('bind ^` gs c toggle LastResortMode')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind ^`')
    send_command('unbind !=')
    send_command('unbind ^[')
    send_command('unbind ![')
    send_command('unbind @f9')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    -- Augmented gear
  
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA['Diabolic Eye'] = {hands="Fallen's Finger Gauntlets +1"}
    sets.precast.JA['Nether Void']  = {legs="Heathen's Flanchard +1"}
    sets.precast.JA['Dark Seal']    = {head="Fallen's burgeonet +1"}
    sets.precast.JA['Souleater']    = {head="Ignominy burgeonet +1"}
    sets.precast.JA['Blood Weapon'] = {body="Fallen's Cuirass +1"}
    sets.precast.JA['Last Resort']  = {back="Ankou's Mantle"}

    sets.CapacityMantle  = { back="Mecistopins Mantle" }
              

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo="Impatiens",
        head="Carmine Mask +1",
        body="Odyssean Chestplate",
		neck="baetyl pendant",
        ear1="Loquacious Earring",
		ear2="Etiolation Earring",
        hands="Leyline Gloves",
        ring1="Lebeche Ring",
		ring2="Kishar Ring",
        legs="Eschite Cuisses",
        feet="Carmine greaves",
    }

    
    sets.precast.FC['Enfeebling Magic'] = set_combine(sets.precast.FC, {
        head="Cizin Helm +1",
    })
    

    -- Midcast Sets
    sets.midcast.FastRecast = {
        ammo="Impatiens",
        head="Fallen's Burgeonet +1",
        body="Odyssean Chestplate",
        legs="Carmine Cuisses +1",
        
    }
    
    

    -- Specific spells
    sets.midcast.Utsusemi = {
        ammo="Impatiens",
        neck="Incanter's Torque",
        hands="Leyline Gloves",
    }

    sets.midcast['Dark Magic'] = {
        ammo="Pemphredo Tathlum", 
        head="Ignominy burgeonet +1", -- 17
        neck="Incanter's Torque", -- 10
        ear1="Gwati Earring",
        body="Demon's Harness", --5
        hands="Fallen's Finger Gauntlets +1", -- 14
        ring1="Fenrir Ring +1",

        legs="Eschite Cuisses",  -- 20
        feet="Ratri Sollerets"
    }
   

    sets.midcast['Dark Magic'].Acc = set_combine(sets.midcast['Dark Magic'], {
        
        hands="Leyline Gloves",
        waist="Eschan Stone"
    })

    sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Dark Magic'], {
        head="Valorous Mask",
        neck="Sanctity Necklace",
        
        hands="Leyline Gloves", 
    })

    sets.midcast['Elemental Magic'] = {
        ammo="Pemphredo Tathlum",
        
        neck="Sanctity Necklace", 
        ear1="Friomisi Earring", -- 10 matk
        ear2="Crematio Earring", -- 6 matk 6 mdmg
        hands="Leyline Gloves",
        ring1="Fenrir Ring +1", 
        ring2="Shiva Ring", 
        waist="Eschan Stone", 
        legs="Eschite Cuisses", 
    }

    -- Mix of HP boost, -Spell interruption%, and Dark Skill
    sets.midcast['Dread Spikes'] = set_combine(sets.midcast['Dark Magic'], {
        ammo="Impatiens",
        body="Heathen's Cuirass",
        hands="Emicho Gauntlets",
        ring2="K'ayres Ring",
        back="Trepidity Mantle",
        waist="Eschan Stone", -- macc/matk 7
        legs="Carmine Cuisses +1",
        
    })
    sets.midcast['Dread Spikes'].Acc = set_combine(sets.midcast['Dark Magic'], {
        body="Heathen's Cuirass",
        hands="Leyline Gloves",
        waist="Eschan Stone", -- macc/matk 7
    })

    -- Drain spells 
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        ear1="Gwati Earring",
        ear2="Hirudinea Earring",
        body="Lugra Cloak +1",
        ring2="Excelsis Ring",
    })
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Drain.Acc = set_combine(sets.midcast.Drain, {
        head="Ignominy Burgeonet +1",
        hands="Leyline Gloves",
        waist="Eschan Stone", -- macc/matk 7
    })
    sets.midcast.Aspir.Acc = sets.midcast.Drain.Acc

    sets.midcast.Drain.OhShit = set_combine(sets.midcast.Drain, {
        legs="Carmine Cuisses +1",
    })

    -- Absorbs
    sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'], {
        back="Chuparrosa Mantle",
        hands="Pavor Gauntlets",
    })

    sets.midcast['Absorb-TP'] = set_combine(sets.midcast.Absorb, {
        hands="Heathen's Gauntlets +1"
    })

    

    -- WEAPONSKILL SETS
    -- General sets
    sets.precast.WS = {
        ammo="Ginsen",
		head="Flam. Zucchetto +2",
        neck="Lissome Necklace",
        body="Ignominy Cuirass +3",
		hands="Flam. Manopolas +2",
        right_ear="Cessance Earring",
		left_ear="Ishvara Earring",
		legs="Ig. Flanchard +3",
		ring1="Niqmaddu Ring",
        ring2="Regal Ring",
        waist="Ioskeha Belt",
        feet="Sulev. Leggings +2"
    }
    sets.precast.WS.Mid = set_combine(sets.precast.WS, {
        ammo="Ginsen",
        head="Argosy Celata",
        
    })
    sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
        ear1="Zennaroi Earring",
        waist="Olseni Belt",
    })

    -- RESOLUTION
    -- 86-100% STR
    sets.precast.WS.Resolution = set_combine(sets.precast.WS, {
        ammo="Seeth. Bomblet +1",
		left_ear="Brutal Earring",
		neck="Fotia Gorget",
        waist="Fotia Belt",
		feet="Flam. Gambieras +2",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    })
    

    -- TORCLEAVER 
    -- VIT 80%
    sets.precast.WS.Torcleaver = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
		head="Odyssean Helm",
		neck="Fotia Gorget",
		hands="Odyssean Gauntlets",
		legs="Odyssean Cuisses",
        waist="Fotia Belt",
		right_ear="Ishvara Earring",
		back={ name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
    })
    

    -- INSURGENCY
    -- 20% STR / 20% INT 
    -- Base set only used at 3000TP to put AM3 up
    sets.precast.WS.Insurgency = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",
		waist="Fotia Belt",
		ammo="Knobkierrie",
    })
    sets.precast.WS.Insurgency.AM3 = set_combine(sets.precast.WS.Insurgency, {
    })
    -- Mid assumes higher defense target
    sets.precast.WS.Insurgency.Mid = set_combine(sets.precast.WS.Insurgency, {
        legs="Sulevia's Cuisses +1",
        waist="Fotia Belt"
    })
    sets.precast.WS.Insurgency.AM3Mid = set_combine(sets.precast.WS.Insurgency.Mid, {})
    sets.precast.WS.Insurgency.Acc = set_combine(sets.precast.WS.Insurgency.Mid, {
        ear1="Zennaroi Earring",
        waist="Olseni Belt",
        
    })
    sets.precast.WS.Insurgency.AM3Acc = set_combine(sets.precast.WS.Insurgency.Acc, {})

    sets.precast.WS.Catastrophe = set_combine(sets.precast.WS, {
        ear2="Ishvara Earring",
        neck="Fotia Gorget",
        waist="Fotia Belt"
    })
    sets.precast.WS.Catastrophe.Mid = set_combine(sets.precast.WS.Catastrophe, {})
    sets.precast.WS.Catastrophe.Acc = set_combine(sets.precast.WS.Catastrophe.Mid, {
        ear1="Zennaroi Earring",
        waist="Olseni Belt",
        
    })

    -- CROSS REAPER
    -- 60% STR / 60% MND
    sets.precast.WS['Cross Reaper'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",
        waist="Fotia Belt",
		ammo="Knobkierrie",
		legs="Ratri cuisses"
    })
    sets.precast.WS['Cross Reaper'].AM3 = set_combine(sets.precast.WS['Cross Reaper'], {
        head="Sulevia's Mask +1",
        legs="Sulevia's Cuisses +1",
    })

    
    -- ENTROPY
    -- 86-100% INT 
    sets.precast.WS.Entropy = set_combine(sets.precast.WS, {
        ammo="Pemphredo Tathlum",
        head="Heathen's Burgonet +1",
        neck="Fotia Gorget",
        body="Fallen's Cuirass +1",
        ring2="Shiva Ring",
        waist="Fotia Belt",
        legs="Sulevia's Cuisses +1",
        feet="Sulevia's Leggings +1"
    })
    sets.precast.WS.Entropy.AM3 = set_combine(sets.precast.WS.Entropy, { })
    sets.precast.WS.Entropy.Mid = set_combine(sets.precast.WS.Entropy, {
        body="Odyssean Chestplate",
    })
    sets.precast.WS.Entropy.AM3Mid = set_combine(sets.precast.WS.Entropy.Mid, {})
    

    -- Quietus
    -- 60% STR / MND 
    sets.precast.WS.Quietus = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",
		ammo="Knobkierrie",
        ear2="Ishvara Earring",
        waist="Windbuffet Belt +1",
    })
    sets.precast.WS.Quietus.AM3 = set_combine(sets.precast.WS.Quietus, {})
    sets.precast.WS.Quietus.Mid = set_combine(sets.precast.WS.Quietus, {
        waist="Caudata Belt",
    })
    sets.precast.WS.Quietus.AM3Mid = set_combine(sets.precast.WS.Quietus.Mid, {
        ear1="Lugra Earring +1",
        ear2="Ishvara Earring",
    })
    sets.precast.WS.Quietus.Acc = set_combine(sets.precast.WS.Quietus.Mid, {})

    -- SPIRAL HELL
    -- 50% STR / 50% INT 
    sets.precast.WS['Spiral Hell'] = set_combine(sets.precast.WS['Entropy'], {
        neck="Fotia Gorget",
        
    })
    sets.precast.WS['Spiral Hell'].Mid = set_combine(sets.precast.WS['Spiral Hell'], sets.precast.WS.Mid, { })
    sets.precast.WS['Spiral Hell'].Acc = set_combine(sets.precast.WS['Spiral Hell'], sets.precast.WS.Acc, { })

    -- SHADOW OF DEATH
    -- 40% STR 40% INT - Darkness Elemental
    sets.precast.WS['Shadow of Death'] = set_combine(sets.precast.WS['Entropy'], {
        
        ear1="Friomisi Earring",
        hands="Leyline Gloves",
        
        waist="Eschan Stone", -- macc/matk 7
        feet="Sulevia's Leggings +1"
    })

    sets.precast.WS['Shadow of Death'].Mid = set_combine(sets.precast.WS['Shadow of Death'], sets.precast.WS.Mid, {
    })
    sets.precast.WS['Shadow of Death'].Acc = set_combine(sets.precast.WS['Shadow of Death'], sets.precast.WS.Acc, {
    })

    -- DARK HARVEST 
    -- 40% STR 40% INT - Darkness Elemental
    sets.precast.WS['Dark Harvest'] = sets.precast.WS['Shadow of Death']
    sets.precast.WS['Dark Harvest'].Mid = set_combine(sets.precast.WS['Shadow of Death'], {feet="Heathen's Sollerets +1"})
    sets.precast.WS['Dark Harvest'].Acc = set_combine(sets.precast.WS['Shadow of Death'], {feet="Heathen's Sollerets +1", ring1="Sangoma Ring"})


    -- Idle sets
    sets.idle.Town = {
        ammo="Ginsen",
        head="",
        neck="Sanctity Necklace",
        ear1="Cessance Earring",
        
        hands="Sulevia's Gauntlets +1",
        
        ring2="Defending Ring",
       
        waist="Flume Belt",
        legs="Carmine Cuisses +1",
        feet="Sulevia's leggings +1"
    }

    sets.idle.Field = set_combine(sets.idle.Town, {
        ammo="Ginsen",
        head="Valorous Mask",
        ear1="Zennaroi Earring",
        neck="Sanctity Necklace",
        hands="Sulevia's Gauntlets +1",
        
        ring2="Defending Ring",
        
        waist="Flume Belt",
        legs="Carmine Cuisses +1",
        feet="Sulevia's leggings +1"
    })
    sets.idle.Regen = set_combine(sets.idle.Field, {
        neck="Sanctity Necklace",
  
        ring1="Paguroidea Ring",
        
    })
    sets.idle.Refresh = set_combine(sets.idle.Regen, {
        neck="Coatl Gorget +1"
    })


    -- Defense sets
    sets.defense.PDT = {
        ammo="Hasty Pinion +1",
        head="Sulevia's Mask +1",
        neck="Agitator's Collar",
        
        hands="Sulevia's Gauntlets +1",
        ear1="Zennaroi Earring",
        ring1="Patricius Ring",
        ring2="Defending Ring",
        back="Grounded Mantle +1",
        waist="Ioskeha Belt",
        legs="Sulevia's Cuisses +1",
        feet="Amm Greaves"
    }
    sets.defense.Reraise = sets.idle.Weak

    sets.defense.MDT = set_combine(sets.defense.PDT, {
        neck="Twilight Torque",
        
        ear1="Zennaroi Earring",
        
    })

    sets.Kiting = {
        legs="Carmine Cuisses +1",
    }

    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}


    -- Defensive sets to combine with various weapon-specific sets below
    -- These allow hybrid acc/pdt sets for difficult content
    sets.Defensive = {
        head="Sulevia's Mask +1",
        neck="Agitator's Collar",
        body="Odyssean Chestplate",
        hands="Sulevia's Gauntlets +1",
        ring1="Patricius Ring",
        ring2="Defending Ring",
        
        waist="Ioskeha Belt",
        legs="Sulevia's Cuisses +1",
        feet="Loyalist Sabatons"
    }
    sets.Defensive_Mid = set_combine(sets.Defensive, {
        ear1="Zennaroi Earring",
        ring2="Supershear Ring",
    })
    sets.Defensive_Acc = sets.Defensive_Mid

    sets.Sulevia = set_combine(sets.Defensive_Mid, {
        head="Sulevia's Mask +1",
        body="Sulevia's Platemail",
        hands="Sulevia's Gauntlets +1",
        legs="Sulevia's Cuisses +1",
        feet="Sulevia's Leggings +1"
    })

    -- Engaged set
    sets.engaged = {
        ammo="Ginsen",
    head="Flam. Zucchetto +2",
    body="Valorous Mail",
    hands="Flam. Manopolas +2",
    legs="Odyssean Cuisses",
    feet="Flam. Gambieras +2",
    neck="Combatant's Torque",
    waist="Ioskeha Belt",
    left_ear="Telos Earring",
    right_ear="Cessance Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Petrov Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    }
   
   

    sets.buff.Souleater = { 
        head="Ignominy Burgeonet +1",
    }

    sets.buff['Last Resort'] = { 
        feet="Fallen's Sollerets +1" 
    }
end

function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type:endswith('Magic') and buffactive.silence then
        eventArgs.cancel = true
        send_command('input /item "Echo Drops" <me>')
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    aw_custom_aftermath_timers_precast(spell)
end

function job_post_precast(spell, action, spellMap, eventArgs)

    -- Make sure abilities using head gear don't swap 
    if spell.type:lower() == 'weaponskill' then
        
        -- CP mantle must be worn when a mob dies, so make sure it's equipped for WS.
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end

        
        
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english:startswith('Drain') then
        if player.status == 'Engaged' and state.CastingMode.current == 'Normal' and player.hpp < 70 then
            classes.CustomClass = 'OhShit'
        end
    end

    if (state.HybridMode.current == 'PDT' and state.PhysicalDefenseMode.current == 'Reraise') then
        equip(sets.Reraise)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    aw_custom_aftermath_timers_aftercast(spell)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
    end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if state.Buff.Souleater and state.SouleaterMode.value then
            send_command('@wait 1.0;cancel souleater')
            --enable("head")
        end
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
end
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 70 then
        idleSet = set_combine(idleSet, sets.idle.Refresh)
    end
    if player.hpp < 70 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    if state.HybridMode.current == 'PDT' then
        idleSet = set_combine(idleSet, sets.defense.PDT)
    end
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    if state.Buff['Souleater'] then
        meleeSet = set_combine(meleeSet, sets.buff.Souleater)
    end
    --meleeSet = set_combine(meleeSet, select_earring())
    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.


-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end

  
    -- Drain II HP Boost. Set SE to stay on.
    if buff == "Max HP Boost" and state.SouleaterMode.value then
        if gain or buffactive['Max HP Boost'] then
            state.SouleaterMode:set(false)
        else
            state.SouleaterMode:set(true)
        end
    end
    -- Make sure SE stays on for BW
    if buff == 'Blood Weapon' and state.SouleaterMode.value then
        if gain or buffactive['Blood Weapon'] then
            state.SouleaterMode:set(false)
        else
            state.SouleaterMode:set(true)
        end
    end
    -- AM custom groups
    if buff:startswith('Aftermath') then
        if player.equipment.main == 'Liberator' then
            classes.CustomMeleeGroups:clear()

            if (buff == "Aftermath: Lv.3" and gain) or buffactive['Aftermath: Lv.3'] then
                classes.CustomMeleeGroups:append('AM3')
                add_to_chat(8, '-------------AM3 UP-------------')
            end

            if not midaction() then
                handle_equipping_gear(player.status)
            end
        else
            classes.CustomMeleeGroups:clear()

            if buff == "Aftermath" and gain or buffactive.Aftermath then
                classes.CustomMeleeGroups:append('AM')
            end

            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end
    
    if  buff == "Samurai Roll" then
        classes.CustomRangedGroups:clear()
        if (buff == "Samurai Roll" and gain) or buffactive['Samurai Roll'] then
            classes.CustomRangedGroups:append('SamRoll')
        end
       
    end

    --if buff == "Last Resort" then
    --    if gain then
    --        send_command('@wait 1.0;cancel hasso')
    --    else
    --        if not midaction() then
    --            send_command('@wait 1.0;input /ja "Hasso" <me>')
    --        end
    --    end
    --end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.

function get_custom_wsmode(spell, spellMap, default_wsmode)
    if state.OffenseMode.current == 'Mid' then
        if buffactive['Aftermath: Lv.3'] then
            return 'AM3Mid'
        end
    elseif state.OffenseMode.current == 'Acc' then
        if buffactive['Aftermath: Lv.3'] then
            return 'AM3Acc'
        end
    else
        if buffactive['Aftermath: Lv.3'] then
            return 'AM3'
        end
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function aw_custom_aftermath_timers_precast(spell)
    if spell.type == 'WeaponSkill' then
        info.aftermath = {}

        local mythic_ws = "Insurgency"

        info.aftermath.weaponskill = mythic_ws
        info.aftermath.duration = 0

        info.aftermath.level = math.floor(player.tp / 1000)
        if info.aftermath.level == 0 then
            info.aftermath.level = 1
        end

        if spell.english == mythic_ws and player.equipment.main == 'Liberator' then
            -- nothing can overwrite lvl 3
            if buffactive['Aftermath: Lv.3'] then
                return
            end
            -- only lvl 3 can overwrite lvl 2
            if info.aftermath.level ~= 3 and buffactive['Aftermath: Lv.2'] then
                return
            end

            if info.aftermath.level == 1 then
                info.aftermath.duration = 90
            elseif info.aftermath.level == 2 then
                info.aftermath.duration = 120
            else
                info.aftermath.duration = 180
            end
        end
    end
end

-- Call from job_aftercast() to create the custom aftermath timer.
function aw_custom_aftermath_timers_aftercast(spell)
    if not spell.interrupted and spell.type == 'WeaponSkill' and
        info.aftermath and info.aftermath.weaponskill == spell.english and info.aftermath.duration > 0 then

        local aftermath_name = 'Aftermath: Lv.'..tostring(info.aftermath.level)
        send_command('timers d "Aftermath: Lv.1"')
        send_command('timers d "Aftermath: Lv.2"')
        send_command('timers d "Aftermath: Lv.3"')
        send_command('timers c "'..aftermath_name..'" '..tostring(info.aftermath.duration)..' down abilities/aftermath'..tostring(info.aftermath.level)..'.png')

        info.aftermath = {}
    end
end

function display_current_job_state(eventArgs)
    local msg = ''
    msg = msg .. 'Offense: '..state.OffenseMode.current
    msg = msg .. ', Hybrid: '..state.HybridMode.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    if state.CapacityMode.value then
        msg = msg .. ', Capacity, '
    end
    if state.SouleaterMode.value then
        msg = msg .. ', SE Cancel, '
    end
    if state.LastResortMode.value then
        msg = msg .. ', LR Defense, '
    end
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end
    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(123, msg)
    eventArgs.handled = true
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
end

-- Creating a custom spellMap, since Mote capitalized absorbs incorrectly
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Dark Magic' and absorbs:contains(spell.english) then
        return 'Absorb'
    end
    if spell.type == 'Trust' then
        return 'Trust'
    end
end

function select_earring()
    if world.time >= (17*60) or world.time <= (7*60) then
        return sets.Lugra
    else
        return sets.Brutal
    end
end

function update_melee_groups()

    classes.CustomMeleeGroups:clear()
    -- mythic AM	
    if player.equipment.main == 'Liberator' then
        if buffactive['Aftermath: Lv.3'] then
            classes.CustomMeleeGroups:append('AM3')
        end
    else
        -- relic AM
        if buffactive['Aftermath'] then
            classes.CustomMeleeGroups:append('AM')
        end
        if buffactive['Samurai Roll'] then
            classes.CustomRangedGroups:append('SamRoll')
        end
    end
end

function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(6, 2)
    elseif player.sub_job == 'SAM' then
        set_macro_page(7, 4)
    else
        set_macro_page(8, 4)
    end
end
