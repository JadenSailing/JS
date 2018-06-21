using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
public class LuaHelper
{
    /// <summary>
    /// 按位与
    /// </summary>
    /// <param name="lhs"></param>
    /// <param name="rhs"></param>
    /// <returns></returns>
    public static uint BitAnd(uint lhs, uint rhs)
    {
        return lhs & rhs;
    }

    /// <summary>
    /// 按位或
    /// </summary>
    /// <param name="lhs"></param>
    /// <param name="rhs"></param>
    /// <returns></returns>
    public static uint BitOr(uint lhs, uint rhs)
    {
        return lhs | rhs;
    }
}
