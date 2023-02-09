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

local ballooncolor5
local lastcolor

-- Add the 'ballooncolor' cvar
CV_RegisterVar({
	name = "ballooncolor",
	defaultvalue = "Red",
	PossibleValue= {
		Red = 1,
		Green = 2,
		Blue = 3
	},
	string = "Red",
	flags = CV_CALL,
	func = function(bcolor)
		lastcolor = R_GetColorByName(bcolor.string)
		ballooncolor5 = lastcolor
	end
})

-- Add the 'balloonadd' command
COM_AddCommand('balloonadd', function(player)
	local object = _G["MT_BALLOON"]
	print(ballooncolor5)

	if player.mo and player.mo.valid then
		player.balloon = P_SpawnMobj(player.mo.x, player.mo.y, player.mo.z, object)
		if ballooncolor5 != nil then
			player.balloon.color = ballooncolor5
		end
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
 --[[ addHook("MobjSpawn", function(mobj) -- mobj is the balloon just spawned
	-- better way to cover colors
	mobj.color = R_GetColorByName(CV_FindVar("ballooncolor").string)
	return true 
 en-d, MT_BALLOON) ]]--

 addHook("NetVars", function(network)
	lastcolor = network($)
 end)
