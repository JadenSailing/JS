--[Comment]
--本地数据相关

_G.LocalData = {}

LocalData.Key = 
{
    Today = "LocalData.Key.Today",
    TodayQuestion = "LocalData.Key.TodayQuestion",
    TodayTopQuestion = "LocalData.Key.TodayTopQuestion",
}

function LocalData:GetInt(key, default)
    if(default == nil) then
        default = 0;
    end
    return LocalDataManager:GetInt(key, default);
end

function LocalData:GetFloat(key, default)
    if(default == nil) then
        default = 0;
    end
    return LocalDataManager:GetFloat(key, default);
end

function LocalData:GetString(key, default)
    if(default == nil) then
        default = "";
    end
    return LocalDataManager:GetString(key, default);
end

function LocalData:SetInt(key, value)
    LocalDataManager:SetInt(key, value);
end

function LocalData:SetFloat(key, value)
    LocalDataManager:SetFloat(key, value);
end

function LocalData:SetString(key, value)
    LocalDataManager:SetString(key, value);
end

function LocalData:SaveData()
    LocalDataManager:SaveData();
end