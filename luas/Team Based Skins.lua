--[[
	Updated Version -> https://github.com/Zack2kl/Team-Based-Skins/
]]

local LocalPlayer,GetValue,SetValue,f,C,LPI,PIbyUID,exec,G,Register,R,Checkbox,Window,Button,sK,sG=entities.GetLocalPlayer,gui.GetValue,gui.SetValue,string.format,gui.Combobox,client.GetLocalPlayerIndex,client.GetPlayerIndexByUserID,client.Command,gui.Groupbox,callbacks.Register,gui.Reference,gui.Checkbox,gui.Window,gui.Button,'skin_knife','skin_gloves'

local w,h,gW,gH,tM,tR,bG,Bh,S,wW,wH,gY=200,320,1302,354,214,428,336,68,16,1334,497,382
local TO=(tR+w+S)-2
local TK=(TO+w+S)-2
local TG=(TK+w+S)-2

local function u() exec('cl_fullupdate', true) end
local sw=Checkbox(R('MISC','GENERAL','Main'),'lua_tbs_tbk_tbg_show_window','Show Team Based Skins Window',false)

local w1=Window('lua_tbs_tbk_tbg_window','Stuff Window',w,w,w,559)
local g=G(w1,'Team Based Skins',S,S)
local A1=Checkbox(g,'lua_tbs_active','Active',false)
local e=C(g,'lua_tbs_ct_t_show_window','Show Team Skins Window','-','CT Skins Window','T Skins Window')

local a=G(w1,'Team Based Knives',S,130)
local A2=Checkbox(a,'lua_tbk_active','Active',false)
local knife_ct=C(a, 'lua_ct_knife', 'CT Knife', 'Bayonet','Classic Knife','Flip Knife','Gut Knife','Karambit','M9 Bayonet','Huntsman Knife','Falchion Knife','Bowie Knife','Butterfly Knife','Shadow Daggers','Pancord Knife','Survival Knife','Ursus Knife','Navaja Knife','Nomad Knife','Stiletto Knife','Talon Knife','Skeleton Knife')
local knife_t=C(a, 'lua_t_knife', 'T Knife', 'Bayonet','Classic Knife','Flip Knife','Gut Knife','Karambit','M9 Bayonet','Huntsman Knife','Falchion Knife','Bowie Knife','Butterfly Knife','Shadow Daggers','Pancord Knife','Survival Knife','Ursus Knife','Navaja Knife','Nomad Knife','Stiletto Knife','Talon Knife','Skeleton Knife')

local b=G(w1,'Team Based Gloves',S,289)
local A3=Checkbox(b,'lua_tbg_active','Active',false)
local gloves_ct=C(b, 'lua_ct_gloves', 'CT Gloves', 'Bloodhound Gloves', 'Sport Gloves', 'Driver Gloves', 'Hand Wraps', 'Moto Gloves', 'Specialist Gloves', 'Hydra Glove')
local gloves_t=C(b, 'lua_t_gloves', 'T Gloves', 'Bloodhound Gloves', 'Sport Gloves', 'Driver Gloves', 'Hand Wraps', 'Moto Gloves', 'Specialist Gloves', 'Hydra Glove')

local ac=Button(G(w1,'',S,444,168,Bh),'Apply Changes',u)

local w2=Window('lua_tbs_ct_window','CT Skins Window',0,0,wW,wH)
local c=G(w2,'CT Skins',S,S,gW,gH)
local cp=G(c,'Pistols',0,0,w,h)
local cr=G(c,'Rifles',tM,0,w,h)
local cs=G(c,'SMGs',tR,0,w,h)
local co=G(c,'Other',TO,0,w,h)
local ck=G(c,'Knives',TK,0,w,h)
local cg=G(c,'Gloves',TG,0,w,h)

local ac=Button(G(w2,'',S,gY,gW,Bh),'Apply Changes',u)

local w3=Window('lua_tbs_t_window','T Skins Window',0,0,wW,wH)
local t=G(w3,'T Skins',S,S,gW,gH)
local tp=G(t,'Pistols',0,0,w,h)
local tr=G(t,'Rifles',tM,0,w,h)
local ts=G(t,'SMGs',tR,0,w,h)
local to=G(t,'Other',TO,0,w,h)
local tk=G(t,'Knives',TK,0,w,h)
local tg=G(t,'Gloves',TG,0,w,h)

local ac=Button(G(w3,'',S,gY,gW,Bh),'Apply Changes',u)

