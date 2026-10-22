Shader "DemoShader/Light/Ambient"
{
    SubShader
    {
        Pass
        {
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            struct v2f
            {
                float4 pos : SV_POSITION;
                fixed3 color : COLOR;
            };

            v2f vert(float4 v : POSITION)
            {
                v2f o;

                o.pos = UnityObjectToClipPos(v);
                o.color = UNITY_LIGHTMODEL_AMBIENT.xyz;

                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                return fixed4(i.color, 1.);
            }

            ENDCG
        }
    }
}

// Shader "DemoShader/Ambient"
// {
//     SubShader
//     {
//         Pass
//         {
//             CGPROGRAM

//             #pragma vertex vert
//             #pragma fragment frag

//             float4 vert(float4 v : POSITION) : SV_POSITION
//             {
//                 return UnityObjectToClipPos(v);
//             }

//             fixed4 frag() : SV_Target
//             {
//                 return fixed4(UNITY_LIGHTMODEL_AMBIENT.xyz, 1.);
//             }

//             ENDCG
//         }
//     }
// }