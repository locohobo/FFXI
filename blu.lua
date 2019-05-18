--To toggle gearsets:
--Main command: //gs c toggle x set       where x = set name variable. Variables are as follows: --
--Idle sets: Idle, TP sets: TP--
--Requiescat sets: Req, Chant du Cygne sets: CDC, Expiacion sets: Expi, Savage Blade sets: Savage--
--Realm, FlashNova--

--E.g.   /console gs c toggle CDC set--
--              /console gs c toggle TP set--
--                              Reqi, etc, read at the bottom of the GS in the toggles for the names--
 
--I am sure there is outdated gear in here that I have probably even forgotten to change --
--Just look over it and fit it to your needs--


		send_command('bind f9 gs c toggle TP set')
		send_command('bind f10 gs c toggle CDC set')
		send_command('bind f11 gs c toggle Req set')
		send_command('bind f12 gs c toggle Idle set') 
		send_command('bind ^f9 input /ws "Chant du Cygne" <t>')
		send_command('bind ^f10 input /ws "Expiacion" <t>')
		send_command('bind ^f11 input /ws "Sanguine Blade" <t>')
		send_command('bind ^f12 input /ws "Requiescat" <t>')
		send_command('bind !f12 input /ws "Realmrazer" <t>')
		send_command('bind !f10 gs c toggle Rea set')
		send_command('bind !f11 gs c toggle Expi set') 
	   
        function file_unload()
     
 
        send_command('unbind ^f9')
        send_command('unbind ^f10')
        send_command('unbind ^f11')
        send_command('unbind ^f12')
       
        send_command('unbind !f9')
        send_command('unbind !f10')
        send_command('unbind !f11')
        send_command('unbind !f12')
 
        send_command('unbind f9')
        send_command('unbind f10')
        send_command('unbind f11')
        send_command('unbind f12')
 
       
 
        end 


