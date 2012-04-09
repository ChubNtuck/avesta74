function onUse(cid, item, frompos, item2, topos)
	if(topos.x == 0 and topos.y == 0 and topos.z == 0) then
		doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTPOSSIBLE)
		return FALSE
	end 
	
	topos.stackpos = 255
	local tmp = getThingfromPos(topos)
	if (tmp.itemid ~= 0) then
		return FALSE
	end
	
	newPos = {x = topos.x, y = topos.y, z = topos.z, stackpos = 0}
	groundItem = getThingfromPos(newPos)
	if (isInArray(ROPE_SPOT, groundItem.itemid) == TRUE) then
		newPos.y = newPos.y + 1
		newPos.z = newPos.z - 1
		doTeleportThing(cid, newPos)
	elseif (isInArray(OPENED_HOLE, groundItem.itemid) == TRUE or isInArray(OPENED_TRAP, groundItem.itemid) == TRUE or isInArray(DOWN_LADDER, groundItem.itemid) == TRUE) then
		newPos.y = newPos.y + 1
		downPos = {x = topos.x, y = topos.y, z = topos.z + 1, stackpos = 255}
		downItem = getThingfromPos(downPos)
		if (downItem.itemid > 0) then
			doTeleportThing(downItem.uid, newPos)
		else
			doPlayerSendCancel(cid, RETURNVALUE_NOTPOSSIBLE)
		end
	else
		return FALSE
	end
	
	return TRUE
end