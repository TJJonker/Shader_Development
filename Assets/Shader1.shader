Shader "Unlit/Shader1"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
        _Scale ("UV Scale", float) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            float4 _Color;
            float _Scale;

            struct MeshData {
                float4 vertex : POSITION;
                float3 normals : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct Interpolators {
                float4 vertex : SV_POSITION;
                float3 normal : TEXCOORD0;
                float2 uv : TEXCOORD1;
            };

            Interpolators vert (MeshData v) {
                Interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normals);
                o.uv = v.uv * _Scale;
                return o;
            }

            fixed4 frag (Interpolators i) : SV_Target {
                return float4(i.uv.yx, 0, 1);
            }
            ENDCG
        }
    }
}
