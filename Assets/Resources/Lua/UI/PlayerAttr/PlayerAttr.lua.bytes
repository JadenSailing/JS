_G.PlayerAttr = BaseUI:New(UIPath.PlayerAttr);
local count = 0;

function PlayerAttr:Init()
    EventManager:Register(LuaEvent.ShowPlayerAttr, self);
end

function PlayerAttr:OnEvent(p_event, p_param)
    if(p_event == LuaEvent.ShowPlayerAttr) then
        self:Open();
    end
end

function PlayerAttr:OnClick(obj)
    if(obj.name == "Button_Close") then
        self:Close();
    end
end

function PlayerAttr:OnStart()
    RegisterUpdate(self.uiName, 0.04);
    self:InitUI();

    --延迟关闭
    self:DelayCall(self.OnDelayCall, 5, 123, "123");
end

function PlayerAttr:OnDelayCall(p_int, p_string)
    Log:Info("Test BaseUI DelayCall, p_int = " .. p_int .. ", p_string = " .. p_string);
end

function PlayerAttr:InitUI()

end


function PlayerAttr:OnUpdate()

end

function PlayerAttr:OnDestroy()
    RemoveUpdate(self.uiName);
end

function PlayerAttr:OnShow()

end

function PlayerAttr:OnHide()

end