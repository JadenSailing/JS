--[Comment]
--quiz

require "UI/Quiz/QuizMain";
require "UI/Quiz/QuizTitle";

QuizModule = BaseModule:New(ModuleCfg.QuizModule);

QuizModule.BasePath = "Pack/UI/quiz/";
QuizModule.TitleImage = "titleImage/";
QuizModule.QuestionImage = "questionImage/";
QuizModule.Quiz = "quiz/";

--[[
{
    "quizId": 10001,
    "quizTitle": "Choose Some Pokemon, And We'll Tell You What October Meme Is Literally Your Life",
    "quizImageUrl": "titleImage//10001.png",
    "quizDescription": "Gotta \"fetch\" 'em all!",
    "quizGroupName":"Fun Test",
    "quizGroupIcon":"groupIcon//fun.png",
    "questionsArray": [
        {
            "questionId": 1,
            "questionTitle": "Xatu or Oricorio?",
            "questionImageUrl": "questionImage//10001//questionImage_1.jpg",
            "answerArray": [
                {
                    "answerId": 1,
                    "answerImageUrl": "",
                    "answerDescription": "Xatu!"
                },
                {
                    "answerId": 2,
                    "answerImageUrl": "",
                    "answerDescription": "Oricorio!"
                }
            ]
        },
        {
            "questionId": 2,
            "questionTitle": "Mimikyu or Spirtomb?",
            "questionImageUrl": "questionImage//10001//questionImage_2.jpg",
            "answerArray": [
                {
                    "answerId": 1,
                    "answerImageUrl": "",
                    "answerDescription": "Spiritomb!"
                },
                {
                    "answerId": 2,
                    "answerImageUrl": "",
                    "answerDescription": "Mimikyu?"
                }
            ]
        },
        {
            "questionId": 3,
            "questionTitle": "Lycanroc or Stoutland?",
            "questionImageUrl": "questionImage//10001//questionImage_3.jpg",
            "answerArray": [
                {
                    "answerId": 1,
                    "answerImageUrl": "",
                    "answerDescription": "Stoutland!"
                },
                {
                    "answerId": 2,
                    "answerImageUrl": "",
                    "answerDescription": "Lycanroc!"
                }
            ]
        },
        {
            "questionId": 4,
            "questionTitle": "Primarina or Empoleon!?",
            "questionImageUrl": "questionImage//10001//questionImage_4.jpg",
            "answerArray": [
                {
                    "answerId": 1,
                    "answerImageUrl": "",
                    "answerDescription": "Primarina!"
                },
                {
                    "answerId": 2,
                    "answerImageUrl": "",
                    "answerDescription": "Empoleon!"
                }
            ]
        },
        {
            "questionId": 5,
            "questionTitle": "BONUS! Pick a starter Pokemon!",
            "questionImageUrl": "questionImage//10001//questionImage_5.jpg",
            "answerArray": [
                {
                    "answerId": 1,
                    "answerImageUrl": "",
                    "answerDescription": "Squirtle!"
                },
                {
                    "answerId": 2,
                    "answerImageUrl": "",
                    "answerDescription": "Bulbasaur!"
                }
            ]
        }
    ],
    "resultArray": [
        {
            "resultId": 1,
            "resultTitle": "Hip And Popular!",
            "resultImageUrl": "questionImage//10001//resultImage_1.jpg",
            "resultDescription": "We get it, you've been worshipping at the altar of Morticia since you could barely walk. You've never been afraid to mess around with Ouija boards and tarot cards, and the rest of us are posers. Maybe you should engage with everyone's enthusiasm once in a while- it can only win you a friend or two!"
        },
        {
            "resultId": 2,
            "resultTitle": "One Leaf On The Ground!",
            "resultImageUrl": "questionImage//10001//resultImage_2.jpg",
            "resultDescription": "Forget Christmas, Hanukkah, and Kwanzaa. October is the moooost wonderfulll tiiiiiime of the yeaaaarrr. Go pumpkin crazy, now's the time! One thing to keep in mind: not EVERYONE is as into October as you are, so maybe try to rein it in from time to time."
        },
        {
            "resultId": 3,
            "resultTitle": "Pumpkin Patch!",
            "resultImageUrl": "questionImage//10001//resultImage_3.jpg",
            "resultDescription": "You're basic, but you're kind of okay with that. If doing it for the Insta while wearing Uggs and drinking a PSL is wrong, you don't want to be right. Maybe think about how you can elevate your next snap: drone photography, perhaps?"
        }
    ]
}
--]]

local QuizData = {};

function QuizModule:Init()
    --数据初始化
    for i = 1, QuizDefine.MaxQuestion do
        local qId = QuizDefine.QuestionStartID + i - 1;
        local jsonStr = ResourceManager:LoadPath(self:GetQuizJson(qId));
        local jsonData = JsonDecode(tostring(jsonStr));
        QuizData[qId] = jsonData;
    end

    --UI监听
    QuizMain:Init()
    QuizTitle:Init();

    EventManager:Register(DataEvent.StartUp, self);

    for i = 1, QuizDefine.MaxQuestion do
        local qId = QuizDefine.QuestionStartID + i - 1;
        local resId = self:GetTitleImgResId(qId);
        UIRes:AddRes(resId, self:GetTitleImagePath(qId));
    end
end

function QuizModule:OnEvent(p_event, p_param)
    if(p_event == DataEvent.StartUp) then
        QuizTitle:Open();
    end
end

function QuizModule:GetTitleImgResId(qId)
    return qId + 10000;
end

function QuizModule:GetTitleImagePath(qId)
    return QuizModule.BasePath .. QuizModule.TitleImage .. tostring(qId);
end
--[[

function QuizModule:GetQuestionImage(qId, sId)
    return QuizModule.BasePath .. QuizModule.QuestionImage .. tostring(qid) .. "/" .. "questionImage_" .. tostring(sId);
end

function QuizModule:GetAnswerImage(qId, rId)
    return QuizModule.BasePath .. QuizModule.QuestionImage .. tostring(qid) .. "/" .. "resultImage_" .. tostring(rId);
end
--]]

function QuizModule:GetQuizJson(qId)
    return QuizModule.BasePath .. QuizModule.Quiz .. tostring(qId);
end

function QuizModule:GetTitleDesc(qId)
    local data = QuizData[qId];
    if(data == nil) then
        return tostring(qId) .. " not found!";
    end
    return data["quizTitle"];
end

function QuizModule:GetTodyQuestion()
    local n = QuizDefine.MaxQuestion;
    local rand = LuaHelper.Next(n);
    return rand + QuizDefine.QuestionStartID;
end

function QuizModule:GetRandomQuestions(qNum)
    local n = QuizDefine.MaxQuestion;
    local ret = {};
    for i = 1, n do
        if(LuaHelper.Next(n - i + 1) < qNum) then
            qNum = qNum - 1;
            ret[#ret+1] = i + QuizDefine.QuestionStartID - 1;
            if(qNum <= 0) then
                break;
            end
        end
    end
    return ret;
end