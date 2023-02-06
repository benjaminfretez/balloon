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


-- Add the 'ballooncolor' cvar
CV_RegisterVar({
	name = "ballooncolor",
	defaultvalue = "Red",
	PossibleValue= {
		Red = 1,
		Green = 2,
		Blue = 3
	},
	string = "Red"
})

-- Add the 'balloonadd' command
COM_AddCommand('balloonadd', function(player)
	local object = _G["MT_BALLOON"]
	
	if player.mo and player.mo.valid then
		local balloon = P_SpawnMobj(player.mo.x, player.mo.y, player.mo.z, object)
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

-- Add Hook for do things when the balloon spawns
--[[ use the return value of P_SpawnMobj in a
 	variable and put it here as the function
 	argument because it returns mobj_t and we 
 	need that as an argument of the function 
 	for the MobjSpawn hook... 
	
	When I connect in netgames the balloons are seen in the color predefined.
	I don;t like that
 ]]
 addHook("MobjSpawn", function(mobj)
	if CV_FindVar("ballooncolor").string == "Green" then
		mobj.color = SKINCOLOR_GREEN
	elseif CV_FindVar("ballooncolor").string == "Blue" then
		mobj.color = SKINCOLOR_BLUE
	else -- Default is red
		mobj.color = SKINCOLOR_RED
	end
	return true
 end, MT_BALLOON)
