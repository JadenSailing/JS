using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System;
using LuaInterface;

/// <summary>
/// 事件发送 C#发往Lua
/// </summary>
public class CEventSender 
{
    public static void SendEvent(int p_event)
    {
        if (!LuaCall.Instance.IsReady)
        {
            return;
        }
        LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnEvent");
        if (func != null)
        {
            func.Call<int>(p_event);
        }
    }

    public static void SendEvent<T1>(int p_event, T1 t1)
    {
        if (!LuaCall.Instance.IsReady)
        {
            return;
        }
        LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnEvent");
        if (func != null)
        {
            func.Call<int, T1>(p_event, t1);
        }
    }

    public static void SendEvent<T1, T2>(int p_event, T1 t1, T2 t2)
    {
        if (!LuaCall.Instance.IsReady)
        {
            return;
        }
        LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnEvent");
        if (func != null)
        {
            func.Call<int, T1, T2>(p_event, t1, t2);
        }
    }
    public static void SendEvent<T1, T2, T3>(int p_event, T1 t1, T2 t2, T3 t3)
    {
        if (!LuaCall.Instance.IsReady)
        {
            return;
        }
        LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnEvent");
        if (func != null)
        {
            func.Call<int, T1, T2, T3>(p_event, t1, t2, t3);
        }
    }

    public static void SendEvent<T1, T2, T3, T4>(int p_event, T1 t1, T2 t2, T3 t3, T4 t4)
    {
        if (!LuaCall.Instance.IsReady)
        {
            return;
        }
        LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnEvent");
        if (func != null)
        {
            func.Call<int, T1, T2, T3, T4>(p_event, t1, t2, t3, t4);
        }
    }

    public static void SendEvent<T1, T2, T3, T4, T5>(int p_event, T1 t1, T2 t2, T3 t3, T4 t4, T5 t5)
    {
        if (!LuaCall.Instance.IsReady)
        {
            return;
        }
        LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnEvent");
        if (func != null)
        {
            func.Call<int, T1, T2, T3, T4, T5>(p_event, t1, t2, t3, t4, t5);
        }
    }

    public static void SendEvent<T1, T2, T3, T4, T5, T6>(int p_event, T1 t1, T2 t2, T3 t3, T4 t4, T5 t5, T6 t6)
    {
        if (!LuaCall.Instance.IsReady)
        {
            return;
        }
        LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnEvent");
        if (func != null)
        {
            func.Call<int, T1, T2, T3, T4, T5, T6>(p_event, t1, t2, t3, t4, t5, t6);
        }
    }

    public static void SendEvent<T1, T2, T3, T4, T5, T6, T7>(int p_event, T1 t1, T2 t2, T3 t3, T4 t4, T5 t5, T6 t6, T7 t7)
    {
        if (!LuaCall.Instance.IsReady)
        {
            return;
        }
        LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnEvent");
        if (func != null)
        {
            func.Call<int, T1, T2, T3, T4, T5, T6, T7>(p_event, t1, t2, t3, t4, t5, t6, t7);
        }
    }

    public static void SendEvent<T1, T2, T3, T4, T5, T6, T7, T8>(int p_event, T1 t1, T2 t2, T3 t3, T4 t4, T5 t5, T6 t6, T7 t7, T8 t8)
    {
        if (!LuaCall.Instance.IsReady)
        {
            return;
        }
        LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnEvent");
        if (func != null)
        {
            func.Call<int, T1, T2, T3, T4, T5, T6, T7, T8>(p_event, t1, t2, t3, t4, t5, t6, t7, t8);
        }
    }
}