function get_sets()
	   
	--Idle Sets--				
	
	sets.Idle = {ammo="Hydrocera",
			head="Rawhide Mask", neck="Loricate Torque",
		    body="Jhakri Robe +2",ring1="Sheltered ring",ring2="Paguroidea Ring",
			back="Solemnity Cape",waist="Flume Belt",legs="Carmine Cuisses +1"}
						  					
							
	
	--TP Sets--
	
	--DW III +1200JP--
	sets.TP = {ammo="Ginsen",
					head="Adhemar Bonnet +1",
					body="Adhemar jacket +1",
					hands="Adhemar Wrist. +1",
					legs="Samnuha Tights",
					feet={ name="Herculean Boots", augments={'Accuracy+16 Attack+16','"Triple Atk."+2','DEX+8','Attack+11',}},
					neck="Lissome Necklace",
					waist="Reiki yotai",
					ear2="Brutal Earring",
					ear1="Telos Earring",
					left_ring="Petrov Ring",
					right_ring="Hetairoi Ring",
					back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Store TP"+10',}}}
	
	--Weaponskill Sets-- Cornflower for Requiescat because it saves a spot as it is the ONLY thing I would need to carry Bleating Mantle for...
	sets.WS = {}
		
	sets.Requiescat = {ammo="Floestone",
			        head="Jhakri Coronal +2",
					neck="Fotia Gorget",
					ear1="Mache Earring",ear2="Brutal Earring",
					body="Jhakri Robe +2",
					hands="Jhakri Cuffs +2",
					ring1="Epona's ring",ring2="Rufescent Ring",
					waist="Fotia Belt",
					back="Bleating Mantle",
					legs="Jhakri Slops +2",
					feet="Jhakri Pigaches +2"}
								  
							 
	
	sets.ChantDuCygne = {ammo="Jukukik Feather",
					head="Adhemar Bonnet +1",
					neck="Fotia Gorget",
					ear1="Mache Earring",ear2="Brutal Earring",
					body="Abnoba Kaftan",
					hands="Adhemar Wrist. +1",
					ring1="Begrudging Ring",ring2="Hetairoi Ring",
					back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
					waist="Fotia Belt",
					legs="Samnuha Tights",
					feet={ name="Herculean Boots", augments={'Accuracy+16 Attack+16','"Triple Atk."+2','DEX+8','Attack+11',}}}
							   
	
	  sets.SavageBlade = sets.Expiacion
	
	sets.Expiacion = {ammo="Floestone",
			        head="Lilitu Headpiece",
					neck="Fotia Gorget",
					ear1="Ishvara Earring",ear2="Vulcan's Pearl",
				    body="Assim. Jubbah +3",
					hands="Jhakri cuffs +2",
					legs={ name="Herculean Trousers", augments={'Mag. Acc.+4','INT+7','Weapon skill damage +9%','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
					ring1="Rufescent Ring",ring2="Ifrit Ring",
				    back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
					waist="Prosilio Belt +1",
					}
					
	
	sets.WS.SanguineBlade = {ammo="Pemphredo Tathlum",
					head="Pixie Hairpin +1",
					neck="Sanctity Necklace",
					ear1="Friomisi Earring",ear2="Hecate's earring",
					body="Amalric Doublet",
					hands="Amalric Gages",
					ring1="Archon Ring",ring2="Rufescent Ring",
					back="Bleating Mantle",
					waist="Grunfeld Rope",
					legs="Amalric Slops",
					feet="Jhakri Pigaches +2"}
			
	sets.CircleBlade = {ammo="Floestone",
			       head="Adhemar Bonnet +1",
				   neck="Lissome necklace",
				   ear1="Cessance Earring",ear2="Brutal Earring",
			       body="Adhemar Jacket +1",
				   hands="Adhemar Wrist. +1",
				   ring1="Epona's ring",ring2="Apate Ring",
			       back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
				   waist="Windbuffet Belt +1",
				   legs="Samnuha Tights",
				    }							
	
	
				   
	--Blue Magic Sets--
	sets.BlueMagic = {}
	
	sets.BlueMagic.STR = {ammo="Floestone",
			      head="Adhemar Bonnet +1",
				  neck="Caro Necklace",
				  ear1="Zennaroi Earring",
			      body="Adhemar Jacket +1",
				  hands="Adhemar Wrist. +1",
				  ring1="Ifrit Ring",ring2="Apate Ring",
			      back="Cornflower cape",
				  waist="Grunfeld Rope",
				  legs="Samnuha Tights",
				  feet={ name="Herculean Boots", augments={'Accuracy+16 Attack+16','"Triple Atk."+2','DEX+8','Attack+11',}}}
						  
	sets.BlueMagic.STRDEX = set_combine(sets.BlueMagic.STR,{
				 })
							
		sets.BlueMagic.STRVIT = set_combine(sets.BlueMagic.STR,{
				 })
							 
		sets.BlueMagic.STRMND = set_combine(sets.BlueMagic.STR,{
				 })
								
	sets.BlueMagic.AGI = set_combine(sets.BlueMagic.STR,{
				feet="Thereoid Greaves"})
		
	sets.BlueMagic.INT = {ammo="Pemphredo Tathlum",
			    head="Jhakri Coronal +2",
				neck="Sanctity Necklace",
				ear1="Regal Earring",ear2="Friomisi earring",
			    body="Jhakri Robe +2",
				hands="Jhakri Cuffs +2",
				ring1="Arvina Ringlet +1",ring2="Shiva Ring",
			    back="Cornflower cape",
				waist="Eschan Stone",
				legs="Jhakri Slops +2",
				feet="Jhakri Pigaches +2"}
				  
	sets.BlueMagic.DarkNuke = set_combine(sets.BlueMagic.INT,{
				head="Pixie Hairpin +1",
				ring2="Archon Ring",})
						  
	sets.BlueMagic.Cures = {ammo="Hydrocera",
			        head="Carmine Mask +1",
					neck="Phalaina Locket",
					ear1="Mendicant's Earring",ear2="Ethereal Earring",
			        body="Vrikodara Jupon",
					hands="Telchine Gloves",
					ring1="Kunaji Ring",ring2="Rufescent Ring",
			        back="Cornflower Cape",
					waist="Gishdubar Sash",
					legs="Gyve Trousers",
					feet="Medium's Sabots"}
	
	sets.BlueMagic.Battery = {ammo="Pemphredo Tathlum",
					head="Amalric Coif",
					neck="Incanter's Torque",
					right_ear="Suppanomimi",left_ear="Ethereal earring",
					body="Emet Harness +1",
					ring2="Defending Ring",
					waist="Gishdubar Sash",
					legs="Iuitl Tights +1",
					feet="Carmine Greaves"}
							
	sets.BlueMagic.Stun = {ammo="Pemphredo Tathlum",
				    head="Carmine Mask +1",
					neck="Sanctity Necklace",
					ear1="Zennaroi Earring",ear2="Dignitary's Earring",
				    body="Amalric Doublet",
					hands="Adhemar Wrist. +1",
					ring1="Ramuh Ring",ring2="Fenrir Ring +1",
				    back="Cornflower cape",
					waist="Eschan Stone",
					legs="Hashishin Tayt",
					}
						   
	sets.BlueMagic.HeavyStrike = {ammo="Falcon Eye",
					head="Adhemar Bonnet +1",
					neck="Caro Necklace",
					ear1="Zennaroi Earring",ear2="Kuwunga Earring",
					body="Adhemar Jacket +1",
					hands="Adhemar Wrist. +1",
					ring1="Ifrit Ring",ring2="Apate Ring",
					back="Rosmerta's Cape",
					waist="Grunfeld Rope",
					legs="Samnuha Tights",
					feet={ name="Herculean Boots", augments={'Accuracy+16 Attack+16','"Triple Atk."+2','DEX+8','Attack+11',}}}
								  
	
	sets.BlueMagic.WhiteWind = {ammo="Pemphredo Tathlum",
				    head="Adhemar Bonnet +1",
					neck="Phalaina Locket",
					ear1="Mendicant's Earring",ear2="Ethereal Earring",
			        body="Vrikodara Jupon",
					hands="Telchine Gloves",
					ring1="Kunaji Ring",ring2="Rufescent Ring",
			        back="Cornflower Cape",
					waist="Gishdubar Sash",
					legs="Gyve Trousers",
					feet="Medium's Sabots"}
									 
	sets.BlueMagic.MagicAccuracy = {ammo="Pemphredo Tathlum",
				    head="Jhakri coronal +2",
					neck="Sanctity Necklace",
					ear1="Gwati Earring",ear2="Digni. Earring",
				    body="Amalric Doublet",
					hands="Leyline Gloves",
					ring1="Arvina Ringlet +1",ring2="Fenrir Ring +1",
				    back="Cornflower cape",
					waist="Eschan Stone",
					legs="Jhakri Slops +2",
					feet="Jhakri Pigaches +2"} 
									 
	sets.BlueMagic.Skill = {ammo="Pemphredo Tathlum",
					head="Luhlaza Keffiyeh",
					neck="Incanter's Torque",
					right_ear="Suppanomimi",left_ear="Ethereal earring",
					body="Assim. jubbah +3",
					hands="Rawhide Gloves",
					ring1="Lebeche ring",ring2="Fenrir Ring +1",
					back="Cornflower cape",
					waist="Gishdubar Sash",
					legs="Hashishin Tayt",
					feet="Luhlaza charuqs"}
					  

						
	--Utility Sets--
	--Sets such as Phalanx/Steps are out of date because I don't fucking cast/use that shit!
	
	sets.Utility = {}
	
	sets.Utility.Stoneskin = {ammo="Hydrocera",
					head="Carmine Mask +1",
					
					ear1="Loquac. earring",ear2="Earthcry earring",
					body="Assim. jubbah +3",
					
					ring2="Rufescent Ring",
					back="Swith cape",
					waist="Siegel sash",
					legs="Haven hose",
					}
							  						
							
	sets.Enhancing = {ammo="Pemphredo Tathlum",
					head="Carmine Mask +1",
					neck="Incanter's Torque",
					right_ear="Suppanomimi",left_ear="Ethereal earring",
					body="Telchine Chasuble",
					ring2="Defending Ring",
					back="Umbra Cape",
					waist="Gishdubar Sash",
					legs="Carmine Cuisses +1",
					feet="Carmine Greaves"}
	
	
	
	--Job Ability Sets--
	
	sets.JA = {}
	
	sets.JA.ChainAffinity = {feet="Assim. charuqs +1"}
	
	sets.JA.BurstAffinity = {feet="Hashishin Basmak +1"}
	
	sets.JA.Efflux = {legs="Hashishin Tayt"}
	
	sets.JA.AzureLore = {hands="Luhlaza bazubands"}
	
	sets.JA.Diffusion = {ammo="Pemphredo Tathlum", neck="Incanter's Torque", head="Amalric Coif", feet="Luhlaza Charuqs", waist="Gishdubar Sash"}
	
								
								
			
			
			
			
	--Precast Sets--
	sets.precast = {}
	
	sets.precast.FC = {}
	
	sets.precast.FC.Standard = {ammo="Impatiens",
					head="Carmine Mask +1",
					neck="Baetyl Pendant",
					ear1="Loquac. Earring",ear2="Etiolation Earring",
				    body="Dread Jupon",
					hands="Leyline Gloves",
					ring1="Kishar Ring",
			        back="Swith Cape",
					waist="Witful Belt",
					legs="Psycloth Lappas",
					feet="Carmine Greaves"}
	
	sets.precast.FC.Blue = {ammo="Impatiens",
					head="Carmine Mask +1",
					neck="Baetyl Pendant",
					ear1="Loquac. Earring",ear2="Etiolation Earring",
					body="Hashishin Mintan +1",
					hands="Leyline Gloves",
					ring1="Kishar Ring",
					back="Swith Cape",
					waist="Witful Belt",
					legs="Psycloth Lappas",
					feet="Carmine Greaves"}	
end






function precast(spell)
	if spell.action_type == 'Magic' then
		equip(sets.precast.FC.Standard)
				
		elseif spell.action_type == 'BlueMagic' then
		equip(sets.precast.FC.Blue)
	end
	
	if spell.english == 'Azure Lore' then
		equip(sets.JA.AzureLore)
	end
	
	if spell.english == 'Requiescat' then
		equip(sets.Requiescat)
	end
	
	if spell.english == 'Chant du Cygne' then
		equip(sets.ChantDuCygne)
	end
	
	if spell.english == 'Expiacion' then
		equip(sets.Expiacion)
	end

	if spell.english == 'Savage Blade' then
		equip(sets.Expiacion)
	end
	
	if spell.english == 'Realmrazer' then
		equip(sets.Realmrazer)
	end
	
	if spell.english == 'Flash Nova' then
		equip(sets.FlashNova)
	end
	
	if spell.english == 'Circle Blade' then
		equip(sets.WS.CircleBlade)
	end
	
	if spell.english == 'Sanguine Blade' or spell.english == 'Red Lotus Blade' then
		equip(sets.WS.SanguineBlade)
	end
	
	if spell.english == 'Box Step' then
		equip(sets.Utility.Steps)
	end
end
	
function midcast(spell,act)
	if spell.english == 'Vertical Cleave' 	or spell.english == 'Death Scissors' 	or spell.english == 'Empty Thrash' 
	or spell.english == 'Dimensional Death' or spell.english == 'Quadrastrike' 		or spell.english == 'Bloodrake' 
	or spell.english == 'Sweeping Gouge' 	then
		equip(sets.BlueMagic.STR)
		if buffactive['Chain Affinity'] then
			equip(sets.JA.ChainAffinity)
		end
		if buffactive['Efflux'] then
			equip(sets.JA.Efflux)
		end
	end
		
	if spell.english == 'Disseverment' 		or spell.english == 'Hysteric Barrage' 	or spell.english == 'Frenetic Rip' 
	or spell.english == 'Seedspray' 		or spell.english == 'Vanity Dive' 		or spell.english == 'Goblin Rush' 
	or spell.english == 'Paralyzing Triad'	or spell.english == 'Thrashing Assault'  then
		equip(sets.BlueMagic.STRDEX)
		if buffactive['Chain Affinity'] then
			equip(sets.JA.ChainAffinity)
		end
		if buffactive['Efflux'] then
			equip(sets.JA.Efflux)
		end
	end
	
	if spell.english == 'Quad. Continuum' or spell.english == 'Delta Thrust' or spell.english == 'Cannonball' 
	or spell.english == 'Glutinous Dart'  or spell.english == 'Sinker Drill' then
		equip(sets.BlueMagic.STRVIT)
		if buffactive['Chain Affinity'] then
			equip(sets.JA.ChainAffinity)
		end
		if buffactive['Efflux'] then
			equip(sets.JA.Efflux)
		end
	end
	
	if spell.english == 'Whirl of Rage' then
		equip(sets.BlueMagic.STRMND)
		if buffactive['Chain Affinity'] then
			equip(sets.JA.ChainAffinity)
		end
		if buffactive['Efflux'] then
			equip(sets.JA.Efflux)
		end
	end
	
	if spell.english == 'Benthic Typhoon' or spell.english == 'Final Sting' or spell.english == 'Spiral Spin' then
		equip(sets.BlueMagic.AGI)
		if buffactive['Chain Affinity'] then
			equip(sets.JA.ChainAffinity)
		end
		if buffactive['Efflux'] then
			equip(sets.JA.Efflux)
		end
	end
	
	if spell.english == 'Gates of Hades' 	or spell.english == 'Leafstorm' 		or spell.english == 'Firespit' 
	or spell.english == 'Acrid Stream' 		or spell.english == 'Regurgitation' 	or spell.english == 'Corrosive Ooze' 	
	or spell.english == 'Thermal Pulse' 	or spell.english == 'Evryone. Grudge' 	or spell.english == 'Water Bomb' 		
	or spell.english == 'Dark Orb' 			or spell.english == 'Thunderbolt' 		or spell.english == 'Tem. Upheaval' 
	or spell.english == 'Embalming Earth' 	or spell.english == 'Foul Waters' 		or spell.english == 'Rending Deluge' 
	or spell.english == 'Droning Whirlwind' or spell.english == 'Subduction' 		or spell.english == 'Polar Roar' 		
	or spell.english == 'Entomb' 			or spell.english == 'Spectral Floe' 	
	or spell.english == 'Scouring Spate' 	or spell.english == 'Searing Tempest' 	or spell.english == 'Anvil Lightning' 
	or spell.english == 'Silent Storm' 		or spell.english == 'Swipe' 			or spell.english == 'Lunge' then
		equip(sets.BlueMagic.INT)
		if buffactive['Burst Affinity'] then
			equip(sets.JA.BurstAffinity)
		end
	end	
		
	if spell.english == 'Magic Hammer' 		or spell.english == 'Retinal Glare' 	or spell.english == 'Uproot' 
	or spell.english == 'Blinding Fulgor' 	or spell.english == 'Diffusion Ray' 	or spell.english == 'Rail Cannon' then
		equip(sets.BlueMagic.LightNuke)
		if buffactive['Burst Affinity'] then
			equip(sets.JA.BurstAffinity)
		end
	end
	
	if spell.english == 'Tenebral Crush' 	or spell.english == 'Palling Salvo' 	or spell.english == 'Eyes on Me' 
	or spell.english == 'Evryone. Grudge'  or spell.english == 'Dark Orb' then
		equip(sets.BlueMagic.DarkNuke)
		if buffactive['Burst Affinity'] then
			equip(sets.JA.BurstAffinity)
		end	
	end
	
	if spell.english == 'Magic Fruit' 	or spell.english == 'Plenilune Embrace'		or spell.english == 'Wild Carrot' 
	or spell.english == 'Pollen' 		or spell.english == 'Cure IV' 				or spell.english == 'Restoral' then
		equip(sets.BlueMagic.Cures)
	end
	
	if spell.english == 'White Wind' then
		equip(sets.BlueMagic.WhiteWind)
	end
	
	if spell.english == 'Battery Charge' 	or spell.english == 'Refresh' then
		equip(sets.BlueMagic.Battery)
	end
	
	if spell.english == 'Barstone' 		or spell.english == 'Barsleep' 				or spell.english == 'Barwater' 
	or spell.english == 'Barfire'		or spell.english == 'Barfire'				or spell.english == 'Barblind'
	or spell.english == 'Barblizzard'	or spell.english == 'Barsilence'			or spell.english == 'Barthunder'
	or spell.english == 'Barvirus'		or spell.english == 'Barpetrify'			or spell.english == 'Regen'
	or spell.english == 'Regen II'		or spell.english == 'Aquaveil'				or spell.english == 'Protect II'
	or spell.english == 'Shell II'		or spell.english == 'Regeneration' then
		equip(sets.Enhancing)
	end
	
	if spell.english == 'Head Butt' 	or spell.english == 'Sudden Lunge' 			or spell.english == 'Blitzstrahl' then
		equip(sets.BlueMagic.Stun)
	end
	
	if spell.english == 'Heavy Strike' then
		equip(sets.BlueMagic.HeavyStrike)
	end
	
		
	if spell.english == 'Frightful Roar' 	or spell.english == 'Infrasonics' 			or spell.english == 'Barbed Crescent' 
	or spell.english == 'Tourbillion' 		or spell.english == 'Cimicine Discharge' 	or spell.english == 'Sub-zero smash' 
	or spell.english == 'Filamented Hold' 	or spell.english == 'Mind Blast' 			or spell.english == 'Sandspin' 
	or spell.english == 'Hecatomb Wave' 	or spell.english == 'Cold Wave' 			or spell.english == 'Terror Touch' 
	or spell.english == 'Dream Flower'		or spell.english == 'Absolute Terror' 		or spell.english == 'Temporal Shift' 
	or spell.english == 'Blank Gaze' then
		equip(sets.BlueMagic.MagicAccuracy)
	end
	
	if spell.english == 'MP Drainkiss' 		or spell.english == 'Digest' 				or spell.english == 'Blood Saber' 
	or spell.english == 'Blood Drain' 		or spell.english == 'Osmosis' 				or spell.english == 'Occultation' 
	or spell.english == 'Magic Barrier' 	or spell.english == 'Diamondhide' 			or spell.english == 'Metallic Body'
	or spell.english == 'Mighty Guard' then
		equip(sets.BlueMagic.Skill)
		if buffactive['Diffusion'] then
			equip(sets.JA.Diffusion)
		end
	end
	
	if spell.english == 'Cocoon' 			or spell.english == 'Harden Shell' 			or spell.english == 'Animating Wail' 
	or spell.english == 'Nat. Meditation' 	or spell.english == 'Carcharian Verve' 		
	or spell.english == 'O. Counterstance' 	or spell.english == 'Barrier Tusk' 			or spell.english == 'Saline Coat' then
		if buffactive['Diffusion'] then
			equip(sets.JA.Diffusion)
		end
	end

end

function aftercast(spell)
	if player.status == 'Engaged' then
		equip(sets.TP)
	else
		equip(sets.Idle)
	end
end

function status_change(new,old)
	if new == 'Engaged' then
		equip(sets.TP)
	else
		equip(sets.Idle)
	end
end

