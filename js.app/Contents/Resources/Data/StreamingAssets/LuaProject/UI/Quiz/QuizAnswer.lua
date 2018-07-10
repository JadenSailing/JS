_G.QuizAnswer = BaseUI:New(UIPath.QuizAnswer);


local count = 0;

local uiRef = {};

local currentQId = -1;
local currentAIndex = 1;

function QuizAnswer:Init()
    
end

function QuizAnswer:OnEvent(p_event, p_param)
    
end

function QuizAnswer:TryOpen(qId, answerId)
    currentQId = tonumber(qId);
    currentAIndex = answerId;
    Log:InfoColor("currentQId = " .. currentQId);
    if(currentQId == nil or currentQId < 0) then
        return;
    end
    self:Open();
end

function QuizAnswer:OnClick(obj)
    QuizTitle:Open();
    self:Close();
end

function QuizAnswer:OnClickItem(obj, itemScript)
    
end

function QuizAnswer:OnStart()
    RegisterUpdate(self.uiName, 0.04);
    self:InitUI();
end

function QuizAnswer:InitUI()
    
end

function QuizAnswer:OnDelayCall(p_int, p_string)
    
end


function QuizAnswer:OnUpdate()

end


function QuizAnswer:OnDestroy()
    RemoveUpdate(self.uiName);
end

function QuizAnswer:ShowQuestion()
    local data = QuizModule:GetQuizData(currentQId);
    local qArray = data["questionsArray"]
    local aArray = data["resultArray"]

    local uiScript = self:GetUIScript();
    local texture = ResourceManager:LoadPath(QuizModule:GetAnswerImagePath(currentQId, currentAIndex));
    uiScript.List_Texture[0].mainTexture = texture;

    --[[
    local ratio = 560/420;
    local width = 600;
    local height = 600 / ratio;

    uiScript.List_Texture[0].width = width;
    uiScript.List_Texture[0].height = height;
    --]]
    

    uiScript.List_Label[0].text = QuizModule:GetTitleDesc(currentQId);

    uiScript.List_Label[2].text = "YOUR ANSWER:";

    uiScript.List_Label[3].text = aArray[currentAIndex].resultDescription;
    
end

function QuizAnswer:OnShow()
    currentAIndex = 1;
    self:ShowQuestion();
    
end

function QuizAnswer:OnHide()
    
end