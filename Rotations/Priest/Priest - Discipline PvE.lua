--------------------------------
-- Priest - Discipline PvE
-- Version - 1.0.0
-- Author - Dreams
--------------------------------
-- Changelog
-- 1.0.0 Initial release
--------------------------------
local ni = ...

local queue = {
    "Inner Fire",
    "Pause Rotation",
    "Pain Suppression",
    "Shadowfiend",
    "Dispel Magic",
    "Renew",
    "Prayer of Mending",
    "Power Word: Shield",
    "Penance",
    "Flash Heal"
}

local abilities = {
    ["Inner Fire"] = function()
        if ni.spell.available("Inner Fire")
        and not ni.unit.buff("player", "Inner Fire") then
            ni.spell.cast("Inner Fire")
        end
    end,

    ["Pause Rotation"] = function()
        if IsMounted()
        or not UnitAffectingCombat("player")
        or UnitIsDeadOrGhost("player") then
            return true;
        end
    end,

    ["Pain Suppression"] = function()
        for i = 1, #ni.members do
            if ni.members[i].hp < 20
            and ni.members[i].range
            and ni.spell.available("Pain Suppression") then
                ni.spell.cast("Pain Suppression", ni.members[i].unit)
            end
        end
    end,

    ["Shadowfiend"] = function()
        if ni.spell.available("Shadowfiend")
        and ni.unit.exists("target")
        and ni.player.power() < 60 then
            ni.spell.cast("Shadowfiend", "target")
        end
    end,

    ["Dispel Magic"] = function()
        for i = 1, #ni.members do
            if ni.members[i].dispel
            and ni.members[i].range
            and ni.spell.available("Dispel Magic") then
                ni.spell.cast("Dispel Magic", ni.members[i].unit)
            end
        end
    end,

    ["Renew"] = function ()
        for i = 1, #ni.members do
            if ni.members[i].istank
            and ni.members[i].range
            and not ni.members[i]:buff("Renew", "player")
            and ni.spell.available("Renew") then
                ni.spell.cast("Renew", ni.members[i].unit)
            end
        end
    end,

    ["Prayer of Mending"] = function ()
        for i = 1, #ni.members do
            if ni.members[i].istank
            and ni.members[i].range
            and not ni.unit.buff(ni.members[i].unit, "Prayer of Mending", "player")
            and ni.spell.available("Prayer of Mending") then
                ni.spell.cast("Prayer of Mending", ni.members[i].unit)
            end
        end
    end,

    ["Power Word: Shield"] = function ()
        for i = 1, #ni.members do
            if ni.members[i].hp > 60
            and ni.members[i].range
            and not ni.unit.debuff(ni.members[i].unit, "Weakened Soul", "player")
            and not ni.unit.buff(ni.members[i].unit, "Power Word: Shield", "player")
            and ni.spell.available("Power Word: Shield") then
                ni.spell.cast("Power Word: Shield", ni.members[i].unit)
            end
        end
    end,

    ["Penance"] = function ()
        for i = 1, #ni.members do
            if ni.members[i].hp < 90
            and ni.members[i].range
            and ni.spell.available("Penance") then
                ni.spell.cast("Penance", ni.members[i].unit)
            end
        end
    end,

    ["Flash Heal"] = function ()
        for i = 1, #ni.members do
            if ni.members[i].hp < 90
            and ni.members[i].range
            and ni.spell.available("Flash Heal") then
                ni.spell.cast("Flash Heal", ni.members[i].unit)
            end
        end
    end
}

ni.bootstrap.rotation("Priest - Discipline PvE", queue, abilities)