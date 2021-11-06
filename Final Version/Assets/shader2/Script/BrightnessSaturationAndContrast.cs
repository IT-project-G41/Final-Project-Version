using System.Collections;
using UnityEngine;

public class BrightnessSaturationAndContrast : PostEffectsBase
{

    public Shader briSatConShader;   //ָ����shader
    public Material briSatConMaterial = null;  //�����Ĳ���

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


    // ��дMonoBehaviour�е�OnRenderImage�������ú�����������������src��dest
    //src: ��Ӧ��Դ��������Ļ�������У��ò���ͨ���ǽ���ǰ��Ļ����Ⱦ���������һ�������õ�����Ⱦ����
    //dest: Ŀ������Ⱦ�������ֵΪnull�ͻ�ֱ�ӽ������ʾ����Ļ��
    //ÿ��OnRenderImage������ʱ������������Ƿ���á�������ã��ͽ������������ʣ��ٵ���Graphic.Blit���д������򣬽�ԭͼ����ʾ����Ļ�ϣ������κδ���
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
