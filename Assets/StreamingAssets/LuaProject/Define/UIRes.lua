--[Comment]
--UIRes UI资源配置
--可以以其他配表形式出现
--id唯一id

UIRes = {};
UIRes[10001] = {id = 1001, path = "Pack/UI/base/PlayerHeadUI"};
UIRes[10002] = {id = 1002, path = "Pack/UI/playerAttribute/PlayerAttr"};
UIRes[10003] = {id = 1003, path = "Pack/UI/quiz/UI/QuizMain"};
UIRes[10004] = {id = 1004, path = "Pack/UI/quiz/UI/QuizTitle"};

function UIRes:AddRes(id, path)
    UIRes[id] = {id = id, path = path};
end

function UIRes:GetPath(id)
    return UIRes[id].path;
end

--20001-200046 titleimg

