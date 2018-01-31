using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
public class LogSystem : Singleton<LogSystem>
{
    public void Error(string msg)
    {
        UnityEngine.Debug.LogError(msg);
    }
}