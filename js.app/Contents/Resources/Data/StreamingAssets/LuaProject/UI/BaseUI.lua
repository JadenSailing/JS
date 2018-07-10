_G.BaseUI = {}
local mt = {}
mt.__index = BaseUI

BaseUI.uiName = "baseUI";
BaseUI.isBaseUI = false;
BaseUI.uiPath = nil;

--UI基类构造函数 所有UI类从此方法实例化
function BaseUI:New(uiPath)
	local ui = {};
    ui.uiPath = uiPath;
    ui.uiName = uiPath.uiName;
    ui.isBaseUI = true;

    --设置元表
    setmetatable(ui, mt)

    --添加名称到UIPath表中 备用  
    if(UIPath[ui.uiName] == nil) then
        print("UIPath not contains " .. ui.uiName);
    else
        UIPath[ui.uiName].uiName = ui.uiName;
    end
	return ui;
end

function BaseUI:GetUI()
    return UIManager:GetUI(self.uiPath);
end

function BaseUI:GetUIScript()
    return UIManager:GetUIScript(self.uiPath);
end

--[Comment]
--打开UI
function BaseUI:Open()
    return UIManager:OpenUI(self.uiPath);
end

--[Comment]
--关闭UI
function BaseUI:Close()
    return UIManager:CloseUI(self.uiPath);
end

--[Comment]
--UI是否打开
function BaseUI:IsOpen()
    return UIManager:IsUIOpen(self.uiPath);
end

--[Comment]
--UI是否在加载

function BaseUI:IsLoading()
    return UIManager:IsUILoading(self.uiPath);
end

--[Comment]
--func 要调用的函数
--delay 延迟时间 秒
--延迟调用函数
function BaseUI:DelayCall(func, delay, ...)
    Invoke:DelayCall(func, delay, self, ...);
end

--[Comment]
--设置Texture资源
function BaseUI:SetTexture(uiTexutre, resID)
    TextureManager:SetTexture(self.uiPath.id, uiTexutre, resID);
end