-- Thanks to:
-- https://wow.gamepedia.com/API_CombatLogGetCurrentEventInfo

local BOOM_ACTIVE = true
local playerGUID = UnitGUID("player")
local MSG_CRITICAL_HIT = "#YOLO [ %s - %d ]"

-- enableBoom()
function enableBoom()
	-- TODO
end

-- disableBoom()
function disableBoom()
	-- TODO
end

local f = CreateFrame("Frame")
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:SetScript("OnEvent", function(self, event)
	self:OnEvent(event, CombatLogGetCurrentEventInfo())
end)

function f:OnEvent(event, ...)
	local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = ...
	local spellId, spellName, spellSchool
	local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand

	if subevent == "SWING_DAMAGE" then
		amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand = select(12, ...)
	elseif subevent == "SPELL_DAMAGE" then
		spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand = select(12, ...)
	end
	
	if critical and sourceGUID == playerGUID then
		local action = spellId and GetSpellLink(spellId) or "melee swing"
		print(MSG_CRITICAL_HIT:format(action, amount))
		-- Say it:
		-- SendChatMessage(MSG_CRITICAL_HIT:format(action, amount) ,"SAY");
		-- Yell it:
		-- SendChatMessage(MSG_CRITICAL_HIT:format(action, amount) ,"YELL");
	end
end

-- Slash command to toggle Boom
SLASH_BOOMTOGGLE = '/boom';
function SlashCmdList.BOOMTOGGLE(msg, editbox)
	BOOM_ACTIVE = not BOOM_ACTIVE
	if BOOM_ACTIVE then
		-- Call Enable()
	else
		-- Call Disable()
	end
	print("Hello, World! "..BOOM_ACTIVE);
end