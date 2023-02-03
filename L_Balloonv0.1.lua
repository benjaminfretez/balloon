--[[
    author: b3njamin (benjaminfretez in github)
    desc: balloon
    date: 02/03/2023
]]


-- Add the 'balloondebug' cvar
CV_RegisterVar({
	name = "balloondebug",
	defaultvalue= "Off",
	PossibleValue= CV_OnOff,
	string = "Off"
})

-- Add the 'balloonadd' command
COM_AddCommand('balloonadd', function(player)
	local object = _G[string.upper("mt_balloon")]
	
	if player.mo and player.mo.valid then
		P_SpawnMobj(player.mo.x, player.mo.y, player.mo.z, object)
		if CV_FindVar("balloondebug").string == "On" then
			CONS_Printf(player, "Úballoon spawned")
			CONS_Printf(player, player.mo.x/FRACUNIT, player.mo.y/FRACUNIT, player.mo.z/FRACUNIT)
		end
	end	
end)

-- Add the Hook for trigger that command

addHook("KeyDown", function(keyevent_t)	
	if keyevent_t.num == input.keyNameToNum("q") then
		-- balloon spawned
		COM_BufInsertText(player, "balloonadd")
		return true
	end
	return false
end)
