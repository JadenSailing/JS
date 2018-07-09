-- Lua入口
require "RootDefine"

function Start()
    --初始化UI引用
    UIManager:Init();
    Invoke:Init();

    --加载模块
    RequireModule:LoadBaseModule();
end	

--待处理添加或移除Update的对象
local waitingUpdateDict = {};
--需要执行Update的对象
local updateUIDict = {};

--[Comment]
-- 注册帧更新回调 表名|间隔(秒)
function RegisterUpdate(tableName, deltaTime)
    deltaTime = deltaTime or 1.0;
    waitingUpdateDict[tableName] = { name = tableName, delta = deltaTime, lastTime = 0 , isAdd = true};
end

function RemoveUpdate(tableName)
    waitingUpdateDict[tableName] = { name = tableName, delta = deltaTime, lastTime = 0 , isAdd = false};
end

function RootUpdate()
    --Log:InfoColor(Helper:GetTime() .. ", " .. Helper:GetTimeByDay());
    local currentTime = Time.realtimeSinceStartup;
    --先处理注册和移除的帧监听
    if(not table.isEmpty(waitingUpdateDict)) then
        for k, v in pairs(waitingUpdateDict) do
            if(v.isAdd == true) then
                updateUIDict[k] = v;
            else
                updateUIDict[k] = nil;
            end
        end
        waitingUpdateDict = {};
    end
    for i, v in pairs(updateUIDict) do
        local tableName = v.name;
        if (_G[tableName] ~= nil) then
            if (_G[tableName]["OnUpdate"] ~= nil) then
                if (currentTime - v.lastTime > v.delta) then
                    _G[tableName]["OnUpdate"](_G[tableName]);
                    v.lastTime = currentTime;
                end
            end
        end
    end
end

-- 事件接收
function OnEvent(p_event, ...)
    -- Event处理统一接口 所有Lua事件走EventManager注册
    local p_param = {...}
    EventManager:OnEvent(p_event, p_param);
end

-- UI behavior 直调 通过这种方式的有 Awake Start OnEnable OnDisable , Destroy是关闭UI时自己调用的
function UIBehavior(p_ui, p_behavior)
    if (_G[p_ui] == nil) then
        return
    end
    if (_G[p_ui][p_behavior] == nil) then
        return
    end

    _G[p_ui][p_behavior](_G[p_ui]);

end

-- UI交互事件 点击
function OnUIEvent(p_func, p_ui, p_target)
    if (_G[p_ui] == nil) then
        return
    end
    if (_G[p_ui][p_func] == nil) then
        return
    end
    
    _G[p_ui][p_func](_G[p_ui], p_target);

end

-- UI behavior 直调 以保持c#下的习惯 Awake Start OnEnable OnDisable Update
function UIItemBehavior(p_ui, p_behavior, p_item)
    if (_G[p_ui] == nil) then
        return
    end
    if (_G[p_ui][p_behavior] == nil) then
        return
    end

    _G[p_ui][p_behavior](_G[p_ui], p_item);
end

-- UI交互事件 点击
function OnUIItemEvent(p_func, p_ui, p_target, p_item)
    if (_G[p_ui] == nil) then
        return
    end
    if (_G[p_ui][p_func] == nil) then
        return
    end
    _G[p_ui][p_func](_G[p_ui], p_target, p_item);
end

-- 资源加载回调入口
function OnResourceLoaded(index, obj)
    ResourceManager:OnResourceLoaded(index, obj);
end

Log:InfoColor("Lua Root Loaded!", LogColor.Green);