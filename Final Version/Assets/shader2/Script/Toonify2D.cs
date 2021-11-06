using System.Collections;
using UnityEngine;

public class Toonify2D : MonoBehaviour
{
	public Shader gaussianBlurShader;
	private Material gaussianBlurMaterial = null;


	protected Material CheckShaderAndCreateMaterial(Shader shader, Material material)
	{
		if (shader == null)
		{
			return null;
		}

		if (shader.isSupported && material && material.shader == shader)
			return material;

		if (!shader.isSupported)
		{
			return null;
		}
		else
		{
			material = new Material(shader);
			material.hideFlags = HideFlags.DontSave;
			if (material)
				return material;
			else
				return null;
		}
	}

	public Material material
	{
		get
		{
			gaussianBlurMaterial = CheckShaderAndCreateMaterial(gaussianBlurShader, gaussianBlurMaterial);
			return gaussianBlurMaterial;
		}
	}


    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        if (material != null)
        {

			//Graphics.Blit(src, dest, material);

			int rtW = src.width;
			int rtH = src.height;

			RenderTexture buffer0 = RenderTexture.GetTemporary(rtW, rtH, 0);
			buffer0.filterMode = FilterMode.Bilinear;

			Graphics.Blit(src, buffer0);
			for (int i = 0; i < 1; i++)
			{

				RenderTexture buffer1 = RenderTexture.GetTemporary(rtW, rtH, 0);

				Graphics.Blit(buffer0, buffer1, material, 0);

				RenderTexture.ReleaseTemporary(buffer0);
				buffer0 = buffer1;
				buffer1 = RenderTexture.GetTemporary(rtW, rtH, 0);

				Graphics.Blit(buffer0, buffer1, material, 1);

				RenderTexture.ReleaseTemporary(buffer0);
				buffer0 = buffer1;
			}
			Graphics.Blit(buffer0, dest);
			RenderTexture.ReleaseTemporary(buffer0);
		}
        else
        {
            Graphics.Blit(src, dest);
        }
    }
}
