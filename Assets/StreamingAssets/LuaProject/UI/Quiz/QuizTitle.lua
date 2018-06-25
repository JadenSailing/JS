_G.QuizTitle = BaseUI:New(UIPath.QuizTitle);

QuizTitle.Page = 
{
    Title = 1,
    Quiz = 2
}

local count = 0;

local uiRef = {};

function QuizTitle:Init()
    
end

function QuizTitle:OnEvent(p_event, p_param)
    
end

function QuizTitle:OnClick(obj)
    Log:InfoColor(obj.name .. " clicked")
    if(obj.name == "box") then
        self:Close();
    end
end

function QuizTitle:OnClickItem(obj, itemScript)
    if(itemScript.ItemName == "TitleItem") then
        local qId = itemScript.Data;
        if(obj.name == "TitleImage") then
            self:ShowPage(QuizTitle.Page.Quiz);
        end
    end
end

--[Comment]
--更新问题
function QuizTitle:UpdateQuestion(qId, sId)

end

function QuizTitle:OnStart()
    RegisterUpdate(self.uiName, 0.04);
    self:InitUI();
end

function QuizTitle:InitUI()

end

function QuizTitle:OnDelayCall(p_int, p_string)
    
end


function QuizTitle:OnUpdate()

end

function QuizTitle:OnDestroy()
    RemoveUpdate(self.uiName);
end

function QuizTitle:OnShow()
end

function QuizTitle:OnHide()
    
end