local ct_gun={
	deagle=C(cp,'lua_ct_deagle_skin','Desert Eagle','-','Urban DDPAT','Blaze','Night','Hypnotic','Mudder','Golden Koi','Cobalt Disruption','Crimson Web','Urban Rubble','Heirloom','Meteorite','Hand Cannon','Pilot','Conspiracy','Naga','Bronze Deco','Midnight Storm','Sunset Storm 1','Sunset Storm 2','Corinthian','Kumicho Dragon','Directive','Oxide Blaze','Code Red','Emerald Jörmungandr','Mecha Industries','Light Rail'),
	elite=C(cp,'lua_ct_elite_skin','Dual Berettas','-','Anodized Navy','Stained','Contractor','Colony','Demolition','Black Limba','Hemoglobin','Cobalt Quartz','Marina','Panther','Retribution','Briar','Urban Shock','Duelist','Moon in Libra','Emerald','Dualing Dragons','Cartel','Ventilators','Royal Consorts','Cobra Strike','Shred','Twin Turbo','Pyre','Balance','Elite 1.6'),
	fiveseven=C(cp,'lua_ct_fiveseven_skin','Five-Seven','-','Candy Apple','Case Hardened','Contractor','Forest Night','Orange Peel','Jungle','Anodized Gunmetal','Nightshade','Silver Quartz','Nitro','Kami','Copper Galaxy','Fowl Play','Hot Shot','Urban Hazard','Monkey Business','Neon Kimono','Retrobution','Triumvirate','Violet Daimyo','Scumbria','Capillary','Hyper Beast','Flame Test','Crimson Blossom','Coolant','Angry Mob','Buddy'),
	glock=C(cp,'lua_ct_glock_skin','Glock-18','-','Groundwater','Candy Apple','Fade','Night','Dragon Tattoo','Brass','Sand Dude','Steel Disruption','Blue Fissure','Death Rattle','Water Elemental','Reactor','Grinder','Catacombs','Twilight Galaxy','Bunsen Burner','Wraiths','Royal Legion','Wasteland Rebel','Weasel','Ironwork','Off World','Moonrise','Warhawk','Synth Leaf','Nuclear Garden','High Beam','Oxide Blaze','Sacrifice'),
	ak47=C(cr,'lua_ct_ak47_skin','AK-47','-','Red Laminate','Case Hardened','Safari Mesh','Jungle Spray','Predator','Black Laminate','Fire Serpent','Blue Laminate','Redline','Emerald Pinstripe','Vulcan','Jaguar','Jet Set','First Class','Wasteland Rebel','Cartel','Elite Build','Hydroponic','Aquamarine Revenge','Frontside Misty','Point Disarray','Fuel Injector','Neon Revolution','Bloodsport','Orbit Mk01','The Empress','Neon Ride','Wild Lotus','Baroque Purple','Safety Net','Asiimov','Uncharted','Rat Rod'),
	aug=C(cr,'lua_ct_aug_skin','AUG','-','Bengal Tiger','Copperhead','Hot Rod','Contractor','Colony','Wings','Storm','Condemned','Anodized Navy','Chameleon','Torque','Radiation Hazard','Daedalus','Akihabara Accept','Ricochet','Fleet Flock','Aristocrat','Syd Mead','Triqua','Stymphalian','Amber Slipstream','Midnight Lily','Navy Murano','Flame Jörmungandr','Random Access','Sweeper','Momentum','Arctic Wolf','Death by Puppy'),
	awp=C(cr,'lua_ct_awp_skin','AWP','-','Snake Camo','Lightning Strike','Safari Mesh','Pink DDPAT','BOOM','Corticera','Graphite','Electric Hive','Pit Viper','Redline','Asiimov','Dragon Lore',"Man-o'-war",'Worm God','Medusa','Sun in Leo','Hyper Beast','Elite Build','Phobos','Fever Dream','Oni Taiji','Mortis','PAW','The Prince','Gungnir','Acheron','Neo-Noir','Atheris','Containment Breach','Wildfire'),
	famas=C(cr,'lua_ct_famas_skin','Famas','-','Contrast Spray','Colony','Cyanospatter','Afterimage','Doomkitty','Spitfire','Hexane','Teardown','Pulse','Sergeant','Styx','Djinn','Neural Net','Survivor Z','Valence','Roll Cage','Mecha Industries','Macabre','Eye of Athena','Crypsis','Decommissioned'),
	g3sg1=C(cr,'lua_ct_g3sg1_skin','G3GSG1','-','Arctic Camo','Desert Storm','Contractor','Safari Mesh','Polar Camo','Jungle Dashed','Demeter','Azure Zebra','VariCamo','Green Apple','Murky','Chronos','Orange Kimono','Flux','The Executioner','Orange Crash','Ventilator','Stinger','Hunter','High Seas','Violet Murano','Scavenger','Black Sand'),
	galilar=C(cr,'lua_ct_galilar_skin','Galil AR','-','Winter Forest','Orange DDPAT','Tornado','Sage Spray','Shattered','Blue Titanium','VariCamo','Urban Rubble','Hunting Blind','Sandstorm','Tuxedo','Kami','Cerberus','Chatterbox','Eco','Aqua Terrace','Rocket Pop','Stone Cold','Firefight','Black Sand','Crimson Tsunami','Sugar Rush','Cold Fusion','Signal','Akoben'),
	m249=C(co,'lua_ct_m249_skin','M249','-','Contrast Spray','Blizzard Marbleized','Jungle','Jungle DDPAT','Gator Mesh','Magma','System Lock','Shipping Forecast','Impact Drill','Nebula Crusader','Spectre','Emerald Poison Dart','Warbird','Aztec'),
	m4a1=C(cr,'lua_ct_m4a1_skin','M4A4','-','Desert Storm','Jungle Tiger','Urban DDPAT','Tornado','Bullet Rain','Modern Hunter','Radiation Hazard','Faded Zebra','Zirka','X-Ray','Asiimov','Howl','Desert-Strike','Griffin','(Dragon King)','Poseidon','Daybreak','Evil Daimyo','Royal Paladin','The Battlestar','Desolate Space','Buzz Kill','Hellfire','Neo-Noir','Dark Blossom','Mainframe','Converter','Magnesium','The Emperor'),
	mac10=C(cs,'lua_ct_mac10_skin','MAC-10','-','Candy Apple','Urban DDPAT','Silver','Fade','Ultraviolet','Tornado','Palm','Graven','Amber Fade','Heat','Curse','Indigo','Tatter','Commuter','Nuclear Garden','Malachite','Neon Rider','Rangeen','Lapis Gator','Carnivore','Last Dive','Aloha','Oceanic','Red Filigree','Calf Skin','Copper Borre','Pipe Down','Whitefish','Surfwood','Stalker','Classic Crate'),
	p90=C(cs,'lua_ct_p90_skin','P90','-','Virus','Cold Blooded','Storm','Glacier Mesh','Sand Spray','Death by Kitty','Fallout Warning','Scorched','Emerald Dragon','Blind Spot','Ash Wood','Teardown','Trigon','Desert Warfare','Module','Leather','Asiimov','Elite Build','Shapewood','Chopper','Grim','Shallow Grave','Death Grip','Traction','Sunset Lily','Baroque Red','Astral Jörmungandr','Facility Negative','Off World','Nostalgia'),
	mp5sd=C(cs,'lua_ct_mp5sd_skin','MP5-SD','-','Dirt Drop','Co-Processor','Lab Rate','Phosphor','Gauss','Bamboo Garden','Acid Wash','Agent'),
	ump45=C(cs,'lua_ct_ump45_skin','UMP-45','-','Gunsmoke','Urban DDPAT','Blaze','Carbon Fiber','Mudder','Caramel','Fallout Warning','Scorched','Bone Pile','Corporal','Indigo','Labyrinth','Delusion','Grand Prix',"Minotaur's Labyrinth",'Riot','Primal Saber','Briefing','Scaffold','Metal Flowers','Exposure','Arctic Wolf','Day Lily','Facility Dark','Momentum','Moonrise','Plastique'),
	xm1014=C(co,'lua_ct_xm1014_skin','XM1014','-','Blue Steel','Grassland','Blue Spruce','Urban Perforated','Blaze Orange','Fallout Warning','Jungle','VariCamo Blue','CaliCamo','Heaven Guard','Red Python','Red Leather','Bone Machine','Tranquility','Quicksilver','Scumbria','Teclu Burner','Black Tie','Slipstream','Seasons','Ziggy','Oxide Blaze','Banana Leaf','Frost Borre','Incinegator'),
	bizon=C(cs,'lua_ct_bizon_skin','PP-Bizon','-','Candy Apple','Blue Streak','Forest Leaves','Carbon Fiber','Sand Dashed','Urban Dashed','Brass','Modern Hunter','Irradiated Alert','Rust Coat','Water Sigil','Night Ops','Cobalt Halftone','Antique','Osiris','Chemical Green','Bamboo Print','Fuel Rod','Photic Zone','Judgement of Anubis','Harvester','Jungle Slipstream','High Roller','Night Riot','Facility Sketch','Seabird','Embargo'),
	mag7=C(co,'lua_ct_mag7_skin','Mag-7','-','Silver','Metallic DDPAT','Bulldozer','Sand Dune','Storm','Irradiated Alert','Memento','Hazard','Heaven Guard','Chainmail','Firestarter','Heat','Counter Terrace','Seabird','Cobalt Core','Praetorian','Petroglyph','Sonar','Hard Water','SWAG-7','Cinquedea','Rust Coat','Core Breach','Popdog'),
	negev=C(co,'lua_ct_negev_skin','Negev','-','Anodized Navy','Palm','CaliCamo','Terrain','Army Sheen','Bratatat','Desert-Strike','Nuclear Waste',"Man-o'-war",'Loudmouth','Power Loader','Dazzle','Lionfish','Mjölnir','Bulkhead','Boroque Sand'),
	sawedoff=C(co,'lua_ct_sawedoff_skin','Sawed-Off','-','Forest DDPAT','Snake Camo','Copper','Orange DDPAT','Sage Spray','Irradiated Alert','Mosaico','Amber Fade','Full Stop','The Kraken','Rust Coat','First Class','Highwayman','Serenity','Origami','Bamboo Shadow','Yorick','Fubar','Limelight','Wasteland Princess','Zander','Morris','Devourer','Brake Light','Black Sand','Jungle Thicket'),
	tec9=C(cp,'lua_ct_tec9_skin','Tec-9','-','Groundwater','Urban DDPAT','Ossified','Brass','Nuclear Threat','Tornado','Blue Titanium','VariCamo','Army Mesh','Red Quartz','Titanium Bit','Sandstorm','Isaac','Toxic','Hades','Bamboo Forest','Terrace','Avalanche','Jambiya','Re-Entry','Ice Cap','Fuel Injector','Cut Out','Cracked Opal','Snek-9','Rust Leaf','Orange Murano','Remote Control','Fubar','Bamboozle','Decimator','Flash Out'),
	hkp2000=C(cp,'lua_ct_hkp2000_skin','P2000','-','Granite Marbleized','Silver','Scorpion','Grassland','Grassland Leaves','Corticera','Ocean Foam','Amber Fade','Red FragCam','Chainmail','Pulse','Coach Class','Ivory','Fire Elemental','Pathfinder','Handgun','Imperial','Oceanic','Imperial Dragon','Turf','Woodsman','Urban Hazard','Obsidian'),
	mp7=C(cs,'lua_ct_mp7_skin','MP7','-','Forest DDPAT','Skulls','Gunsmoke','Anodized Navy','Whiteout','Orange Peel','Scorched','Groundwater','Ocean Foam','Army Recon','Full Stop','Urban Hazard','Olive Plaid','Armor Core','Asteroin','Nemesis','Special Delivery','Impire','Cirrus','Akoben','Bloodsport','Powercore','Teal Blossom','Fade','Motherboard','Mischief','Neon Ply'),
	mp9=C(cs,'lua_ct_mp9_skin','MP9','-','Hot Rod','Bulldozer','Hypnotic','Storm','Orange Peel','Sand Dashed','Dry Season','Rose Iron','Dark Age','Green Plaid','Setting Sun','Dart','Deadly Poison',"Pandora's Box",'Ruby Poison Dart','Bioleak','Airlock','Sand Scale','Goo','Black Sand','Capillary','Wild Lily','Slide','Modest Threat','Stained Glass','Hydra'),
	nova=C(co,'lua_ct_nova_skin','Nova','-','Candy Apple','Forest Leaves','Bloomstick','Sand Dune','Polar Mesh','Walnut','Modern Hunter','Blaze Orange','Predator','Tempest','Graphite','Ghost Camo','Rising Skull','Antique','Green Apple','Caged Steel','Koi','Moon in Libra','Ranger','Hyper Beast','Exo','Gila','Wild Six','Toy Soldier','Baroque Orange','Mandrel','Wood Fired','Plume'),
	p250=C(cp,'lua_ct_p250_skin','P250','-','Gunsmoke','Bone Mask','Metallic DDPAT','Boreal Forest','Sand Dune','Whiteout','X-Ray','Splash','Modern Hunter','Nuclear Threat','Facets','Hive','Steal Disruption','Mehndi','Undertow','Franklin','Supernova','Contamination','Cartel','Muertos','Valence','Crimson Kimono','Mint Kimono','Wingshot','Asiimov','Iron Clad','Ripple','Red Rock','See Ya Later','Dark Filigree','Vino Primo','Facility Draft','Exchanger','Nevermore','Verdigris','Inferno'),
	scar20=C(cr,'lua_ct_scar20_skin','SCAR-20','-','Contractor','Carbon Fiber','Storm','Sand Mesh','Palm','Brass','Splash Jam','Emerald','Crimson Web','Army Sheen','Cyrex','Cardiac','Grotto','Green Marine','Outbreak','Bloodsport','Powercore','Blueprint','Jungle Slipstream','Stone Mosaico','Torn','Assault'),
	sg556=C(cr,'lua_ct_sg556_skin','SG556','-','Anodized Navy','Bulldozer','Ultraviolet','Tornado','Waves Perforated','Wave Spray','Gator Mesh','Damascus Steel','Pulse','Army Sheen','Traveler','Fallout Warning','Cyrex','Tiger Moth','Atlas','Aerial','Triarch','Phantom','Aloha','Integrale','Danger Close','Barricade','Candy Apple','Colony IV'),
	ssg08=C(cr,'lua_ct_ssg08_skin','SSG 08','-','Lichen Dashed','Dark Water','Blue Spruce','Sand Dune','Mayan Dreams','Blood in the Water','Tropical Storm','Acid Fade','Slashed','Detour','Abyss','Big Iron','Necropos','Ghost Crusader','Dragonfire',"Death's Head",'Orange Filigree','Hand Brake','Red Stone','Sea Calico','Bloodshot'),
	m4a1_silencer=C(cr,'lua_ct_m4a1_silencer_skin','M4A1-S','-','Dark Water','Boreal Forest','Bright Water','Blood Tiger','VariCamo','Nitro','Guardian','Atomic Alloy','Master Piece','Knight','Cyrex','Basilisk','Hyper Beast','Icarus Fell','Hot Rod','Golden Coil',"Chantico's Fire",'Mecha Industries','Flashback','Decimator','Briefing','Leaded Glass','Nightmare','Control Panel','Moss Quartz'),
	usp_silencer=C(cp,'lua_ct_usp_silencer_skin','USP-S','-','Forest Leaves','Dark Water','Overgrowth','Blood Tiger','Serum','Night Ops','Stainless','Guardian','Orion','Road Rash','Royal Blue','Caiman','Business Class','Pathfinder','Para Green','Torque','Kill Confirmed','Lead Conduit','Cyrex','Neo-Noir','Blueprint','Cortex','Check Engine','Flashback'),
	cz75a=C(cp,'lua_ct_cz75a_skin','CZ75-Auto','-','Crimson Web','Hexane','Tread Plate','The Fuschia is Now','Victoria','Tuxedo','Army Sheen','Poison Dart','Nitro','Chalice','Twist','Tigris','Green Plaid','Pole Position','Emerald','Yellow Jacket','Red Astor','Imprint','Polymer','Xiangliu','Tacticat','Eco','Emerald Quartz'),
	revolver=C(cp,'lua_ct_revolver_skin','R8 Revolver','-','Crimson Web','Bone Mask','Fade','Amber Fade','Reboot','Llama Cannon','Grip','Survivalist','Nitro','Skull Crusher','Canal Spray','Memento'),

	bayonet=C(ck,'lua_ct_bayonet_skin','Bayonet','-','Forest DDPAT','Crimson Web','Fade','Night','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Damascus Steel','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7','Lore','Black Laminate','Gamma Doppler 1','Gamma Doppler 2','Gamma Doppler 3','Gamma Doppler 4','Gamma Doppler 5','Autotronic','Bright Water','Freehand'),
	knife_css=C(ck,'lua_ct_knife_css_skin','Classic Knife','-','Forest DDPAT','Crimson Web','Fade','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Urban Masked','Scorched','Night Stripe'),
	knife_flip=C(ck,'lua_ct_knife_flip_skin','Flip Knife','-','Forest DDPAT','Crimson Web','Fade','Night','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Damascus Steel','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7','Lore','Black Laminate','Gamma Doppler 1','Gamma Doppler 2','Gamma Doppler 3','Gamma Doppler 4','Gamma Doppler 5','Autotronic','Bright Water','Freehand'),
	knife_gut=C(ck,'lua_ct_knife_gut_skin','Gut Knife','-','Forest DDPAT','Crimson Web','Fade','Night','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Damascus Steel','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7','Lore','Black Laminate','Gamma Doppler 1','Gamma Doppler 2','Gamma Doppler 3','Gamma Doppler 4','Gamma Doppler 5','Autotronic','Bright Water','Freehand'),
	knife_karambit=C(ck,'lua_ct_knife_karambit_skin','Karambit','-','Forest DDPAT','Crimson Web','Fade','Night','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Damascus Steel','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7','Lore','Black Laminate','Gamma Doppler 1','Gamma Doppler 2','Gamma Doppler 3','Gamma Doppler 4','Gamma Doppler 5','Autotronic','Bright Water','Freehand'),
	knife_m9_bayonet=C(ck,'lua_ct_knife_m9_bayonet_skin','M9 Bayonet','-','Forest DDPAT','Crimson Web','Fade','Night','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Damascus Steel','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7','Lore','Black Laminate','Gamma Doppler 1','Gamma Doppler 2','Gamma Doppler 3','Gamma Doppler 4','Gamma Doppler 5','Autotronic','Bright Water','Freehand'),
	knife_tactical=C(ck,'lua_ct_knife_tactical_skin','Huntsman Knife','-','Forest DDPAT','Crimson Web','Fade','Night','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Urban Masked','Scorched','Tiger Tooth','Damascus Steel','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7','Ultraviolet'),
	knife_falchion=C(ck,'lua_ct_knife_falchion_skin','Falchion Knife','-','Forest DDPAT','Crimson Web','Fade','Night','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Urban Masked','Scorched','Tiger Tooth','Damascus Steel','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7','Ultraviolet'),
	knife_survival_bowie=C(ck,'lua_ct_knife_survival_bowie_skin','Bowie Knife','-','Forest DDPAT','Crimson Web','Fade','Night','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Damascus Steel','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7'),
	knife_butterfly=C(ck,'lua_ct_knife_butterfly_skin','Butterfly Knife','-','Forest DDPAT','Crimson Web','Fade','Night','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Damascus Steel','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7'),
	knife_push=C(ck,'lua_ct_knife_push_skin','Shadow Daggers','-','Forest DDPAT','Crimson Web','Fade','Night','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Damascus Steel','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7'),
	knife_cord=C(ck,'lua_ct_knife_cord_skin','Paracord Knife','-','Forest DDPAT','Crimson Web','Fade','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Urban Masked','Scorched','Night Stripe'),
	knife_canis=C(ck,'lua_ct_knife_canis_skin','Survival Knife','-','Forest DDPAT','Crimson Web','Fade','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Urban Masked','Scorched','Night Stripe'),
	knife_ursus=C(ck,'lua_ct_knife_ursus_skin','Ursus Knife','-','Forest DDPAT','Crimson Web','Fade','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7','Night Stripe','Damascus Steel'),
	knife_gypsy_jackknife=C(ck,'lua_ct_knife_gypsy_jackknife_skin','Navaja Knife','-','Forest DDPAT','Crimson Web','Fade','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7','Night Stripe','Damascus Steel'),
	knife_outdoor=C(ck,'lua_ct_knife_outdoor_skin','Nomad Knife','-','Forest DDPAT','Crimson Web','Fade','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7','Night Stripe','Damascus Steel'),
	knife_stiletto=C(ck,'lua_ct_knife_stiletto_skin','Stiletto Knife','-','Forest DDPAT','Crimson Web','Fade','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7','Night Stripe','Damascus Steel'),
	knife_widowmaker=C(ck,'lua_ct_knife_widowmaker_skin','Talon Knife','-','Forest DDPAT','Crimson Web','Fade','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Night Stripe','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Marble Fade','Damascus Steel'),
	knife_skeleton=C(ck,'lua_ct_knife_skeleton_skin','Skeleton Knife','-','Forest DDPAT','Crimson Web','Fade','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7','Night Stripe','Damascus Steel'),

	studded_bloodhound_gloves=C(cg,'lua_ct_studded_bloodhound_gloves_skin','Bloodhound Gloves','-','Charred','Snakebite','Bronzed','Guerrilla'),
	sporty_gloves=C(cg,'lua_ct_sporty_gloves_skin','Sport Gloves','-','Superconductor','Arid',"Pandora's Box",'Hedge Maze','Amphibious','Bronze Morph','Omega','Vice'),
	slick_gloves=C(cg,'lua_ct_slick_gloves_skin','Driver Gloves','-','Lunar Weave','Convoy','Crimson Weave','Diamondback','King Snake','Imperial Plaid','Overtake','Racing Green'),
	leather_handwraps=C(cg,'lua_ct_leather_handwraps_skin','Hand Wraps','-','Leather','Spruce DDPAT','Slaughter','Badlands','Cobalt Skulls','Overprint','Duct Tape','Arboreal'),
	motorcycle_gloves=C(cg,'lua_ct_motorcycle_gloves_skin','Moto Gloves','-','Eclipse','Spearmint','Boom!','Cool Mint','POW!','Turtle','Transport','Polygon'),
	specialist_gloves=C(cg,'lua_ct_specialist_gloves_skin','Specialist Gloves','-','Forest DDPAT','Crimson Kimono','Emerald Web','Foundation','Crimson Web','Buckshot','Fade','Mogul'),
	studded_hydra_gloves=C(cg,'lua_ct_studded_hydra_gloves_skin','Hydra Gloves','-','Emerald','Mangrove','Rattler','Case Hardened')
}

