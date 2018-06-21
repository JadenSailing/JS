using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
public class LogSystem : Singleton<LogSystem>
{
    public void Info(string msg)
    {
        UnityEngine.Debug.Log(msg);
    }

    public void Error(string msg)
    {
        UnityEngine.Debug.LogError(msg);
    }
}