Shader "PA/TransparentRoundedRectangleHalf"
{
	Properties
	{
		_MainTex ("Base (RGB), Alpha (A)", 2D) = "black" {}
		_Radius ("°ë¾¶",Range( 0.0 , 0.5 )) = 1
		_Radio("¿í¸ß±È",Range(0.1, 10)) = 1
	}
	
	SubShader
	{
		LOD 150

		Tags
		{
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderType" = "Transparent"
		}
		
		Pass
		{
			Cull Off
			Lighting Off
			ZWrite Off
			Fog { Mode Off }
			Offset -1, -1
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag			
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float _Radius;
			float _Radio;
	
			struct appdata_t
			{
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
				fixed4 color : COLOR;
			};
	
			struct v2f
			{
				float4 vertex : SV_POSITION;
				half2 texcoord : TEXCOORD0;
				fixed4 color : COLOR;
			};
	
			v2f o;

			v2f vert (appdata_t v)
			{
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.texcoord = v.texcoord;
				o.color = v.color;
				return o;
			}
				
			fixed4 frag (v2f IN) : COLOR
			{
				//Ô²½Ç¾ØÐÎ
				float alpha = 1;
				fixed deltaX = (IN.texcoord.x - 0.5);
				fixed deltaY = (IN.texcoord.y - 0.5);
				deltaX = (0.5 - abs(deltaX)) * _Radio;
				if (deltaY < 0)
				{
					alpha = 1;
				}
				else
				{
					deltaY = 0.5 - abs(deltaY);
					if ((deltaX < _Radius) && (deltaY < _Radius))
					{
						deltaX = _Radius - deltaX;
						deltaY = _Radius - deltaY;
						if (deltaX * deltaX + deltaY * deltaY > _Radius * _Radius)
						{
							alpha = 0;
						}
					}
				}
				
				return tex2D(_MainTex, IN.texcoord) * IN.color * alpha;
			}
			ENDCG
		}
	}
}
