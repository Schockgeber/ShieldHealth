local f = CreateFrame("Frame")

local spellName 		= ""
local shieldStatus 		= ""
local shieldMaxHealth 	= 1
local shieldHealth 		= 0
local shieldActive 		= false
local timer 			= false
local soundPlayed 		= false

f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
f:RegisterEvent("PLAYER_REGEN_ENABLED")
f:RegisterEvent("PLAYER_REGEN_DISABLED")

function ShieldHealth_OnLoad(frame)
    frame:RegisterForClicks("RightButtonUp")
    frame:RegisterForDrag("LeftButton")
end

f:SetScript("OnEvent", function(self, event, arg1, arg2, arg3, ...)
	
	self:OnEvent(event, CombatLogGetCurrentEventInfo())
	
	--Rang 1 / spellId = 17 / shieldMaxHealth = 55
	if (event == "UNIT_SPELLCAST_SUCCEEDED" and arg1 == "player" and arg3 == 17) then
		shieldActive 	= true
		spellName 		= "Machtwort: Schild"
		shieldStatus 	= "MW: Schild R1"
		shieldMaxHealth = 55
		shieldHealth 	= shieldMaxHealth
		timer 			= true
		ShieldHealth_UpdateText()
	end		
	
	--Rang 2 / spellId = 592 / shieldMaxHealth = 108
	if (event == "UNIT_SPELLCAST_SUCCEEDED" and arg1 == "player" and arg3 == 592) then
		shieldActive 	= true
		spellName 		= "Machtwort: Schild"
		shieldStatus 	= "MW: Schild R2"
		shieldMaxHealth = 108
		shieldHealth 	= shieldMaxHealth
		timer 			= true
		ShieldHealth_UpdateText()
	end	
	
	--Rang 3 / spellId = 600 / shieldMaxHealth = 190
	if (event == "UNIT_SPELLCAST_SUCCEEDED" and arg1 == "player" and arg3 == 600) then
		shieldActive 	= true
		spellName 		= "Machtwort: Schild"
		shieldStatus 	= "MW: Schild R3"
		shieldMaxHealth = 190
		shieldHealth 	= shieldMaxHealth
		timer 			= true
		ShieldHealth_UpdateText()
	end
	
	--Rang 4 / spellId = 3747 / shieldMaxHealth = 280
	if (event == "UNIT_SPELLCAST_SUCCEEDED" and arg1 == "player" and arg3 == 3747) then
		shieldActive 	= true
		spellName 		= "Machtwort: Schild"
		shieldStatus 	= "MW: Schild R4"
		shieldMaxHealth = 280
		shieldHealth 	= shieldMaxHealth
		timer 			= true
		ShieldHealth_UpdateText()
	end

	--Rang 5 / spellId = 6065 / shieldMaxHealth = 359
	if (event == "UNIT_SPELLCAST_SUCCEEDED" and arg1 == "player" and arg3 == 6065) then
		shieldActive 	= true
		spellName 		= "Machtwort: Schild"
		shieldStatus 	= "MW: Schild R5"
		shieldMaxHealth = 359
		shieldHealth 	= shieldMaxHealth
		timer 			= true
		ShieldHealth_UpdateText()
	end
	
	--Rang 6 / spellId = 6066 / shieldMaxHealth = 438
	if (event == "UNIT_SPELLCAST_SUCCEEDED" and arg1 == "player" and arg3 == 6066) then
		shieldActive 	= true
		spellName 		= "Machtwort: Schild"
		shieldStatus 	= "MW: Schild R6"
		shieldMaxHealth = 438
		shieldHealth 	= shieldMaxHealth
		timer 			= true
		ShieldHealth_UpdateText()
	end
	
	--Rang 7 / spellId = 10898 / shieldMaxHealth = 556
	if (event == "UNIT_SPELLCAST_SUCCEEDED" and arg1 == "player" and arg3 == 10898) then
		shieldActive 	= true
		spellName 		= "Machtwort: Schild"
		shieldStatus 	= "MW: Schild R7"
		shieldMaxHealth = 556
		shieldHealth 	= shieldMaxHealth
		timer 			= true
		ShieldHealth_UpdateText()
	end
	
	--Rang 8 / spellId = 10899 / shieldMaxHealth = 695
	if (event == "UNIT_SPELLCAST_SUCCEEDED" and arg1 == "player" and arg3 == 10899) then
		shieldActive 	= true
		spellName 		= "Machtwort: Schild"
		shieldStatus 	= "MW: Schild R8"
		shieldMaxHealth = 695
		shieldHealth 	= shieldMaxHealth
		timer 			= true
		ShieldHealth_UpdateText()
	end	
	
	--Rang 9 / spellId = 10900 / shieldMaxHealth = 877
	if (event == "UNIT_SPELLCAST_SUCCEEDED" and arg1 == "player" and arg3 == 10900) then
		shieldActive 	= true
		spellName 		= "Machtwort: Schild"
		shieldStatus 	= "MW: Schild R9"
		shieldMaxHealth = 877
		shieldHealth 	= shieldMaxHealth
		timer 			= true
		ShieldHealth_UpdateText()
	end		
	
	--Rang 10 / spellId = 10901 / shieldMaxHealth = 1083
	if (event == "UNIT_SPELLCAST_SUCCEEDED" and arg1 == "player" and arg3 == 10901) then
		shieldActive 	= true
		spellName 		= "Machtwort: Schild"
		shieldStatus 	= "MW: Schild R10"
		shieldMaxHealth = 1083
		shieldHealth 	= shieldMaxHealth
		timer 			= true
		ShieldHealth_UpdateText()
	end		
end)

