-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
--[[
        Custom commands:
 
        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.
 
                                        Light Arts              Dark Arts
 
        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
        gs c scholar addendum           Addendum: White         Addendum: Black
--]]
 
 
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
 
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end
 
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}
 
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    update_active_strategems()
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','PDT')
    state.CastingMode:options('Normal', 'MB')
    state.IdleMode:options('Normal', 'PDT')
                         
    info.Helix = S{"Geohelix","Hydrohelix","Anemohelix","Pyrohelix","Cryohelix","Ionohelix","Luminohelix","Noctohelix",
                  "Geohelix II","Hydrohelix II","Anemohelix II","Pyrohelix II","Cryohelix II","Ionohelix II","Luminohelix II","Noctohelix II"}
     
     
    send_command('bind ^q gs c cycle CastingMode')
    send_command('bind ^e gs c cycle OffenseMode')
    send_command('bind ^` input /ma Stun <t>')
    send_command('bind %b input /ja sublimation <me>')
     
 
    select_default_macro_book()
end
 
function user_unload()
    send_command('unbind ^`')
    send_command('unbind ^q')
    send_command('unbind ^e')
    send_command('unbind %b')
    send_command('unbind ^q')
    send_command('unbind ^e')
end
 
 
-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
         
    -- Precast Sets
 
    -- Precast sets to enhance JAs
 
    sets.precast.JA['Tabula Rasa'] = {}
 
 
    -- Fast cast sets for spells
 
    sets.precast.FC = {ammo="Impatiens",
        head="Merlinic Hood",ear1="Etiolation Earring", ear2="Loquacious earring",
        body="Anhur Robe",hands="Acad. Bracers +1",ring1="Lebeche Ring",
        back="Swith Cape",waist="Channeler's Stone",legs="psycloth lappas",feet="Merlinic crackows", augments={'"Cure" spellcasting time -7%','"Fast Cast"+3','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
 
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
 
    sets.precast.FC.Stoneskin = {
    ammo="Impatiens",
    head="Merlinic Hood",
    body={ name="Helios Jacket", augments={'"Fast Cast"+3',}},
    hands="Acad. Bracers +1",
    legs="Psycloth Lappas",
    feet={ name="Merlinic Crackows", augments={'"Cure" spellcasting time -7%','"Fast Cast"+3','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
    waist="Siegel Sash",
    ear1="Etiolation Earring", ear2="Loquacious earring",
    back="Swith Cape",
}
     
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {neck="Stoicheion Medal",ear1="Barkaro. Earring"})
 
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {back="Pahtli Cape",ear1="Mendicant's earring",body="Vanya Robe",feet="Vanya clogs"})
 
    sets.precast.FC.Curaga = sets.precast.FC.Cure
 
    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {head=empty,body="Twilight Cloak"})
 
 
    -- Midcast Sets
 
    sets.midcast.FastRecast = {ammo="Impatiens",
        head="Merlinic Hood",ear2="Loquacious Earring",
        body="Anhur Robe",ring1="Prolix Ring",
        back="Swith Cape",waist="Goading Belt",legs="",feet="Acad. Loafers +1"}
 
    sets.midcast.Cure = {
    ammo="Hydrocera",
    legs="Psycloth Lappas",
    feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
    neck="Nodens Gorget",
    waist="Gishdubar Sash",
    left_ear="Calamitous Earring",
    right_ear="Mendi. Earring",
    left_ring="Asklepian Ring",
    right_ring="Sirona's Ring",
    back="Oretania's Cape",
	head="Chironic Hat",
    body={ name="Chironic Doublet", augments={'"Mag.Atk.Bns."+30','"Conserve MP"+1','MND+1',}},
}
 
    sets.midcast.CureWithLightWeather = {}
    sets.midcast.Curaga = sets.midcast.Cure
 
    sets.midcast.Regen = {
    head="Arbatel bonnet +1",
    back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
}
 
    sets.midcast.Cursna = {
    ammo="Impatiens",
    head="Merlinic Hood",
    body="Witching Robe",
    legs="Psycloth Lappas",
    neck="Malison Medallion",
    waist="Gishdubar Sash",
    left_ear="Gifted Earring",
    right_ear="Calamitous Earring",
    left_ring="Ephedra Ring",
    back="Solemnity Cape",
}
 
    sets.midcast['Enhancing Magic'] = {    ammo="Impatiens",
    neck="Twilight Torque",
    waist="Siegel Sash",
    left_ear="Gifted Earring",
    right_ear="Calamitous Earring",
    left_ring="Vertigo Ring",
    right_ring="Ephedra Ring",
    back="Perimede Cape",
}
 
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {ear1="Earthcry earring",legs="Haven hose",neck="Nodens gorget"})
 
    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {feet="Pedagogy Loafers"})
 
    sets.midcast.Protect = {}
    sets.midcast.Protectra = sets.midcast.Protect
 
    sets.midcast.Shell = {}
 
    sets.midcast.Shellra = sets.midcast.Shell
 
 
    -- Custom spell classes
    sets.midcast.MndEnfeebles = {ammo="Mana ampulla",
        head="Jhakri coronal +1",neck="Imbodla Necklace",ear1="Barkaro. Earring",ear2="Lifestorm Earring",
        body="Vanya Robe",hands="Jhakri cuffs +1",ring1="Sirona's ring",ring2="Strendu Ring",
        back="Lugh's cape",waist="Eschan Stone",legs="Psycloth Lappas",feet="Jhakri pigaches +1"}
 
    sets.midcast.IntEnfeebles = {ammo="Mana ampulla",
        head="Jhakri coronal +1",neck="Imbodla Necklace",ear1="Friomisi Earring",ear2="Barkaro. Earring",
        body="Vanya Robe",hands="Jhakri cuffs +1",ring1="Fenrir Ring +1",ring2="Strendu Ring",
        back="Lugh's cape",waist="Eschan Stone",legs="Psycloth Lappas",feet="Jhakri pigaches +1"}
 
    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles
 
    sets.midcast['Dark Magic'] = {ammo="Mana ampulla",
        head="Pixie Hairpin +1",neck="Sanctity necklace",ear1="Barkaro. Earring",ear2="Lifestorm Earring",
        body="Jhakri robe +1",hands="Jhakri cuffs +1",ring1="Sirona's ring",ring2="Strendu Ring",
        back="Lugh's cape",waist="Eschan Stone",legs="jhakri slops +1",feet="Jhakri pigaches +1"}
 
    sets.midcast.Kaustra = {ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Sanctity necklace",ear1="Barkaro. Earring",ear2="Static earring",
        body="Jhakri robe +1",hands="Amalric gages",ring1="Fenrir Ring +1",ring2="Strendu Ring",
        back="Lugh's cape",waist="Eschan Stone",legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+13 "Mag.Atk.Bns."+13','Phys. dmg. taken -2%','Mag. Acc.+11','"Mag.Atk.Bns."+13',}},feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','INT+9','Mag. Acc.+9','"Mag.Atk.Bns."+15',}}}
         
    sets.midcast.Kaustra.MB = {ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Mizu. Kubikazari",ear1="Barkaro. Earring",ear2="Static earring",
        body="Jhakri robe +1",hands="Amalric gages",ring1="Locus Ring",ring2="Mujin Band",
        back="Lugh's cape",waist="Eschan Stone",legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+13 "Mag.Atk.Bns."+13','Phys. dmg. taken -2%','Mag. Acc.+11','"Mag.Atk.Bns."+13',}},feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','INT+9','Mag. Acc.+9','"Mag.Atk.Bns."+15',}}}
 
    sets.midcast.Drain = {ammo="Mana ampulla",
        head="Pixie Hairpin +1",neck="Stoicheion medal",ear1="Barkaro. Earring",ear2="Lifestorm Earring",
        body="Jhakri robe +1",hands="Jhakri cuffs +1",ring1="Sirona's ring",ring2="Strendu Ring",
        back="Lugh's cape",waist="Eschan Stone",legs="jhakri slops +1",feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','INT+9','Mag. Acc.+9','"Mag.Atk.Bns."+15',}}}
 
    sets.midcast.Aspir = sets.midcast.Drain
 
    sets.midcast.Stun = {}
 
    -- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] = {ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Sanctity necklace",ear1="Barkaro. Earring",ear2="Friomisi Earring",
        body="Jhakri robe +1",hands="Amalric gages",ring1="Fenrir Ring +1",ring2="Strendu Ring",
        back="Lugh's cape",waist="Eschan Stone",legs="jhakri slops +1",feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','INT+9','Mag. Acc.+9','"Mag.Atk.Bns."+15',}}}
 
    sets.midcast['Elemental Magic'].MB = {ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Mizu. Kubikazari",ear1="Barkaro. Earring",ear2="Friomisi earring",
        body="Jhakri robe +1",hands="Amalric gages",ring1="Locus Ring",ring2="Mujin Band",
        back="Lugh's cape",waist="Eschan Stone",legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+13 "Mag.Atk.Bns."+13','Phys. dmg. taken -2%','Mag. Acc.+11','"Mag.Atk.Bns."+13',}},feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','INT+9','Mag. Acc.+9','"Mag.Atk.Bns."+15',}}}
         
    ------ Barkarole Earring replaces Hectate
	----- S
	
	
	
	
	-- Custom refinements for certain nuke tiers
   --sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'])
   --sets.midcast['Elemental Magic'].HighTierNuke.MB = set_combine(sets.midcast['Elemental Magic'].MB)
 
 
    sets.midcast.Impact = {}
 
    sets.midcast.Helix = {ammo="Pemphredo Tathlum",
        head="Jhakri coronal +1",neck="Sanctity necklace",ear1="Barkaro. Earring",ear2="Friomisi Earring",
        body="Jhakri robe +1",hands="Jhakri cuffs +1",ring1="Fenrir Ring +1",ring2="Strendu Ring",
        back="Lugh's cape",waist="Eschan Stone",legs="jhakri slops +1",feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','INT+9','Mag. Acc.+9','"Mag.Atk.Bns."+15',}}}
     
    sets.midcast.Helix.MB = {ammo="Pemphredo Tathlum",
        head="Jhakri coronal +1",neck="Mizu. Kubikazari",ear1="Barkaro. Earring",ear2="Static earring",
        body="Jhakri robe +1",hands="Amalric gages",ring1="Locus Ring",ring2="Mujin Band",
        back="Lugh's cape",waist="Eschan Stone",legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+13 "Mag.Atk.Bns."+13','Phys. dmg. taken -2%','Mag. Acc.+11','"Mag.Atk.Bns."+13',}},feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','INT+9','Mag. Acc.+9','"Mag.Atk.Bns."+15',}}}
    -- Sets to return to when not performing an action.
 
    -- Resting sets
    sets.resting = {}
 
 
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
     
    sets.precast.WS['Myrkr']={
ammo=SCH_whale_ammo,
head=SCH_whale_head,
body=SCH_whale_body,
hands=SCH_whale_hands,
legs=SCH_whale_legs,
feet=SCH_whale_feet,
neck=SCH_whale_neck,
waist=SCH_whale_waist,
left_ear=SCH_whale_left_ear,
right_ear=SCH_whale_right_ear,
left_ring=SCH_whale_left_ring,
right_ring=SCH_whale_right_ring,
back=SCH_whale_back}
 
    sets.idle.Town = {ammo="Impatiens",
        head="Befouled Crown",neck="Sanctity necklace",ear1="Infused earring",ear2="Friomisi Earring",
        body="Jhakri robe +1",hands="Jhakri cuffs +1",ring1="Defending ring",ring2="Fenrir Ring +1",
        back="Lugh's cape",waist="Eschan Stone",legs="Lengo Pants",feet="Jhakri pigaches +1"}
 
    sets.idle.Field = {ammo="Impatiens",
        head="Befouled Crown",neck="Sanctity necklace",ear1="Infused earring",ear2="Lifestorm earring",
        body="Jhakri robe +1",hands="Jhakri cuffs +1",ring1="Ephedra ring",ring2="Defending ring",
        back="Solemnity cape",waist="Eschan Stone",legs="Lengo Pants",feet="Jhakri pigaches +1"}
 

    sets.idle.Field.Stun = {}
 
    sets.idle.Weak = {}
	
    -- Engaged sets
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
 
    -- Normal melee group
    sets.engaged = {ammo="Impatiens",
        head="Jhakri coronal +1",neck="Sanctity necklace",ear1="Infused earring",ear2="Lifestorm earring",
        body="Jhakri robe +1",hands="Jhakri cuffs +1",ring1="Ephedra ring",ring2="shneddick ring",
        back="Solemnity cape",waist="Eschan Stone",legs="Assiduity pants +1",feet="Jhakri pigaches +1"}
     
 
    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Ebullience'] = {head="Arbatel Bonnet +1"}
    sets.buff['Rapture'] = {head="Arbatel Bonnet +1"}
    sets.buff['Perpetuance'] = {hands="Arbatel bracers"}
    sets.buff['Immanence'] = {hands="Arbatel Bracers"}
    sets.buff['Penury'] = {legs="Arbatel Pants +1"}
    sets.buff['Parsimony'] = {legs="Arbatel Pants +1"}
    sets.buff['Celerity'] = {feet="Pedagogy Loafers"}
    sets.buff['Alacrity'] = {feet="Pedagogy Loafers"}
 
    sets.buff['Klimaform'] = {feet="Arbatel Loafers +1"}
 
    sets.buff.FullSublimation = {}
    sets.buff.PDTSublimation = {}
 
    --sets.buff['Sandstorm'] = {feet="Desert Boots"}
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.self_healing)
    end
    if spell.action_type == 'Magic' then
        apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    end
    if spell.skill == 'Elemental Magic' then
        if (spell.element == world.day_element or spell.element == world.weather_element) and spellMap ~= 'Helix' then
            equip({waist="Hachirin-No-Obi"})
            add_to_chat(8,'----- Obi Equipped. -----')          
        end
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end
end
 
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if world.weather_element == 'Light' then
                return 'CureWithLightWeather'
            end
        elseif spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        --elseif spell.skill == 'Elemental Magic' then
          --  if info.low_nukes:contains(spell.english) then
            --    return 'LowTierNuke'
            --elseif info.mid_nukes:contains(spell.english) then
              --  return 'MidTierNuke'
            --elseif info.high_nukes:contains(spell.english) then
              --  return 'HighTierNuke'
            --end
        end
    end
end
 
function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        if state.IdleMode.value == 'Normal' then
            idleSet = set_combine(idleSet, sets.buff.FullSublimation)
        elseif state.IdleMode.value == 'PDT' then
            idleSet = set_combine(idleSet, sets.buff.PDTSublimation)
        end
    end
 
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
 
    return idleSet
end
 
-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not (buffactive['light arts']      or buffactive['dark arts'] or
                       buffactive['addendum: white'] or buffactive['addendum: black']) then
        if state.IdleMode.value == 'Stun' then
            send_command('@input /ja "Dark Arts" <me>')
        else
            send_command('@input /ja "Light Arts" <me>')
        end
    end
 
    update_active_strategems()
    update_sublimation()
end
 
-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false
 
    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end
 
function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end
 
-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.Buff.Ebullience and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
        end
    end
 
    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end
 
 
-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use
 
    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()
 
    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end
 
 
-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
    -- returns recast in seconds.
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]
 
    local maxStrategems = (player.main_job_level + 10) / 20
 
    local fullRechargeTime = 4*60
 
    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)
 
    return currentCharges
end
 
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 20)
end
