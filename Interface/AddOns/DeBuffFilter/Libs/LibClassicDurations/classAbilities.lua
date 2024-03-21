local lib = LibStub and LibStub("LibClassicDurations", true)
if not lib then
    return
end

local Type, Version = "SpellTable", 72
if lib:GetDataVersion(Type) >= Version then
    return
end  -- older versions didn't have that function

local Spell = lib.AddAura
local INFINITY = math.huge
local locale = GetLocale()

------------------
-- GLOBAL
------------------


-- World Buffs incl. Chronoboon IDs
Spell(349981, { duration = INFINITY }) -- World effect suspended
Spell({ 355363, 22888 }, { duration = 7200 }) -- Rallying Cry of the Dragonslayer
Spell({ 355365, 24425 }, { duration = 7200 }) -- Spirit of Zandalar
Spell({ 355366, 16609 }, { duration = 3600 }) -- Warchief's Blessing

-- Atiesh Buffs
Spell(28142, { duration = INFINITY, type = "BUFF" }) -- Power of the Guardian
Spell(28143, { duration = INFINITY, type = "BUFF" }) -- Power of the Guardian
Spell(28144, { duration = INFINITY, type = "BUFF" }) -- Power of the Guardian
Spell(28145, { duration = INFINITY, type = "BUFF" }) -- Power of the Guardian

-- Net-o-Matic

Spell(23451, { duration = 10 }) -- Battleground speed buff
Spell(23493, { duration = 10 }) -- Battleground heal buff
Spell(23505, { duration = 60 }) -- Battleground damage buff
Spell(6615, { duration = 30, type = "BUFF", buffType = "Magic" }) -- Free Action Potion
Spell(24364, { duration = 5, type = "BUFF", buffType = "Magic" }) -- Living Action Potion
Spell(3169, { duration = 6, type = "BUFF", buffType = "Magic" }) -- Limited Invulnerability Potion
Spell(16621, { duration = 3, type = "BUFF" }) -- Invulnerable Mail
Spell(11359, { duration = 30, type = "BUFF" }) -- Restorative Potion
Spell(5024, { duration = 10, type = "BUFF" }) -- Skull of Impending Doom
Spell(2379, { duration = 15, type = "BUFF", buffType = "Magic" }) -- Swiftness Potion
Spell(23097, { duration = 5, type = "BUFF" }) -- Fire Reflector
Spell(23131, { duration = 5, type = "BUFF" }) -- Frost Reflector
Spell(23132, { duration = 5, type = "BUFF" }) -- Shadow Reflector
Spell({ 25750, 25747, 25746, 23991 }, { duration = 15, type = "BUFF" }) -- AB Trinkets
Spell(23506, { duration = 20, type = "BUFF" }) -- Arena Grand Master trinket
Spell(29506, { duration = 20, type = "BUFF" }) -- Burrower's Shell trinket
Spell(12733, { duration = 30, type = "BUFF" }) -- Blacksmith trinket
Spell(14530, { duration = 10, type = "BUFF" }) -- Nifty Stopwatch
Spell(14253, { duration = 8, type = "BUFF" }) -- Black Husk Shield
Spell(9175, { duration = 15, type = "BUFF" }) -- Swift Boots
Spell(13141, { duration = 20, type = "BUFF" }) -- Gnomish Rocket Boots
Spell(8892, { duration = 20, type = "BUFF" }) -- Goblin Rocket Boots
Spell(9774, { duration = 5, type = "BUFF" }) -- Spider Belt & Ornate Mithril Boots
Spell({ 746, 1159, 3267, 3268, 7926, 7927, 10838, 10839, 18608, 18610, 23567, 23568, 23569, 23696, 24412, 24413, 24414 }, { duration = 8, type = "BUFF" }) -- First Aid
Spell(437327, { duration = 12, type = "BUFF" }) -- Charged Inspiration

-------------
-- RACIALS
-------------

Spell(26635, { duration = 10, type = "BUFF" }) -- Berserking
Spell(20600, { duration = 20, type = "BUFF" }) -- Perception
Spell(23234, { duration = 15, type = "BUFF" }) -- Blood Fury
Spell(20594, { duration = 8, type = "BUFF" }) -- Stoneform
Spell(7744, { duration = 5, type = "BUFF" }) -- Will of the Forsaken

-------------
-- PRIEST
-------------

