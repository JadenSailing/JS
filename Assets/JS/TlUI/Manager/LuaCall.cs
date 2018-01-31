using LuaInterface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/// <summary>
/// 集中调用Lua的无GC方法
/// </summary>
public class LuaCall : Singleton<LuaCall>
{
    public void LuaRootStart()
    {
        LuaFunction luaFunc = this.GetLuaFunction("Start");
        luaFunc.BeginPCall();
        luaFunc.PCall();
        luaFunc.EndPCall();
        luaFunc.Dispose();
    }

    public void LuaRootUpdate()
    {
        LuaFunction luaFunc = this.GetLuaFunction("RootUpdate");
        luaFunc.BeginPCall();
        luaFunc.PCall();
        luaFunc.EndPCall();
    }

    public void ToLuaUpdate()
    {
        
        LuaFunction luaFunc = this.GetLuaFunction("Update");
        luaFunc.BeginPCall();
        luaFunc.PCall();
        luaFunc.EndPCall();
    }

    private LuaFunction GetLuaFunction(string funcName)
    {
        return LuaRoot.Instance.Lua.GetFunction(funcName);
    }

    public bool IsReady
    {
        get
        {
            return true;
        }
    }

    public void Call(string funcName)
    {
        if(!IsReady)
        {
            return;
        }

    }

    /// <summary>
    /// 资源加载回调
    /// </summary>
    /// <param name="index"></param>
    /// <param name="obj"></param>
    public void OnResourceLoaded(int index, UnityEngine.Object obj)
    {
        if (!IsReady)
        {
            return;
        }
        LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnResourceLoaded");
        if (func != null)
        {
            func.BeginPCall();
            func.Push(index);
            func.Push(obj);
            func.PCall();
            func.EndPCall();
        }
    }
}
