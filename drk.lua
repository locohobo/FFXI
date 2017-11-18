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
    Acro = {}
    Acro.Hands = {}
    Acro.Feet = {}

    Acro.Hands.Haste = {name="Acro gauntlets", augments={'STR+4 DEX+4','Accuracy+18 Attack+18','Haste+2'}} 
    Acro.Hands.STP = {name="Acro gauntlets", augments={'Accuracy+19 Attack+19','"Store TP"+5','Weapon skill damage +3%'}}

    Acro.Feet.STP = {name="Acro Leggings", augments={'STR+7 AGI+7','Accuracy+17 Attack+17','"Store TP"+6'}} 
    Acro.Feet.WSD = {name="Acro Leggings", augments={'Accuracy+18 Attack+18','"Dbl. Atk."+3','Weapon skill damage +2%'}} 

    Niht = {}
    Niht.DarkMagic = {name="Niht Mantle", augments={'Attack+7','Dark magic skill +10','"Drain" and "Aspir" potency +25'}}
    Niht.WSD = {name="Niht Mantle", augments={'Attack+14','Dark magic skill +4', '"Drain" and "Aspir" potency +17', 'Weapon skill damage +5%'}}
    
    Ankou = {}
    Ankou.STP = { name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}
    Ankou.WSD = { name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}

    Odyssean = {}
    Odyssean.Legs = {}
    Odyssean.Legs.TP = { name="Odyssean Cuisses", augments={'Accuracy+23 Attack+23','"Dbl.Atk."+2','STR+3','Accuracy+11','Attack+8',}}
    Odyssean.Legs.WS = { name="Odyssean Cuisses", augments={'Accuracy+25 Attack+25','Weapon skill damage +2%','STR+7','Accuracy+11',}}
    Odyssean.Feet = {}
    Odyssean.Feet.FC = { name="Odyssean Greaves", augments={'Attack+20','"Fast Cast"+4','Accuracy+15',}}
    Odyssean.Feet.TP = { name="Odyssean Greaves", augments={'Accuracy+16 Attack+16','"Store TP"+4','DEX+1','Accuracy+13','Attack+15',}}
 
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA['Diabolic Eye'] = {hands="Fallen's Finger Gauntlets +1"}
    sets.precast.JA['Nether Void']  = {legs="Heathen's Flanchard +1"}
    sets.precast.JA['Dark Seal']    = {head="Fallen's burgeonet +1"}
    sets.precast.JA['Souleater']    = {head="Ignominy burgeonet +1"}
    sets.precast.JA['Blood Weapon'] = {body="Fallen's Cuirass +1"}
    sets.precast.JA['Last Resort']  = {back=Ankou.WSD}

    sets.CapacityMantle  = { back="Mecistopins Mantle" }
    
    
    
    -- Earring considerations, given Lugra's day/night stats
    sets.BrutalLugra     = { ear1="Cessance Earring", ear2="Lugra Earring +1" }
    sets.Lugra           = { ear1="Lugra Earring +1" }
    sets.Brutal          = { ear1="Brutal Earring" }

   

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

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, { 
        head="Cizin Helm +1",
        neck="Stoicheion Medal" 
    })
    sets.precast.FC['Enfeebling Magic'] = set_combine(sets.precast.FC, {
        head="Cizin Helm +1",
    })
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        body="Jumalik Mail",
    })

    -- Midcast Sets
    sets.midcast.FastRecast = {
        ammo="Impatiens",
        head="Fallen's Burgeonet +1",
        body="Odyssean Chestplate",
        hands=Acro.Hands.Haste,
        back="Grounded Mantle +1",
        legs="Carmine Cuisses +1",
        feet=Odyssean.Feet.FC
    }
    sets.midcast.Trust =  {
        head="Fallen's Burgeonet +1",
        hands=Acro.Hands.Haste,
        body="Odyssean Chestplate",
        legs="Carmine Cuisses +1",
        feet=Odyssean.Feet.FC
    }
    sets.midcast["Apururu (UC)"] = set_combine(sets.midcast.Trust, {
        body="Apururu Unity shirt",
    })

    -- Specific spells
    sets.midcast.Utsusemi = {
        ammo="Impatiens",
        head="Otomi Helm",
        neck="Incanter's Torque",
        body="Founder's Breastplate",
        hands="Leyline Gloves",
        back="Grounded Mantle +1",
        feet=Odyssean.Feet.FC
    }

    sets.midcast['Dark Magic'] = {
        ammo="Plumose Sachet", 
        head="Ignominy burgeonet +1", -- 17
        neck="Incanter's Torque", -- 10
        ear1="Gwati Earring",
        ear2="Dark Earring", -- 3
        body="Demon's Harness", --5
        hands="Fallen's Finger Gauntlets +1", -- 14
        waist="Casso Sash", -- 5
        ring1="Evanescence Ring", -- 10
        ring2="Sangoma Ring",
        back=Niht.DarkMagic, -- 10
        legs="Eschite Cuisses",  -- 20
        feet="Heathen's Sollerets +1"
    }
    sets.midcast.Endark = set_combine(sets.midcast['Dark Magic'], {
        feet=Odyssean.Feet.FC
    })

    sets.midcast['Dark Magic'].Acc = set_combine(sets.midcast['Dark Magic'], {
        body="Founder's Breastplate",
        hands="Leyline Gloves",
        waist="Eschan Stone"
    })

    sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Dark Magic'], {
        head="Valorous Mask",
        neck="Sanctity Necklace",
        body="Founder's breastplate",
        hands="Leyline Gloves",
        back="Aput Mantle"
    })

    sets.midcast['Elemental Magic'] = {
        ammo="Plumose Sachet",
        head="Terminal Helm", -- mab+15 mdmg+15
        neck="Eddy Necklace", -- 11 matk
        ear1="Friomisi Earring", -- 10 matk
        ear2="Crematio Earring", -- 6 matk 6 mdmg
        body="Founder's breastplate", -- 21 matk 20 macc
        hands="Leyline Gloves",
        ring1="Resonance Ring", -- int 8
        ring2="Shiva Ring", -- matk 4
        waist="Eschan Stone", -- macc/matk 7
        legs="Eschite Cuisses", -- matk 25 
        back="Aput Mantle", -- mdmg 10
        feet="Founder's Greaves" -- matk 29
    }

    -- Mix of HP boost, -Spell interruption%, and Dark Skill
    sets.midcast['Dread Spikes'] = set_combine(sets.midcast['Dark Magic'], {
        ammo="Impatiens",
        head="Gavialis Helm",
        body="Heathen's Cuirass +1",
        hands="Emicho Gauntlets",
        ring2="K'ayres Ring",
        back="Trepidity Mantle",
        waist="Eschan Stone", -- macc/matk 7
        legs="Carmine Cuisses +1",
        feet=Odyssean.Feet.FC
    })
    sets.midcast['Dread Spikes'].Acc = set_combine(sets.midcast['Dark Magic'], {
        body="Heathen's Cuirass +1",
        hands="Leyline Gloves",
        waist="Eschan Stone", -- macc/matk 7
    })

    -- Drain spells 
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        ear1="Gwati Earring",
        ear2="Hirudinea Earring",
        body="Lugra Cloak +1",
        ring2="Excelsis Ring",
        feet=Odyssean.Feet.FC
    })
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Drain.Acc = set_combine(sets.midcast.Drain, {
        head="Ignominy Burgeonet +1",
        body="Founder's Breastplate",
        hands="Leyline Gloves",
        waist="Eschan Stone", -- macc/matk 7
    })
    sets.midcast.Aspir.Acc = sets.midcast.Drain.Acc

    sets.midcast.Drain.OhShit = set_combine(sets.midcast.Drain, {
        legs="Carmine Cuisses +1",
        feet=Odyssean.Feet.FC
    })

    -- Absorbs
    sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'], {
        back="Chuparrosa Mantle",
        body="Founder's Breastplate",
        hands="Pavor Gauntlets",
    })

    sets.midcast['Absorb-TP'] = set_combine(sets.midcast.Absorb, {
        hands="Heathen's Gauntlets +1"
    })

    sets.midcast.Absorb.Acc = set_combine(sets.midcast['Dark Magic'].Acc, {
        back="Chuparrosa Mantle",
    })
    sets.midcast['Absorb-TP'].Acc = set_combine(sets.midcast.Absorb.Acc, {
        hands="Heathen's Gauntlets +1"
    })


    -- WEAPONSKILL SETS
    -- General sets
    sets.precast.WS = {
        ammo="Aqreqaq Bomblet",
        neck="Ganesha's Mala",
        body="Valorous mail",
        ring1="Niqmaddu Ring",
        ring2="Regal Ring",
        waist="Windbuffet Belt +1",
        feet="Sulevia's Leggings +1"
    }
    sets.precast.WS.Mid = set_combine(sets.precast.WS, {
        ammo="Ginsen",
        head="Argosy Celata",
        body="Mes'yohi Haubergeon",
        legs=Odyssean.Legs.WS
    })
    sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
        ear1="Zennaroi Earring",
        --legs="Sulevia's Cuisses +1",
        waist="Olseni Belt",
    })

    -- RESOLUTION
    -- 86-100% STR
    sets.precast.WS.Resolution = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",
        waist="Fotia Belt"
    })
    sets.precast.WS.Resolution.Mid = set_combine(sets.precast.WS.Resolution, {
        ammo="Ginsen",
    })
    sets.precast.WS.Resolution.Acc = set_combine(sets.precast.WS.Resolution.Mid, sets.precast.WS.Acc) 

    -- TORCLEAVER 
    -- VIT 80%
    sets.precast.WS.Torcleaver = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
		neck="Fotia Gorget",
        hands="Odyssean Gauntlets",
        waist="Fotia Belt",
		right_ear="Ishvara Earring"
		
    })
    sets.precast.WS.Torcleaver.Mid = set_combine(sets.precast.WS.Mid, {
        ammo="Ginsen",
        neck="Fotia Gorget",
    })
    sets.precast.WS.Torcleaver.Acc = set_combine(sets.precast.WS.Torcleaver.Mid, sets.precast.WS.Acc)

    -- INSURGENCY
    -- 20% STR / 20% INT 
    -- Base set only used at 3000TP to put AM3 up
    sets.precast.WS.Insurgency = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",
        body="Odyssean Chestplate",
        waist="Windbuffet Belt +1",
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
        legs=Odyssean.Legs.WS, 
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
        legs=Odyssean.Legs.WS, 
    })

    -- CROSS REAPER
    -- 60% STR / 60% MND
    sets.precast.WS['Cross Reaper'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",
        waist="Windbuffet Belt +1"
    })
    sets.precast.WS['Cross Reaper'].AM3 = set_combine(sets.precast.WS['Cross Reaper'], {
        head="Sulevia's Mask +1",
        legs="Sulevia's Cuisses +1",
    })

    sets.precast.WS['Cross Reaper'].Mid = set_combine(sets.precast.WS['Cross Reaper'], {
        waist="Metalsinger Belt",
    })
    sets.precast.WS['Cross Reaper'].AM3Mid = set_combine(sets.precast.WS['Cross Reaper'].Mid, {
        legs="Sulevia's Cuisses +1",
        neck="Fotia Gorget",
    })
    sets.precast.WS['Cross Reaper'].Acc = set_combine(sets.precast.WS['Cross Reaper'].Mid, {
        ammo="Ginsen",
        neck="Fotia Gorget",
        legs=Odyssean.Legs.WS, 
    })
    -- ENTROPY
    -- 86-100% INT 
    sets.precast.WS.Entropy = set_combine(sets.precast.WS, {
        ammo="Ginsen",
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
    sets.precast.WS.Entropy.Acc = set_combine(sets.precast.WS.Entropy.Mid, {
        legs=Odyssean.Legs.WS
    })

    -- Quietus
    -- 60% STR / MND 
    sets.precast.WS.Quietus = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",
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
        waist="Metalsinger belt",
    })
    sets.precast.WS['Spiral Hell'].Mid = set_combine(sets.precast.WS['Spiral Hell'], sets.precast.WS.Mid, { })
    sets.precast.WS['Spiral Hell'].Acc = set_combine(sets.precast.WS['Spiral Hell'], sets.precast.WS.Acc, { })

    -- SHADOW OF DEATH
    -- 40% STR 40% INT - Darkness Elemental
    sets.precast.WS['Shadow of Death'] = set_combine(sets.precast.WS['Entropy'], {
        head="Terminal Helm",
        neck="Eddy Necklace",
        body="Founder's Breastplate",
        ear1="Friomisi Earring",
        hands="Leyline Gloves",
        back="Toro Cape",
        legs="Valorous Hose",
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
    sets.precast.WS['Dark Harvest'].Mid = set_combine(sets.precast.WS['Shadow of Death'], {head="Terminal Helm", feet="Heathen's Sollerets +1"})
    sets.precast.WS['Dark Harvest'].Acc = set_combine(sets.precast.WS['Shadow of Death'], {head="Terminal Helm", feet="Heathen's Sollerets +1", ring1="Sangoma Ring"})

    -- Sword WS's
    -- SANGUINE BLADE
    -- 50% MND / 50% STR Darkness Elemental
    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
        head="Terminal Helm",
        neck="Eddy Necklace",
        ear1="Friomisi Earring",
        body="Founder's Breastplate",
        hands="Founder's Gauntlets",
        back="Toro Cape",
        feet="Heathen's Sollerets +1"
    })
    sets.precast.WS['Sanguine Blade'].Mid = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Mid)
    sets.precast.WS['Sanguine Blade'].Acc = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Acc)

    -- REQUISCAT
    -- 73% MND - breath damage
    sets.precast.WS.Requiescat = set_combine(sets.precast.WS, {
        head="Acro Helm",
        neck="Fotia Gorget",
        body="Acro Surcoat",
        hands="Odyssean Gauntlets",
        legs="Valorous Hose",
        waist="Fotia Belt",
    })
    sets.precast.WS.Requiescat.Mid = set_combine(sets.precast.WS.Requiscat, sets.precast.WS.Mid)
    sets.precast.WS.Requiescat.Acc = set_combine(sets.precast.WS.Requiscat, sets.precast.WS.Acc)

    -- Idle sets
    sets.idle.Town = {
        ammo="Ginsen",
        head="",
        neck="Sanctity Necklace",
        ear1="Cessance Earring",
        ear2="Tripudio Earring",
        body="Lugra Cloak +1",
        hands="Sulevia's Gauntlets +1",
        ring1="Paguroidea Ring",
        ring2="Defending Ring",
        back="Impassive Mantle",
        waist="Flume Belt",
        legs="Carmine Cuisses +1",
        feet="Sulevia's leggings +1"
    }

    sets.idle.Field = set_combine(sets.idle.Town, {
        ammo="Ginsen",
        head="Valorous Mask",
        ear1="Zennaroi Earring",
        neck="Sanctity Necklace",
        body="Jumalik mail",
        hands="Sulevia's Gauntlets +1",
        ring1="Dark Ring",
        ring2="Defending Ring",
        back="Impassive Mantle",
        waist="Flume Belt",
        legs="Carmine Cuisses +1",
        feet="Sulevia's leggings +1"
    })
    sets.idle.Regen = set_combine(sets.idle.Field, {
        neck="Sanctity Necklace",
        body="Lugra Cloak +1",
        ring1="Paguroidea Ring",
        head="",
    })
    sets.idle.Refresh = set_combine(sets.idle.Regen, {
        neck="Coatl Gorget +1"
    })


    -- Defense sets
    sets.defense.PDT = {
        ammo="Hasty Pinion +1",
        head="Sulevia's Mask +1",
        neck="Agitator's Collar",
        body="Jumalik Mail",
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
        body="Lugra Cloak +1",
        ear1="Zennaroi Earring",
        ring1="Dark Ring",
        back="Impassive Mantle",
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
        back=Ankou.STP,
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
    head="Flam. Zucchetto +1",
    body={ name="Valorous Mail", augments={'Accuracy+18 Attack+18','STR+12',}},
    hands="Flam. Manopolas +1",
    legs="Ig. Flanchard +2",
    feet={ name="Valorous Greaves", augments={'Attack+27','Weapon skill damage +3%','STR+14','Accuracy+8',}},
    neck="Combatant's Torque",
    waist="Kentarch Belt +1",
    left_ear="Telos Earring",
    right_ear="Brutal Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Petrov Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    }
    --[[sets.engaged.Mid = set_combine(sets.engaged, {
        head="Valorous Mask",
        hands="Emicho Gauntlets",
        body="Mes'yohi Haubergeon",
        back=Ankou.STP,
        waist="Ioskeha Belt",
        legs=Odyssean.Legs.TP,
        feet=Odyssean.Feet.TP
    })
    sets.engaged.Acc = set_combine(sets.engaged.Mid, {
        ammo="Hasty Pinion +1",
        neck="Lissome Necklace",
        ear1="Cessance Earring",
        body="Odyssean Chestplate",
        ear2="Zennaroi Earring",
        ring1="Cacoethic Ring +1",
        back=Ankou.STP,
        waist="Ioskeha Belt",
    })--]]
   

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

        if player.tp > 2999 then
            equip(sets.BrutalLugra)
        else -- use Lugra + moonshade
            if world.time >= (17*60) or world.time <= (7*60) then
                equip(sets.Lugra)
            else
                equip(sets.Brutal)
            end
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