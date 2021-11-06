using System.Collections;
using UnityEngine;

public class BrightnessSaturationAndContrast : PostEffectsBase
{

    public Shader briSatConShader;   //指定的shader
    public Material briSatConMaterial = null;  //创建的材质

    public Material material
    {
        get
        {
            briSatConMaterial = CheckShaderAndCreateMaterial(briSatConShader, briSatConMaterial);
            return briSatConMaterial;
        }
    }

    [Range(0.0f, 3.0f)]
    public float brightness = 1.0f;

    [Range(0.0f, 3.0f)]
    public float saturation = 1.0f;

    [Range(0.0f, 3.0f)]
    public float contrast = 1.0f;


    // 重写MonoBehaviour中的OnRenderImage函数，该函数接收两个参数，src和dest
    //src: 对应的源纹理，在屏幕后处理技术中，该参数通常是将当前屏幕的渲染纹理或是上一步处理后得到的渲染纹理
    //dest: 目标是渲染纹理，如果值为null就会直接将结果显示在屏幕上
    //每当OnRenderImage被调用时，它会检查材质是否可用。如果可用，就将参数传给材质，再调用Graphic.Blit进行处理；否则，将原图像显示到屏幕上，不做任何处理
    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        if(material != null)
        {
            material.SetFloat("_Brightness", brightness);
            material.SetFloat("_Saturation", saturation);
            material.SetFloat("_Contrast", contrast);

            Graphics.Blit(src, dest, material);
        }
        else
        {
            Graphics.Blit(src, dest);
        }
    }


  
}
