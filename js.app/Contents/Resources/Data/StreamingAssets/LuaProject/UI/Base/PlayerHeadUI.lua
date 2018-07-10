_G.PlayerHeadUI = BaseUI:New(UIPath.PlayerHeadUI);
local count = 1;

function PlayerHeadUI:OnClick(obj)
    if(obj.name == "PlayerHeadUI_headIcon") then
        --显示弹窗
        --PlayerAttr:Open(); --直接调用
        EventManager:SendEvent(LuaEvent.ShowPlayerAttr);
    end
end

function PlayerHeadUI:OnStart()
    RegisterUpdate(self.uiName, 1);
    self:InitUI();
end

function PlayerHeadUI:InitUI()
    --UI相关初始化
    self:SetTexture(self:GetUIScript().List_Texture[0], 20001);
end

function PlayerHeadUI:OnShow()
    self:GetUIScript().List_Label[1].text = 1;
    self:UpdateCount();
end

function PlayerHeadUI:UpdateCount()
    if(self:IsOpen()) then
        self:GetUIScript().List_Label[0].text = count * 1000;
        local index = count % 12;
        self:SetTexture(self:GetUIScript().List_Texture[0], 20001 + index);
    end
end

function PlayerHeadUI:OnUpdate()
    count = count + 1;
    self:UpdateCount();
end

function PlayerHeadUI:OnHide()
    --UI关闭或隐藏的处理
end

function PlayerHeadUI:OnDestroy()
    RemoveUpdate(self.uiName);
end