local t_gun={
	deagle=C(tp,'lua_t_deagle_skin','Desert Eagle','-','Urban DDPAT','Blaze','Night','Hypnotic','Mudder','Golden Koi','Cobalt Disruption','Crimson Web','Urban Rubble','Heirloom','Meteorite','Hand Cannon','Pilot','Conspiracy','Naga','Bronze Deco','Midnight Storm','Sunset Storm 1','Sunset Storm 2','Corinthian','Kumicho Dragon','Directive','Oxide Blaze','Code Red','Emerald Jörmungandr','Mecha Industries','Light Rail'),
	elite=C(tp,'lua_t_elite_skin','Dual Berettas','-','Anodized Navy','Stained','Contractor','Colony','Demolition','Black Limba','Hemoglobin','Cobalt Quartz','Marina','Panther','Retribution','Briar','Urban Shock','Duelist','Moon in Libra','Emerald','Dualing Dragons','Cartel','Ventilators','Royal Consorts','Cobra Strike','Shred','Twin Turbo','Pyre','Balance','Elite 1.6'),
	fiveseven=C(tp,'lua_t_fiveseven_skin','Five-Seven','-','Candy Apple','Case Hardened','Contractor','Forest Night','Orange Peel','Jungle','Anodized Gunmetal','Nightshade','Silver Quartz','Nitro','Kami','Copper Galaxy','Fowl Play','Hot Shot','Urban Hazard','Monkey Business','Neon Kimono','Retrobution','Triumvirate','Violet Daimyo','Scumbria','Capillary','Hyper Beast','Flame Test','Crimson Blossom','Coolant','Angry Mob','Buddy'),
	glock=C(tp,'lua_t_glock_skin','Glock-18','-','Groundwater','Candy Apple','Fade','Night','Dragon Tattoo','Brass','Sand Dude','Steel Disruption','Blue Fissure','Death Rattle','Water Elemental','Reactor','Grinder','Catacombs','Twilight Galaxy','Bunsen Burner','Wraiths','Royal Legion','Wasteland Rebel','Weasel','Ironwork','Off World','Moonrise','Warhawk','Synth Leaf','Nuclear Garden','High Beam','Oxide Blaze','Sacrifice'),
	ak47=C(tr,'lua_t_ak47_skin','AK-47','-','Red Laminate','Case Hardened','Safari Mesh','Jungle Spray','Predator','Black Laminate','Fire Serpent','Blue Laminate','Redline','Emerald Pinstripe','Vulcan','Jaguar','Jet Set','First Class','Wasteland Rebel','Cartel','Elite Build','Hydroponic','Aquamarine Revenge','Frontside Misty','Point Disarray','Fuel Injector','Neon Revolution','Bloodsport','Orbit Mk01','The Empress','Neon Ride','Wild Lotus','Baroque Purple','Safety Net','Asiimov','Uncharted','Rat Rod'),
	aug=C(tr,'lua_t_aug_skin','AUG','-','Bengal Tiger','Copperhead','Hot Rod','Contractor','Colony','Wings','Storm','Condemned','Anodized Navy','Chameleon','Torque','Radiation Hazard','Daedalus','Akihabara Accept','Ricochet','Fleet Flock','Aristocrat','Syd Mead','Triqua','Stymphalian','Amber Slipstream','Midnight Lily','Navy Murano','Flame Jörmungandr','Random Access','Sweeper','Momentum','Arctic Wolf','Death by Puppy'),
	awp=C(tr,'lua_t_awp_skin','AWP','-','Snake Camo','Lightning Strike','Safari Mesh','Pink DDPAT','BOOM','Corticera','Graphite','Electric Hive','Pit Viper','Redline','Asiimov','Dragon Lore',"Man-o'-war",'Worm God','Medusa','Sun in Leo','Hyper Beast','Elite Build','Phobos','Fever Dream','Oni Taiji','Mortis','PAW','The Prince','Gungnir','Acheron','Neo-Noir','Atheris','Containment Breach','Wildfire'),
	famas=C(tr,'lua_t_famas_skin','Famas','-','Contrast Spray','Colony','Cyanospatter','Afterimage','Doomkitty','Spitfire','Hexane','Teardown','Pulse','Sergeant','Styx','Djinn','Neural Net','Survivor Z','Valence','Roll Cage','Mecha Industries','Macabre','Eye of Athena','Crypsis','Decommissioned'),
	g3sg1=C(tr,'lua_t_g3sg1_skin','G3GSG1','-','Arctic Camo','Desert Storm','Contractor','Safari Mesh','Polar Camo','Jungle Dashed','Demeter','Azure Zebra','VariCamo','Green Apple','Murky','Chronos','Orange Kimono','Flux','The Executioner','Orange Crash','Ventilator','Stinger','Hunter','High Seas','Violet Murano','Scavenger','Black Sand'),
	galilar=C(tr,'lua_t_galilar_skin','Galil AR','-','Winter Forest','Orange DDPAT','Tornado','Sage Spray','Shattered','Blue Titanium','VariCamo','Urban Rubble','Hunting Blind','Sandstorm','Tuxedo','Kami','Cerberus','Chatterbox','Eco','Aqua Terrace','Rocket Pop','Stone Cold','Firefight','Black Sand','Crimson Tsunami','Sugar Rush','Cold Fusion','Signal','Akoben'),
	m249=C(to,'lua_t_m249_skin','M249','-','Contrast Spray','Blizzard Marbleized','Jungle','Jungle DDPAT','Gator Mesh','Magma','System Lock','Shipping Forecast','Impact Drill','Nebula Crusader','Spectre','Emerald Poison Dart','Warbird','Aztec'),
	m4a1=C(tr,'lua_t_m4a1_skin','M4A4','-','Desert Storm','Jungle Tiger','Urban DDPAT','Tornado','Bullet Rain','Modern Hunter','Radiation Hazard','Faded Zebra','Zirka','X-Ray','Asiimov','Howl','Desert-Strike','Griffin','(Dragon King)','Poseidon','Daybreak','Evil Daimyo','Royal Paladin','The Battlestar','Desolate Space','Buzz Kill','Hellfire','Neo-Noir','Dark Blossom','Mainframe','Converter','Magnesium','The Emperor'),
	mac10=C(ts,'lua_t_mac10_skin','MAC-10','-','Candy Apple','Urban DDPAT','Silver','Fade','Ultraviolet','Tornado','Palm','Graven','Amber Fade','Heat','Curse','Indigo','Tatter','Commuter','Nuclear Garden','Malachite','Neon Rider','Rangeen','Lapis Gator','Carnivore','Last Dive','Aloha','Oceanic','Red Filigree','Calf Skin','Copper Borre','Pipe Down','Whitefish','Surfwood','Stalker','Classic Crate'),
	p90=C(ts,'lua_t_p90_skin','P90','-','Virus','Cold Blooded','Storm','Glacier Mesh','Sand Spray','Death by Kitty','Fallout Warning','Scorched','Emerald Dragon','Blind Spot','Ash Wood','Teardown','Trigon','Desert Warfare','Module','Leather','Asiimov','Elite Build','Shapewood','Chopper','Grim','Shallow Grave','Death Grip','Traction','Sunset Lily','Baroque Red','Astral Jörmungandr','Facility Negative','Off World','Nostalgia'),
	mp5sd=C(ts,'lua_t_mp5sd_skin','MP5-SD','-','Dirt Drop','Co-Processor','Lab Rate','Phosphor','Gauss','Bamboo Garden','Acid Wash','Agent'),
	ump45=C(ts,'lua_t_ump45_skin','UMP-45','-','Gunsmoke','Urban DDPAT','Blaze','Carbon Fiber','Mudder','Caramel','Fallout Warning','Scorched','Bone Pile','Corporal','Indigo','Labyrinth','Delusion','Grand Prix',"Minotaur's Labyrinth",'Riot','Primal Saber','Briefing','Scaffold','Metal Flowers','Exposure','Arctic Wolf','Day Lily','Facility Dark','Momentum','Moonrise','Plastique'),
	xm1014=C(to,'lua_t_xm1014_skin','XM1014','-','Blue Steel','Grassland','Blue Spruce','Urban Perforated','Blaze Orange','Fallout Warning','Jungle','VariCamo Blue','CaliCamo','Heaven Guard','Red Python','Red Leather','Bone Machine','Tranquility','Quicksilver','Scumbria','Teclu Burner','Black Tie','Slipstream','Seasons','Ziggy','Oxide Blaze','Banana Leaf','Frost Borre','Incinegator'),
	bizon=C(ts,'lua_t_bizon_skin','PP-Bizon','-','Candy Apple','Blue Streak','Forest Leaves','Carbon Fiber','Sand Dashed','Urban Dashed','Brass','Modern Hunter','Irradiated Alert','Rust Coat','Water Sigil','Night Ops','Cobalt Halftone','Antique','Osiris','Chemical Green','Bamboo Print','Fuel Rod','Photic Zone','Judgement of Anubis','Harvester','Jungle Slipstream','High Roller','Night Riot','Facility Sketch','Seabird','Embargo'),
	mag7=C(to,'lua_t_mag7_skin','Mag-7','-','Silver','Metallic DDPAT','Bulldozer','Sand Dune','Storm','Irradiated Alert','Memento','Hazard','Heaven Guard','Chainmail','Firestarter','Heat','Counter Terrace','Seabird','Cobalt Core','Praetorian','Petroglyph','Sonar','Hard Water','SWAG-7','Cinquedea','Rust Coat','Core Breach','Popdog'),
	negev=C(to,'lua_t_negev_skin','Negev','-','Anodized Navy','Palm','CaliCamo','Terrain','Army Sheen','Bratatat','Desert-Strike','Nuclear Waste',"Man-o'-war",'Loudmouth','Power Loader','Dazzle','Lionfish','Mjölnir','Bulkhead','Boroque Sand'),
	sawedoff=C(to,'lua_t_sawedoff_skin','Sawed-Off','-','Forest DDPAT','Snake Camo','Copper','Orange DDPAT','Sage Spray','Irradiated Alert','Mosaico','Amber Fade','Full Stop','The Kraken','Rust Coat','First Class','Highwayman','Serenity','Origami','Bamboo Shadow','Yorick','Fubar','Limelight','Wasteland Princess','Zander','Morris','Devourer','Brake Light','Black Sand','Jungle Thicket'),
	tec9=C(tp,'lua_t_tec9_skin','Tec-9','-','Groundwater','Urban DDPAT','Ossified','Brass','Nuclear Threat','Tornado','Blue Titanium','VariCamo','Army Mesh','Red Quartz','Titanium Bit','Sandstorm','Isaac','Toxic','Hades','Bamboo Forest','Terrace','Avalanche','Jambiya','Re-Entry','Ice Cap','Fuel Injector','Cut Out','Cracked Opal','Snek-9','Rust Leaf','Orange Murano','Remote Control','Fubar','Bamboozle','Decimator','Flash Out'),
	hkp2000=C(tp,'lua_t_hkp2000_skin','P2000','-','Granite Marbleized','Silver','Scorpion','Grassland','Grassland Leaves','Corticera','Ocean Foam','Amber Fade','Red FragCam','Chainmail','Pulse','Coach Class','Ivory','Fire Elemental','Pathfinder','Handgun','Imperial','Oceanic','Imperial Dragon','Turf','Woodsman','Urban Hazard','Obsidian'),
	mp7=C(ts,'lua_t_mp7_skin','MP7','-','Forest DDPAT','Skulls','Gunsmoke','Anodized Navy','Whiteout','Orange Peel','Scorched','Groundwater','Ocean Foam','Army Recon','Full Stop','Urban Hazard','Olive Plaid','Armor Core','Asteroin','Nemesis','Special Delivery','Impire','Cirrus','Akoben','Bloodsport','Powercore','Teal Blossom','Fade','Motherboard','Mischief','Neon Ply'),
	mp9=C(ts,'lua_t_mp9_skin','MP9','-','Hot Rod','Bulldozer','Hypnotic','Storm','Orange Peel','Sand Dashed','Dry Season','Rose Iron','Dark Age','Green Plaid','Setting Sun','Dart','Deadly Poison',"Pandora's Box",'Ruby Poison Dart','Bioleak','Airlock','Sand Scale','Goo','Black Sand','Capillary','Wild Lily','Slide','Modest Threat','Stained Glass','Hydra'),
	nova=C(to,'lua_t_nova_skin','Nova','-','Candy Apple','Forest Leaves','Bloomstick','Sand Dune','Polar Mesh','Walnut','Modern Hunter','Blaze Orange','Predator','Tempest','Graphite','Ghost Camo','Rising Skull','Antique','Green Apple','Caged Steel','Koi','Moon in Libra','Ranger','Hyper Beast','Exo','Gila','Wild Six','Toy Soldier','Baroque Orange','Mandrel','Wood Fired','Plume'),
	p250=C(tp,'lua_t_p250_skin','P250','-','Gunsmoke','Bone Mask','Metallic DDPAT','Boreal Forest','Sand Dune','Whiteout','X-Ray','Splash','Modern Hunter','Nuclear Threat','Facets','Hive','Steal Disruption','Mehndi','Undertow','Franklin','Supernova','Contamination','Cartel','Muertos','Valence','Crimson Kimono','Mint Kimono','Wingshot','Asiimov','Iron Clad','Ripple','Red Rock','See Ya Later','Dark Filigree','Vino Primo','Facility Draft','Exchanger','Nevermore','Verdigris','Inferno'),
	scar20=C(tr,'lua_t_scar20_skin','SCAR-20','-','Contractor','Carbon Fiber','Storm','Sand Mesh','Palm','Brass','Splash Jam','Emerald','Crimson Web','Army Sheen','Cyrex','Cardiac','Grotto','Green Marine','Outbreak','Bloodsport','Powercore','Blueprint','Jungle Slipstream','Stone Mosaico','Torn','Assault'),
	sg556=C(tr,'lua_t_sg556_skin','SG556','-','Anodized Navy','Bulldozer','Ultraviolet','Tornado','Waves Perforated','Wave Spray','Gator Mesh','Damascus Steel','Pulse','Army Sheen','Traveler','Fallout Warning','Cyrex','Tiger Moth','Atlas','Aerial','Triarch','Phantom','Aloha','Integrale','Danger Close','Barricade','Candy Apple','Colony IV'),
	ssg08=C(tr,'lua_t_ssg08_skin','SSG 08','-','Lichen Dashed','Dark Water','Blue Spruce','Sand Dune','Mayan Dreams','Blood in the Water','Tropical Storm','Acid Fade','Slashed','Detour','Abyss','Big Iron','Necropos','Ghost Crusader','Dragonfire',"Death's Head",'Orange Filigree','Hand Brake','Red Stone','Sea Calico','Bloodshot'),
	m4a1_silencer=C(tr,'lua_t_m4a1_silencer_skin','M4A1-S','-','Dark Water','Boreal Forest','Bright Water','Blood Tiger','VariCamo','Nitro','Guardian','Atomic Alloy','Master Piece','Knight','Cyrex','Basilisk','Hyper Beast','Icarus Fell','Hot Rod','Golden Coil',"Chantico's Fire",'Mecha Industries','Flashback','Decimator','Briefing','Leaded Glass','Nightmare','Control Panel','Moss Quartz'),
	usp_silencer=C(tp,'lua_t_usp_silencer_skin','USP-S','-','Forest Leaves','Dark Water','Overgrowth','Blood Tiger','Serum','Night Ops','Stainless','Guardian','Orion','Road Rash','Royal Blue','Caiman','Business Class','Pathfinder','Para Green','Torque','Kill Confirmed','Lead Conduit','Cyrex','Neo-Noir','Blueprint','Cortex','Check Engine','Flashback'),
	cz75a=C(tp,'lua_t_cz75a_skin','CZ75-Auto','-','Crimson Web','Hexane','Tread Plate','The Fuschia is Now','Victoria','Tuxedo','Army Sheen','Poison Dart','Nitro','Chalice','Twist','Tigris','Green Plaid','Pole Position','Emerald','Yellow Jacket','Red Astor','Imprint','Polymer','Xiangliu','Tacticat','Eco','Emerald Quartz'),
	revolver=C(tp,'lua_t_revolver_skin','R8 Revolver','-','Crimson Web','Bone Mask','Fade','Amber Fade','Reboot','Llama Cannon','Grip','Survivalist','Nitro','Skull Crusher','Canal Spray','Memento'),

	bayonet=C(tk,'lua_t_bayonet_skin','Bayonet','-','Forest DDPAT','Crimson Web','Fade','Night','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Damascus Steel','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7','Lore','Black Laminate','Gamma Doppler 1','Gamma Doppler 2','Gamma Doppler 3','Gamma Doppler 4','Gamma Doppler 5','Autotronic','Bright Water','Freehand'),
	knife_css=C(tk,'lua_t_knife_css_skin','Classic Knife','-','Forest DDPAT','Crimson Web','Fade','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Urban Masked','Scorched','Night Stripe'),
	knife_flip=C(tk,'lua_t_knife_flip_skin','Flip Knife','-','Forest DDPAT','Crimson Web','Fade','Night','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Damascus Steel','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7','Lore','Black Laminate','Gamma Doppler 1','Gamma Doppler 2','Gamma Doppler 3','Gamma Doppler 4','Gamma Doppler 5','Autotronic','Bright Water','Freehand'),
	knife_gut=C(tk,'lua_t_knife_gut_skin','Gut Knife','-','Forest DDPAT','Crimson Web','Fade','Night','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Damascus Steel','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7','Lore','Black Laminate','Gamma Doppler 1','Gamma Doppler 2','Gamma Doppler 3','Gamma Doppler 4','Gamma Doppler 5','Autotronic','Bright Water','Freehand'),
	knife_karambit=C(tk,'lua_t_knife_karambit_skin','Karambit','-','Forest DDPAT','Crimson Web','Fade','Night','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Damascus Steel','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7','Lore','Black Laminate','Gamma Doppler 1','Gamma Doppler 2','Gamma Doppler 3','Gamma Doppler 4','Gamma Doppler 5','Autotronic','Bright Water','Freehand'),
	knife_m9_bayonet=C(tk,'lua_t_knife_m9_bayonet_skin','M9 Bayonet','-','Forest DDPAT','Crimson Web','Fade','Night','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Damascus Steel','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7','Lore','Black Laminate','Gamma Doppler 1','Gamma Doppler 2','Gamma Doppler 3','Gamma Doppler 4','Gamma Doppler 5','Autotronic','Bright Water','Freehand'),
	knife_tactical=C(tk,'lua_t_knife_tactical_skin','Huntsman Knife','-','Forest DDPAT','Crimson Web','Fade','Night','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Urban Masked','Scorched','Tiger Tooth','Damascus Steel','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7','Ultraviolet'),
	knife_falchion=C(tk,'lua_t_knife_falchion_skin','Falchion Knife','-','Forest DDPAT','Crimson Web','Fade','Night','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Urban Masked','Scorched','Tiger Tooth','Damascus Steel','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7','Ultraviolet'),
	knife_survival_bowie=C(tk,'lua_t_knife_survival_bowie_skin','Bowie Knife','-','Forest DDPAT','Crimson Web','Fade','Night','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Damascus Steel','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7'),
	knife_butterfly=C(tk,'lua_t_knife_butterfly_skin','Butterfly Knife','-','Forest DDPAT','Crimson Web','Fade','Night','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Damascus Steel','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7'),
	knife_push=C(tk,'lua_t_knife_push_skin','Shadow Daggers','-','Forest DDPAT','Crimson Web','Fade','Night','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Damascus Steel','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7'),
	knife_cord=C(tk,'lua_t_knife_cord_skin','Paracord Knife','-','Forest DDPAT','Crimson Web','Fade','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Urban Masked','Scorched','Night Stripe'),
	knife_canis=C(tk,'lua_t_knife_canis_skin','Survival Knife','-','Forest DDPAT','Crimson Web','Fade','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Urban Masked','Scorched','Night Stripe'),
	knife_ursus=C(tk,'lua_t_knife_ursus_skin','Ursus Knife','-','Forest DDPAT','Crimson Web','Fade','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7','Night Stripe','Damascus Steel'),
	knife_gypsy_jackknife=C(tk,'lua_t_knife_gypsy_jackknife_skin','Navaja Knife','-','Forest DDPAT','Crimson Web','Fade','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7','Night Stripe','Damascus Steel'),
	knife_outdoor=C(tk,'lua_t_knife_outdoor_skin','Nomad Knife','-','Forest DDPAT','Crimson Web','Fade','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7','Night Stripe','Damascus Steel'),
	knife_stiletto=C(tk,'lua_t_knife_stiletto_skin','Stiletto Knife','-','Forest DDPAT','Crimson Web','Fade','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7','Night Stripe','Damascus Steel'),
	knife_widowmaker=C(tk,'lua_t_knife_widowmaker_skin','Talon Knife','-','Forest DDPAT','Crimson Web','Fade','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Night Stripe','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Marble Fade','Damascus Steel'),
	knife_skeleton=C(tk,'lua_t_knife_skeleton_skin','Skeleton Knife','-','Forest DDPAT','Crimson Web','Fade','Blue Steel','Stained','Case Hardened','Slaughter','Safari Mesh','Boreal Forest','Ultraviolet','Urban Masked','Scorched','Tiger Tooth','Marble Fade','Rust Coat','Doppler 1','Doppler 2','Doppler 3','Doppler 4','Doppler 5','Doppler 6','Doppler 7','Night Stripe','Damascus Steel'),

	studded_bloodhound_gloves=C(tg,'lua_t_studded_bloodhound_gloves_skin','Bloodhound Gloves','-','Charred','Snakebite','Bronzed','Guerrilla'),
	sporty_gloves=C(tg,'lua_t_sporty_gloves_skin','Sport Gloves','-','Superconductor','Arid',"Pandora's Box",'Hedge Maze','Amphibious','Bronze Morph','Omega','Vice'),
	slick_gloves=C(tg,'lua_t_slick_gloves_skin','Driver Gloves','-','Lunar Weave','Convoy','Crimson Weave','Diamondback','King Snake','Imperial Plaid','Overtake','Racing Green'),
	leather_handwraps=C(tg,'lua_t_leather_handwraps_skin','Hand Wraps','-','Leather','Spruce DDPAT','Slaughter','Badlands','Cobalt Skulls','Overprint','Duct Tape','Arboreal'),
	motorcycle_gloves=C(tg,'lua_t_motorcycle_gloves_skin','Moto Gloves','-','Eclipse','Spearmint','Boom!','Cool Mint','POW!','Turtle','Transport','Polygon'),
	specialist_gloves=C(tg,'lua_t_specialist_gloves_skin','Specialist Gloves','-','Forest DDPAT','Crimson Kimono','Emerald Web','Foundation','Crimson Web','Buckshot','Fade','Mogul'),
	studded_hydra_gloves=C(tg,'lua_t_studded_hydra_gloves_skin','Hydra Gloves','-','Emerald','Mangrove','Rattler','Case Hardened')
}

