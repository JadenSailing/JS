--事件管理器
_G.EventManager = {}

--[Comment]
--所有注册监听的事件列表
local eventList = {};

--[Comment]
--事件注册入口 EventManager:Register(someEvent, self/someObj);
--使用传入对象的OnEvent方法(兼容之前做法 改动少)
--所以同一个事件不能在统一个类里注册多个函数
function EventManager:Register(p_event, obj)
    if(p_event == nil) then
        return;
    end
	local childList = eventList[p_event];
	if(childList == nil) then
		--如果该事件没有监听者，建立该事件的监听者列表
		childList = {};
		eventList[p_event] = childList;
	end
	for i,v in ipairs(childList) do
		if(v == obj) then
			return;
		end
	end
	childList[#childList+1] = obj;
end

--[Comment]
--移除事件入口 EventManager:Remove(somEvent, self/someObj);
function EventManager:Remove(p_event, obj)
	local childList = eventList[p_event];
	if(childList ~= nil) then
		for i,v in ipairs(childList) do
			if(v == obj) then
				table.remove(childList, i);
				return;
			end
		end
	end
end

--[Comment]
--Lua内部转发事件
--保持同C#过来的事件参数的一致性
function EventManager:SendEvent(p_event, ...)
    local arg = {...};
    EventManager:OnEvent(p_event, arg);
end


--[Comment]
--业务逻辑不要调用这里
--事件总入口 在此处进行派发
function EventManager:OnEvent(p_event, p_param)
	local childList = eventList[p_event];
	if(childList ~= nil) then
		for i = 1, #childList do
            childList[i]:OnEvent(p_event, p_param);
		end
	end
end