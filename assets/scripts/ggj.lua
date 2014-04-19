
local GGJ = {}
GGJ.__index = GGJ


function GGJ.new(init)
    local self = setmetatable({}, GGJ)
    self.textureIDs = {}
    self.meshIDs = {}
    
    self.textureIDs["conetexture1"] = jli.TextureFactory_createTextureFromData("conetexture1")
    self.textureIDs["cubetexture1"] = jli.TextureFactory_createTextureFromData("cubetexture1")
    self.textureIDs["floor"] = jli.TextureFactory_createTextureFromData("floor")
    self.textureIDs["spheretexture"] = jli.TextureFactory_createTextureFromData("spheretexture")
    self.textureIDs["walltexture"] = jli.TextureFactory_createTextureFromData("walltexture")

    self.meshIDs["cube"] = jli.ViewObjectFactory_createViewObject("cube", self.textureIDs["cubetexture1"]);
    self.meshIDs["planeobject"] = jli.ViewObjectFactory_createViewObject("planeobject", self.textureIDs["floor"]);
    self.meshIDs["raycone"] = jli.ViewObjectFactory_createViewObject("raycone", self.textureIDs["conetexture1"]);
    self.meshIDs["skybox"] = jli.ViewObjectFactory_createViewObject("skybox", self.textureIDs["walltexture"]);
    self.meshIDs["sphere"] = jli.ViewObjectFactory_createViewObject("sphere", self.textureIDs["spheretexture"]);

    return self
end

function GGJ.getTextureID(self, name)
    return self.textureIDs[name]
end

function GGJ.getMeshID(self, name)
    return self.meshIDs[name]
end

-- Start cube Collision Response Functions -----------------------------------------------
function cubeCollisionResponse(currentEntity, otherEntity, point)
	print("cubeCollisionResponse")
	local cr = currentEntity:getCollisionResponseBehavior()
	print("collide " .. currentEntity:getName())
end
-- End   cube Collision Response Functions -----------------------------------------------

-- Start planeobject Collision Response Functions -----------------------------------------------
function planeobjectCollisionResponse(currentEntity, otherEntity, point)
	print("planeobjectCollisionResponse")
	local cr = currentEntity:getCollisionResponseBehavior()
	print("collide " .. currentEntity:getName())
end
-- End   planeobject Collision Response Functions -----------------------------------------------

-- Start raycone Collision Response Functions -----------------------------------------------
function rayconeCollisionResponse(currentEntity, otherEntity, point)
	print("rayconeCollisionResponse")
	local cr = currentEntity:getCollisionResponseBehavior()
	print("collide " .. currentEntity:getName())
end
-- End   raycone Collision Response Functions -----------------------------------------------

-- Start skybox Collision Response Functions -----------------------------------------------
function skyboxCollisionResponse(currentEntity, otherEntity, point)
	print("skyboxCollisionResponse")
	local cr = currentEntity:getCollisionResponseBehavior()
	print("collide " .. currentEntity:getName())
end
-- End   skybox Collision Response Functions -----------------------------------------------

-- Start sphere Collision Response Functions -----------------------------------------------
function sphereCollisionResponse(currentEntity, otherEntity, point)
	print("sphereCollisionResponse")
	local cr = currentEntity:getCollisionResponseBehavior()
	print("collide " .. currentEntity:getName())
end
-- End   sphere Collision Response Functions -----------------------------------------------

-- Start cube State Functions -----------------------------------------------
function cubeEnterState(currentEntity)
	print("cubeEnterState")
end
function cubeUpdateState(currentEntity, deltaTimeStep)
	print("cubeUpdateState")
end
function cubeExitState(currentEntity)
	print("cubeExitState")
end
function cubeOnMessage(currentEntity, telegram)
	print("cubeOnMessage")
end
-- End   cube State Functions -----------------------------------------------

-- Start planeobject State Functions -----------------------------------------------
function planeobjectEnterState(currentEntity)
	print("planeobjectEnterState")
end
function planeobjectUpdateState(currentEntity, deltaTimeStep)
	print("planeobjectUpdateState")
end
function planeobjectExitState(currentEntity)
	print("planeobjectExitState")
end
function planeobjectOnMessage(currentEntity, telegram)
	print("planeobjectOnMessage")
end
-- End   planeobject State Functions -----------------------------------------------

-- Start raycone State Functions -----------------------------------------------
function rayconeEnterState(currentEntity)
	print("rayconeEnterState")
end
function rayconeUpdateState(currentEntity, deltaTimeStep)
	print("rayconeUpdateState")
end
function rayconeExitState(currentEntity)
	print("rayconeExitState")
end
function rayconeOnMessage(currentEntity, telegram)
	print("rayconeOnMessage")
end
-- End   raycone State Functions -----------------------------------------------

-- Start skybox State Functions -----------------------------------------------
function skyboxEnterState(currentEntity)
	print("skyboxEnterState")
end
function skyboxUpdateState(currentEntity, deltaTimeStep)
	print("skyboxUpdateState")
end
function skyboxExitState(currentEntity)
	print("skyboxExitState")
end
function skyboxOnMessage(currentEntity, telegram)
	print("skyboxOnMessage")
end
-- End   skybox State Functions -----------------------------------------------

-- Start sphere State Functions -----------------------------------------------
function sphereEnterState(currentEntity)
	print("sphereEnterState")
end
function sphereUpdateState(currentEntity, deltaTimeStep)
	print("sphereUpdateState")
end
function sphereExitState(currentEntity)
	print("sphereExitState")
end
function sphereOnMessage(currentEntity, telegram)
	print("sphereOnMessage")
end
-- End   sphere State Functions -----------------------------------------------