function f:OnEvent(event, ...)
	
	local timestamp, subevent = ...
	local amount 					= select(19, ...)
	local spellAbsorbedName 		= select(17, ...)
	local spellAbsorbedNameSpell 	= select(20, ...)
	local spellAuraRemovedName 		= select(13, ...)
	local soulDebuff = false

	if subevent == "SPELL_ABSORBED" and spellAbsorbedName == spellName then
		shieldHealth = shieldHealth - amount
		
		else if subevent == "SPELL_ABSORBED" and spellAbsorbedNameSpell == spellName then
			amount = select(22, ...)
			shieldHealth = shieldHealth - amount
		end
		
		ShieldHealth_UpdateText()
	end
	
	if shieldHealth <= 0 then
		shieldActive = false
		shieldHealth = 0
		ShieldHealthDebuff_UpdateText()
	end
	
	if subevent == "SPELL_AURA_REMOVED" and spellAuraRemovedName == spellName then
		shieldActive = false
		shieldHealth = 0
		ShieldHealthDebuff_UpdateText()
	end
	
end

function ShieldHealth_UpdateText()
	
	local greenFontColor 	= "|cff32cd32"
	local yellowFontColor 	= "|cffffcc00"
	local orangeFontColor 	= "|cffff6600"
	local redFontColor		= "|cffff0000"
	
	--grün 90% oder mehr
	if shieldHealth >= shieldMaxHealth*0.99 then
		local status = string.format("|cffd9d9d9%s\n|r |cff32cd32%d/%d\n%d%%\n==========", shieldStatus, shieldHealth, shieldMaxHealth, (shieldHealth/shieldMaxHealth)*100)
		ShieldHealthFrameText:SetText(status)
	end
	
	--grün 90% oder mehr
	if shieldHealth <= shieldMaxHealth*0.99 and shieldHealth >= shieldMaxHealth*0.9 then
		local status = string.format("|cffd9d9d9%s\n|r |cff32cd32%d/%d\n%d%%\n=========", shieldStatus, shieldHealth, shieldMaxHealth, (shieldHealth/shieldMaxHealth)*100)
		ShieldHealthFrameText:SetText(status)
	end
	
	--grün 90% oder mehr
	if shieldHealth <= shieldMaxHealth*0.89 and shieldHealth >= shieldMaxHealth*0.8 then
		local status = string.format("|cffd9d9d9%s\n|r |cff32cd32%d/%d\n%d%%\n========", shieldStatus, shieldHealth, shieldMaxHealth, (shieldHealth/shieldMaxHealth)*100)
		ShieldHealthFrameText:SetText(status)
	end
	--gelb 79% bis 50%
	if shieldHealth <= shieldMaxHealth*0.79 and shieldHealth >= shieldMaxHealth*0.7 then
		local status = string.format("|cffd9d9d9%s\n|r |cffffcc00%d/%d\n%d%%\n=======", shieldStatus, shieldHealth, shieldMaxHealth, (shieldHealth/shieldMaxHealth)*100)
		ShieldHealthFrameText:SetText(status)
	end
	--gelb 79% bis 50%
	if shieldHealth <= shieldMaxHealth*0.69 and shieldHealth >= shieldMaxHealth*0.6 then
		local status = string.format("|cffd9d9d9%s\n|r |cffffcc00%d/%d\n%d%%\n======", shieldStatus, shieldHealth, shieldMaxHealth, (shieldHealth/shieldMaxHealth)*100)
		ShieldHealthFrameText:SetText(status)
	end
	
	--gelb 79% bis 50%
	if shieldHealth <= shieldMaxHealth*0.59 and shieldHealth >= shieldMaxHealth*0.5 then 
		local status = string.format("|cffd9d9d9%s\n|r |cffffcc00%d/%d\n%d%%\n=====", shieldStatus, shieldHealth, shieldMaxHealth, (shieldHealth/shieldMaxHealth)*100)
		ShieldHealthFrameText:SetText(status)
	end 
	
	--orange 49% bis 30%
	if shieldHealth <= shieldMaxHealth*0.49 and shieldHealth >= shieldMaxHealth*0.4 then 
		local status = string.format("|cffd9d9d9%s\n|r |cffff6600%d/%d\n%d%%\n====", shieldStatus, shieldHealth, shieldMaxHealth, (shieldHealth/shieldMaxHealth)*100)
		ShieldHealthFrameText:SetText(status)
	end
	
	--orange 49% bis 30%
	if shieldHealth <= shieldMaxHealth*0.39 and shieldHealth >= shieldMaxHealth*0.3 then 
		local status = string.format("|cffd9d9d9%s\n|r |cffff6600%d/%d\n%d%%\n===", shieldStatus, shieldHealth, shieldMaxHealth, (shieldHealth/shieldMaxHealth)*100)
		ShieldHealthFrameText:SetText(status)
	end
	
	--rot 29% oder weniger
	if shieldHealth <= shieldMaxHealth*0.29 and shieldHealth >= shieldMaxHealth*0.2 then 
		local status = string.format("|cffd9d9d9%s\n|r |cffff0000%d/%d\n%d%%\n==", shieldStatus, shieldHealth, shieldMaxHealth, (shieldHealth/shieldMaxHealth)*100)
		ShieldHealthFrameText:SetText(status)
	end
	
	if shieldHealth <= shieldMaxHealth*0.19 then  
		local status = string.format("|cffd9d9d9%s\n|r |cffff0000%d/%d\n%d%%\n=", shieldStatus, shieldHealth, shieldMaxHealth, (shieldHealth/shieldMaxHealth)*100)
		ShieldHealthFrameText:SetText(status)
	end
	
end

function ShieldHealthDebuff_UpdateText()
    local status = string.format("|cff999999Schild\ninaktiv")
    ShieldHealthFrameText:SetText(status)
end

--erweitertes eventtracing /etrace
if not EventTraceFrame then
	UIParentLoadAddOn("Blizzard_DebugTools")
end

local function addArgs(args, index, ...)
	for i = 1, select("#", ...) do
		if not args[i] then
			args[i] = {}
		end
		args[i][index] = select(i, ...)
	end
end
 
EventTraceFrame:HookScript("OnEvent", function(self, event)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" and not self.ignoredEvents[event] and self.events[self.lastIndex] == event then
		addArgs(self.args, self.lastIndex, CombatLogGetCurrentEventInfo())
	end
end)
