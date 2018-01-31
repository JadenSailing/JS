using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using LuaInterface;
using System;
//UIItem模块 持有引用
public class UIItem : MonoBehaviour 
{
    public string ModuleName;
    public string ItemName;
    [HideInInspector]
    public int Index; //表示该Item的动态index
    public List<UISprite> List_Sprite;
    public List<UILabel> List_Label;
    public List<UIButton> List_Button;
	public List<UISlider> List_Slider;
	public List<UIGrid> List_Grid;
    public List<UIToggle> List_Toggle;
    public List<UIElement> List_Element;
    public List<GameObject> List_Object;
	public List<Shader> List_ShaderObject;
    public List<UITexture> List_Texture;
    public List<UITable> List_Table;
    public List<UISpriteAnimation> List_SpriteAnimation;
    public List<UIWidget> List_UIWidget;
    public List<Collider> List_Collider;

    private object data;
    /// <summary>
    /// 用于赋值（Lua中传递数据用）
    /// </summary>
    public object Data
    {
        get { return data; }
        set { data = value; }
    }
    public void Awake()
    {

    }

    /*
    public void Start()
    {

    }

    public void OnDestroy()
    {
#if UNITY_EDITOR
        if (LuaRoot.Instance.Lua == null)
        {
            return;
        }
#endif
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("UIItemBehavior");
            func.BeginPCall();
            
            func.Push(ModuleName);
            func.Push("OnDestroyItem");
            func.Push(this);
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIItemModule Call OnDestroy Error:" + ModuleName + "-" + ItemName + e.ToString());
        }
    }
    */

    public void Btn_OnPressure(GameObject btn)
    {
#if GAMEDEBUG
        LuaManager.Instance.AddBuglyLog("UIItemBehavior-Btn_OnPressure" + ModuleName);
#endif
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnUIItemEvent");
            func.BeginPCall();
            
            func.Push("OnPressureItem");
            func.Push(ModuleName);
            func.Push(btn);
            func.Push(this);
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIItemModule Call Btn_OnPressure Error:" + ModuleName + "-" + ItemName + "-" + btn.name + e.ToString());
        }
    }

    public void Btn_OnClick(GameObject btn)
	{
#if GAMEDEBUG
        LuaManager.Instance.AddBuglyLog("UIItemBehavior-Btn_OnClick" + ModuleName);
#endif
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnUIItemEvent");
            func.BeginPCall();
            
            func.Push("OnClickItem");
            func.Push(ModuleName);
            func.Push(btn);
            func.Push(this);
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIItemModule Call Btn_OnClick Error:" + ModuleName + "-" + ItemName + "-" + btn.name + e.ToString());
        }
    }

	public void Btn_OnMouseOver(GameObject btn)
	{
        
	}

	public void Btn_OnMouseOut(GameObject btn)
	{
        
	}

	public void Btn_OnPress(GameObject btn)
	{
#if GAMEDEBUG
        LuaManager.Instance.AddBuglyLog("UIItemBehavior-Btn_OnPress" + ModuleName);
#endif
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnUIItemEvent");
            func.BeginPCall();
            
            func.Push("OnPressItem");
            func.Push(ModuleName);
            func.Push(btn);
            func.Push(this);
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIItemModule Call Btn_OnPress Error:" + ModuleName + "-" + ItemName + "-" + btn.name + e.ToString());
        }
    }

	public void Btn_OnRelease(GameObject btn)
	{
#if GAMEDEBUG
        LuaManager.Instance.AddBuglyLog("UIItemBehavior-Btn_OnRelease" + ModuleName);
#endif
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnUIItemEvent");
            func.BeginPCall();
            
            func.Push("OnReleaseItem");
            func.Push(ModuleName);
            func.Push(btn);
            func.Push(this);
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIItemModule Call Btn_OnRelease Error:" + ModuleName + "-" + ItemName + "-" + btn.name + e.ToString());
        }
    }

	public void Btn_OnDoubleClick(GameObject btn)
	{
#if GAMEDEBUG
        LuaManager.Instance.AddBuglyLog("UIItemBehavior-Btn_OnDoubleClick" + ModuleName);
#endif
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnUIItemEvent");
            func.BeginPCall();
            
            func.Push("OnDoubleClickItem");
            func.Push(ModuleName);
            func.Push(btn);
            func.Push(this);
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIItemModule Call Btn_OnDoubleClick Error:" + ModuleName + "-" + ItemName + "-" + btn.name + e.ToString());
        }
    }

    public void OnClickLabelURL(UILabel component)
    {
#if GAMEDEBUG
        LuaManager.Instance.AddBuglyLog("UIItemBehavior-OnClickLabelURL" + ModuleName);
#endif
        string url = component.GetUrlAtPosition(UICamera.lastWorldPosition);
        if (!string.IsNullOrEmpty(url))
        {
            Data = url;
            try
            {
                LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnUIItemEvent");
                func.BeginPCall();
                
                func.Push("OnClickItemLabelURL");
                func.Push(ModuleName);
                func.Push(component);
                func.Push(this);
                func.PCall();
                func.EndPCall();
            }
            catch (System.Exception e)
            {
                LogSystem.Instance.Error("UIItemModule Call OnClickLabelURL Error:" + ModuleName + "-" + ItemName + "-" + component.name + e.ToString());
            }
        }
        
    }

}