Shader "DemoShader/CompleteBlinnPhongPixelLevel-BuildInFunctions"
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
                o.worldNormal = UnityObjectToWorldNormal(v.normal);

                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;

                fixed3 worldNormal = normalize(i.worldNormal);
                fixed3 worldLightDir = normalize(UnityWorldSpaceLightDir(i.worldPos));
                fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * saturate(dot(worldNormal, worldLightDir));

                fixed3 viewDir = normalize(UnityWorldSpaceViewDir(i.worldPos));
                fixed3 halfDir = normalize(worldLightDir + viewDir);
                fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(saturate(dot(worldNormal, halfDir)), _Gloss);

                fixed3 color = ambient + diffuse + specular;

                return fixed4(color, 1.0);
            }

            ENDCG
        }
    }
    FallBack "Diffuse"
}