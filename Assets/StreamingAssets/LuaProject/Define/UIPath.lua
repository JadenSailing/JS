--[Comment]
--UIPath UI相关的配置
--id唯一id
--res资源id
--uiName类名
--layer层级：0base，1pop，2tip

UIPath = {};
UIPath.PlayerHeadUI = {id = 1, res = 10001, uiName = "PlayerHeadUI", layer = UILayer.Base};
UIPath.PlayerAttr = {id = 2, res = 10002, uiName = "PlayerAttr", layer = UILayer.Pop};

UIPath.QuizMain = {id = 3, res = 10003, uiName = "QuizMain", layer = UILayer.Pop};
UIPath.QuizTitle = {id = 4, res = 10004, uiName = "QuizTitle", layer = UILayer.Pop};