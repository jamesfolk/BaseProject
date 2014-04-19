
local MAZE = {}
MAZE.__index = MAZE


function MAZE.new(init)
    local self = setmetatable({}, MAZE)
    self.textureIDs = {}
    self.meshIDs = {}
    
    self.textureIDs["bricks"] = jli.TextureFactory_createTextureFromData("bricks")
    self.textureIDs["j"] = jli.TextureFactory_createTextureFromData("j")
    self.textureIDs["spritetest"] = jli.TextureFactory_createTextureFromData("spritetest")
    self.textureIDs["tarsier"] = jli.TextureFactory_createTextureFromData("tarsier")
    self.textureIDs["temp"] = jli.TextureFactory_createTextureFromData("temp")

    self.meshIDs["cone"] = jli.ViewObjectFactory_createViewObject("cone", self.textureIDs["bricks"]);
    self.meshIDs["cube"] = jli.ViewObjectFactory_createViewObject("cube", self.textureIDs["bricks"]);
    self.meshIDs["cylinder"] = jli.ViewObjectFactory_createViewObject("cylinder", self.textureIDs["bricks"]);
    self.meshIDs["icosphere"] = jli.ViewObjectFactory_createViewObject("icosphere", self.textureIDs["bricks"]);
    self.meshIDs["mazeblock"] = jli.ViewObjectFactory_createViewObject("mazeblock", self.textureIDs["bricks"]);
    self.meshIDs["mazeblock2"] = jli.ViewObjectFactory_createViewObject("mazeblock2", self.textureIDs["temp"]);
    self.meshIDs["mazewall"] = jli.ViewObjectFactory_createViewObject("mazewall", self.textureIDs["bricks"]);
    self.meshIDs["plane"] = jli.ViewObjectFactory_createViewObject("plane", self.textureIDs["tarsier"]);
    self.meshIDs["skybox"] = jli.ViewObjectFactory_createViewObject("skybox", self.textureIDs["j"]);
    self.meshIDs["sphere"] = jli.ViewObjectFactory_createViewObject("sphere", self.textureIDs["tarsier"]);
    self.meshIDs["sprite"] = jli.ViewObjectFactory_createViewObject("sprite", self.textureIDs["spritetest"]);

    return self
end

function MAZE.getTextureID(self, name)
    return self.textureIDs[name]
end

function MAZE.getMeshID(self, name)
    return self.meshIDs[name]
end
