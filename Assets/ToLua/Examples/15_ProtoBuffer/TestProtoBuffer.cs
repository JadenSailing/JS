//#define USE_PROTOBUF_NET
using UnityEngine;
using System.Collections;
using LuaInterface;
using System;
using System.IO;

#if USE_PROTOBUF_NET
using ProtoBuf;

[ProtoContract]
class Header
{
    [ProtoMember(1, IsRequired = true)]
    public int cmd { get; set; }

    [ProtoMember(2, IsRequired = true)]
    public int seq { get; set; }
}

[ProtoContract]
class Person
{
    [ProtoMember(1, IsRequired = true)]
    public Header header { get; set; }
    [ProtoMember(2, IsRequired = true)]
    public long id { get; set; }

    [ProtoMember(3, IsRequired = true)]
    public string name { get; set; }

    [ProtoMember(4, IsRequired = false)]
    public int age { get; set; }

    [ProtoMember(5, IsRequired = false)]
    public string email { get; set; }

    [ProtoMember(6, IsRequired = true)]
    public int[] array;
}

#endif

public class TestProtoBuffer : LuaClient
{
    private string script = @"      
        local common_pb = require 'Protol.common_pb'
        local person_pb = require 'Protol.person_pb'
       
        function Decoder()  
            local value, pos;
            local pb = require 'pb';
            local _DecodeVarint = pb.signed_varint_decoder
            local tmpBytes = TestProtol.data2
            local testStr = '12345';
            local c1 = os.clock();
            for i = 1, 10000 do
                --local a,b = 1,2
                --local c = a + b -- 0.005;
                --value, pos = _DecodeVarint(TestProtol.data, 0) --0.263s
                --value = testStr[0]; --0.2s
                --value = TestProtol.data[0];   --访问luabuffer 0.263s
                --value = TestProtol.data2[0];  --访问bytes index 1.45s
                --value = TestProtol.GetInt(0);   --调用C# 无bytes 0.279s
                --value = TestProtol.GetInt3(0, 0)--调用C# int,int 0.355s 
                --value = TestProtol.GetInt2(tmpBytes, 0)--调用C# 有bytes 0.475
                --value = TestProtol.GetInt4(tmpBytes,0, 0)--调用C# byte int int 0.554
                --value,pos = TestProtol.GetInt5(tmpBytes,0, 0,0)--调用C# byte int int 0.61
            end
            local c2 = os.clock();
            --print('测试时间=' .. (c2-c1));
            --print('test protocol value =' .. value .. ', pos now =' .. pos);
            --[[
            local c1 = os.clock();
            local msg = person_pb.Person()
            for i=1, 1000 do
                msg:ParseFromString(TestProtol.data)
            end
            local c2 = os.clock();
            print('cost time = ' .. (c2-c1));
            --tostring 不会打印默认值
            --print('person_pb decoder: '..tostring(msg)..'age: '..msg.age..'\nemail: '..msg.email)
            --]]
        end

        function Encoder()                     
            local msg = person_pb.Person()                                 
            msg.header.cmd = 10010                                 
            msg.header.seq = 1
            msg.id = '1223372036854775807'            
            msg.name = 'foo'              
            --数组添加                              
            msg.array:append(1)                              
            msg.array:append(2)            
            --extensions 添加
            local phone = msg.Extensions[person_pb.Phone.phones]:add()
            phone.num = '13788888888'      
            phone.type = person_pb.Phone.MOBILE      
            local pb_data = msg:SerializeToString()                   
            TestProtol.data = pb_data
        end
        ";

    private string tips = "";

    //实际应用如Socket.Send(LuaStringBuffer buffer)函数发送协议, 在lua中调用Socket.Send(pb_data)
    //读取协议 Socket.PeekMsgPacket() {return MsgPacket}; lua 中，取协议字节流 MsgPack.data 为 LuaStringBuffer类型
    //msg = Socket.PeekMsgPacket() 
    //pb_data = msg.data    
    new void Awake()
    {
#if UNITY_5		
        Application.logMessageReceived += ShowTips;
#else
        Application.RegisterLogCallback(ShowTips);
#endif  
        base.Awake();
    }

    protected override LuaFileUtils InitLoader()
    {
        return new LuaResLoader();
    }

    protected override void Bind()
    {
        base.Bind();
        luaState.BeginModule(null);
        //TestProtolWrap.Register(luaState);
        luaState.EndModule();
    }

    //屏蔽，例子不需要运行
    protected override void CallMain() { }

    protected override void OnLoadFinished()
    {
        base.OnLoadFinished();
        luaState.DoString(script, "TestProtoBuffer.cs");

#if !USE_PROTOBUF_NET
        //LuaFunction func = luaState.GetFunction("Encoder");
        //func.Call();
        //func.Dispose();
        TestProtol.data = new byte[100];
        TestProtol.data[0] = 100;
        TestProtol.data[1] = 3;
        TestProtol.data[2] = 2;
        TestProtol.data[3] = 1;

        TestProtol.data2 = new byte[100];
        TestProtol.data2[0] = 100;
        TestProtol.data2[1] = 3;
        TestProtol.data2[2] = 2;
        TestProtol.data2[3] = 1;

        LuaFunction func = luaState.GetFunction("Decoder");
        //UnityEngine.Profiler.BeginSample("***************");
        func.Call();
        //UnityEngine.Profiler.EndSample();
        func.Dispose();
        func = null;
#else
        Person data = new Person();
        data.id = 1223372036854775807;
        data.name = "foo";
        data.header = new Header();
        data.header.cmd = 10086;
        data.header.seq = 1;
        data.array = new int[2];
        data.array[0] = 1;
        data.array[1] = 2;
        MemoryStream stream = new MemoryStream();
        Serializer.Serialize<Person>(stream, data);
        TestProtol.data = stream.ToArray();

        LuaFunction func = luaState.GetFunction("Decoder");
        func.Call();
        func.Dispose();
        func = null;

        func = luaState.GetFunction("Encoder");
        func.Call();
        func.Dispose();
        func = null;

        stream = new MemoryStream(TestProtol.data);
        data = Serializer.Deserialize<Person>(stream);
        Debugger.Log("Decoder from lua int64 is: {0}, cmd: {1}", data.id, data.header.cmd);
#endif
    }

    private void Update()
    {
        UnityEngine.Profiler.BeginSample("@@@@@@@@@@@@@");
        LuaFunction func = luaState.GetFunction("Decoder");
        func.Call();
        UnityEngine.Profiler.EndSample();
        func.Dispose();
        func = null;
    }

    void ShowTips(string msg, string stackTrace, LogType type)
    {
        tips = tips + msg + "\r\n";
    }

    void OnGUI()
    {
        GUI.Label(new Rect(Screen.width / 2 - 250, Screen.height / 2 - 200, 500, 500), tips);
    }

    new void OnApplicationQuit()
    {
        base.Destroy();
#if UNITY_5
        Application.logMessageReceived -= ShowTips;
#else
        Application.RegisterLogCallback(null);
#endif
    }
}
