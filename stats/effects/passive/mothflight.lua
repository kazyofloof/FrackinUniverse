function init()
end

function daytimeCheck()
	return world.timeOfDay() < 0.5 -- true if daytime
end

function undergroundCheck()
	return world.underground(mcontroller.position())
end

function getLight()
	local position = mcontroller.position()
	position[1] = math.floor(position[1])
	position[2] = math.floor(position[2])
	local lightLevel = math.min(world.lightLevel(position),1.0)
	lightLevel = math.floor(lightLevel * 100)
	return lightLevel
end

function update(dt)
	daytime = daytimeCheck()
	underground = undergroundCheck()
	local lightLevel = getLight()

	if (not daytime and (lightLevel <= 60)) or underground then --if its dark or underground, a saturnian can regen their food if its dark enough
		if status.isResource("food") then
			local adjustedHunger = (0.0075*dt)
			status.modifyResourcePercentage("food",adjustedHunger)
		end
	end
	if not daytime and lightLevel >= 60 then --if its night and they are in bright light, a saturnian can regen their food
		if status.isResource("food") then
			local adjustedHunger = (lightLevel * 0.007*dt)
			status.modifyResourcePercentage("food",adjustedHunger)
		end
	end
end

function uninit()

end