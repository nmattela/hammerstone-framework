--- Hammerstone: controller.lua
--- Overridden controller file, used for hooking up lifecycle events to the Hammerstone Mod Loader.
--- All events will be fired in the main thread, using the eventManager
--- @author SirLich

-- Hammerstone
local eventManager = mjrequire "hammerstone/event/eventManager"
local eventTypes = mjrequire "hammerstone/event/eventTypes"
local logger = mjrequire "hammerstone/logging"
local inputManager = mjrequire "hammerstone/input/inputManager"
local utils = mjrequire "hammerstone/utils/utils"

local mod = {
	loadOrder = 999, -- Load after everything, so everything has a chance to initialise
}

function mod:onload(controller)
	logger:log("Loading Hammerstone Mod Framework...")

	-- Setup other Hammerstone Mod Framework stuff
	inputManager:init()

	eventManager:call(eventTypes.init)

	-- Save super
	local superWorldLoaded = controller.worldLoaded
	controller.worldLoaded = function(self, world)
		superWorldLoaded(controller, world) -- Shouldn't this be superWorldLoaded(self, world)?
		eventManager:call(eventTypes.worldLoad)
	end
end

return mod