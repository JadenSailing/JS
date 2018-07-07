--[Comment]
--主界面(for test)

require "UI/PlayerAttr/PlayerAttr";
require "UI/Base/PlayerHeadUI";

MainUIModule = BaseModule:New(ModuleCfg.MainUIModule);

function MainUIModule:Init()
    EventManager:Register(DataEvent.StartUp, self);
    PlayerAttr:Init();
end

function MainUIModule:OnEvent(p_event, p_param)
    if(p_event == DataEvent.StartUp) then
        PlayerHeadUI:Open();
    end
end