--[Comment]
--玩家属性(for test)
require "UI/PlayerAttr/PlayerAttr";

PlayerModule = BaseModule:New(ModuleCfg.PlayerModule);

function PlayerModule:Init()
    PlayerAttr:Init();
end