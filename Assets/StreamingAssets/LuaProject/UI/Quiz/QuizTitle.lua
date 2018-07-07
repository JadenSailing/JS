_G.QuizTitle = BaseUI:New(UIPath.QuizTitle);

QuizTitle.Page = 
{
    Title = 1,
    Quiz = 2
}

local count = 0;

local uiRef = {};

local topQId = 0;

function QuizTitle:Init()
    
end

function QuizTitle:OnEvent(p_event, p_param)
    
end

function QuizTitle:OnClick(obj)
    local objName = obj.name;
    Log:InfoColor(objName .. " is clicked")
    if(objName == "upBg") then
        --show question
        Log:InfoColor("open question = " .. topQId);
        EventManager:SendEvent(LuaEvent.ShowQuizQuestion, topQId);
        self:Close();
    else
        
    end
end

function QuizTitle:OnClickItem(obj, itemScript)
    if(itemScript.ItemName == "QItem") then
        local qId = itemScript.Data
        EventManager:SendEvent(LuaEvent.ShowQuizQuestion, qId);
        self:Close();
    end
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
    --top
    local topId = QuizModule:GetTodyQuestion();
    topQId = topId;
    local uiScript = self:GetUIScript();
    local texture = ResourceManager:LoadPath(UIRes:GetPath(QuizModule:GetTitleImgResId(topId)));
    uiScript.List_Texture[0].mainTexture = texture;

    --[[
    local ratio = 560/420;
    local width = 600;
    local height = 600 / ratio;

    uiScript.List_Texture[0].width = width;
    uiScript.List_Texture[0].height = height;
    --]]

    uiScript.List_Label[0].text = QuizModule:GetTitleDesc(topId);
    uiScript.List_Label[1].text = "Today's Special";

    uiScript.List_Label[2].text = "Hottest Quiz";

    --list
    local topNum = 5;
    local randomIds = QuizModule:GetRandomQuestions(topNum);
    local res = self:GetUIScript().List_Object[0];
    local parent = self:GetUIScript().List_Table[0].gameObject;
    for i = 1, topNum do
        local item = NGUITools.AddChild(parent, res);
        item:SetActive(true);
        self:RefreshItem(item, randomIds[i]);
    end
    res:SetActive(false);
    self:GetUIScript().List_Table[0]:Reposition();
end

function QuizTitle:RefreshItem(item, qId)
    local itemScript = item:GetComponent("UIItem");
    itemScript.Data = qId;
    --self:SetTexture(itemScript.List_Texture[0], QuizModule:GetTitleImgResId(qId));

    local texture = ResourceManager:LoadPath(UIRes:GetPath(QuizModule:GetTitleImgResId(qId)));
    itemScript.List_Texture[0].mainTexture = texture;

    local width = 130;
    local height = 130;
    local ratio = 560/420; --texture.width / texture.height;

    width = 130 * ratio;

    itemScript.List_Texture[0].width = width;
    itemScript.List_Texture[0].height = height;

    itemScript.List_Label[0].text = QuizModule:GetTitleDesc(qId);
    itemScript.List_Label[1].text = Helper:GetDateStr();
end

function QuizTitle:OnHide()
    
end