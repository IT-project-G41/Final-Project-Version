using System.Collections;
using UnityEngine;

public class Toonify : MonoBehaviour
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

            Graphics.Blit(src, dest, material);
        }
        else
        {
            Graphics.Blit(src, dest);
        }
    }
}
