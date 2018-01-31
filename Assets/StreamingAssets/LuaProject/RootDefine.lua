--[Comment]
--基础定义&核心类定义&顶级方法
require "Util/Log"
require "Util/EventManager";
require "Define/ModuleCfg";
require "Define/DataEvent";
require "Define/LuaEvent";
require "Define/UILayer";
require "Define/UIPath";
require "Define/UIRes";
require "UI/BaseUI";
require "Util/Invoke";
require "Util/ResourceManager";
require "Util/TextureManager";
require "Util/UIManager";
require "Module/BaseModule";
require "Module/RequireModule";

--unity 对象判断为空, 如果你有些对象是在c#删掉了，lua 不知道
--判断这种对象为空时可以用下面这个函数。
function IsNil(uobj)
	return uobj == nil or uobj:Equals(nil)
end

function IsTable(o)
    return (type(o) == "table")
end

function IsString(o)
    return (type(o) == "string")
end

function IsNumber(o)
    return (type(o) == "number")
end

function IsDecimal(o)
    return (type(o) == "number" and math.floor(o) < o)
end

function IsBool(o)
    return (type(o) == "boolean")
end

function table.isEmpty(self)
    return next(self) == nil;
end

Log:InfoColor("RootDefine Loaded", LogColor.Green);