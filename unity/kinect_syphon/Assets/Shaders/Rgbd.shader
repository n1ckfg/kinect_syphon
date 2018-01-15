Shader "Custom/Rgbd" {

    Properties {
        _MainTex1 ("RGB Texture", 2D) = "white" {}
        _MainTex2 ("Depth Texture", 2D) = "white" {}
	}
    
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			//#pragma multi_compile_fog // make fog work
			#include "UnityCG.cginc"

			struct appdata {
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f {
				float2 uv : TEXCOORD0;
				//UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

            sampler2D _MainTex1;
            sampler2D _MainTex2;
			float4 _MainTex1_ST;
			
			v2f vert (appdata v) {
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex1);
				//UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target {
                fixed4 rgb = tex2D(_MainTex1, i.uv);
                fixed4 depth = tex2D(_MainTex2, i.uv);
                fixed4 col = fixed4(rgb.xyz, depth.x);
           
				//UNITY_APPLY_FOG(i.fogCoord, col); // apply fog

                return col;
			}
			ENDCG
		}
	}
    
}
