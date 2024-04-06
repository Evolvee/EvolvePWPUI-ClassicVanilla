local _, addon = ...

if addon.game ~= "CLASSIC" then return end
addon.statWeights = {
    ['Warrior Speedrun'] = {
        ['Title'] = "Warrior Speedrun",
        ['Class'] = "Warrior",
        ['Kind'] = "Speedrun",
        ['ITEM_MOD_STRENGTH_SHORT'] = 2.00,
        ['ITEM_MOD_AGILITY_SHORT'] = 0.96,
        ['ITEM_MOD_INTELLECT_SHORT'] = 0.05,
        ['ITEM_MOD_STAMINA_SHORT'] = 0.50,
        ['ITEM_MOD_SPIRIT_SHORT'] = 1.50,
        ['ITEM_MOD_HEALTH_REGEN_SHORT'] = 0.50,
        ['ITEM_MOD_POWER_REGEN0_SHORT'] = 0.00,
        ['STAT_SPELLDAMAGE'] = 0.00,
        ['ITEM_MOD_SPELL_HEALING_DONE'] = 0.00,
        ['ITEM_MOD_HIT_SPELL_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_CRIT_SPELL_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_ATTACK_POWER_SHORT'] = 1.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT'] = 14.00,
        ['ITEM_MOD_CR_SPEED_SHORT_2H'] = 50.00,
        ['ITEM_MOD_CR_SPEED_SHORT_MH'] = 50.00,
        ['ITEM_MOD_CR_SPEED_SHORT_OH'] = 0.00,
        ['ITEM_MOD_HIT_RATING_SHORT'] = 18.00,
        ['ITEM_MOD_CRIT_RATING_SHORT'] = 10.50,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT_RANGED'] = 1.00,
        ['ITEM_MOD_CR_SPEED_SHORT_RANGED'] = 7.00,
        ['ITEM_MOD_RANGED_ATTACK_POWER_SHORT'] = 0.00,
        ['STAT_ARMOR'] = 0.02,
        ['ITEM_MOD_DEFENSE_SKILL_RATING_SHORT'] = 0.30,
        ['ITEM_MOD_DODGE_RATING_SHORT'] = 1.00,
        ['ITEM_MOD_PARRY_RATING_SHORT'] = 2.00,
        ['STAT_SPELLDAMAGE_ARCANE'] = 0.00,
        ['STAT_SPELLDAMAGE_FIRE'] = 0.00,
        ['STAT_SPELLDAMAGE_NATURE'] = 0.00,
        ['STAT_SPELLDAMAGE_FROST'] = 0.00,
        ['STAT_SPELLDAMAGE_SHADOW'] = 0.00,
        ['Axe skill'] = 0.00,
        ['Bow skill'] = 0.00,
        ['Crossbow skill'] = 0.00,
        ['Dagger skill'] = 0.00,
        ['Gun skill'] = 0.00,
        ['Mace skill'] = 0.00,
        ['Sword skill'] = 0.00,
        ['Two handed axe skill'] = 5.00,
        ['Two handed mace skill'] = 5.00,
        ['Two handed sword skill'] = 5.00,
        ['Total'] = 175.33,
    },
    ['Warrior Hardcore'] = {
        ['Title'] = "Warrior Hardcore",
        ['Class'] = "Warrior",
        ['Kind'] = "Hardcore",
        ['ITEM_MOD_STRENGTH_SHORT'] = 2.00,
        ['ITEM_MOD_AGILITY_SHORT'] = 1.10,
        ['ITEM_MOD_INTELLECT_SHORT'] = 0.05,
        ['ITEM_MOD_STAMINA_SHORT'] = 1.00,
        ['ITEM_MOD_SPIRIT_SHORT'] = 0.75,
        ['ITEM_MOD_HEALTH_REGEN_SHORT'] = 0.25,
        ['ITEM_MOD_POWER_REGEN0_SHORT'] = 0.00,
        ['STAT_SPELLDAMAGE'] = 0.00,
        ['ITEM_MOD_SPELL_HEALING_DONE'] = 0.00,
        ['ITEM_MOD_HIT_SPELL_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_CRIT_SPELL_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_ATTACK_POWER_SHORT'] = 1.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT'] = 14.00,
        ['ITEM_MOD_CR_SPEED_SHORT_2H'] = 50.00,
        ['ITEM_MOD_CR_SPEED_SHORT_MH'] = 50.00,
        ['ITEM_MOD_CR_SPEED_SHORT_OH'] = 0.00,
        ['ITEM_MOD_HIT_RATING_SHORT'] = 22.00,
        ['ITEM_MOD_CRIT_RATING_SHORT'] = 10.50,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT_RANGED'] = 1.00,
        ['ITEM_MOD_CR_SPEED_SHORT_RANGED'] = 7.00,
        ['ITEM_MOD_RANGED_ATTACK_POWER_SHORT'] = 0.00,
        ['STAT_ARMOR'] = 0.04,
        ['ITEM_MOD_DEFENSE_SKILL_RATING_SHORT'] = 0.30,
        ['ITEM_MOD_DODGE_RATING_SHORT'] = 2.00,
        ['ITEM_MOD_PARRY_RATING_SHORT'] = 4.00,
        ['STAT_SPELLDAMAGE_ARCANE'] = 0.00,
        ['STAT_SPELLDAMAGE_FIRE'] = 0.00,
        ['STAT_SPELLDAMAGE_NATURE'] = 0.00,
        ['STAT_SPELLDAMAGE_FROST'] = 0.00,
        ['STAT_SPELLDAMAGE_SHADOW'] = 0.00,
        ['Axe skill'] = 0.00,
        ['Bow skill'] = 0.00,
        ['Crossbow skill'] = 0.00,
        ['Dagger skill'] = 0.00,
        ['Gun skill'] = 0.00,
        ['Mace skill'] = 0.00,
        ['Sword skill'] = 0.00,
        ['Two handed axe skill'] = 5.00,
        ['Two handed mace skill'] = 5.00,
        ['Two handed sword skill'] = 5.00,
        ['Total'] = 181.99,
    },
    ['Shaman Enhancement Speedrun'] = {
        ['Title'] = "Shaman Enhancement Speedrun",
        ['Class'] = "Shaman",
        ['Spec'] = "Enhancement",
        ['Kind'] = "Speedrun",
        ['ITEM_MOD_STRENGTH_SHORT'] = 2.00,
        ['ITEM_MOD_AGILITY_SHORT'] = 1.59,
        ['ITEM_MOD_INTELLECT_SHORT'] = 0.26,
        ['ITEM_MOD_STAMINA_SHORT'] = 0.50,
        ['ITEM_MOD_SPIRIT_SHORT'] = 0.45,
        ['ITEM_MOD_HEALTH_REGEN_SHORT'] = 0.50,
        ['ITEM_MOD_POWER_REGEN0_SHORT'] = 0.50,
        ['STAT_SPELLDAMAGE'] = 0.18,
        ['ITEM_MOD_SPELL_HEALING_DONE'] = 0.10,
        ['ITEM_MOD_HIT_SPELL_RATING_SHORT'] = 0.26,
        ['ITEM_MOD_CRIT_SPELL_RATING_SHORT'] = 3.15,
        ['ITEM_MOD_ATTACK_POWER_SHORT'] = 1.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT'] = 14.00,
        ['ITEM_MOD_CR_SPEED_SHORT_2H'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_MH'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_OH'] = 0.00,
        ['ITEM_MOD_HIT_RATING_SHORT'] = 18.00,
        ['ITEM_MOD_CRIT_RATING_SHORT'] = 18.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT_RANGED'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_RANGED'] = 0.00,
        ['ITEM_MOD_RANGED_ATTACK_POWER_SHORT'] = 0.00,
        ['STAT_ARMOR'] = 0.02,
        ['ITEM_MOD_DEFENSE_SKILL_RATING_SHORT'] = 0.25,
        ['ITEM_MOD_DODGE_RATING_SHORT'] = 1.00,
        ['ITEM_MOD_PARRY_RATING_SHORT'] = 2.00,
        ['STAT_SPELLDAMAGE_ARCANE'] = 0.00,
        ['STAT_SPELLDAMAGE_FIRE'] = 0.02,
        ['STAT_SPELLDAMAGE_NATURE'] = 0.00,
        ['STAT_SPELLDAMAGE_FROST'] = 0.00,
        ['STAT_SPELLDAMAGE_SHADOW'] = 0.00,
        ['Axe skill'] = 5.00,
        ['Bow skill'] = 0.00,
        ['Crossbow skill'] = 0.00,
        ['Dagger skill'] = 0.00,
        ['Gun skill'] = 0.00,
        ['Mace skill'] = 0.00,
        ['Sword skill'] = 0.00,
        ['Two handed axe skill'] = 5.00,
        ['Two handed mace skill'] = 5.00,
        ['Two handed sword skill'] = 0.00,
        ['Total'] = 78.77,
    },
    ['Shaman Enhancement Hardcore'] = {
        ['Title'] = "Shaman Enhancement Hardcore",
        ['Class'] = "Shaman",
        ['Spec'] = "Enhancement",
        ['Kind'] = "Hardcore",
        ['ITEM_MOD_STRENGTH_SHORT'] = 2.00,
        ['ITEM_MOD_AGILITY_SHORT'] = 1.72,
        ['ITEM_MOD_INTELLECT_SHORT'] = 0.41,
        ['ITEM_MOD_STAMINA_SHORT'] = 1.00,
        ['ITEM_MOD_SPIRIT_SHORT'] = 0.35,
        ['ITEM_MOD_HEALTH_REGEN_SHORT'] = 0.25,
        ['ITEM_MOD_POWER_REGEN0_SHORT'] = 0.25,
        ['STAT_SPELLDAMAGE'] = 0.18,
        ['ITEM_MOD_SPELL_HEALING_DONE'] = 0.10,
        ['ITEM_MOD_HIT_SPELL_RATING_SHORT'] = 0.26,
        ['ITEM_MOD_CRIT_SPELL_RATING_SHORT'] = 3.15,
        ['ITEM_MOD_ATTACK_POWER_SHORT'] = 1.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT'] = 14.00,
        ['ITEM_MOD_CR_SPEED_SHORT_2H'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_MH'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_OH'] = 0.00,
        ['ITEM_MOD_HIT_RATING_SHORT'] = 18.00,
        ['ITEM_MOD_CRIT_RATING_SHORT'] = 18.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT_RANGED'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_RANGED'] = 0.00,
        ['ITEM_MOD_RANGED_ATTACK_POWER_SHORT'] = 0.00,
        ['STAT_ARMOR'] = 0.04,
        ['ITEM_MOD_DEFENSE_SKILL_RATING_SHORT'] = 0.25,
        ['ITEM_MOD_DODGE_RATING_SHORT'] = 2.00,
        ['ITEM_MOD_PARRY_RATING_SHORT'] = 4.00,
        ['STAT_SPELLDAMAGE_ARCANE'] = 0.00,
        ['STAT_SPELLDAMAGE_FIRE'] = 0.02,
        ['STAT_SPELLDAMAGE_NATURE'] = 0.00,
        ['STAT_SPELLDAMAGE_FROST'] = 0.00,
        ['STAT_SPELLDAMAGE_SHADOW'] = 0.00,
        ['Axe skill'] = 5.00,
        ['Bow skill'] = 0.00,
        ['Crossbow skill'] = 0.00,
        ['Dagger skill'] = 0.00,
        ['Gun skill'] = 0.00,
        ['Mace skill'] = 0.00,
        ['Sword skill'] = 0.00,
        ['Two handed axe skill'] = 5.00,
        ['Two handed mace skill'] = 5.00,
        ['Two handed sword skill'] = 0.00,
        ['Total'] = 81.97,
    },
    ['Shaman Elemental Speedrun'] = {
        ['Title'] = "Shaman Elemental Speedrun",
        ['Class'] = "Shaman",
        ['Spec'] = "Elemental",
        ['Kind'] = "Speedrun",
        ['ITEM_MOD_STRENGTH_SHORT'] = 0.00,
        ['ITEM_MOD_AGILITY_SHORT'] = 0.09,
        ['ITEM_MOD_INTELLECT_SHORT'] = 0.55,
        ['ITEM_MOD_STAMINA_SHORT'] = 0.50,
        ['ITEM_MOD_SPIRIT_SHORT'] = 0.45,
        ['ITEM_MOD_HEALTH_REGEN_SHORT'] = 0.50,
        ['ITEM_MOD_POWER_REGEN0_SHORT'] = 0.50,
        ['STAT_SPELLDAMAGE'] = 0.88,
        ['ITEM_MOD_SPELL_HEALING_DONE'] = 0.10,
        ['ITEM_MOD_HIT_SPELL_RATING_SHORT'] = 1.31,
        ['ITEM_MOD_CRIT_SPELL_RATING_SHORT'] = 10.50,
        ['ITEM_MOD_ATTACK_POWER_SHORT'] = 0.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_2H'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_MH'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_OH'] = 0.00,
        ['ITEM_MOD_HIT_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_CRIT_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT_RANGED'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_RANGED'] = 0.00,
        ['ITEM_MOD_RANGED_ATTACK_POWER_SHORT'] = 0.00,
        ['STAT_ARMOR'] = 0.02,
        ['ITEM_MOD_DEFENSE_SKILL_RATING_SHORT'] = 0.20,
        ['ITEM_MOD_DODGE_RATING_SHORT'] = 1.00,
        ['ITEM_MOD_PARRY_RATING_SHORT'] = 2.00,
        ['STAT_SPELLDAMAGE_ARCANE'] = 0.00,
        ['STAT_SPELLDAMAGE_FIRE'] = 0.11,
        ['STAT_SPELLDAMAGE_NATURE'] = 0.77,
        ['STAT_SPELLDAMAGE_FROST'] = 0.00,
        ['STAT_SPELLDAMAGE_SHADOW'] = 0.00,
        ['Axe skill'] = 0.00,
        ['Bow skill'] = 0.00,
        ['Crossbow skill'] = 0.00,
        ['Dagger skill'] = 0.00,
        ['Gun skill'] = 0.00,
        ['Mace skill'] = 0.00,
        ['Sword skill'] = 0.00,
        ['Two handed axe skill'] = 0.00,
        ['Two handed mace skill'] = 0.00,
        ['Two handed sword skill'] = 0.00,
        ['Total'] = 19.47,
    },
    ['Shaman Elemental Hardcore'] = {
        ['Title'] = "Shaman Elemental Hardcore",
        ['Class'] = "Shaman",
        ['Spec'] = "Elemental",
        ['Kind'] = "Hardcore",
        ['ITEM_MOD_STRENGTH_SHORT'] = 0.00,
        ['ITEM_MOD_AGILITY_SHORT'] = 0.22,
        ['ITEM_MOD_INTELLECT_SHORT'] = 0.75,
        ['ITEM_MOD_STAMINA_SHORT'] = 1.00,
        ['ITEM_MOD_SPIRIT_SHORT'] = 0.35,
        ['ITEM_MOD_HEALTH_REGEN_SHORT'] = 0.25,
        ['ITEM_MOD_POWER_REGEN0_SHORT'] = 0.25,
        ['STAT_SPELLDAMAGE'] = 0.88,
        ['ITEM_MOD_SPELL_HEALING_DONE'] = 0.10,
        ['ITEM_MOD_HIT_SPELL_RATING_SHORT'] = 1.31,
        ['ITEM_MOD_CRIT_SPELL_RATING_SHORT'] = 10.50,
        ['ITEM_MOD_ATTACK_POWER_SHORT'] = 0.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_2H'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_MH'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_OH'] = 0.00,
        ['ITEM_MOD_HIT_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_CRIT_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT_RANGED'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_RANGED'] = 0.00,
        ['ITEM_MOD_RANGED_ATTACK_POWER_SHORT'] = 0.00,
        ['STAT_ARMOR'] = 0.04,
        ['ITEM_MOD_DEFENSE_SKILL_RATING_SHORT'] = 0.20,
        ['ITEM_MOD_DODGE_RATING_SHORT'] = 2.00,
        ['ITEM_MOD_PARRY_RATING_SHORT'] = 4.00,
        ['STAT_SPELLDAMAGE_ARCANE'] = 0.00,
        ['STAT_SPELLDAMAGE_FIRE'] = 0.11,
        ['STAT_SPELLDAMAGE_NATURE'] = 0.77,
        ['STAT_SPELLDAMAGE_FROST'] = 0.00,
        ['STAT_SPELLDAMAGE_SHADOW'] = 0.00,
        ['Axe skill'] = 0.00,
        ['Bow skill'] = 0.00,
        ['Crossbow skill'] = 0.00,
        ['Dagger skill'] = 0.00,
        ['Gun skill'] = 0.00,
        ['Mace skill'] = 0.00,
        ['Sword skill'] = 0.00,
        ['Two handed axe skill'] = 0.00,
        ['Two handed mace skill'] = 0.00,
        ['Two handed sword skill'] = 0.00,
        ['Total'] = 22.72,
    },
    ['Paladin Speedrun'] = {
        ['Title'] = "Paladin Speedrun",
        ['Class'] = "Paladin",
        ['Kind'] = "Speedrun",
        ['ITEM_MOD_STRENGTH_SHORT'] = 2.00,
        ['ITEM_MOD_AGILITY_SHORT'] = 0.96,
        ['ITEM_MOD_INTELLECT_SHORT'] = 0.22,
        ['ITEM_MOD_STAMINA_SHORT'] = 0.50,
        ['ITEM_MOD_SPIRIT_SHORT'] = 0.75,
        ['ITEM_MOD_HEALTH_REGEN_SHORT'] = 0.50,
        ['ITEM_MOD_POWER_REGEN0_SHORT'] = 0.50,
        ['STAT_SPELLDAMAGE'] = 0.09,
        ['ITEM_MOD_SPELL_HEALING_DONE'] = 0.10,
        ['ITEM_MOD_HIT_SPELL_RATING_SHORT'] = 0.13,
        ['ITEM_MOD_CRIT_SPELL_RATING_SHORT'] = 2.10,
        ['ITEM_MOD_ATTACK_POWER_SHORT'] = 1.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT'] = 14.00,
        ['ITEM_MOD_CR_SPEED_SHORT_2H'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_MH'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_OH'] = 0.00,
        ['ITEM_MOD_HIT_RATING_SHORT'] = 18.00,
        ['ITEM_MOD_CRIT_RATING_SHORT'] = 10.50,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT_RANGED'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_RANGED'] = 0.00,
        ['ITEM_MOD_RANGED_ATTACK_POWER_SHORT'] = 0.00,
        ['STAT_ARMOR'] = 0.02,
        ['ITEM_MOD_DEFENSE_SKILL_RATING_SHORT'] = 0.25,
        ['ITEM_MOD_DODGE_RATING_SHORT'] = 1.00,
        ['ITEM_MOD_PARRY_RATING_SHORT'] = 2.00,
        ['STAT_SPELLDAMAGE_ARCANE'] = 0.00,
        ['STAT_SPELLDAMAGE_FIRE'] = 0.00,
        ['STAT_SPELLDAMAGE_NATURE'] = 0.00,
        ['STAT_SPELLDAMAGE_FROST'] = 0.00,
        ['STAT_SPELLDAMAGE_SHADOW'] = 0.00,
        ['Axe skill'] = 5.00,
        ['Bow skill'] = 0.00,
        ['Crossbow skill'] = 0.00,
        ['Dagger skill'] = 0.00,
        ['Gun skill'] = 0.00,
        ['Mace skill'] = 0.00,
        ['Sword skill'] = 0.00,
        ['Two handed axe skill'] = 5.00,
        ['Two handed mace skill'] = 5.00,
        ['Two handed sword skill'] = 5.00,
        ['Total'] = 74.62,
    },
    ['Paladin Hardcore'] = {
        ['Title'] = "Paladin Hardcore",
        ['Class'] = "Paladin",
        ['Kind'] = "Hardcore",
        ['ITEM_MOD_STRENGTH_SHORT'] = 2.00,
        ['ITEM_MOD_AGILITY_SHORT'] = 1.10,
        ['ITEM_MOD_INTELLECT_SHORT'] = 0.22,
        ['ITEM_MOD_STAMINA_SHORT'] = 1.00,
        ['ITEM_MOD_SPIRIT_SHORT'] = 0.50,
        ['ITEM_MOD_HEALTH_REGEN_SHORT'] = 0.25,
        ['ITEM_MOD_POWER_REGEN0_SHORT'] = 0.25,
        ['STAT_SPELLDAMAGE'] = 0.09,
        ['ITEM_MOD_SPELL_HEALING_DONE'] = 0.10,
        ['ITEM_MOD_HIT_SPELL_RATING_SHORT'] = 0.13,
        ['ITEM_MOD_CRIT_SPELL_RATING_SHORT'] = 2.10,
        ['ITEM_MOD_ATTACK_POWER_SHORT'] = 1.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT'] = 14.00,
        ['ITEM_MOD_CR_SPEED_SHORT_2H'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_MH'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_OH'] = 0.00,
        ['ITEM_MOD_HIT_RATING_SHORT'] = 18.00,
        ['ITEM_MOD_CRIT_RATING_SHORT'] = 10.50,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT_RANGED'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_RANGED'] = 0.00,
        ['ITEM_MOD_RANGED_ATTACK_POWER_SHORT'] = 0.00,
        ['STAT_ARMOR'] = 0.04,
        ['ITEM_MOD_DEFENSE_SKILL_RATING_SHORT'] = 0.25,
        ['ITEM_MOD_DODGE_RATING_SHORT'] = 2.00,
        ['ITEM_MOD_PARRY_RATING_SHORT'] = 4.00,
        ['STAT_SPELLDAMAGE_ARCANE'] = 0.00,
        ['STAT_SPELLDAMAGE_FIRE'] = 0.00,
        ['STAT_SPELLDAMAGE_NATURE'] = 0.00,
        ['STAT_SPELLDAMAGE_FROST'] = 0.00,
        ['STAT_SPELLDAMAGE_SHADOW'] = 0.00,
        ['Axe skill'] = 5.00,
        ['Bow skill'] = 0.00,
        ['Crossbow skill'] = 0.00,
        ['Dagger skill'] = 0.00,
        ['Gun skill'] = 0.00,
        ['Mace skill'] = 0.00,
        ['Sword skill'] = 0.00,
        ['Two handed axe skill'] = 5.00,
        ['Two handed mace skill'] = 5.00,
        ['Two handed sword skill'] = 5.00,
        ['Total'] = 77.52,
    },
    ['Rogue Speedrun'] = {
        ['Title'] = "Rogue Speedrun",
        ['Class'] = "Rogue",
        ['Kind'] = "Speedrun",
        ['ITEM_MOD_STRENGTH_SHORT'] = 1.00,
        ['ITEM_MOD_AGILITY_SHORT'] = 1.97,
        ['ITEM_MOD_INTELLECT_SHORT'] = 0.05,
        ['ITEM_MOD_STAMINA_SHORT'] = 0.50,
        ['ITEM_MOD_SPIRIT_SHORT'] = 1.00,
        ['ITEM_MOD_HEALTH_REGEN_SHORT'] = 0.50,
        ['ITEM_MOD_POWER_REGEN0_SHORT'] = 0.00,
        ['STAT_SPELLDAMAGE'] = 0.00,
        ['ITEM_MOD_SPELL_HEALING_DONE'] = 0.00,
        ['ITEM_MOD_HIT_SPELL_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_CRIT_SPELL_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_ATTACK_POWER_SHORT'] = 1.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT'] = 14.00,
        ['ITEM_MOD_CR_SPEED_SHORT_2H'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_MH'] = 60.00,
        ['ITEM_MOD_CR_SPEED_SHORT_OH'] = -40.00,
        ['ITEM_MOD_HIT_RATING_SHORT'] = 18.00,
        ['ITEM_MOD_CRIT_RATING_SHORT'] = 10.50,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT_RANGED'] = 1.00,
        ['ITEM_MOD_CR_SPEED_SHORT_RANGED'] = 7.00,
        ['ITEM_MOD_RANGED_ATTACK_POWER_SHORT'] = 0.00,
        ['STAT_ARMOR'] = 0.02,
        ['ITEM_MOD_DEFENSE_SKILL_RATING_SHORT'] = 0.25,
        ['ITEM_MOD_DODGE_RATING_SHORT'] = 1.00,
        ['ITEM_MOD_PARRY_RATING_SHORT'] = 2.00,
        ['STAT_SPELLDAMAGE_ARCANE'] = 0.00,
        ['STAT_SPELLDAMAGE_FIRE'] = 0.00,
        ['STAT_SPELLDAMAGE_NATURE'] = 0.00,
        ['STAT_SPELLDAMAGE_FROST'] = 0.00,
        ['STAT_SPELLDAMAGE_SHADOW'] = 0.00,
        ['Axe skill'] = 0.00,
        ['Bow skill'] = 0.00,
        ['Crossbow skill'] = 0.00,
        ['Dagger skill'] = 5.00,
        ['Gun skill'] = 0.00,
        ['Mace skill'] = 5.00,
        ['Sword skill'] = 5.00,
        ['Two handed axe skill'] = 0.00,
        ['Two handed mace skill'] = 0.00,
        ['Two handed sword skill'] = 0.00,
        ['Total'] = 94.79,
    },
    ['Rogue Hardcore'] = {
        ['Title'] = "Rogue Hardcore",
        ['Class'] = "Rogue",
        ['Kind'] = "Hardcore",
        ['ITEM_MOD_STRENGTH_SHORT'] = 1.00,
        ['ITEM_MOD_AGILITY_SHORT'] = 2.13,
        ['ITEM_MOD_INTELLECT_SHORT'] = 0.05,
        ['ITEM_MOD_STAMINA_SHORT'] = 1.00,
        ['ITEM_MOD_SPIRIT_SHORT'] = 0.50,
        ['ITEM_MOD_HEALTH_REGEN_SHORT'] = 0.25,
        ['ITEM_MOD_POWER_REGEN0_SHORT'] = 0.25,
        ['STAT_SPELLDAMAGE'] = 0.00,
        ['ITEM_MOD_SPELL_HEALING_DONE'] = 0.00,
        ['ITEM_MOD_HIT_SPELL_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_CRIT_SPELL_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_ATTACK_POWER_SHORT'] = 1.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT'] = 14.00,
        ['ITEM_MOD_CR_SPEED_SHORT_2H'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_MH'] = 60.00,
        ['ITEM_MOD_CR_SPEED_SHORT_OH'] = -40.00,
        ['ITEM_MOD_HIT_RATING_SHORT'] = 22.00,
        ['ITEM_MOD_CRIT_RATING_SHORT'] = 10.50,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT_RANGED'] = 1.00,
        ['ITEM_MOD_CR_SPEED_SHORT_RANGED'] = 7.00,
        ['ITEM_MOD_RANGED_ATTACK_POWER_SHORT'] = 0.00,
        ['STAT_ARMOR'] = 0.04,
        ['ITEM_MOD_DEFENSE_SKILL_RATING_SHORT'] = 0.25,
        ['ITEM_MOD_DODGE_RATING_SHORT'] = 2.00,
        ['ITEM_MOD_PARRY_RATING_SHORT'] = 4.00,
        ['STAT_SPELLDAMAGE_ARCANE'] = 0.00,
        ['STAT_SPELLDAMAGE_FIRE'] = 0.00,
        ['STAT_SPELLDAMAGE_NATURE'] = 0.00,
        ['STAT_SPELLDAMAGE_FROST'] = 0.00,
        ['STAT_SPELLDAMAGE_SHADOW'] = 0.00,
        ['Axe skill'] = 0.00,
        ['Bow skill'] = 0.00,
        ['Crossbow skill'] = 0.00,
        ['Dagger skill'] = 5.00,
        ['Gun skill'] = 0.00,
        ['Mace skill'] = 5.00,
        ['Sword skill'] = 5.00,
        ['Two handed axe skill'] = 0.00,
        ['Two handed mace skill'] = 0.00,
        ['Two handed sword skill'] = 0.00,
        ['Total'] = 101.97,
    },
    ['Druid Speedrun'] = {
        ['Title'] = "Druid Speedrun",
        ['Class'] = "Druid",
        ['Kind'] = "Speedrun",
        ['ITEM_MOD_STRENGTH_SHORT'] = 2.00,
        ['ITEM_MOD_AGILITY_SHORT'] = 1.96,
        ['ITEM_MOD_INTELLECT_SHORT'] = 0.35,
        ['ITEM_MOD_STAMINA_SHORT'] = 0.50,
        ['ITEM_MOD_SPIRIT_SHORT'] = 1.00,
        ['ITEM_MOD_HEALTH_REGEN_SHORT'] = 0.50,
        ['ITEM_MOD_POWER_REGEN0_SHORT'] = 0.50,
        ['STAT_SPELLDAMAGE'] = 0.00,
        ['ITEM_MOD_SPELL_HEALING_DONE'] = 0.10,
        ['ITEM_MOD_HIT_SPELL_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_CRIT_SPELL_RATING_SHORT'] = 1.58,
        ['ITEM_MOD_ATTACK_POWER_SHORT'] = 1.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_2H'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_MH'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_OH'] = 0.00,
        ['ITEM_MOD_HIT_RATING_SHORT'] = 18.00,
        ['ITEM_MOD_CRIT_RATING_SHORT'] = 10.50,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT_RANGED'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_RANGED'] = 0.00,
        ['ITEM_MOD_RANGED_ATTACK_POWER_SHORT'] = 0.00,
        ['STAT_ARMOR'] = 0.02,
        ['ITEM_MOD_DEFENSE_SKILL_RATING_SHORT'] = 0.25,
        ['ITEM_MOD_DODGE_RATING_SHORT'] = 1.00,
        ['ITEM_MOD_PARRY_RATING_SHORT'] = 0.00,
        ['STAT_SPELLDAMAGE_ARCANE'] = 0.00,
        ['STAT_SPELLDAMAGE_FIRE'] = 0.00,
        ['STAT_SPELLDAMAGE_NATURE'] = 0.00,
        ['STAT_SPELLDAMAGE_FROST'] = 0.00,
        ['STAT_SPELLDAMAGE_SHADOW'] = 0.00,
        ['Axe skill'] = 0.00,
        ['Bow skill'] = 0.00,
        ['Crossbow skill'] = 0.00,
        ['Dagger skill'] = 0.00,
        ['Gun skill'] = 0.00,
        ['Mace skill'] = 0.00,
        ['Sword skill'] = 0.00,
        ['Two handed axe skill'] = 0.00,
        ['Two handed mace skill'] = 0.00,
        ['Two handed sword skill'] = 0.00,
        ['Total'] = 39.26,
    },
    ['Druid Hardcore'] = {
        ['Title'] = "Druid Hardcore",
        ['Class'] = "Druid",
        ['Kind'] = "Hardcore",
        ['ITEM_MOD_STRENGTH_SHORT'] = 2.00,
        ['ITEM_MOD_AGILITY_SHORT'] = 2.10,
        ['ITEM_MOD_INTELLECT_SHORT'] = 0.65,
        ['ITEM_MOD_STAMINA_SHORT'] = 1.00,
        ['ITEM_MOD_SPIRIT_SHORT'] = 0.90,
        ['ITEM_MOD_HEALTH_REGEN_SHORT'] = 0.25,
        ['ITEM_MOD_POWER_REGEN0_SHORT'] = 0.25,
        ['STAT_SPELLDAMAGE'] = 0.00,
        ['ITEM_MOD_SPELL_HEALING_DONE'] = 0.10,
        ['ITEM_MOD_HIT_SPELL_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_CRIT_SPELL_RATING_SHORT'] = 1.58,
        ['ITEM_MOD_ATTACK_POWER_SHORT'] = 1.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_2H'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_MH'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_OH'] = 0.00,
        ['ITEM_MOD_HIT_RATING_SHORT'] = 18.00,
        ['ITEM_MOD_CRIT_RATING_SHORT'] = 10.50,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT_RANGED'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_RANGED'] = 0.00,
        ['ITEM_MOD_RANGED_ATTACK_POWER_SHORT'] = 0.00,
        ['STAT_ARMOR'] = 0.04,
        ['ITEM_MOD_DEFENSE_SKILL_RATING_SHORT'] = 0.25,
        ['ITEM_MOD_DODGE_RATING_SHORT'] = 2.00,
        ['ITEM_MOD_PARRY_RATING_SHORT'] = 0.00,
        ['STAT_SPELLDAMAGE_ARCANE'] = 0.00,
        ['STAT_SPELLDAMAGE_FIRE'] = 0.00,
        ['STAT_SPELLDAMAGE_NATURE'] = 0.00,
        ['STAT_SPELLDAMAGE_FROST'] = 0.00,
        ['STAT_SPELLDAMAGE_SHADOW'] = 0.00,
        ['Axe skill'] = 0.00,
        ['Bow skill'] = 0.00,
        ['Crossbow skill'] = 0.00,
        ['Dagger skill'] = 0.00,
        ['Gun skill'] = 0.00,
        ['Mace skill'] = 0.00,
        ['Sword skill'] = 0.00,
        ['Two handed axe skill'] = 0.00,
        ['Two handed mace skill'] = 0.00,
        ['Two handed sword skill'] = 0.00,
        ['Total'] = 40.61,
    },
    ['Hunter Speedrun'] = {
        ['Title'] = "Hunter Speedrun",
        ['Class'] = "Hunter",
        ['Kind'] = "Speedrun",
        ['ITEM_MOD_STRENGTH_SHORT'] = 0.20,
        ['ITEM_MOD_AGILITY_SHORT'] = 3.15,
        ['ITEM_MOD_INTELLECT_SHORT'] = 0.15,
        ['ITEM_MOD_STAMINA_SHORT'] = 0.50,
        ['ITEM_MOD_SPIRIT_SHORT'] = 0.75,
        ['ITEM_MOD_HEALTH_REGEN_SHORT'] = 0.50,
        ['ITEM_MOD_POWER_REGEN0_SHORT'] = 0.50,
        ['STAT_SPELLDAMAGE'] = 0.00,
        ['ITEM_MOD_SPELL_HEALING_DONE'] = 0.00,
        ['ITEM_MOD_HIT_SPELL_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_CRIT_SPELL_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_ATTACK_POWER_SHORT'] = 1.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT'] = 3.00,
        ['ITEM_MOD_CR_SPEED_SHORT_2H'] = 50.00,
        ['ITEM_MOD_CR_SPEED_SHORT_MH'] = 50.00,
        ['ITEM_MOD_CR_SPEED_SHORT_OH'] = 0.00,
        ['ITEM_MOD_HIT_RATING_SHORT'] = 18.00,
        ['ITEM_MOD_CRIT_RATING_SHORT'] = 10.50,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT_RANGED'] = 14.00,
        ['ITEM_MOD_CR_SPEED_SHORT_RANGED'] = 100.00,
        ['ITEM_MOD_RANGED_ATTACK_POWER_SHORT'] = 0.80,
        ['STAT_ARMOR'] = 0.02,
        ['ITEM_MOD_DEFENSE_SKILL_RATING_SHORT'] = 0.20,
        ['ITEM_MOD_DODGE_RATING_SHORT'] = 1.00,
        ['ITEM_MOD_PARRY_RATING_SHORT'] = 2.00,
        ['STAT_SPELLDAMAGE_ARCANE'] = 0.00,
        ['STAT_SPELLDAMAGE_FIRE'] = 0.00,
        ['STAT_SPELLDAMAGE_NATURE'] = 0.00,
        ['STAT_SPELLDAMAGE_FROST'] = 0.00,
        ['STAT_SPELLDAMAGE_SHADOW'] = 0.00,
        ['Axe skill'] = 0.00,
        ['Bow skill'] = 4.00,
        ['Crossbow skill'] = 4.00,
        ['Dagger skill'] = 0.00,
        ['Gun skill'] = 4.00,
        ['Mace skill'] = 0.00,
        ['Sword skill'] = 0.00,
        ['Two handed axe skill'] = 1.00,
        ['Two handed mace skill'] = 0.00,
        ['Two handed sword skill'] = 1.00,
        ['Total'] = 270.27,
    },
    ['Hunter Hardcore'] = {
        ['Title'] = "Hunter Hardcore",
        ['Class'] = "Hunter",
        ['Kind'] = "Hardcore",
        ['ITEM_MOD_STRENGTH_SHORT'] = 0.20,
        ['ITEM_MOD_AGILITY_SHORT'] = 3.27,
        ['ITEM_MOD_INTELLECT_SHORT'] = 0.30,
        ['ITEM_MOD_STAMINA_SHORT'] = 1.00,
        ['ITEM_MOD_SPIRIT_SHORT'] = 0.50,
        ['ITEM_MOD_HEALTH_REGEN_SHORT'] = 0.25,
        ['ITEM_MOD_POWER_REGEN0_SHORT'] = 0.25,
        ['STAT_SPELLDAMAGE'] = 0.00,
        ['ITEM_MOD_SPELL_HEALING_DONE'] = 0.00,
        ['ITEM_MOD_HIT_SPELL_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_CRIT_SPELL_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_ATTACK_POWER_SHORT'] = 1.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT'] = 3.00,
        ['ITEM_MOD_CR_SPEED_SHORT_2H'] = 50.00,
        ['ITEM_MOD_CR_SPEED_SHORT_MH'] = 50.00,
        ['ITEM_MOD_CR_SPEED_SHORT_OH'] = 0.00,
        ['ITEM_MOD_HIT_RATING_SHORT'] = 22.00,
        ['ITEM_MOD_CRIT_RATING_SHORT'] = 10.50,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT_RANGED'] = 14.00,
        ['ITEM_MOD_CR_SPEED_SHORT_RANGED'] = 100.00,
        ['ITEM_MOD_RANGED_ATTACK_POWER_SHORT'] = 0.80,
        ['STAT_ARMOR'] = 0.04,
        ['ITEM_MOD_DEFENSE_SKILL_RATING_SHORT'] = 0.20,
        ['ITEM_MOD_DODGE_RATING_SHORT'] = 2.00,
        ['ITEM_MOD_PARRY_RATING_SHORT'] = 4.00,
        ['STAT_SPELLDAMAGE_ARCANE'] = 0.00,
        ['STAT_SPELLDAMAGE_FIRE'] = 0.00,
        ['STAT_SPELLDAMAGE_NATURE'] = 0.00,
        ['STAT_SPELLDAMAGE_FROST'] = 0.00,
        ['STAT_SPELLDAMAGE_SHADOW'] = 0.00,
        ['Axe skill'] = 0.00,
        ['Bow skill'] = 4.00,
        ['Crossbow skill'] = 4.00,
        ['Dagger skill'] = 0.00,
        ['Gun skill'] = 4.00,
        ['Mace skill'] = 0.00,
        ['Sword skill'] = 0.00,
        ['Two handed axe skill'] = 1.00,
        ['Two handed mace skill'] = 0.00,
        ['Two handed sword skill'] = 1.00,
        ['Total'] = 277.31,
    },
    ['Priest Speedrun'] = {
        ['Title'] = "Priest Speedrun",
        ['Class'] = "Priest",
        ['Kind'] = "Speedrun",
        ['ITEM_MOD_STRENGTH_SHORT'] = 0.00,
        ['ITEM_MOD_AGILITY_SHORT'] = 0.09,
        ['ITEM_MOD_INTELLECT_SHORT'] = 0.44,
        ['ITEM_MOD_STAMINA_SHORT'] = 0.50,
        ['ITEM_MOD_SPIRIT_SHORT'] = 2.20,
        ['ITEM_MOD_HEALTH_REGEN_SHORT'] = 0.50,
        ['ITEM_MOD_POWER_REGEN0_SHORT'] = 0.50,
        ['STAT_SPELLDAMAGE'] = 0.70,
        ['ITEM_MOD_SPELL_HEALING_DONE'] = 0.10,
        ['ITEM_MOD_HIT_SPELL_RATING_SHORT'] = 1.05,
        ['ITEM_MOD_CRIT_SPELL_RATING_SHORT'] = 4.20,
        ['ITEM_MOD_ATTACK_POWER_SHORT'] = 0.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_2H'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_MH'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_OH'] = 0.00,
        ['ITEM_MOD_HIT_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_CRIT_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT_RANGED'] = 14.00,
        ['ITEM_MOD_CR_SPEED_SHORT_RANGED'] = 0.00,
        ['ITEM_MOD_RANGED_ATTACK_POWER_SHORT'] = 0.00,
        ['STAT_ARMOR'] = 0.02,
        ['ITEM_MOD_DEFENSE_SKILL_RATING_SHORT'] = 0.20,
        ['ITEM_MOD_DODGE_RATING_SHORT'] = 1.00,
        ['ITEM_MOD_PARRY_RATING_SHORT'] = 0.00,
        ['STAT_SPELLDAMAGE_ARCANE'] = 0.00,
        ['STAT_SPELLDAMAGE_FIRE'] = 0.00,
        ['STAT_SPELLDAMAGE_NATURE'] = 0.00,
        ['STAT_SPELLDAMAGE_FROST'] = 0.00,
        ['STAT_SPELLDAMAGE_SHADOW'] = 0.47,
        ['Axe skill'] = 0.00,
        ['Bow skill'] = 0.00,
        ['Crossbow skill'] = 0.00,
        ['Dagger skill'] = 0.00,
        ['Gun skill'] = 0.00,
        ['Mace skill'] = 0.00,
        ['Sword skill'] = 0.00,
        ['Two handed axe skill'] = 0.00,
        ['Two handed mace skill'] = 0.00,
        ['Two handed sword skill'] = 0.00,
        ['Total'] = 25.96,
    },
    ['Priest Hardcore'] = {
        ['Title'] = "Priest Hardcore",
        ['Class'] = "Priest",
        ['Kind'] = "Hardcore",
        ['ITEM_MOD_STRENGTH_SHORT'] = 0.00,
        ['ITEM_MOD_AGILITY_SHORT'] = 0.22,
        ['ITEM_MOD_INTELLECT_SHORT'] = 0.74,
        ['ITEM_MOD_STAMINA_SHORT'] = 1.00,
        ['ITEM_MOD_SPIRIT_SHORT'] = 2.10,
        ['ITEM_MOD_HEALTH_REGEN_SHORT'] = 0.25,
        ['ITEM_MOD_POWER_REGEN0_SHORT'] = 0.25,
        ['STAT_SPELLDAMAGE'] = 0.70,
        ['ITEM_MOD_SPELL_HEALING_DONE'] = 0.10,
        ['ITEM_MOD_HIT_SPELL_RATING_SHORT'] = 1.05,
        ['ITEM_MOD_CRIT_SPELL_RATING_SHORT'] = 4.20,
        ['ITEM_MOD_ATTACK_POWER_SHORT'] = 0.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_2H'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_MH'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_OH'] = 0.00,
        ['ITEM_MOD_HIT_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_CRIT_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT_RANGED'] = 14.00,
        ['ITEM_MOD_CR_SPEED_SHORT_RANGED'] = 0.00,
        ['ITEM_MOD_RANGED_ATTACK_POWER_SHORT'] = 0.00,
        ['STAT_ARMOR'] = 0.04,
        ['ITEM_MOD_DEFENSE_SKILL_RATING_SHORT'] = 0.20,
        ['ITEM_MOD_DODGE_RATING_SHORT'] = 2.00,
        ['ITEM_MOD_PARRY_RATING_SHORT'] = 0.00,
        ['STAT_SPELLDAMAGE_ARCANE'] = 0.00,
        ['STAT_SPELLDAMAGE_FIRE'] = 0.00,
        ['STAT_SPELLDAMAGE_NATURE'] = 0.00,
        ['STAT_SPELLDAMAGE_FROST'] = 0.00,
        ['STAT_SPELLDAMAGE_SHADOW'] = 0.47,
        ['Axe skill'] = 0.00,
        ['Bow skill'] = 0.00,
        ['Crossbow skill'] = 0.00,
        ['Dagger skill'] = 0.00,
        ['Gun skill'] = 0.00,
        ['Mace skill'] = 0.00,
        ['Sword skill'] = 0.00,
        ['Two handed axe skill'] = 0.00,
        ['Two handed mace skill'] = 0.00,
        ['Two handed sword skill'] = 0.00,
        ['Total'] = 27.32,
    },
    ['Warlock Speedrun'] = {
        ['Title'] = "Warlock Speedrun",
        ['Class'] = "Warlock",
        ['Kind'] = "Speedrun",
        ['ITEM_MOD_STRENGTH_SHORT'] = 0.00,
        ['ITEM_MOD_AGILITY_SHORT'] = 0.09,
        ['ITEM_MOD_INTELLECT_SHORT'] = 0.27,
        ['ITEM_MOD_STAMINA_SHORT'] = 0.50,
        ['ITEM_MOD_SPIRIT_SHORT'] = 0.40,
        ['ITEM_MOD_HEALTH_REGEN_SHORT'] = 0.50,
        ['ITEM_MOD_POWER_REGEN0_SHORT'] = 0.50,
        ['STAT_SPELLDAMAGE'] = 0.88,
        ['ITEM_MOD_SPELL_HEALING_DONE'] = 0.00,
        ['ITEM_MOD_HIT_SPELL_RATING_SHORT'] = 1.31,
        ['ITEM_MOD_CRIT_SPELL_RATING_SHORT'] = 2.10,
        ['ITEM_MOD_ATTACK_POWER_SHORT'] = 0.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_2H'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_MH'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_OH'] = 0.00,
        ['ITEM_MOD_HIT_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_CRIT_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT_RANGED'] = 14.00,
        ['ITEM_MOD_CR_SPEED_SHORT_RANGED'] = 0.00,
        ['ITEM_MOD_RANGED_ATTACK_POWER_SHORT'] = 0.00,
        ['STAT_ARMOR'] = 0.02,
        ['ITEM_MOD_DEFENSE_SKILL_RATING_SHORT'] = 0.20,
        ['ITEM_MOD_DODGE_RATING_SHORT'] = 1.00,
        ['ITEM_MOD_PARRY_RATING_SHORT'] = 0.00,
        ['STAT_SPELLDAMAGE_ARCANE'] = 0.00,
        ['STAT_SPELLDAMAGE_FIRE'] = 0.07,
        ['STAT_SPELLDAMAGE_NATURE'] = 0.00,
        ['STAT_SPELLDAMAGE_FROST'] = 0.00,
        ['STAT_SPELLDAMAGE_SHADOW'] = 0.80,
        ['Axe skill'] = 0.00,
        ['Bow skill'] = 0.00,
        ['Crossbow skill'] = 0.00,
        ['Dagger skill'] = 0.00,
        ['Gun skill'] = 0.00,
        ['Mace skill'] = 0.00,
        ['Sword skill'] = 0.00,
        ['Two handed axe skill'] = 0.00,
        ['Two handed mace skill'] = 0.00,
        ['Two handed sword skill'] = 0.00,
        ['Total'] = 22.64,
    },
    ['Warlock Hardcore'] = {
        ['Title'] = "Warlock Hardcore",
        ['Class'] = "Warlock",
        ['Kind'] = "Hardcore",
        ['ITEM_MOD_STRENGTH_SHORT'] = 0.00,
        ['ITEM_MOD_AGILITY_SHORT'] = 0.22,
        ['ITEM_MOD_INTELLECT_SHORT'] = 0.47,
        ['ITEM_MOD_STAMINA_SHORT'] = 1.00,
        ['ITEM_MOD_SPIRIT_SHORT'] = 0.30,
        ['ITEM_MOD_HEALTH_REGEN_SHORT'] = 0.25,
        ['ITEM_MOD_POWER_REGEN0_SHORT'] = 0.25,
        ['STAT_SPELLDAMAGE'] = 0.88,
        ['ITEM_MOD_SPELL_HEALING_DONE'] = 0.00,
        ['ITEM_MOD_HIT_SPELL_RATING_SHORT'] = 1.31,
        ['ITEM_MOD_CRIT_SPELL_RATING_SHORT'] = 2.10,
        ['ITEM_MOD_ATTACK_POWER_SHORT'] = 0.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_2H'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_MH'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_OH'] = 0.00,
        ['ITEM_MOD_HIT_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_CRIT_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT_RANGED'] = 14.00,
        ['ITEM_MOD_CR_SPEED_SHORT_RANGED'] = 0.00,
        ['ITEM_MOD_RANGED_ATTACK_POWER_SHORT'] = 0.00,
        ['STAT_ARMOR'] = 0.04,
        ['ITEM_MOD_DEFENSE_SKILL_RATING_SHORT'] = 0.20,
        ['ITEM_MOD_DODGE_RATING_SHORT'] = 2.00,
        ['ITEM_MOD_PARRY_RATING_SHORT'] = 0.00,
        ['STAT_SPELLDAMAGE_ARCANE'] = 0.00,
        ['STAT_SPELLDAMAGE_FIRE'] = 0.07,
        ['STAT_SPELLDAMAGE_NATURE'] = 0.00,
        ['STAT_SPELLDAMAGE_FROST'] = 0.00,
        ['STAT_SPELLDAMAGE_SHADOW'] = 0.80,
        ['Axe skill'] = 0.00,
        ['Bow skill'] = 0.00,
        ['Crossbow skill'] = 0.00,
        ['Dagger skill'] = 0.00,
        ['Gun skill'] = 0.00,
        ['Mace skill'] = 0.00,
        ['Sword skill'] = 0.00,
        ['Two handed axe skill'] = 0.00,
        ['Two handed mace skill'] = 0.00,
        ['Two handed sword skill'] = 0.00,
        ['Total'] = 23.89,
    },
    ['Mage Speedrun'] = {
        ['Title'] = "Mage Speedrun",
        ['Class'] = "Mage",
        ['Kind'] = "Speedrun",
        ['ITEM_MOD_STRENGTH_SHORT'] = 0.00,
        ['ITEM_MOD_AGILITY_SHORT'] = 0.09,
        ['ITEM_MOD_INTELLECT_SHORT'] = 1.18,
        ['ITEM_MOD_STAMINA_SHORT'] = 0.50,
        ['ITEM_MOD_SPIRIT_SHORT'] = 0.60,
        ['ITEM_MOD_HEALTH_REGEN_SHORT'] = 0.50,
        ['ITEM_MOD_POWER_REGEN0_SHORT'] = 0.50,
        ['STAT_SPELLDAMAGE'] = 0.88,
        ['ITEM_MOD_SPELL_HEALING_DONE'] = 0.00,
        ['ITEM_MOD_HIT_SPELL_RATING_SHORT'] = 1.31,
        ['ITEM_MOD_CRIT_SPELL_RATING_SHORT'] = 5.25,
        ['ITEM_MOD_ATTACK_POWER_SHORT'] = 0.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_2H'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_MH'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_OH'] = 0.00,
        ['ITEM_MOD_HIT_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_CRIT_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT_RANGED'] = 14.00,
        ['ITEM_MOD_CR_SPEED_SHORT_RANGED'] = 0.00,
        ['ITEM_MOD_RANGED_ATTACK_POWER_SHORT'] = 0.00,
        ['STAT_ARMOR'] = 0.02,
        ['ITEM_MOD_DEFENSE_SKILL_RATING_SHORT'] = 0.20,
        ['ITEM_MOD_DODGE_RATING_SHORT'] = 1.00,
        ['ITEM_MOD_PARRY_RATING_SHORT'] = 0.00,
        ['STAT_SPELLDAMAGE_ARCANE'] = 0.22,
        ['STAT_SPELLDAMAGE_FIRE'] = 0.22,
        ['STAT_SPELLDAMAGE_NATURE'] = 0.00,
        ['STAT_SPELLDAMAGE_FROST'] = 0.44,
        ['STAT_SPELLDAMAGE_SHADOW'] = 0.00,
        ['Axe skill'] = 0.00,
        ['Bow skill'] = 0.00,
        ['Crossbow skill'] = 0.00,
        ['Dagger skill'] = 0.00,
        ['Gun skill'] = 0.00,
        ['Mace skill'] = 0.00,
        ['Sword skill'] = 0.00,
        ['Two handed axe skill'] = 0.00,
        ['Two handed mace skill'] = 0.00,
        ['Two handed sword skill'] = 0.00,
        ['Total'] = 26.89,
    },
    ['Mage Hardcore'] = {
        ['Title'] = "Mage Hardcore",
        ['Class'] = "Mage",
        ['Kind'] = "Hardcore",
        ['ITEM_MOD_STRENGTH_SHORT'] = 0.00,
        ['ITEM_MOD_AGILITY_SHORT'] = 0.22,
        ['ITEM_MOD_INTELLECT_SHORT'] = 1.18,
        ['ITEM_MOD_STAMINA_SHORT'] = 1.00,
        ['ITEM_MOD_SPIRIT_SHORT'] = 0.50,
        ['ITEM_MOD_HEALTH_REGEN_SHORT'] = 0.25,
        ['ITEM_MOD_POWER_REGEN0_SHORT'] = 0.25,
        ['STAT_SPELLDAMAGE'] = 0.88,
        ['ITEM_MOD_SPELL_HEALING_DONE'] = 0.00,
        ['ITEM_MOD_HIT_SPELL_RATING_SHORT'] = 1.31,
        ['ITEM_MOD_CRIT_SPELL_RATING_SHORT'] = 5.25,
        ['ITEM_MOD_ATTACK_POWER_SHORT'] = 0.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_2H'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_MH'] = 0.00,
        ['ITEM_MOD_CR_SPEED_SHORT_OH'] = 0.00,
        ['ITEM_MOD_HIT_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_CRIT_RATING_SHORT'] = 0.00,
        ['ITEM_MOD_DAMAGE_PER_SECOND_SHORT_RANGED'] = 14.00,
        ['ITEM_MOD_CR_SPEED_SHORT_RANGED'] = 0.00,
        ['ITEM_MOD_RANGED_ATTACK_POWER_SHORT'] = 0.00,
        ['STAT_ARMOR'] = 0.04,
        ['ITEM_MOD_DEFENSE_SKILL_RATING_SHORT'] = 0.20,
        ['ITEM_MOD_DODGE_RATING_SHORT'] = 2.00,
        ['ITEM_MOD_PARRY_RATING_SHORT'] = 0.00,
        ['STAT_SPELLDAMAGE_ARCANE'] = 0.22,
        ['STAT_SPELLDAMAGE_FIRE'] = 0.22,
        ['STAT_SPELLDAMAGE_NATURE'] = 0.00,
        ['STAT_SPELLDAMAGE_FROST'] = 0.44,
        ['STAT_SPELLDAMAGE_SHADOW'] = 0.00,
        ['Axe skill'] = 0.00,
        ['Bow skill'] = 0.00,
        ['Crossbow skill'] = 0.00,
        ['Dagger skill'] = 0.00,
        ['Gun skill'] = 0.00,
        ['Mace skill'] = 0.00,
        ['Sword skill'] = 0.00,
        ['Two handed axe skill'] = 0.00,
        ['Two handed mace skill'] = 0.00,
        ['Two handed sword skill'] = 0.00,
        ['Total'] = 27.95,
    },
}

