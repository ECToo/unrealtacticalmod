/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 * 
 */

class ExampleScreen extends Actor placeable
    //native
    ClassGroup(Example);

/** This will be the flash movie that this actor plays. */
var() noclear SwfMovie ScreenMovie;
/** This will be the green screen texture onto which the ScreenMovie projects. */
var TextureRenderTarget2D ScreenTexture;
/** The flash player to play the flash movie. */
var GfxUDKMapSpawnNode ESP; // Extends from GFxMoviePlayer, just has an extra function that overrides Start() to call both super.Start() and Advance(0).
/** The static mesh actor which will have the flash movie playing on it. */
//var StaticMeshComponent EScreen;
var SkeletalMeshComponent EScreen;
/** To be able to add the flash movie to the actor, I have to be able to manipulate the material interface. */
var MaterialInstanceConstant EMIC;

///** creates and initializes a new TextureRenderTarget2D with the requested settings */
//static native noexport final function TextureRenderTarget2D Create(int InSizeX, int InSizeY, optional EPixelFormat InFormat = PF_A8R8G8B8, optional LinearColor InClearColor, optional bool bOnlyRenderOnce );
var MaterialInterface defaultMaterial0;
event PostBeginPlay()
{
    super.PostBeginPlay();
	
	
	//defaultMaterial0=Material'CustomHUD.AS3_Mat';
	defaultMaterial0=Material'CustomHUD.AS3_Mat';
	
	
    ESP = new class'GfxUDKMapSpawnNode';
    ESP.SetMovieInfo(ScreenMovie);
    ScreenTexture = new class'TextureRenderTarget2D';
	//ScreenTexture.Create( 1024, 1024,,,false);
	ScreenTexture.Create( 1024, 1024);
        // Adopting the same method in Uscript that Matt Doyle does via kismet and the editor in his videos.
        //   Except using unrealscript instead of "Open GFx Movie" kismet.
    //ESP.RenderTexture = ScreenTexture;
	ESP.SetExternalTexture("MyRenderTarget", ScreenTexture);
	
    ESP.RenderTextureMode = RTM_AlphaComposite;
    EMIC = new class'MaterialInstanceConstant';
	//EMIC.SetParent(EScreen.GetMaterial(0));
	if(defaultMaterial0 == none){
		`log("ERROR MATERIAL");
	}
	else
	{
		`log("SET MATERIAL");
		EScreen.SetMaterial(0, defaultMaterial0);
	}
	`log("========================");
	`log(EMIC);
	`log("========================");
	EMIC.SetTextureParameterValue('Emissive', ScreenTexture);
	//EScreen.SetMaterial(0, EMIC);
	/*
    EMIC.SetParent(EScreen.GetMaterial(0));
    
        // The material is only a texture parameter node that plugs directly into the emissive slot.
        //    The material uses the AlphaComposite opacity setting, just like the video tutorial.
    EMIC.SetTextureParameterValue('Emissive', ScreenTexture);
	
	ESP.Advance(0);
    ESP.Init();
	ESP.Start();
	*/
}
   
defaultproperties
{
    // Native.

    // Custom.
    //ScreenMovie=SwfMovie'ExampleSWF'
    ScreenMovie=SwfMovie'CustomHUD.papervision3d21'

    //begin Object Name="Screen" Class="StaticMeshComponent"
    //StaticMesh=StaticMesh'ExampleMeshes.ExampleActor'
        //StaticMesh=StaticMesh'EngineMeshes.Cube'
        //Scale=2.f
    //end Object
	Begin Object class=SkeletalMeshComponent Name="Screen"
        SkeletalMesh=SkeletalMesh'CustomHUD.Test01'
    End Object
    Components.add(Screen);
    EScreen=Screen
}