--[Comment]
--处理模块加载
--Lua文件过多的情况下，初始化会成为负担
--所以需要设置合理的分批加载策略

RequireModule = BaseModule:New(ModuleCfg.RequireModule);

local requiredModule = {};

function RequireModule:Init()
    
end

--[Comment]
--加载模块
local function LoadModule(moduleCfg)
    if(requiredModule[moduleCfg.moduleName] == true) then
        return;
    end
    --加载对应lua文件
    require(moduleCfg.path);
    --执行Init方法
    _G[moduleCfg.moduleName]:Init();
    requiredModule[moduleCfg.moduleName] = true
end

--[Comment]
--登录模块
function RequireModule:LoadLoginModule()
    
end

--[Comment]
--基础模块
function RequireModule:LoadBaseModule()
    --LoadModule(ModuleCfg.MainUIModule);
    --LoadModule(ModuleCfg.PlayerModule);
    LoadModule(ModuleCfg.QuizModule);
end

--[Comment]
--其他模块
function RequireModule:LoadOtherModule()
    
end