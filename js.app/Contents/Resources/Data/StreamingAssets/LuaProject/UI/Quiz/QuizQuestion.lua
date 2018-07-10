_G.QuizQuestion = BaseUI:New(UIPath.QuizQuestion);

QuizQuestion.Page = 
{
    Title = 1,
    Quiz = 2
}

local count = 0;

local uiRef = {};

local currentQId = -1;
local currentQIndex = 0;

function QuizQuestion:Init()
    
end

function QuizQuestion:OnEvent(p_event, p_param)
    
end

function QuizQuestion:TryOpen(qId)
    currentQId = tonumber(qId);
    Log:InfoColor("currentQId = " .. currentQId);
    if(currentQId == nil or currentQId < 0) then
        return;
    end
    self:Open();
end

function QuizQuestion:OnClick(obj)
    local objName = obj.name;
    Log:InfoColor(objName .. " is clicked!")
    local answerIndex = string.sub(objName, 3, 3);
    Log:InfoColor("answerIndex = " .. answerIndex);
    currentQIndex = currentQIndex + 1;
    self:ShowQuestion();
end

function QuizQuestion:OnClickItem(obj, itemScript)
    if(itemScript.ItemName == "StartBtn") then
        
    end
end

function QuizQuestion:OnStart()
    RegisterUpdate(self.uiName, 0.04);
    self:InitUI();
end

function QuizQuestion:InitUI()
    
end

function QuizQuestion:OnDelayCall(p_int, p_string)
    
end


function QuizQuestion:OnUpdate()

end


function QuizQuestion:OnDestroy()
    RemoveUpdate(self.uiName);
end

function QuizQuestion:ShowQuestion()
    local data = QuizModule:GetQuizData(currentQId);
    local qArray = data["questionsArray"]
    if(currentQIndex > #qArray) then
        self:Close();
        QuizAnswer:TryOpen(currentQId, 1);
        return;
    end

    local uiScript = self:GetUIScript();
    local texture = ResourceManager:LoadPath(QuizModule:GetQuestionImagePath(currentQId, currentQIndex));
    uiScript.List_Texture[0].mainTexture = texture;

    --[[
    local ratio = 560/420;
    local width = 600;
    local height = 600 / ratio;

    uiScript.List_Texture[0].width = width;
    uiScript.List_Texture[0].height = height;
    --]]

    uiScript.List_Sprite[0].width = currentQIndex / #qArray * 640
    

    uiScript.List_Label[0].text = QuizModule:GetTitleDesc(currentQId);

    uiScript.List_Label[1].text = qArray[currentQIndex].questionTitle;

    uiScript.List_Label[2].text = currentQIndex .. "/" .. #qArray;

    --list
    local aArray = qArray[currentQIndex].answerArray
    for i = 1, QuizDefine.MaxSubQuestion do
        if(i <= #aArray) then
            uiScript.List_Object[i-1]:SetActive(true);
            uiScript.List_Label[2+i].text = aArray[i].answerDescription
        else
            uiScript.List_Object[i-1]:SetActive(false);
        end
    end
end

function QuizQuestion:OnShow()
    currentQIndex = 1;
    self:ShowQuestion();
    
end

function QuizQuestion:OnHide()
    
end