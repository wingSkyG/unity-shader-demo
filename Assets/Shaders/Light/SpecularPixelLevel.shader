Shader "DemoShader/SpecularPixelLevel"
{
    Properties
    {
        _Diffuse ("Diffuse", Color) =  (1, 1, 1, 1)
        _Specular ("Specular", Color) =  (1, 1, 1, 1)
        _Gloss ("Gloss", Range(8., 256.)) = 20
    }

    SubShader
    {
        Pass
        {
            Tags { "LightMode" = "ForwardBase" }

            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "Lighting.cginc"

            fixed4 _Diffuse;
            fixed4 _Specular;
            float _Gloss;

            struct v2f
            {
                float4 pos : SV_POSITION;
                fixed3 worldPos : TEXCOORD1;
                fixed3 worldNormal : TEXCOORD0;
            };

            v2f vert(appdata_base v)
            {
                v2f o;

                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);

                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                fixed3 worldNormal = normalize(i.worldNormal);
                fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
                fixed3 reflectDir = normalize(reflect(-worldLightDir, worldNormal));
                fixed3 viewDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
                fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(saturate(dot(reflectDir, viewDir)), _Gloss);

                return fixed4(specular, 1.);
            }

            ENDCG
        }
    }
}