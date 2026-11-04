Shader "DemoShader/Basic"
{
    Properties
    {
		_Color ("Color Tint", Color) = (1, 1, 1, 1)
		_MainTex ("Image Sequence", 2D) = "white" {}
    	_HorizontalAmount ("Horizontal Amount", Float) = 4
    	_VerticalAmount ("Vertical Amount", Float) = 4
    	_Speed ("Speed", Range(1, 100)) = 30
	}

    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Geometry"}

        Pass
        {
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            float4 vert(float4 v : POSITION) : SV_POSITION
            {
                return UnityObjectToClipPos(v);
            }

            fixed4 frag() : SV_Target
            {
                return fixed4(.3, 1., 1., 1.);
            }

            ENDCG
        }
    }
}