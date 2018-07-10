Helper = {};

Helper.SecondsPerDay = 3600 * 24;

function Helper:GetDateStr()
    local date=os.date("%Y-%m-%d");
    return date;
end

function Helper:GetTime()
    local time = os.time();
    return time;
end

function Helper:GetTimeByDay()
    local time = self:GetTime();
    time = math.floor(time / Helper.SecondsPerDay);
    return time;
end