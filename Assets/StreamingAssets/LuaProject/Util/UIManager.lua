UIManager = {};

--[Comment]
--UI分层的实际父节点
UIManager.Layer = {
base = nil,
pop = nil,
tip = nil
}

--[Comment]
--UI面板分层存储池
--{ui = ui, uiPath = uiPath, mask = mask}
UIManager.Pool = {
base = {},
pop = {},
tip = {}
}

UIFunction = {
OnStart = "OnStart";
OnDestroy = "OnDestroy";
OnShow = "OnShow";
OnHide = "OnHide";
OnUpdate = "OnUpdate";
}

--[Comment]
--正在加载的资源列表
--异步index - uiPath
local LoadingUITable = {};

--[Comment]
--UIManager初始化
function UIManager:Init()
    local luaRoot = LuaRoot.Instance;
    UIManager.Layer.base = luaRoot.LayerList[0];
    UIManager.Layer.pop = luaRoot.LayerList[1];
    UIManager.Layer.tip = luaRoot.LayerList[2];
end

--[Comment]
--获取UI对应的层级
function UIManager:GetUIParent(uiPath)
    if(uiPath.layer == UILayer.Base) then
        return UIManager.Layer.base;
    elseif(uiPath.layer == UILayer.Pop) then
        return UIManager.Layer.pop;
    elseif(uiPath.layer == UILayer.Tip) then
        return UIManager.Layer.tip;
    end
end

--[Comment]
--获取UI对应的存储池
function UIManager:GetUIPool(uiPath)
    if(uiPath.layer == UILayer.Base) then
        return UIManager.Pool.base;
    elseif(uiPath.layer == UILayer.Pop) then
        return UIManager.Pool.pop;
    elseif(uiPath.layer == UILayer.Tip) then
        return UIManager.Pool.tip;
    end
end

--[Comment]
--基于配置获取UI
function UIManager:GetUI(uiPath)
    local parent = self:GetUIPool(uiPath);
    if(parent == nil) then
        return nil;
    end
    return parent[uiPath].ui;
end

--[Comment]
--基于配置获取UIScript
function UIManager:GetUIScript(uiPath)
    local ui = self:GetUI(uiPath);
    if(ui == nil) then
        return nil;
    end
    return ui:GetComponent("UIScript");
end

--[Comment]
--调用某个UI的某个方法
function UIManager:CallUIFunction(uiPath, funcName)
    if(uiPath == nil or funcName == nil) then
        return;
    end
    local tName = uiPath.uiName;
    if(tName == nil) then
        return;
    end
    local t = _G[tName];
    if(t == nil) then
        return;
    end
    if(t[funcName] == nil) then
        return;
    end
    t[funcName](t);
end

--[Comment]
--打开UI
function UIManager:OpenUI(uiPath)
    --是否正在加载
    if(self:IsUILoading(uiPath)) then
        return;
    end
    --是否已打开
    if(self:IsUIOpen(uiPath)) then
        return;
    end
    local index = ResourceManager:InstantiateAsync(uiPath.res, self, false, uiPath);
    LoadingUITable[uiPath] = index;
end

--[Comment]
--资源回调
function UIManager:OnResourceLoaded(index, id, res, data)
    LoadingUITable[data] = nil;
    self:OpenUIWithRes(data, res);
end

--[Comment]
--实际打开的处理
function UIManager:OpenUIWithRes(uiPath, res)
    local pool = self:GetUIPool(uiPath);
    local uiData = {};
    uiData.ui = res;
    uiData.uiPath = uiPath;
    pool[uiPath] = uiData;
    local parent = self:GetUIParent(uiPath);
    self:SetParent(parent, res);
    res:SetActive(true);
    --首次调用Start方法
    self:CallUIFunction(uiPath, UIFunction.OnStart);
    --同时调用OnShow方法
    self:CallUIFunction(uiPath, UIFunction.OnShow);
end

--[Comment]
--设置父节点
function UIManager:SetParent(parentObj, childObj)
    if(parentObj == nil or childObj == nil) then
        return;
    end
    local childT = childObj.transform;
    local parentT = parentObj.transform;
    childT.parent = parentT;
    childT.localPosition = Vector3.zero;
    childT.localRotation = Quaternion.identity;
    childT.localScale = Vector3.one;
end

--[Comment]
--关闭UI
function UIManager:CloseUI(uiPath)
    if(not self:IsUIOpen(uiPath)) then
        return;
    end
    local pool = self:GetUIPool(uiPath);
    --TODO：处理mask

    --处理BaseUI

    local uiTable = _G[uiPath.uiName]
    if(uiTable ~= nil) then
        if(uiTable.OnDestroy ~= nil) then
            uiTable:OnDestroy();
        end
    end

    --销毁资源
    ResourceManager:DestroyResource(pool[uiPath].ui);
    pool[uiPath] = nil;

    --调用OnHide方法
    self:CallUIFunction(uiPath, UIFunction.OnHide);
    --同时调用OnDestroy方法
    self:CallUIFunction(uiPath, UIFunction.OnDestroy);
end

--[Comment]
--UI是否打开
function UIManager:IsUIOpen(uiPath)
    local uiData = self:GetUIPool(uiPath)[uiPath];
    if(uiData == nil) then
        return false;
    end
    return true;
end

--[Comment]
--UI是否在加载
function UIManager:IsUILoading(uiPath)
    if(LoadingUITable[uiPath] ~= nil) then
        return true;
    end
    return false;
end