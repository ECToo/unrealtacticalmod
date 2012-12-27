/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 * 
 */

 /*
 * Trigger something here to see it
 * SequenceAction
 *
 */

class GFxTexture2DOpenMovie extends GFxAction_OpenMovie;

DefaultProperties
{
	//RTM_AlphaComposite
	RenderTextureMode=RTM_AlphaComposite
	Movie=SwfMovie'CustomHUD.papervision3d21'
	ObjName="Open GFx Movie AS3"
	//RenderTexture=TextureRenderTarget2D'CustomHUD.AS3_2DRender'
	RenderTexture=TextureRenderTarget2D'CustomHUD.AS3_2DRender3'
}