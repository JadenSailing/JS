_G.Invoke = {}

local WaitList = {}
local InvokeList = {}
local RemoveList = {Count = 0};

function Invoke:Init()
    RegisterUpdate("Invoke", 0.04);
end

--[Comment]
--func 要调用的函数
--delay 延迟时间 秒
--延迟调用函数
function Invoke:DelayCall(func, delay, ...)
    local param = InvokeParam:New(Time.realtimeSinceStartup, func, delay, ...);
    WaitList[#WaitList+1] = param;
end

function Invoke:OnUpdate()
    --处理待添加
    if(#WaitList > 0) then
        for i,v in ipairs(WaitList) do
            InvokeList[#InvokeList+1] = v;
        end    
        WaitList = {}
    end
    
    if(#InvokeList == 0) then
        return;
    end

    --处理待移除
    if(RemoveList.Count > 0) then
        local tmp = {};
        for i,v in ipairs(InvokeList) do
            if(RemoveList[v] == nil) then
                tmp[#tmp+1] = v;
            end
        end
        RemoveList = {Count = 0};
        InvokeList = tmp;

        if(#InvokeList == 0) then
            return;
        end
    end
    local t = Time.realtimeSinceStartup;
    for i,v in ipairs(InvokeList) do
        if(t - v.startTime >= v.delay) then
            --移除该项
            RemoveList[v] = true;
            RemoveList.Count = RemoveList.Count + 1;
            local isOk, result = pcall(
            function(v)
                v.func(unpack(v.param));
            end
            , v, result);

            if(not isOk) then
                Log:Error("发生回调错误:" .. result);
            end
        end
    end
end

----------------------------
_G.InvokeParam = {}
InvokeParam.startTime = 0;
InvokeParam.func = nil;
InvokeParam.delay = 1;
InvokeParam.param = nil;

local mt = {}
mt.__index = InvokeParam

--[Comment]
--New
function InvokeParam:New(startTime, func, delay, ...)
    local t = {};
    --设置元表
    setmetatable(t, mt)

    t.startTime = startTime;
    t.func = func;
    t.delay = delay;
    t.param = {...};
    return t;
end
