ResourceManager = {};
local loadingResourceTable = {};

function ResourceManager:Load(id)
    
end

function ResourceManager:Instantiate(id, isActive)

end

function ResourceManager:LoadPath(path)
    return ResourceManager_Lua.Instance:Load(-1, path);
end

--[Comment]
--异步加载一个资源
function ResourceManager:LoadAync(id, obj, data)
    local index = ResourceManager_Lua.Instance:LoadAync(id, UIRes[id].path);
    loadingResourceTable[index] = {id = id, obj = obj, data = data};
    return index;
end

--[Comment]
--异步实例化一个资源
function ResourceManager:InstantiateAsync(id, obj, isActive, data)
    local index = ResourceManager_Lua.Instance:InstantiateAsync(id, UIRes[id].path);
    loadingResourceTable[index] = {id = id, obj = obj, data = data};
    return index;
end

--资源加载完毕
function ResourceManager:OnResourceLoaded(index, res)
    local t = loadingResourceTable[index];
    if(t == nil) then
        Log:Info("没有注册资源的回调!", obj);
        return;
    end

    --注册回调的表
    local obj = t["obj"];
    if(obj == nil) then
        return;
    end

    --增加判断 如果资源没有加载回来 LogError 并返回
    if(res == nil) then
        Log:Info("资源加载失败！id=" .. t.id);
        loadingResourceTable[index] = nil;
        return;
    end

    if(obj.OnResourceLoaded == nil) then
        Log:Info("注册资源回调的表没有OnResourceLoaded方法");
    end
    loadingResourceTable[index] = nil;
    obj:OnResourceLoaded(index, t.id, res, t.data);
end

--[Comment]
--销毁资源
function ResourceManager:DestroyResource(obj)
    UnityEngine.GameObject.Destroy(obj);
end