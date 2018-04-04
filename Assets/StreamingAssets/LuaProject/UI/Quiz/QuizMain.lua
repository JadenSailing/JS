_G.QuizMain = BaseUI:New(UIPath.QuizMain);

QuizMain.Page = 
{
    Title = 1,
    Quiz = 2
}

local count = 0;

local uiRef = {};

function QuizMain:Init()
    EventManager:Register(DataEvent.StartUp, self);
end

function QuizMain:OnEvent(p_event, p_param)
    if(p_event == DataEvent.StartUp) then
        self:Open();
    end
end

function QuizMain:OnClick(obj)
    if(obj.name == "Button_Close") then
        self:Close();
    end
end

function QuizMain:OnClickItem(obj, itemScript)
    if(itemScript.ItemName == "TitleItem") then
        local qId = itemScript.Data;
        if(obj.name == "TitleImage") then
            self:ShowPage(QuizMain.Page.Quiz);
        end
    end
end

function QuizMain:ShowPage(page)
    if(page == QuizMain.Page.Title) then
        uiRef.pageTitle:SetActive(true);
        uiRef.pageQuiz:SetActive(false);
    else
        uiRef.pageTitle:SetActive(false);
        uiRef.pageQuiz:SetActive(true);
    end
end

--[Comment]
--更新问题
function QuizMain:UpdateQuestion(qId, sId)

end

function QuizMain:OnStart()
    RegisterUpdate(self.uiName, 0.04);
    self:InitUI();
end

function QuizMain:InitUI()
    uiRef.pageTitle = self:GetUIScript().List_Object[0];
    uiRef.pageQuiz = self:GetUIScript().List_Object[1];
    uiRef.titleItem = self:GetUIScript().List_Object[2];
    uiRef.titleTable = self:GetUIScript().List_Table[0];
end

function QuizMain:OnDelayCall(p_int, p_string)
    
end


function QuizMain:OnUpdate()

end

function QuizMain:OnDestroy()
    RemoveUpdate(self.uiName);
end

local function UpdateItem(item, i)
    local itemScript = item:GetComponent("UIItem");
    local qId = QuestionStartID + i - 1;
    itemScript.Data = qId;
    itemScript.List_Label[0].text = QuizModule:GetTitleDesc(qId);
    local titlePath = QuizModule:GetTitleImage(qId);
    itemScript.List_Texture[0].mainTexture = ResourceManager:LoadPath(titlePath);
end

function QuizMain:OnShow()
    self:ShowPage(QuizMain.Page.Title);
    for i = QuestionStartID, QuizDefine.MaxQuestion + QuestionStartID - 1 do
        local item = NGUITools.AddChild(uiRef.titleTable.gameObject, uiRef.titleItem);
        UpdateItem(item, i);
    end
    uiRef.titleItem:SetActive(false);
end

function QuizMain:OnHide()
    
end