using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

public struct ResourceLoadItem
{
    public ResourceRequest request;
    public int loadIndex;
    public int id;
}

/// <summary>
/// 临时测试类
/// 需要单独实现，这里是提供个范例，不考虑bundle加载和卸载。
/// </summary>
public class ResourceManager_Lua : Singleton<ResourceManager_Lua>
{
    private static int _loadIndex = 0;

    private List<ResourceLoadItem> _loadingResList = new List<ResourceLoadItem>();

    private List<ResourceLoadItem> _loadingInstList = new List<ResourceLoadItem>();

    public UnityEngine.Object Load(int id, string path)
    {
        return Resources.Load(path);
    }

    /// <summary>
    /// 异步加载
    /// </summary>
    /// <param name="id"></param>
    /// <param name="path"></param>
    public int LoadAync(int id, string path)
    {
        ResourceRequest req = Resources.LoadAsync(path, typeof(UnityEngine.Object));
        ResourceLoadItem item = new ResourceLoadItem();
        item.request = req;
        item.loadIndex = _loadIndex++;
        item.id = id;
        _loadingResList.Add(item);
        return item.loadIndex;
    }

    /// <summary>
    /// 异步实例化
    /// </summary>
    /// <param name="id"></param>
    /// <param name="path"></param>
    /// <returns></returns>
    public int InstantiateAsync(int id, string path)
    {
        ResourceRequest req = Resources.LoadAsync(path, typeof(UnityEngine.GameObject));
        ResourceLoadItem item = new ResourceLoadItem();
        item.request = req;
        item.loadIndex = _loadIndex++;
        item.id = id;
        _loadingInstList.Add(item);
        return item.loadIndex;
    }
    
    public void Tick()
    {
        for (int i = 0; i < _loadingResList.Count; i++)
        {
            if(_loadingResList[i].request.isDone)
            {
                OnResourceLoaded(_loadingResList[i].loadIndex, _loadingResList[i].request.asset);
                _loadingResList.RemoveAt(i);
                i--;
            }
        }

        for (int i = 0; i < _loadingInstList.Count; i++)
        {
            if (_loadingInstList[i].request.isDone)
            {
                OnResourceLoaded(_loadingInstList[i].loadIndex, GameObject.Instantiate(_loadingInstList[i].request.asset));
                _loadingInstList.RemoveAt(i);
                i--;
            }
        }
    }

    private void OnResourceLoaded(int index, UnityEngine.Object res)
    {
        LuaCall.Instance.OnResourceLoaded(index, res);
    }
}
