using UnityEngine;
using System.Collections;
using System.Collections.Generic;

/// <summary>
/// UI面板某个区域引用
///         -UIModuleElement-UIModuleElement...
/// UIModule-UIModuleElement
///         -UIModuleElement
/// </summary>
public class UIElement 
{
    public List<UIElement> List_Element;
    public List<UISprite> List_Sprite;
    public List<UILabel> List_Label;
    public List<UIButton> List_Button;
    public List<GameObject> List_Object;
    public List<UITable> List_Table;
    public List<UIGrid> List_Grid;
    public List<UITexture> List_Texture;
    public List<TweenPosition> List_TweenPosition;
    public List<TweenScale> List_TweenScale;
    public List<UIWidget> List_UIWidget;
}