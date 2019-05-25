--[[
    Copyright 2019 Teverse
    @File scale.lua
    @Author(s) Jay
--]]

TOOL_NAME = "Scale"
TOOL_ICON = "fa:s-expand-arrows-alt"
TOOL_DESCRIPTION = "Use this to resize primitives."

local selectionController = require("tevgit:create/controllers/select.lua")
local toolsController = require("tevgit:create/controllers/tool.lua")

local function onToolActivated(toolId)
    local gridGuideline = engine.construct("block", workspace, {
		size = vector3(0,0,0),
		colour = colour(1,1,1),
		opacity = 0,
		workshopLocked = true,
		castsShadows = false
	})
	
	toolsController.tools[toolId].data.gridGuideline = gridGuideline
    for i = 1,6 do
		local component = components[c]
		local face = vector3(0,0,0)
		face[component] = o == 0 and o-1 or o
		
		local handle = engine.construct("block", nil, {
			name = "_ScaleMode_",
			castsShadows = false,
			opacity = 0,
			size = vector3(0.1, 0.1, 0.1),
			colour = colour(c==1 and 1 or 0, c==2 and 1 or 0, c==3 and 1 or 0),
			emissiveColour = colour(c==1 and .5 or 0, c==2 and .5 or 0, c==3 and .5 or 0), 
			workshopLocked = true
		})
    end
    updateHandles = function()
		if selectionController.boundingBox.size == vector3(0,0,0) then
			for _,v in pairs(toolsController.tools[toolId].data.handles) do
				v[1].size = vector3(0,0,0)
				v[1].opacity = 0
			end
		else
			for _,v in pairs(toolsController.tools[toolId].data.handles) do
				v[1].position = selectionController.boundingBox.position + selectionController.boundingBox.rotation* ((v[2] * selectionController.boundingBox.size/2) + (v[2]*1.5)) 
				v[1]:lookAt(selectionController.boundingBox.position)
				v[1].size = vector3(0.1, 0.1, 0.25)
				v[1].opacity = 1
			end
		end
	end
    while wait() do
       updateHandles()
       wait()
    end
end

local function onToolDeactviated(toolId)
  
end

return toolsController:register({
    
    name = TOOL_NAME,
    icon = TOOL_ICON,
    description = TOOL_DESCRIPTION,

    activated = onToolActivated,
    deactivated = onToolDeactviated

})
