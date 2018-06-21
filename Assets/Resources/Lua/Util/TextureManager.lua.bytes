_G.TextureManager = {}

--[Comment]
--设置texture的表
--{id:{texture}}
local setTextureTable = {}
local cacheTextureTable = {}
local loadingTextureTable = {}
local textureLoadIndexTable = {}
local textureResIDTable = {}

--[Comment]
--主界面的Id, uitexture要设置资源的texture, resId资源id
--设置texture的resId
function TextureManager:SetTexture(uiId, uiTexture, resId)
    local list = setTextureTable[uiId];
    if(list == nil) then
        list = {};
        setTextureTable[uiId] = list;
    end

    local loadingList = loadingTextureTable[uiId];
    if(loadingList == nil) then
        loadingList = {};
        loadingTextureTable[uiId] = loadingList;
    end

    if(IsNil(uiTexture)) then
        Log:Error("TextureManager:SetTextureRes,uiTexture=nil");
        return;
    end

    --设置texture对应的resId
    local t2idTable = textureResIDTable[uiId];
    if(t2idTable == nil) then
        t2idTable = {};
        textureResIDTable[uiId] = t2idTable;
    end
    t2idTable[uiTexture] = resId;

    if(cacheTextureTable[uiId] ~= nil) then
        local texture = cacheTextureTable[uiId][resId];
        if(not IsNil(texture)) then
            uiTexture.mainTexture = texture;
            return;
        end
    end

    --置空
    uiTexture.mainTexture = nil;
    uiTexture:MarkAsChanged();

    local loadingIndex = loadingList[resId];
    if(loadingIndex ~= nil) then
        local isExist = false;
        for i,v in ipairs(list) do
           if(v.texture == uiTexture) then
                --更换加载资源
                v.resId = resId;
                v.loadIndex = loadingIndex;
                isExist = true;
                break;
           end 
        end
        if(not isExist) then
            local newData = {};
            newData.texture = uiTexture;
            newData.loadIndex = loadingIndex;
            newData.resId = resId;
            list[#list+1] = newData;
        end
        return;
    end

    for i,v in ipairs(list) do
       if(v.texture == uiTexture) then
            if(v.resId ~= resId) then
                --更换加载资源
                v.resId = resId;
                v.loadIndex = ResourceManager:LoadAync(resId, self, {uiId = uiId, resId = resId});
                textureLoadIndexTable[v.loadIndex] = true;
                loadingList[resId] = v.loadIndex;
            end
            return;
       end 
    end
    local newData = {};
    newData.texture = uiTexture;
    newData.loadIndex = ResourceManager:LoadAync(resId, self, {uiId = uiId, resId = resId});
    newData.resId = resId;
    list[#list+1] = newData;
    loadingList[resId] = newData.loadIndex;
    textureLoadIndexTable[newData.loadIndex] = true;
end

function TextureManager:ClearId(uiId)
    Log:Info("清除缓存Texture", uiId);
    setTextureTable[uiId] = nil;
    loadingTextureTable[uiId] = nil;
    textureResIDTable[uiId] = nil;
    if(cacheTextureTable ~= nil) then
        if(cacheTextureTable[uiId] ~= nil) then
            for k,v in pairs(cacheTextureTable[uiId]) do
                if(not IsNil(v)) then
                    ResourceManager:DestroyResource(v);
                else
                    Log:Error("销毁缓存Texture目标为空, uiId = " .. uiId .. ", resId = " .. k);
                end
            end
        end
        cacheTextureTable[uiId] = nil;
    end
end

function TextureManager:OnResourceLoaded(index, id, res, data)
    if(textureLoadIndexTable[index] == nil) then
        return;
    end
    textureLoadIndexTable[index]  = nil;
    if(data == nil) then
        return;
    end
    local list = setTextureTable[data.uiId];
    if(list == nil) then
        return;
    end
    if(res == nil) then
        return;
    end

    if(IsNil(res)) then
        return;
    end

    local loadingList = loadingTextureTable[data.uiId];
    if(loadingList ~= nil) then
        loadingList[data.resId] = nil;
    end
    

    if(cacheTextureTable[data.uiId] == nil) then
        cacheTextureTable[data.uiId] = {};
    end

    cacheTextureTable[data.uiId][data.resId] = res;

    local t2idTable = textureResIDTable[data.uiId];
    local t2Id = -1;
    for i,v in ipairs(list) do
       if(v.loadIndex == index) then
            if(not IsNil(v.texture)) then
                if(t2idTable ~= nil) then
                    t2Id = t2idTable[v.texture];
                end
                if(data.resId == t2Id) then
                    v.texture.mainTexture = res;
                end
            end
       end 
    end
end