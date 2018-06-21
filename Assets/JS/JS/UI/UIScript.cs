using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using LuaInterface;
using System;
//UI模块 持有引用
public class UIScript : MonoBehaviour
{
    public string ScriptName;
    public bool IsTrigger = false;
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
    public List<UIProgressBar> List_ProgressBar;
    public List<UISpriteAnimation> List_animation;
    public List<UIPopupList> List_PopupList;
    public List<UIInput> List_Input;
    public List<UIScrollView> List_ScrollView;
    public List<UIScrollBar> List_ScrollBar;
    public List<UISpriteAnimation> List_SpriteAnimation;
    public List<TweenPosition> List_TweenPosition;
    public List<TweenScale> List_TweenScale;

    //去掉Awake的调用，Start改为Lua中调用，便于管理
    /*
    public void Awake()
    {
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("UIBehavior");
            func.BeginPCall();

            func.Push(ScriptName);
            func.Push("Awake");
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIScript Call Awake Error:" + ScriptName + e.ToString());
        }
    }

    public void Start()
    {
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("UIBehavior");
            func.BeginPCall();

            func.Push(ScriptName);
            func.Push("Start");
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIScript Call Start Error:" + ScriptName + e.ToString());
        }
    }
    */

    public void OnEnable()
    {
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("UIBehavior");
            func.BeginPCall();

            func.Push(ScriptName);
            func.Push("OnEnable");
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIScript Call OnEnable Error:" + ScriptName + e.ToString());
        }
    }

    public void OnDisable()
    {
#if UNITY_EDITOR
        if (LuaRoot.Instance.Lua == null)
        {
            return;
        }
#endif
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("UIBehavior");
            func.BeginPCall();

            func.Push(ScriptName);
            func.Push("OnDisable");
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIScript Call OnDisable Error:" + ScriptName + e.ToString());
        }
    }

    /*
    public void Update()
    {

    }

    public void OnDestroy()
    {

    }
    */

    public void Btn_OnClick(GameObject btn)
    {
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnUIEvent");
            func.BeginPCall();

            func.Push("OnClick");
            func.Push(ScriptName);
            func.Push(btn);
            func.PCall();
            func.EndPCall();
            UnityEngine.Profiler.EndSample();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIScript Call Btn_OnClick Error:" + ScriptName + btn.name + e.ToString());
        }
    }

    public void Btn_OnMouseOver(GameObject btn)
    {
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnUIEvent");
            func.BeginPCall();

            func.Push("OnMouseOver");
            func.Push(ScriptName);
            func.Push(btn);
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIScript Call Btn_OnMouseOver Error:" + ScriptName + btn.name + e.ToString());
        }
    }

    public void Btn_OnMouseOut(GameObject btn)
    {
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnUIEvent");
            func.BeginPCall();

            func.Push("OnMouseOut");
            func.Push(ScriptName);
            func.Push(btn);
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIScript Call Btn_OnMouseOut Error:" + ScriptName + btn.name + e.ToString());
        }
    }

    public void Btn_OnPress(GameObject btn)
    {
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnUIEvent");
            func.BeginPCall();

            func.Push("OnPress");
            func.Push(ScriptName);
            func.Push(btn);
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIScript Call Btn_OnPress Error:" + ScriptName + btn.name + e.ToString());
        }
    }

    public void Btn_OnPressure(GameObject btn)
    {
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnUIEvent");
            func.BeginPCall();

            func.Push("OnPressure");
            func.Push(ScriptName);
            func.Push(btn);
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIScript Call Btn_OnPressure Error:" + ScriptName + btn.name + e.ToString());
        }
    }

    public void Btn_OnRelease(GameObject btn)
    {
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnUIEvent");
            func.BeginPCall();

            func.Push("OnRelease");
            func.Push(ScriptName);
            func.Push(btn);
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIScript Call Btn_OnRelease Error:" + ScriptName + btn.name + e.ToString());
        }
    }

    public void Btn_OnDoubleClick(GameObject btn)
    {
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnUIEvent");
            func.BeginPCall();

            func.Push("OnDoubleClick");
            func.Push(ScriptName);
            func.Push(btn);
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIScript Call Btn_OnDoubleClick Error:" + ScriptName + btn.name + e.ToString());
        }
    }

    public void OnTweenFinished(GameObject tweenObject)
    {
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnUIEvent");
            func.BeginPCall();

            func.Push("OnTweenFinished");
            func.Push(ScriptName);
            func.Push(tweenObject);
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIScript Call OnTweenFinished Error:" + ScriptName + tweenObject.name + e.ToString());
        }
    }

    public void OnTypeWriterFinished(GameObject typeWriterObject)
    {
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnUIEvent");
            func.BeginPCall();

            func.Push("OnTypeWriterFinished");
            func.Push(ScriptName);
            func.Push(typeWriterObject);
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIScript Call OnTypeWriterFinished Error:" + ScriptName + typeWriterObject.name + e.ToString());
        }
    }

    public void OnInputChange(GameObject inputObj)
    {
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnUIEvent");
            func.BeginPCall();

            func.Push("OnInputChange");
            func.Push(ScriptName);
            func.Push(inputObj);
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIScript Call OnInputChange Error:" + ScriptName + inputObj.name + e.ToString());
        }
    }
    public void OnInputSubmit(GameObject inputObj)
    {
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnUIEvent");
            func.BeginPCall();

            func.Push("OnInputSubmit");
            func.Push(ScriptName);
            func.Push(inputObj);
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIScript Call OnInputSubmit Error:" + ScriptName + inputObj.name + e.ToString());
        }
    }

    public void OnSelect(UnityEngine.Object obj)
    {
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnUIEvent");
            func.BeginPCall();

            func.Push("OnSelect");
            func.Push(ScriptName);
            func.Push(obj);
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIScript Call OnSelect Error:" + ScriptName + obj.name + e.ToString());
        }
    }
    public void OnDeselect(UnityEngine.Object obj)
    {
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnUIEvent");
            func.BeginPCall();

            func.Push("OnDeselect");
            func.Push(ScriptName);
            func.Push(obj);
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIScript Call OnDeselect Error:" + ScriptName + obj.name + e.ToString());
        }
    }

    
    public void OnUIInputValueChange(UIInput component)
    {
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnUIEvent");
            func.BeginPCall();

            func.Push("OnUIInputValueChange");
            func.Push(ScriptName);
            func.Push(component);
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIScript Call OnUIInputValueChange Error:" + ScriptName + component.name + e.ToString());
        }
    }

    public void OnUIInputSubmit(UIInput component)
    {
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnUIEvent");
            func.BeginPCall();

            func.Push("OnUIInputSubmit");
            func.Push(ScriptName);
            func.Push(component);
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIScript Call OnUIInputSubmit Error:" + ScriptName + component.name + e.ToString());
        }
    }

    public void OnUIProgressBarValueChange(UIProgressBar component)
    {
        try
        {
            LuaFunction func = LuaRoot.Instance.Lua.GetFunction("OnUIEvent");
            func.BeginPCall();

            func.Push("OnUIProgressBarValueChange");
            func.Push(ScriptName);
            func.Push(component);
            func.PCall();
            func.EndPCall();
        }
        catch (System.Exception e)
        {
            LogSystem.Instance.Error("UIScript Call OnUIProgressBarValueChange Error:" + ScriptName + component.name + e.ToString());
        }
    }
}