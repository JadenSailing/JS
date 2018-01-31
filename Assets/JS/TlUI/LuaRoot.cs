using LuaInterface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

public class LuaRoot : MonoBehaviour
{
    private LuaState _lua;

    private static LuaRoot _instance;

    public GameObject UIRoot;

    public List<GameObject> LayerList;

    public static LuaRoot Instance
    {
        get
        {
            return _instance;
        }
    }

    void Awake()
    {
        _instance = this;
    }

    public LuaState Lua
    {
        get
        {
            return _lua;
        }
    }

    [NoToLua]
    public void Init()
    {
        _lua = new LuaState();
        LuaBinder.Bind(_lua);
        _lua.Start();
        _lua.DoFile("LuaRoot");
        LuaCall.Instance.LuaRootStart();
    }
    
}