local function set(t)
	for i,v in pairs(t) do
		local v = v:GetValue()
		if v >= 0 then
			local e = f('skin_%s_enable', i)
			local pk = f('skin_%s_paintkit', i)
			if GetValue(pk) ~= v then
				if not GetValue(e) then
					SetValue(e, 1)
				end
				SetValue(pk, v-1)
			end
		end
	end
end

local function set_k(a)
	if GetValue(sK)-1 ~= a then
		SetValue(sK,a)
	end
end

local function set_g(a)
	if GetValue(sG)-1 ~= a then
		SetValue(sG,a)
	end
end

Register('Draw', function()
	local mo = R('MENU'):IsActive()
	local e0 = sw:GetValue() and mo
	local e1 = e:GetValue() == 1 and mo
	local e2 = e:GetValue() == 2 and mo

	w1:SetActive(e0)
	w2:SetActive(e1)
	w3:SetActive(e2)
end)

local function A(c)
	local lp = LocalPlayer()
	local a1 = A1:GetValue()
	local a2 = A2:GetValue()
	local a3 = A3:GetValue()

	if lp == nil then
		return
	end

	if lp:GetTeamNumber() == 1 then
		return
	elseif lp:GetTeamNumber() == 2 then
		if a1 then
			set(t_gun)
		end
		if a2 then
			set_k(knife_t:GetValue())
		end
		if a3 then
			set_g(gloves_t:GetValue())
		end
	elseif lp:GetTeamNumber() == 3 then
		if a1 then
			set(ct_gun)
		end
		if a2 then
			set_k(knife_ct:GetValue())
		end
		if a3 then
			set_g(gloves_ct:GetValue())
		end
	end
end

client.AllowListener('player_spawn')
Register('FireGameEvent', function(e)
	if (not A1:GetValue() and not A2:GetValue() and not A3:GetValue()) or e:GetName() ~= 'player_spawn' or PIbyUID(e:GetInt('userid')) ~= LPI() then
		return
	end

	u()
end)

Register('CreateMove', A)