Spell({ 18137, 19312, 19309, 19308, 19310, 19311, 421248 }, { duration = 600, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Shadowguard
Spell({ 15473, 22917, 16592 }, { duration = INFINITY, type = "BUFF" }) -- Shadowform

Spell(14751, { duration = INFINITY, type = "BUFF", buffType = "Magic" }) -- Inner focus

-- Why long auras are disabled
-- When you first get in combat log range with a player,
-- you'll get AURA_APPLIED event as if it was just applied, when it actually wasn't.
-- That's extremely common for these long self-buffs
-- Long raid buffs now have cast filter, that is only if you directly casted a spell it'll register
-- Cast Filter is ignored for enemies, so some personal buffs have it to still show enemy buffs

Spell({ 1243, 1244, 1245, 2791, 10937, 10938 }, { duration = 1800, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Power Word: Fortitude
Spell({ 21562, 21564 }, { duration = 3600, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Prayer of Fortitude
Spell({ 976, 10957, 10958 }, { duration = 600, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Shadow Protection
Spell(27683, { duration = 1200, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Prayer of Shadow Protection
Spell({ 14752, 14818, 14819, 27841 }, { duration = 1800, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Divine Spirit
Spell(27681, { duration = 3600, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Prayer of Spirit

Spell({ 588, 602, 1006, 7128, 10951, 10952 }, { duration = 600, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Inner Fire

Spell({ 14743, 27828 }, { duration = 6, type = "BUFF", buffType = "Magic" }) -- Focused Casting (Martyrdom)
Spell(27827, { duration = 10, type = "BUFF" }) -- Spirit of Redemption
Spell(15271, { duration = 15, type = "BUFF" }) -- Spirit Tap

Spell({ 13896, 19271, 19273, 19274, 19275 }, { duration = 15, type = "BUFF" }) -- Feedback
Spell({ 2651, 19289, 19291, 19292, 19293 }, { duration = 15, type = "BUFF" }) -- Elune's Grace

Spell(6346, { duration = 600, type = "BUFF", buffType = "Magic" }) -- Fear Ward
Spell({ 14893, 15357, 15359 }, { duration = 15, type = "BUFF", buffType = "Magic" }) -- Inspiration
Spell({ 7001, 27873, 27874 }, { duration = 10, type = "BUFF", buffType = "Magic" }) -- Lightwell Renew
Spell(552, { duration = 20, type = "BUFF", buffType = "Magic" }) -- Abolish Disease
Spell({ 17, 592, 600, 3747, 6065, 6066, 10898, 10899, 10900, 10901 }, { duration = 30, type = "BUFF", buffType = "Magic" }) -- PWS
Spell({ 139, 6074, 6075, 6076, 6077, 6078, 10927, 10928, 10929, 25315, 6074, 6075, 6076, 6077, 6078, 10927, 10928, 10929, 25315, 425268, 425269, 425270, 425271, 425272, 425273, 425274, 425275, 425276, 425277 }, {
    duration = 15,
    type = "BUFF", buffType = "Magic" }) -- Renew

Spell(10060, { duration = 15, type = "BUFF", buffType = "Magic" }) --Power Infusion
Spell({ 586, 9578, 9579, 9592, 10941, 10942 }, { duration = 10, type = "BUFF" }) -- Fade

---------------
-- DRUID
---------------

Spell(768, { duration = INFINITY, type = "BUFF" }) -- Cat Form
Spell(783, { duration = INFINITY, type = "BUFF" }) -- Travel Form
Spell(5487, { duration = INFINITY, type = "BUFF" }) -- Bear Form
Spell(9634, { duration = INFINITY, type = "BUFF" }) -- Dire Bear Form
Spell(1066, { duration = INFINITY, type = "BUFF" }) -- Aquatic Form
Spell(24858, { duration = INFINITY, type = "BUFF" }) -- Moonkin Form
Spell(24932, { duration = INFINITY, type = "BUFF" }) -- Leader of the Pack
Spell(17116, { duration = INFINITY, type = "BUFF", buffType = "Magic" }) -- Nature's Swiftness
Spell(409324, { duration = 10, type = "BUFF", buffType = "Magic" }) -- Ancestral Guidance
Spell(417147, { duration = 30, type = "BUFF" }) -- Efflorescence

Spell({ 1126, 5232, 5234, 6756, 8907, 9884, 9885 }, { duration = 1800, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Mark of the Wild
Spell({ 21849, 21850 }, { duration = 3600, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Gift of the Wild
Spell(19975, { duration = 12, buffType = "Magic" }) -- Nature's Grasp root
Spell({ 16689, 16810, 16811, 16812, 16813, 17329 }, { duration = 45, type = "BUFF", buffType = "Magic" }) -- Nature's Grasp
Spell(16864, { duration = 600, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Omen of Clarity
Spell(16870, { duration = 15, type = "BUFF", buffType = "Magic" }) -- Clearcasting from OoC


Spell({ 467, 782, 1075, 8914, 9756, 9910 }, { duration = 600, type = "BUFF", buffType = "Magic" }) -- Thorns
Spell(22812, 428713, { duration = 15, type = "BUFF", buffType = "Magic" }) -- Barkskin
--SKIPPING: Hurricane (Channeled)

Spell({ 1850, 9821 }, { duration = 15, type = "BUFF" }) -- Dash
Spell(5229, { duration = 10, type = "BUFF" }) -- Enrage
Spell({ 22842, 22895, 22896, 428708 }, { duration = 10, type = "BUFF" }) -- Frenzied Regeneration
Spell({ 5217, 6793, 9845, 9846, 417045 }, { name = "Tiger's Fury", duration = 6 })
Spell(2893, { duration = 8, type = "BUFF", buffType = "Magic" }) -- Abolish Poison
Spell(29166, { duration = 20, type = "BUFF", buffType = "Magic" }) -- Innervate

Spell({ 8936, 8938, 8939, 8940, 8941, 9750, 9856, 9857, 9858, 436937, 436946, 436943, 436939, 436945, 436942, 436938, 436940, 436944 }, { duration = 21, type = "BUFF", buffType = "Magic" }) -- Regrowth

Spell({ 774, 1058, 1430, 2090, 2091, 3627, 8910, 9839, 9840, 9841, 25299, 417061, 417064, 417063, 417057, 417062, 417059, 417058, 417066, 417068, 417060, 417065 }, {
    duration = 12, type = "BUFF", buffType = "Magic" }) -- Rejuv

-------------
-- WARRIOR
-------------

Spell(2457, { duration = INFINITY, type = "BUFF" }) -- Battle Stance
Spell(2458, { duration = INFINITY, type = "BUFF" }) -- Berserker Stance
Spell(71, { duration = INFINITY, type = "BUFF" }) -- Def Stance
Spell(20230, { duration = 15, type = "BUFF" }) -- Retaliation
Spell(1719, { duration = 15, type = "BUFF" }) -- Recklessness
Spell(871, { type = "BUFF", duration = 10 }) -- Shield wall, varies
Spell(12976, { duration = 20, type = "BUFF" }) -- Last Stand

Spell({ 5242, 6192, 6673, 11549, 11550, 11551, 25289 }, { type = "BUFF",
                                                          duration = 120 }) -- Battle Shout
Spell(403215, { duration = 120, type = "BUFF" }) -- Commanding Shout


Spell(18499, { duration = 10, type = "BUFF" }) -- Berserker Rage

Spell(29131, { duration = 10, type = "BUFF" }) -- Bloodrage
Spell(2565, { duration = 5, type = "BUFF" }) -- Shield Block, varies BUFF
Spell(12292, { duration = 20, type = "BUFF" }) -- Sweeping Strikes
Spell({ 12880, 14201, 14202, 14203, 14204 }, { duration = 12, type = "BUFF" }) -- Enrage
Spell({ 12966, 12967, 12968, 12969, 12970 }, { duration = 15, type = "BUFF" }) -- Flurry
Spell({ 16488, 16490, 16491 }, { duration = 6, type = "BUFF" }) -- Blood Craze
Spell({ 23885, 23886, 23887, 23888 }, { duration = 6, type = "BUFF" }) -- Bloodthirst

--------------
-- ROGUE
--------------

Spell(14177, { duration = INFINITY, type = "BUFF" }) -- Cold Blood
Spell({ 1784, 1785, 1786, 1787 }, { duration = INFINITY, type = "BUFF" }) -- Stealth

Spell(14278, { duration = 7, type = "BUFF" }) -- Ghostly Strike
Spell(13750, { duration = 15, type = "BUFF" }) -- Adrenaline Rush
Spell(13877, { duration = 15, type = "BUFF" }) -- Blade Flurry
Spell({ 5171, 6774 }, { duration = nil, type = "BUFF" }) -- SnD, to prevent fallback to incorrect db values
Spell({ 2983, 8696, 11305 }, { duration = 15, type = "BUFF" }) -- Sprint
Spell(5277, { duration = 15, type = "BUFF" }) -- Evasion

------------
-- WARLOCK
------------

Spell({ 20707, 20762, 20763, 20764, 20765 }, { duration = 1800, type = "BUFF" }) -- Soulstone Resurrection
Spell({ 687, 696 }, { duration = 1800, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Demon Skin
Spell({ 706, 1086, 11733, 11734, 11735 }, { duration = 1800, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Demon Armor
Spell({ 18791 }, { duration = 1800, type = "BUFF", castFilter = true })  -- Touch of Shadow
Spell({ 18789 }, { duration = 1800, type = "BUFF", castFilter = true })  -- Burning Wish
Spell({ 18792 }, { duration = 1800, type = "BUFF", castFilter = true })  -- Fel Energy
Spell({ 18790 }, { duration = 1800, type = "BUFF", castFilter = true })  -- Fel Stamina
Spell({ 430025, 425463 }, { duration = 6, type = "BUFF" }) -- Demonic Grace
Spell(425467, { duration = 45, type = "BUFF", buffType = "Magic" }) -- Demonic Pact
Spell(427713, { duration = 10, type = "BUFF" }) -- Backdraft
Spell({ 18288 }, { duration = 1800, type = "BUFF", castFilter = true, buffType = "Magic" })  -- Amplify Curse
Spell({ 6307, 7804, 7805, 11766, 11767 }, { duration = INFINITY }) -- Blood Pact
Spell({ 18708 }, { duration = 15, type = "BUFF", buffType = "Magic" }) -- Fel Domination
Spell({ 19480 }, { duration = INFINITY }) -- Paranoia
Spell({ 25228 }, { duration = INFINITY, type = "BUFF", buffType = "Magic" }) -- Soul Link
Spell({ 23829 }, { duration = INFINITY, type = "BUFF" }) -- Master Demonologist
Spell({ 6229, 11739, 11740, 28610 }, { duration = 30, type = "BUFF", buffType = "Magic" }) -- Shadow Ward
Spell({ 7812, 19438, 19440, 19441, 19442, 19443 }, { duration = 30, type = "BUFF", buffType = "Magic" }) -- Sacrifice

---------------
-- SHAMAN
---------------

Spell({ 8185, 10534, 10535 }, { duration = INFINITY, type = "BUFF" }) -- Fire Resistance Totem
Spell({ 8182, 10476, 10477 }, { duration = INFINITY, type = "BUFF" }) -- Frost Resistance Totem
Spell({ 10596, 10598, 10599 }, { duration = INFINITY, type = "BUFF" }) -- Nature Resistance Totem
Spell(25909, { duration = INFINITY, type = "BUFF" }) -- Tranquil Air Totem
Spell({ 5672, 6371, 6372, 10460, 10461 }, { duration = INFINITY, type = "BUFF" }) -- Healing Stream Totem
Spell({ 5677, 10491, 10493, 10494 }, { duration = INFINITY, type = "BUFF" }) -- Mana Spring Totem
Spell({ 8076, 8162, 8163, 10441, 25362 }, { duration = INFINITY, type = "BUFF" }) -- Strength of Earth Totem
Spell({ 8836, 10626, 25360 }, { duration = INFINITY, type = "BUFF" }) -- Grace of Air Totem
Spell({ 8072, 8156, 8157, 10403, 10404, 10405 }, { duration = INFINITY, type = "BUFF" }) -- Stoneskin Totem
Spell({ 16191, 17355, 17360 }, { duration = 12, type = "BUFF" }) -- Mana Tide Totem
Spell(16166, { duration = INFINITY, type = "BUFF" }) -- Elemental Mastery

Spell(8178, { duration = 45, type = "BUFF" }) -- Grounding Totem Effect, no duration, but lasts 45s. Keeping for enemy buffs
Spell({ 324, 325, 905, 945, 8134, 10431, 10432 }, { duration = 600, type = "BUFF", buffType = "Magic" }) -- Lightning Shield
Spell(546, { duration = 600, type = "BUFF", buffType = "Magic" }) -- Water Walking
Spell(131, { duration = 600, type = "BUFF", buffType = "Magic" }) -- Water Breahing
Spell(408510, { duration = 600, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Water Shield
Spell({ 16257, 16277, 16278, 16279, 16280 }, { duration = 15, type = "BUFF" }) -- Flurry

Spell({ 16177, 16236, 16237 }, { duration = 15, type = "BUFF", buffType = "Magic" }) -- Ancestral Fortitude from Ancestral Healing
Spell(29203, { duration = 15, type = "BUFF", buffType = "Magic" }) -- Healing Way
Spell({ 27689, 16170, 6742, 24185, 21049 }, { duration = 30, type = "BUFF", buffType = "Magic" }) -- Bloodlust



--------------
-- PALADIN
--------------

Spell(19746, { duration = INFINITY, type = "BUFF" }) -- Concentration Aura
Spell({ 465, 643, 1032, 10290, 10291, 10292, 10293 }, { duration = INFINITY, type = "BUFF" }) -- Devotion Aura
Spell({ 19891, 19899, 19900 }, { duration = INFINITY, type = "BUFF" }) -- Fire Resistance Aura
Spell({ 19888, 19897, 19898 }, { duration = INFINITY, type = "BUFF" }) -- Frost Resistance Aura
Spell({ 19876, 19895, 19896 }, { duration = INFINITY, type = "BUFF" }) -- Shadow Resistance Aura
Spell({ 7294, 10298, 10299, 10300, 10301 }, { duration = INFINITY, type = "BUFF" }) -- Retribution Aura
Spell({ 20218 }, { duration = INFINITY, type = "BUFF" }) -- Sanctity Aura


Spell(25780, { duration = 1800, type = "BUFF", buffType = "Magic" }) -- Righteous Fury

Spell({ 19740, 19834, 19835, 19836, 19837, 19838, 25291 }, { duration = 300, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Blessing of Might
Spell({ 25782, 25916 }, { duration = 900, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Greater Blessing of Might

Spell({ 19742, 19850, 19852, 19853, 19854, 25290 }, { duration = 300, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Blessing of Wisdom
Spell({ 25894, 25918 }, { duration = 900, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Greater Blessing of Might

Spell(20217, { duration = 300, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Blessing of Kings
Spell(25898, { duration = 900, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Greater Blessing of Kings

Spell({ 20911, 20912, 20913 }, { duration = 300, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Blessing of Sanctuary
Spell(25899, { duration = 900, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Greater Blessing of Sanctuary

Spell(1038, { duration = 300, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Blessing of Salvation
Spell(25895, { duration = 900, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Greater Blessing of Salvation

Spell({ 19977, 19978, 19979 }, { duration = 300, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Blessing of Light
Spell(25890, { duration = 900, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Greater Blessing of Light


Spell(1044, { duration = 10, type = "BUFF", buffType = "Magic" }) -- Blessing of Freedom
Spell({ 6940, 20729 }, { duration = 30, type = "BUFF", buffType = "Magic" }) -- Blessing of Sacrifice
Spell({ 1022, 5599, 10278 }, { type = "BUFF",
                               buffType = "Magic",
                               duration = function(spellID)
                                   if spellID == 1022 then
                                       return 6
                                   elseif spellID == 5599 then
                                       return 8
                                   else
                                       return 10
                                   end
                               end
}) -- Blessing of Protection
Spell({ 498, 5573 }, { type = "BUFF",
                       duration = function(spellID)
                           return spellID == 498 and 6 or 8
                       end
}) -- Divine Protection
Spell({ 642, 1020 }, { type = "BUFF",
                       duration = function(spellID)
                           return spellID == 642 and 10 or 12
                       end
}) -- Divine Shield
Spell({ 20375, 20915, 20918, 20919, 20920 }, { duration = 30, type = "BUFF", buffType = "Magic" }) -- Seal of Command
Spell({ 21084, 20287, 20288, 20289, 20290, 20291, 20292, 20293, 20154 }, { duration = 30, type = "BUFF", buffType = "Magic" }) -- Seal of Righteousness
Spell({ 20162, 20305, 20306, 20307, 20308, 21082 }, { duration = 30, type = "BUFF", buffType = "Magic" }) -- Seal of the Crusader
Spell({ 20165, 20347, 20348, 20349 }, { duration = 30, type = "BUFF", buffType = "Magic" }) -- Seal of Light
Spell({ 20166, 20356, 20357 }, { duration = 30, type = "BUFF", buffType = "Magic" }) -- Seal of Wisdom
Spell(20164, { duration = 30, type = "BUFF", buffType = "Magic" }) -- Seal of Justice
Spell({ 20925, 20927, 20928 }, { duration = 10, type = "BUFF", buffType = "Magic" }) -- Holy Shield
Spell({ 20128, 20131, 20132, 20133, 20134 }, { duration = 10, type = "BUFF" }) -- Redoubt
Spell({ 67, 26017, 26018 }, { duration = 10, type = "BUFF", buffType = "Magic" }) -- Vindication
Spell({ 20050, 20052, 20053, 20054, 20055 }, { duration = 8, type = "BUFF", buffType = "Magic" }) -- Vengeance
Spell({ 16431, 11445 }, { duration = 60, type = "BUFF", buffType = "Magic" }) -- Bone Armor

-------------
-- HUNTER
-------------

Spell(13161, { duration = INFINITY, type = "BUFF" }) -- Aspect of the Beast
Spell(5118, { duration = INFINITY, type = "BUFF" }) -- Aspect of the Cheetah
Spell(13159, { duration = INFINITY, type = "BUFF" }) -- Aspect of the Pack
Spell(13163, { duration = INFINITY, type = "BUFF" }) -- Aspect of the Monkey
Spell(415423, { duration = INFINITY, type = "BUFF" }) -- Aspect of the Viper
Spell({ 20043, 20190 }, { duration = INFINITY, type = "BUFF" }) -- Aspect of the Wild
Spell({ 13165, 14318, 14319, 14320, 14321, 14322, 25296 }, { duration = INFINITY, type = "BUFF" }) -- Aspect of the Hawk
Spell(409580, { duration = INFINITY, type = "BUFF" }) -- Aspect of the Lion
Spell(5384, { duration = INFINITY, type = "BUFF" }) -- Feign Death (Will it work?)
Spell({ 19579, 24529 }, { duration = INFINITY, type = "BUFF" }) -- Spirit Bond
Spell(415320, { duration = 10, type = "BUFF" }) -- Flanking Strike

Spell({ 19506, 20905, 20906 }, { duration = 1800, type = "BUFF", castFilter = true }) -- Trueshot Aura
Spell(19615, { duration = 8, type = "BUFF" }) -- Frenzy
Spell({ 1130, 14323, 14324, 14325 }, { duration = 120 }) -- Hunter's Mark
Spell(19263, { duration = 10, type = "BUFF" }) -- Deterrence
Spell(3045, { duration = 15, type = "BUFF" }) -- Rapid Fire
Spell(19574, { duration = 18, type = "BUFF" }) -- Bestial Wrath
Spell({ 136, 3111, 3661, 3662, 13542, 13543, 13544 }, { duration = 5, type = "BUFF" }) -- Mend Pet

-------------
-- MAGE
-------------

Spell(12043, { duration = INFINITY, type = "BUFF", buffType = "Magic" }) -- Presence of Mind

Spell({ 1459, 1460, 1461, 10156, 10157 }, { duration = 1800, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Arcane Intellect
Spell(23028, { duration = 3600, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Arcane Brilliance
Spell({ 6117, 22782, 22783 }, { duration = 1800, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Mage Armor
Spell({ 168, 7300, 7301 }, { duration = 1800, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Frost Armor
Spell({ 7302, 7320, 10219, 10220 }, { duration = 1800, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Ice Armor
Spell(2855, { duration = 120, type = "BUFF", buffType = "Magic" }) -- Detect Magic
Spell(130, { duration = 1800, type = "BUFF", buffType = "Magic" }) -- Slow Fall
Spell({ 604, 8450, 8451, 10173, 10174 }, { duration = 600, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Dampen Magic
Spell({ 1008, 8455, 10169, 10170 }, { duration = 600, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Amplify Magic
Spell(11958, { duration = 10, type = "BUFF" }) -- Ice Block
Spell({ 1463, 8494, 8495, 10191, 10192, 10193, 412120, 412123, 412120, 412123, 412116, 412122 }, { duration = 60, type = "BUFF", buffType = "Magic" }) -- Mana Shield
Spell({ 11426, 13031, 13032, 13033 }, { duration = 60, type = "BUFF", buffType = "Magic" }) -- Ice Barrier
Spell({ 543, 8457, 8458, 10223, 10225, 412218, 412231, 412230, 412214, 412232 }, { duration = 30, type = "BUFF", buffType = "Magic" }) -- Fire Ward
Spell({ 6143, 8461, 8462, 10177, 28609, 412207, 412207, 412205, 412209, 412210 }, { duration = 30, type = "BUFF", buffType = "Magic" }) -- Frost Ward

-- SoD
Spell(436516, { duration = 20, type = "BUFF" }) -- Chrono Preserv
Spell(400735, { duration = 30, type = "BUFF", buffType = "Magic" }) -- Temporal Beacon
Spell(431655, { duration = 10, type = "BUFF", buffType = "Magic" }) -- Mind Spike
Spell(426316, { duration = 10, type = "BUFF" }) -- Shadow and flame
Spell(426490, { duration = 10, type = "BUFF" }) -- Rallying cry
Spell(426158, { duration = 12, type = "BUFF" }) -- Sheath of Light
Spell(438040, { duration = 15, type = "BUFF" }) -- Redirect
Spell({ 433255, 425336 }, { duration = 15, type = "BUFF" }) -- Shamanistic Rage
Spell({ 425874, 425876, 436391 }, { duration = 10, type = "BUFF" }) -- Decoy Totem
Spell(426065, { duration = INFINITY, type = "BUFF" }) -- Infusion of Light
Spell({ 427725, 427726 }, { duration = INFINITY, type = "BUFF" }) -- Immolation Aura
Spell({ 412019, 53601 }, { duration = 30, type = "BUFF", buffType = "Magic" }) -- Sacred Shield
Spell({ 412018, 58597 }, { duration = 6, type = "BUFF", buffType = "Magic" }) -- Sacred Shield
Spell({ 408255, 408250 }, { duration = 15, type = "BUFF", buffType = "Magic" }) -- Eclipse
Spell({ 429125, 425121 }, { duration = 20, type = "BUFF", buffType = "Magic" }) -- Icy Veins
Spell(442211, { duration = 30, type = "BUFF" }) -- Berserk
Spell(417141, { duration = 15, type = "BUFF" }) -- Berserk
Spell(426979, { duration = 5, type = "BUFF" }) -- Sword & Board
Spell(413399, { duration = 15, type = "BUFF" }) -- Blood surge
Spell(428878, { duration = 30, type = "BUFF" }) -- Balefire Bolt
Spell({ 429307, 428741 }, { duration = 1800, castFilter = true, type = "BUFF" }) -- Molten Armor
Spell({ 426940, 427070, 426942 }, { duration = 30, type = "BUFF" }) -- Rampage
Spell({ 426969, 426953 }, { duration = 9, type = "BUFF" }) -- Taste for Blood
Spell({ 431624, 431649 }, { duration = 12, type = "BUFF", buffType = "Magic" }) -- Divine Aegis
Spell(425585, { duration = 10, type = "BUFF" }) -- Aegis
Spell(427065, { duration = 12, type = "BUFF" }) -- Wrecking Crew
Spell({ 428912, 429243, 428909 }, { duration = 15, type = "BUFF" }) -- Light's Grace
Spell({ 426972, 427068 }, { duration = 1800, castFilter = true, type = "BUFF" }) -- Vigilance
Spell(429144, { duration = INFINITY, type = "BUFF" }) -- Purifying Power
Spell(431666, { duration = 15, type = "BUFF", buffType = "Magic" }) -- Surge of Light
Spell(425294, { duration = 6, type = "BUFF" }) -- Dispersion
Spell({ 400624, 48108, 400625 }, { duration = 10, type = "BUFF" }) -- Hot Streak
Spell(408261, { duration = 8, type = "BUFF" }) -- Dreamstate
Spell(407798, { duration = 30, type = "BUFF", buffType = "Magic" }) -- Seal of Martyrdom
Spell({ 400589, 400588 }, { duration = 15, type = "BUFF", buffType = "Magic" }) -- Missile Barrage
Spell(402004, { duration = 8, type = "BUFF", buffType = "Magic" }) -- Pain Suppression
Spell(425124, { duration = 8, type = "BUFF" }) -- Arcane Surge
Spell(408124, { duration = 7, type = "BUFF", buffType = "Magic" }) -- Lifebloom
Spell({ 402913, 403359 }, { duration = 10, type = "BUFF" }) -- Enraged Regen
Spell(400730, { duration = 15, type = "BUFF", buffType = "Magic" }) -- Fireball!
Spell({ 400669, 400670 }, { duration = 15, type = "BUFF", buffType = "Magic" }) -- Fingers of Frost
Spell(406722, { duration = 3, type = "BUFF" }) -- Shadowstep
Spell(425096, { duration = 6, type = "BUFF" }) -- MoS
Spell(407613, { duration = 60, type = "BUFF", buffType = "Magic" }) -- Beacon of Light
Spell(403338, { duration = 10, type = "BUFF" }) -- Intervene
Spell({ 408514, 974 }, { duration = 600, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Earth Shield
Spell(408120, { duration = 6, type = "BUFF", buffType = "Magic" }) -- Wild Growth
Spell({ 401859, 401877 }, { duration = 30, type = "BUFF", buffType = "Magic" }) -- Prayer of Mending
Spell(407804, { duration = 10, type = "BUFF", buffType = "Magic" }) -- Divine Sacrifice
Spell(407988, { duration = 34, type = "BUFF", buffType = "" }) -- Savage Roar
Spell({ 425207, 425205 }, { duration = 10, type = "BUFF", buffType = "Magic" }) -- Power Word Barrier
Spell(401990, { duration = 5, type = "BUFF" }) -- ShadowCrawl
Spell(414800, { duration = 15, type = "BUFF", buffType = "Magic" }) -- Fury of Stormrage
Spell(413247, { duration = 20, type = "BUFF", buffType = "Magic" }) -- Serendipity
Spell(417157, { duration = 15, type = "BUFF" }) -- Starsurge
Spell(53489, { duration = 15, type = "BUFF", buffType = "Magic" }) -- Art of War
Spell(408024, { duration = 20, type = "BUFF" }) -- Survival Instincts
Spell({ 430949, 430952, 430950, 430951, 430948 }, { duration = 1800, castFilter = true, type = "BUFF", buffType = "Magic" }) --  Arcane buffs
Spell(12043, { duration = 15, type = "BUFF" }) -- Presence of Mind
Spell(12042, { duration = 15, type = "BUFF" }) -- Arcane Power
Spell(12051, { duration = 8, type = "BUFF" }) -- Evocation
Spell(402906, { duration = 12, type = "BUFF" }) -- Flagellation (Warrior)
Spell({ 442226, 442226, 442233, 403828 }, { duration = 3, type = "BUFF" }) -- Menace (Warlock)
Spell({ 400573, 400586 }, { duration = 6, type = "BUFF" }) -- Arcane Blast
Spell(435978, { duration = 10, type = "BUFF", buffType = "Magic" }) -- Energized Hyperconductor
Spell(403789, { duration = INFINITY, type = "BUFF" }) -- Metamorphosis
Spell(426301, { duration = 1800, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Grimoire of Synergy
Spell(408696, { duration = 1800, type = "BUFF", castFilter = true, buffType = "Magic" }) -- Spirit of the Alpha
Spell(408953, { duration = INFINITY, type = "BUFF" }) -- Building Inspiration
Spell(415233, { duration = INFINITY, type = "BUFF", buffType = "Magic" }) -- Ghost Wolf
Spell(415292, { duration = 12, type = "BUFF", buffType = "Magic" }) -- Earthliving
Spell(409324, { duration = 10, type = "BUFF", buffType = "Magic" }) -- Ancestral Guidance
Spell(408505, { duration = 30, type = "BUFF", buffType = "Magic" }) -- Maelstrom Weapon
Spell(415236, { duration = 10, type = "BUFF" }) -- Healing Rain
Spell(425284, { duration = 10, type = "BUFF" }) -- Spirit of the Redeemer
Spell(407805, { duration = 10, type = "BUFF", buffType = "Magic" }) -- Sacrifice Redeemed
Spell(415058, { duration = 15, type = "BUFF", buffType = "Magic" }) -- Guarded by the Light
Spell(407804, { duration = 10, type = "BUFF", buffType = "Magic" }) -- Divine Sacrifice
Spell(401460, { duration = 1.5, type = "BUFF", buffType = "Magic" }) -- Rapid Regeneration
Spell(412510, { duration = 3, type = "BUFF", buffType = "Magic" }) -- Mass Regeneration
Spell(409583, { duration = 15, type = "BUFF" }) -- Heart of the Lion
Spell(428728, { duration = 10, type = "BUFF" }) -- Frenzy
Spell({ 438536, 438537 }, { duration = 7200, type = "BUFF" }) -- Spark of Inspiration
Spell({ 430947, 431111 }, { duration = 7200, type = "BUFF" }) -- Boon of Blackfathom
Spell(429959, { duration = 7200, type = "BUFF" }) -- Well Rested
Spell(435973, { duration = 20, type = "BUFF" }) -- Mildly Irradiated
Spell(439155, { duration = 1800, castFilter = true, type = "BUFF", buffType = "Magic" }) -- Sigil of Innovation
Spell({ 437698, 437699 }, { duration = 30, type = "BUFF" }) -- Coin Flip
Spell(437357, { duration = 20, type = "BUFF" }) -- Gneuromantic Meditation
Spell(434488, { duration = 30, type = "BUFF" }) -- Spicy!
Spell(436443, { duration = 6, type = "BUFF" }) -- Command Aura
Spell(430948, { duration = 1800, castFilter = true, type = "BUFF", buffType = "Magic" }) -- Arcane Recovery
Spell(437362, { duration = 10, type = "BUFF" }) -- Hyperconductive Shock
Spell(435899, { duration = 20, type = "BUFF" }) -- Gyroscopic Acceleration
Spell(437382, { duration = 10, type = "BUFF" }) -- Reinforced Willpower
Spell(435895, { duration = 5, type = "BUFF" }) -- Gniodine Dispel
Spell(400015, { duration = 30, type = "BUFF" }) -- Rolling with the Punches
Spell(428489, { duration = 6, type = "BUFF" }) -- Planar Shift
Spell(415105, { duration = 10, type = "BUFF", buffType = "Magic" }) -- Power surge
Spell(436373, { duration = 20, type = "BUFF" }) -- Sanguine Sanctuary
Spell(407627, { duration = INFINITY, type = "BUFF", buffType = "Magic" }) -- Righteous Fury
Spell(435168, { duration = 1800, castFilter = true, type = "BUFF" }) -- Guard of the Innovator
Spell(428895, { duration = 15, type = "BUFF" }) -- Temporal Anomaly
Spell(415320, { duration = 10, type = "BUFF" }) -- Flanking Strike
Spell(409396, { duration = 30, type = "BUFF" }) -- Kill Command
Spell(432041, { duration = 20, type = "BUFF", buffType = "Magic" }) -- Tidal Waves
Spell(415401, { duration = INFINITY, type = "BUFF" }) -- Sniper Training
Spell(425714, { duration = 30, type = "BUFF" }) -- Cobra Strikes
Spell(436376, { duration = 20, type = "BUFF" }) -- Chain Heal Cost Reduced
Spell({ 412325, 412326 }, { duration = 10, type = "BUFF" }) -- Enlightenment
Spell(436412, { duration = INFINITY, type = "BUFF" }) -- Discoverer's Delight
Spell(407631, { duration = 3, type = "BUFF" }) -- Discoverer's Delight
Spell(437349, { duration = 10, type = "BUFF" }) -- Gneuro-Logical Shock
Spell(429867, { duration = 10, type = "BUFF" }) -- Void Madness
Spell(436100, { duration = 8, type = "BUFF", buffType = "Magic" }) -- Petrify
Spell(437377, { duration = 20, type = "BUFF" }) -- Intense Concentration
Spell(400012, { duration = 30, type = "BUFF" }) -- Blade Dance
Spell(425600, { duration = 120, type = "BUFF" }) -- Horn of Lordaeron
Spell(428726, { duration = 20, type = "BUFF" }) -- Focus Fire
Spell(407880, { duration = 120, type = "BUFF", buffType = "Magic" }) -- Inspiration Exemplar
Spell(409507, { duration = 7, type = "BUFF", buffType = "Magic" }) -- Expose Weakness
Spell(414680, { duration = 15, type = "BUFF", buffType = "Magic" }) -- Living Seed
Spell(426162, { duration = 12, type = "BUFF", buffType = "Magic" }) -- Sheath of Light (HoT)
Spell(426159, { duration = 60, type = "BUFF" }) -- Sheath of Light
Spell(435359, { duration = 10, type = "BUFF" }) -- Hardened to the Core
Spell(436469, { duration = 15, type = "BUFF", buffType = "Magic" }) -- Bloodlash
Spell(434851, { duration = 4, type = "BUFF" }) -- Minor Evocation
Spell(436430, { duration = 15, type = "BUFF" }) -- Avenging Wrath
Spell(412020, { duration = 12, type = "BUFF", buffType = "Magic" }) -- Flash of Light
Spell(408525, { duration = 15, type = "BUFF" }) -- Shield Mastery
Spell(436387, { duration = 7200, castFilter = true, type = "BUFF" }) -- Blessing of the Blood Loa
Spell(433797, { duration = 7, type = "BUFF" }) -- Bladestorm
Spell(408309, { duration = 30, type = "BUFF" }) -- Grace of Elune
Spell(398198, { duration = 30, type = "BUFF" }) -- Storm of Swords
Spell(408307, { duration = 30, type = "BUFF" }) -- Nature's Fury
Spell(420667, { duration = INFINITY, type = "BUFF" }) -- Horde Warbanner
Spell(423298, { duration = 20, type = "BUFF" }) -- Swimming Speed Minor
Spell(437716, { duration = 2, type = "BUFF" }) -- Primal Bloodthirst
Spell(400024, { duration = 3, type = "BUFF" }) -- Cheating Death
Spell(407791, { duration = 15, type = "BUFF", buffType = "" }) -- Aku'mai's Rage
Spell(430494, { duration = 300, castFilter = true, type = "BUFF" }) -- WoW Variety Show - Blazing Speed!
Spell(430492, { duration = 300, castFilter = true, type = "BUFF" }) -- WoW Variety Show - Healthy Competition!
Spell(434907, { duration = 15, type = "BUFF" }) -- Amplified Circuitry
Spell(427714, { duration = 10, type = "BUFF" }) -- Backdraft


-------------
-- MOUNTS
-------------

Spell(17481, { duration = INFINITY, type = "BUFF" }) -- Deathcharger's Reins
Spell(24252, { duration = INFINITY, type = "BUFF" }) -- Swift Zulian Tiger
Spell(23509, { duration = INFINITY, type = "BUFF" }) -- Horn of the Frostwolf Howler
Spell(17229, { duration = INFINITY, type = "BUFF" }) -- Reins of the Winterspring Frostsaber
Spell(26656, { duration = INFINITY, type = "BUFF" }) -- Black Qiraji Resonating Crystal
Spell(24242, { duration = INFINITY, type = "BUFF" }) -- Swift Razzashi Raptor
Spell(23510, { duration = INFINITY, type = "BUFF" }) -- Stormpike Battle Charger
Spell(470, { duration = INFINITY, type = "BUFF" }) -- Black Stallion Bridle
Spell(22723, { duration = INFINITY, type = "BUFF" }) -- Reins of the Black War Tiger
Spell(472, { duration = INFINITY, type = "BUFF" }) -- Pinto Bridle
Spell(23221, { duration = INFINITY, type = "BUFF" }) -- Reins of the Swift Frostsaber
Spell(23227, { duration = INFINITY, type = "BUFF" }) -- Swift Palomino
Spell(23228, { duration = INFINITY, type = "BUFF" }) -- Swift White Steed
Spell(6648, { duration = INFINITY, type = "BUFF" }) -- Chestnut Mare Bridle
Spell(458, { duration = INFINITY, type = "BUFF" }) -- Brown Horse Bridle
Spell(23338, { duration = INFINITY, type = "BUFF" }) -- Reins of the Swift Stormsaber
Spell(23219, { duration = INFINITY, type = "BUFF" }) -- Reins of the Swift Mistsaber
Spell(22721, { duration = INFINITY, type = "BUFF" }) -- Whistle of the Black War Raptor
Spell(23229, { duration = INFINITY, type = "BUFF" }) -- Swift Brown Steed
Spell(22717, { duration = INFINITY, type = "BUFF" }) -- Black War Steed Bridle
Spell(10793, { duration = INFINITY, type = "BUFF" }) -- Reins of the Striped Nightsaber
Spell(22722, { duration = INFINITY, type = "BUFF" }) -- Red Skeletal Warhorse
Spell(18791, { duration = INFINITY, type = "BUFF" }) -- Purple Skeletal Warhorse
Spell(10789, { duration = INFINITY, type = "BUFF" }) -- Reins of the Spotted Frostsaber
Spell(18245, { duration = INFINITY, type = "BUFF" }) -- Horn of the Black War Wolf
Spell(6653, { duration = INFINITY, type = "BUFF" }) -- Horn of the Dire Wolf
Spell(23241, { duration = INFINITY, type = "BUFF" }) -- Swift Blue Raptor
Spell(8394, { duration = INFINITY, type = "BUFF" }) -- Reins of the Striped Frostsaber
Spell(23250, { duration = INFINITY, type = "BUFF" }) -- Horn of the Swift Brown Wolf
Spell(22718, { duration = INFINITY, type = "BUFF" }) -- Black War Kodo
Spell(580, { duration = INFINITY, type = "BUFF" }) -- Horn of the Timber Wolf
Spell(17463, { duration = INFINITY, type = "BUFF" }) -- Blue Skeletal Horse
Spell(23251, { duration = INFINITY, type = "BUFF" }) -- Horn of the Swift Timber Wolf
Spell(23243, { duration = INFINITY, type = "BUFF" }) -- Swift Orange Raptor
Spell(17465, { duration = INFINITY, type = "BUFF" }) -- Green Skeletal Warhorse
Spell(22720, { duration = INFINITY, type = "BUFF" }) -- Black War Ram
Spell(8395, { duration = INFINITY, type = "BUFF" }) -- Whistle of the Emerald Raptor
Spell(6654, { duration = INFINITY, type = "BUFF" }) -- Horn of the Brown Wolf
Spell(17462, { duration = INFINITY, type = "BUFF" }) -- Red Skeletal Horse
Spell(23240, { duration = INFINITY, type = "BUFF" }) -- Swift White Ram
Spell(23252, { duration = INFINITY, type = "BUFF" }) -- Horn of the Swift Gray Wolf
Spell(23247, { duration = INFINITY, type = "BUFF" }) -- Great White Kodo
Spell(23242, { duration = INFINITY, type = "BUFF" }) -- Swift Olive Raptor
Spell(23225, { duration = INFINITY, type = "BUFF" }) -- Swift Green Mechanostrider
Spell(10969, { duration = INFINITY, type = "BUFF" }) -- Blue Mechanostrider
Spell(10799, { duration = INFINITY, type = "BUFF" }) -- Whistle of the Violet Raptor
Spell(22719, { duration = INFINITY, type = "BUFF" }) -- Black Battlestrider
Spell(6898, { duration = INFINITY, type = "BUFF" }) -- White Ram
Spell(17464, { duration = INFINITY, type = "BUFF" }) -- Brown Skeletal Horse
Spell(17454, { duration = INFINITY, type = "BUFF" }) -- Unpainted Mechanostrider
Spell(23223, { duration = INFINITY, type = "BUFF" }) -- Swift White Mechanostrider
Spell(10796, { duration = INFINITY, type = "BUFF" }) -- Whistle of the Turquoise Raptor
Spell(23238, { duration = INFINITY, type = "BUFF" }) -- Swift Brown Ram
Spell(23239, { duration = INFINITY, type = "BUFF" }) -- Swift Gray Ram
Spell(6899, { duration = INFINITY, type = "BUFF" }) -- Brown Ram
Spell(6777, { duration = INFINITY, type = "BUFF" }) -- Gray Ram
Spell(10873, { duration = INFINITY, type = "BUFF" }) -- Red Mechanostrider
Spell(23249, { duration = INFINITY, type = "BUFF" }) -- Great Brown Kodo
Spell(18989, { duration = INFINITY, type = "BUFF" }) -- Gray Kodo
Spell(18990, { duration = INFINITY, type = "BUFF" }) -- Brown Kodo
Spell(23248, { duration = INFINITY, type = "BUFF" }) -- Great Gray Kodo
Spell(23222, { duration = INFINITY, type = "BUFF" }) -- Swift Yellow Mechanostrider
Spell(17453, { duration = INFINITY, type = "BUFF" }) -- Green Mechanostrider
Spell(23214, { duration = INFINITY, type = "BUFF" }) -- Summon Charger
Spell(13819, { duration = INFINITY, type = "BUFF" }) -- Summon Warhorse
Spell(23161, { duration = INFINITY, type = "BUFF" }) -- Summon Dreadsteed
Spell(5784, { duration = INFINITY, type = "BUFF" }) -- Summon Felsteed
Spell(436288, { duration = INFINITY, type = "BUFF" }) -- Mottled Blood Raptor
Spell(436327, { duration = INFINITY, type = "BUFF" }) -- Bengal Tiger
Spell(429856, { duration = INFINITY, type = "BUFF" }) -- Summon Sentinel Nightsaber
Spell(429857, { duration = INFINITY, type = "BUFF" }) -- Summon Outrider Wolf
Spell(436289, { duration = INFINITY, type = "BUFF" }) -- Ivory Raptor
Spell(436329, { duration = INFINITY, type = "BUFF" }) -- Golden Sabercat

-------------
-- ITEMS
-------------

Spell(17670, { duration = INFINITY, type = "BUFF" }) -- Argent Dawn Commission
Spell(29506, { duration = 20, type = "BUFF" }) -- The Burrower's Shell
Spell({ 17543, 18942, 17548, 17549, 7240, 17544, 7250, 29432, 7235 }, { duration = 3600, type = "BUFF" }) -- Potion Protection
Spell(23991, { duration = 15, type = "BUFF", buffType = "Magic" }) -- Damage Absorb
Spell(23506, { duration = 20, type = "BUFF", buffType = "Magic" }) -- Aura of Protection
Spell({ 17730, 128, 17729 }, { duration = 60, type = "BUFF", buffType = "Magic" }) -- Spellstone
Spell(10368, { duration = 15, type = "BUFF", buffType = "Magic" }) -- Uther's Light Effect
Spell(13234, { duration = 600, type = "BUFF" }) -- Harm Prevention Belt
Spell(24021, { duration = 8, type = "BUFF" }) -- Anti-Magic Shield
Spell(7121, { duration = 10, type = "BUFF" }) -- Anti-Magic Shield

lib:SetDataVersion(Type, Version)
