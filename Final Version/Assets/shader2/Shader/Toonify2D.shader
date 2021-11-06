Shader "Custom/Toonifu2D"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        
        CGINCLUDE
        #include "UnityCG.cginc"

        

        sampler2D _MainTex;
        half4 _MainTex_TexelSize;
        




        struct v2f{
            float4 pos : SV_POSITION;
            half2 uv : TEXCOORD0;
            //fixed3 mid_color : COLOR0;
        };


        //����ĳһ���rbg�Ӻ�
        fixed getRGBSum(fixed3 color){
            return color.r + color.g + color.b;
        }


        //����Ҷ�ֵ
        fixed lumiance(fixed3 color){
            return 0.2125 * color.r + 0.7154 * color.g + 0.0721 * color.b;
        }

        //��ֵ�˲�
        fixed3 medianFilter(half2 uv){
                //half2 uv = f.uv;
                
                half2 tex7[49] = {uv + float2(-_MainTex_TexelSize.x * 3.0, _MainTex_TexelSize.y * 3.0), uv + float2(-_MainTex_TexelSize.x * 2.0, _MainTex_TexelSize.y * 3.0), uv + float2(-_MainTex_TexelSize.x * 1.0, _MainTex_TexelSize.y * 3.0), uv + float2(0.0, _MainTex_TexelSize.y * 3.0), uv + float2(_MainTex_TexelSize.x * 1.0, _MainTex_TexelSize.y * 3.0), uv + float2(_MainTex_TexelSize.x * 2.0, _MainTex_TexelSize.y * 3.0), uv + float2(_MainTex_TexelSize.x * 3.0, _MainTex_TexelSize.y * 3.0), 
                                uv + float2(-_MainTex_TexelSize.x * 3.0, _MainTex_TexelSize.y * 2.0), uv + float2(-_MainTex_TexelSize.x * 2.0, _MainTex_TexelSize.y * 2.0), uv + float2(-_MainTex_TexelSize.x * 1.0, _MainTex_TexelSize.y * 2.0), uv + float2(0.0, _MainTex_TexelSize.y * 2.0), uv + float2(_MainTex_TexelSize.x * 1.0, _MainTex_TexelSize.y * 2.0), uv + float2(_MainTex_TexelSize.x * 2.0, _MainTex_TexelSize.y * 2.0), uv + float2(_MainTex_TexelSize.x * 3.0, _MainTex_TexelSize.y * 2.0), 
                                uv + float2(-_MainTex_TexelSize.x * 3.0, _MainTex_TexelSize.y * 1.0), uv + float2(-_MainTex_TexelSize.x * 2.0, _MainTex_TexelSize.y * 1.0), uv + float2(-_MainTex_TexelSize.x * 1.0, _MainTex_TexelSize.y * 1.0), uv + float2(0.0, _MainTex_TexelSize.y * 1.0), uv + float2(_MainTex_TexelSize.x * 1.0, _MainTex_TexelSize.y * 1.0), uv + float2(_MainTex_TexelSize.x * 2.0, _MainTex_TexelSize.y * 1.0), uv + float2(_MainTex_TexelSize.x * 3.0, _MainTex_TexelSize.y * 1.0), 
                                uv + float2(-_MainTex_TexelSize.x * 3.0, 0.0), uv + float2(-_MainTex_TexelSize.x * 2.0, 0.0), uv + float2(-_MainTex_TexelSize.x * 1.0, 0.0), uv, uv + float2(_MainTex_TexelSize.x * 1.0, 0.0), uv + float2(_MainTex_TexelSize.x * 2.0, 0.0), uv + float2(_MainTex_TexelSize.x * 3.0, 0.0), 
                                uv - float2(_MainTex_TexelSize.x * 3.0, _MainTex_TexelSize.y * 1.0), uv - float2(_MainTex_TexelSize.x * 2.0, _MainTex_TexelSize.y * 1.0), uv - float2(_MainTex_TexelSize.x * 1.0, _MainTex_TexelSize.y * 1.0), uv - float2(0.0, _MainTex_TexelSize.y * 1.0), uv - float2(-_MainTex_TexelSize.x * 1.0, _MainTex_TexelSize.y * 1.0), uv - float2(-_MainTex_TexelSize.x * 2.0, _MainTex_TexelSize.y * 1.0), uv - float2(-_MainTex_TexelSize.x * 3.0, _MainTex_TexelSize.y * 1.0),
                                uv - float2(_MainTex_TexelSize.x * 3.0, _MainTex_TexelSize.y * 2.0), uv - float2(_MainTex_TexelSize.x * 2.0, _MainTex_TexelSize.y * 2.0), uv - float2(_MainTex_TexelSize.x * 1.0, _MainTex_TexelSize.y * 2.0), uv - float2(0.0, _MainTex_TexelSize.y * 2.0), uv - float2(-_MainTex_TexelSize.x * 1.0, _MainTex_TexelSize.y * 2.0), uv - float2(-_MainTex_TexelSize.x * 2.0, _MainTex_TexelSize.y * 2.0), uv - float2(-_MainTex_TexelSize.x * 3.0, _MainTex_TexelSize.y * 2.0),
                                uv - float2(_MainTex_TexelSize.x * 3.0, _MainTex_TexelSize.y * 3.0), uv - float2(_MainTex_TexelSize.x * 2.0, _MainTex_TexelSize.y * 3.0), uv - float2(_MainTex_TexelSize.x * 1.0, _MainTex_TexelSize.y * 3.0), uv - float2(0.0, _MainTex_TexelSize.y * 3.0), uv - float2(-_MainTex_TexelSize.x * 1.0, _MainTex_TexelSize.y * 3.0), uv - float2(-_MainTex_TexelSize.x * 2.0, _MainTex_TexelSize.y * 3.0), uv - float2(-_MainTex_TexelSize.x * 3.0, _MainTex_TexelSize.y * 3.0)};
                
                /*
                half2 tex5[25] = {uv + _MainTex_TexelSize.xy * half2(-2, 2), uv + _MainTex_TexelSize.xy * half2(-1, 2), uv + _MainTex_TexelSize.xy * half2(0, 2), uv + _MainTex_TexelSize.xy * half2(1, 2), uv + _MainTex_TexelSize.xy * half2(2, 2), 
                                uv + _MainTex_TexelSize.xy * half2(-2, 1), uv + _MainTex_TexelSize.xy * half2(-1, 1), uv + _MainTex_TexelSize.xy * half2(0, 1), uv + _MainTex_TexelSize.xy * half2(1, 1), uv + _MainTex_TexelSize.xy * half2(2, 1), 
                                uv + _MainTex_TexelSize.xy * half2(-2, 0), uv + _MainTex_TexelSize.xy * half2(-1, 0), uv + _MainTex_TexelSize.xy * half2(0, 0), uv + _MainTex_TexelSize.xy * half2(1, 0), uv + _MainTex_TexelSize.xy * half2(2, 0), 
                                uv + _MainTex_TexelSize.xy * half2(-2, -1), uv + _MainTex_TexelSize.xy * half2(-1, -1), uv + _MainTex_TexelSize.xy * half2(0, -1), uv + _MainTex_TexelSize.xy * half2(1, -1), uv + _MainTex_TexelSize.xy * half2(2, -1), 
                                uv + _MainTex_TexelSize.xy * half2(-2, -2), uv + _MainTex_TexelSize.xy * half2(-1, -2), uv + _MainTex_TexelSize.xy * half2(0, -2), uv + _MainTex_TexelSize.xy * half2(1, -2), uv + _MainTex_TexelSize.xy * half2(2, -2)};


                half2 tex[9] = {uv + float2(-_MainTex_TexelSize.x, _MainTex_TexelSize.y), uv + float2(0.0, _MainTex_TexelSize.y), uv + float2(_MainTex_TexelSize.x, _MainTex_TexelSize.y), 
                                uv + float2(-_MainTex_TexelSize.x, 0.0), uv, uv + float2(_MainTex_TexelSize.x, 0.0), 
                                uv - float2(_MainTex_TexelSize.x, _MainTex_TexelSize.y), uv - float2(0.0, _MainTex_TexelSize.y), uv - float2(-_MainTex_TexelSize.x, _MainTex_TexelSize.y)};


                
                half2 temp = tex[0];
                
                int index = 0;
                [unroll]
                for(int i = 0; i < 49; i++){
                    [unroll]
                    for(int j = i; j < 49; j++){
                        [branch]
                        if(lumiance(tex2D(_MainTex, tex7[j]).rgb) < lumiance(tex2D(_MainTex, tex7[index]).rgb)){
                            index = j;
                        }
                    }
                    half2 temp = tex7[i];
                    tex7[i] = tex7[index];
                    tex7[index] = tex7[i];
                }
                */


                fixed3 last = (0, 0, 0);
                fixed3 temp = tex2D(_MainTex, tex7[0]).rgb;
                [unroll]
                for(int i = 0; i < 25; i++){

                    [unroll]
                    for(int j = 0; j < 49; j++){
                        fixed3 color = tex2D(_MainTex, tex7[j]).rgb;
                        fixed w1 = step(color, temp);
                        fixed w2 = step(temp, last);
                        temp = lerp(temp, color, w1*w2);
                    }

                    last = temp;
                }


                return temp;


                /*
                int index = 0;
                for(int i = 0; i < 25; i++){
                    for(int j = i; j < 25; j++){
                        if(getRGBSum(tex2D(_MainTex, tex5[j]).rgb) < getRGBSum(tex2D(_MainTex, tex5[index]).rgb)){
                            index = j;
                        }
                    }
                    half2 temp = tex5[i];
                    tex5[i] = tex5[index];
                    tex5[index] = tex5[i];
                }

                return tex2D(_MainTex, tex5[12]).rgb;
                */
        }


        //��ɫ����
        fixed3 QuantizeColors(fixed3 color){
            //return fixed3(floor(float(color.r) * 0.04167), floor(float(color.g) * 0.04167), floor(float(color.b) * 0.04167)) * 24;
            //return floor(color / 24) * 24;
            return floor(color * 255 * 0.04166667) * 24 * 0.00392157;
        }


        //����Ҷ�ֵ
        fixed luminance(fixed3 color){
            return 0.2125 * color.r + 0.7154 * color.g + 0.0721 * color.b;
        }



        half Sobel(half2 uv){
            const half Gx[9] = {-1, -2, -1, 
                            0, 0, 0, 
                            1, 2, 1};
            const half Gy[9] = {-1, 0, 1, 
                            -2, 0, 2,
                            -1, 0, 1};
            
            //half2 uv = f.uv[2];
            half2 tex[9] = {uv + _MainTex_TexelSize.xy * half2(-1, -1), uv + _MainTex_TexelSize.xy * half2(0, -1), uv + _MainTex_TexelSize.xy * half2(1, -1),
                            uv +  _MainTex_TexelSize.xy * half2(-1, 0), uv,  uv + _MainTex_TexelSize.xy * half2(1, 0), 
                            uv + _MainTex_TexelSize.xy * half2(-1, 1), uv + _MainTex_TexelSize.xy * half2(0, 1), uv + _MainTex_TexelSize.xy * half2(1, 1)};

            half texColor;
            half edgeX = 0;
            half edgeY = 0;
            [unroll]
            for(int i = 0; i < 9; i++){
                texColor = luminance(tex2D(_MainTex, tex[i]).rgb);
                edgeX += texColor * Gx[i];
                edgeY += texColor * Gy[i];
            }

            half edge = 1 - abs(edgeX) - abs(edgeY);


            return edge;
        }



        //˫���˲�
        fixed3 BilateralFliter(half2 uv){
                half2 tex5[25] = {uv + _MainTex_TexelSize.xy * half2(-2, 2), uv + _MainTex_TexelSize.xy * half2(-1, 2), uv + _MainTex_TexelSize.xy * half2(0, 2), uv + _MainTex_TexelSize.xy * half2(1, 2), uv + _MainTex_TexelSize.xy * half2(2, 2), 
                                uv + _MainTex_TexelSize.xy * half2(-2, 1), uv + _MainTex_TexelSize.xy * half2(-1, 1), uv + _MainTex_TexelSize.xy * half2(0, 1), uv + _MainTex_TexelSize.xy * half2(1, 1), uv + _MainTex_TexelSize.xy * half2(2, 1), 
                                uv + _MainTex_TexelSize.xy * half2(-2, 0), uv + _MainTex_TexelSize.xy * half2(-1, 0), uv + _MainTex_TexelSize.xy * half2(0, 0), uv + _MainTex_TexelSize.xy * half2(1, 0), uv + _MainTex_TexelSize.xy * half2(2, 0), 
                                uv + _MainTex_TexelSize.xy * half2(-2, -1), uv + _MainTex_TexelSize.xy * half2(-1, -1), uv + _MainTex_TexelSize.xy * half2(0, -1), uv + _MainTex_TexelSize.xy * half2(1, -1), uv + _MainTex_TexelSize.xy * half2(2, -1), 
                                uv + _MainTex_TexelSize.xy * half2(-2, -2), uv + _MainTex_TexelSize.xy * half2(-1, -2), uv + _MainTex_TexelSize.xy * half2(0, -2), uv + _MainTex_TexelSize.xy * half2(1, -2), uv + _MainTex_TexelSize.xy * half2(2, -2)};
                
                half weight[25] = {0.0030, 0.0133, 0.0219, 0.0133, 0.0030,
                                   0.0133, 0.0596, 0.0983, 0.0596, 0.0133,
                                   0.0219, 0.0983, 0.1621, 0.0983, 0.0219, 
                                   0.0133, 0.0596, 0.0983, 0.0596, 0.0133,
                                   0.0030, 0.0133, 0.0219, 0.0133, 0.0030};

                fixed3 centerLum = lumiance(tex2D(_MainTex, tex5[12]).rgb);
                fixed3 res = (0, 0, 0);
                [unroll]
                for(int i = 0; i < 25; i++){
                    //res += tex2D(_MainTex, tex5[i]).rgb * weight[i] * normalize(Sobel(tex5[i]));
                    
                    fixed3 temp_color = tex2D(_MainTex, tex5[i]).rgb;
                    fixed final_weight = weight[i] * (1 - abs(centerLum - lumiance(temp_color)));
                    res += temp_color * final_weight;
                    
                }

                return res;
        }



        v2f vert(appdata_img v){
            v2f f;
            f.pos = UnityObjectToClipPos(v.vertex);
            f.uv = v.texcoord;
            return f;
        }


        fixed4 fragEdges(v2f f) : SV_Target{
                
            fixed3 midColor = medianFilter(f.uv);
            
            half edge = Sobel(f.uv);

            fixed4 edgeColor = fixed4(0, 0, 0, 1);
            fixed4 backgroundColor = fixed4(midColor, 1);

            fixed4 onlyEdgeColor = lerp(edgeColor, backgroundColor, edge);

            return onlyEdgeColor;
        }

        fixed4 fragColor(v2f f) : SV_Target{
            fixed3 BF_color = BilateralFliter(f.uv);

            fixed3 midColor = medianFilter(f.uv);
            fixed3 quantize_color = QuantizeColors(midColor * BF_color);

            return fixed4(quantize_color * 1.7, 1);
        }




        ENDCG


        ZTest Always Cull Off ZWrite Off
        
        
        Pass{
            
            NAME "EDGES_EFFECT"

            CGPROGRAM
            #pragma vertex vert  
		    #pragma fragment fragEdges 
           
            /*
            half2 getTextList(half2 uv){
                half2 texList[49] = {};
                texList[0] = uv;
                texList[1] = uv + float2(0.0, _MainTex_TexelSize.y * 1.0);
                texList[2] = uv + float2(0.0, _MainTex_TexelSize.y * 2.0);
                texList[3] = uv + float2(0.0, _MainTex_TexelSize.y * 3.0);
                texList[4] = uv - float2(0.0, _MainTex_TexelSize.y * 1.0);
                texList[5] = uv - float2(0.0, _MainTex_TexelSize.y * 2.0);
                texList[6] = uv - float2(0.0, _MainTex_TexelSize.y * 3.0);

                for(int i = 1; i < 4; i++){
                    int index = i * 2 - 1;    //1, 3, 5
                    int index2 = index + 1;

                    texList[index * 7] = uv + float2(_MainTex_TexelSize.x * i, 0.0);
                    texList[index * 7 + 1] = texList[index * 7] + float2(0.0, _MainTex_TexelSize.y * 1.0);
                    texList[index * 7 + 2] = texList[index * 7] + float2(0.0, _MainTex_TexelSize.y * 2.0);
                    texList[index * 7 + 3] = texList[index * 7] + float2(0.0, _MainTex_TexelSize.y * 3.0);
                    texList[index * 7 + 4] = texList[index * 7] - float2(0.0, _MainTex_TexelSize.y * 1.0);
                    texList[index * 7 + 5] = texList[index * 7] - float2(0.0, _MainTex_TexelSize.y * 2.0);
                    texList[index * 7 + 6] = texList[index * 7] - float2(0.0, _MainTex_TexelSize.y * 3.0);


                    texList[index2 * 7] = uv - float2(_MainTex_TexelSize.x * i, 0.0);
                    texList[index2 * 7 + 1] = texList[index2 * 7] + float2(0.0, _MainTex_TexelSize.y * 1.0);
                    texList[index2 * 7 + 2] = texList[index2 * 7] + float2(0.0, _MainTex_TexelSize.y * 2.0);
                    texList[index2 * 7 + 3] = texList[index2 * 7] + float2(0.0, _MainTex_TexelSize.y * 3.0);
                    texList[index2 * 7 + 4] = texList[index2 * 7] - float2(0.0, _MainTex_TexelSize.y * 1.0);
                    texList[index2 * 7 + 5] = texList[index2 * 7] - float2(0.0, _MainTex_TexelSize.y * 2.0);
                    texList[index2 * 7 + 6] = texList[index2 * 7] - float2(0.0, _MainTex_TexelSize.y * 3.0);
                }

                return texList;
            }
            */

            ENDCG
        }


        
        Pass{
            
            NAME "COLOR_EFFECT"

            CGPROGRAM
            #pragma vertex vert  
		    #pragma fragment fragColor 
            ENDCG

        }

        
    }
    FallBack Off
}
