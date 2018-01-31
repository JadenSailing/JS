--[Comment]
--Log相关

_G.Log = {}
local showTrace = true;

LogColor = {
Red = 1,
Green = 2
}

function Log:Init()
    showTrace = true;
end

function Log:GetStack(msg)
    msg = msg == nil or "";
    return traceback(msg);
end

function Log:GetLuaPreInfo()
    local preInfo = "[Lua]";
    local time = os.date("%X", os.time()) .. preInfo;
    local line = debug.getinfo(3, "l").currentline;
    local file = debug.getinfo(3, "S").source;
    preInfo = time .. preInfo .. "[" .. file .. "][" .. line .. "]:";
    return preInfo;
end

function Log:Info(msg)
    if(not showTrace) then
        return;
    end
    local preInfo = self:GetLuaPreInfo();
    msg = preInfo .. msg;

    --调用日志
    UnityEngine.Debug.Log(msg);
end

function Log:Warn(msg)
    if(not showTrace) then
        return;
    end
    local preInfo = self:GetLuaPreInfo();
    msg = preInfo .. msg;

    --调用日志
    UnityEngine.Debug.LogWarning(msg);
end

function Log:Error(msg)
    if(not showTrace) then
        return;
    end
    local preInfo = self:GetLuaPreInfo();
    msg = preInfo .. msg;

    --调用日志
    UnityEngine.Debug.LogError(msg);
end

function Log:GetColorStr(msg, color)
    local color1 = "<color=#ffffff>";
    local color2 = "</color>";
    if(color == LogColor.Red) then
        color1 = "<color=#ff0000>";
    elseif(color == LogColor.Green) then
        color1 = "<color=#00ff00>";
    end
    return color1 .. msg .. color2;
end

function Log:InfoColor(msg, color)
    if(not showTrace) then
        return;
    end
    if(color == nil) then
        color = LogColor.Green;
    end
    local preInfo = self:GetLuaPreInfo();
    msg = preInfo .. msg;
    msg = self:GetColorStr(msg, color);
    --调用日志
    UnityEngine.Debug.Log(msg);
end
