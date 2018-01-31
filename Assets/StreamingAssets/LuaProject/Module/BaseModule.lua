--[Comment]
--模块基类

_G.BaseModule = {}
local mt = {}
mt.__index = BaseModule

BaseModule.moduleName = "BaseModule";

--UI基类构造函数 所有UI类从此方法实例化
function BaseModule:New(moduleCfg)
	local m = {};
    m.cfg = moduleCfg;
    m.moduleName = moduleCfg.moduleName;
    --设置元表
    setmetatable(m, mt)
	return m;
end

function BaseModule:Init()

end