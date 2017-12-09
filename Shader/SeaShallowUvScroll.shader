Shader "Custom/SeaShallowUvScroll" {
    Properties {
        _MainTex("BaseWaterTexture (RGB)",2D) = "white" {} 	//ベースとなるテクスチャ
        _ScrollX("Scroll X", float) = 0						//横のスクロール量
        _ScrollY("Scroll Y", float) = 0 					//縦のスクロール量
    }
    SubShader {
        Tags { "RenderType"="Opaque" }
    LOD 200 //閾値指定、モバイルなどハードウェアを考慮

        CGPROGRAM
        #pragma surface surf Lambert
    // #pragma target 3.0 //　デフォルト target 2.5 許容しないハードウェアをサポートしないなど

        struct Input {
            float2 uv_MainTex; // 引数にスクロール用XYを渡しします。
        };

        sampler2D _MainTex;
        float _ScrollX, _ScrollY;

        void surf (Input IN, inout SurfaceOutput o) {
            float2 scroll = float2(_ScrollX, _ScrollY) * _SinTime.y; //スクロール量計算 sinをつかって往復している
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex + scroll); //スクロール量適用
        }
        ENDCG
    }
    FallBack "Diffuse"
}

