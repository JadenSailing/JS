using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

/// <summary>
/// 入口
/// </summary>
public class GameManager : MonoBehaviour
{
    private static GameManager _instance;

    public GameManager Instance
    {
        get
        {
            return _instance;
        }
    }

    public void Awake()
    {
        //加载UIRoot
        //GameObject uiRootRes = ResourceManager_Lua.Instance.Load(0, "Pack/UI/UI Root") as GameObject;
        //GameObject uiRoot = GameObject.Instantiate(uiRootRes);
        LuaRoot.Instance.Init();
        LuaLooper looper = this.gameObject.AddComponent<LuaLooper>();
        looper.luaState = LuaRoot.Instance.Lua;
        CEventSender.SendEvent(DataEvent.StartUp);
    }

    public void Update()
    {
        ResourceManager_Lua.Instance.Tick();
    }

    public void OnGUI()
    {
        GUIStyle style = new GUIStyle();
        style.fontSize = 30;
        //GUI.Label(new Rect(0, 0, 200, 500), "Success", style);
    }
}
