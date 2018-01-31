using System;
using LuaInterface;

public static class TestProtol
{
    [LuaByteBufferAttribute]
    public static byte[] data;
    public static byte[] data2;

    public static int GetInt(int index)
    {
        return data2[index];
    }

    public static int GetInt2(byte[] bytes, int index)
    {
        return bytes[index];
    }

    public static int GetInt3(int index, int size)
    {
        return data2[index];
    }

    public static int GetInt4(byte[] bytes, int index, int size)
    {
        return bytes[index];
    }

    public static int GetInt5(byte[] bytes, int index, int size, out int pos)
    {
        pos = 0;
        return bytes[index];
    }
}
