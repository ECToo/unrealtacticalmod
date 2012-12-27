/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 * 
 * Credit to the UDK forum
 * 
 * Link: http://forums.epicgames.com/threads/903411-Multiple-Instances-of-SWF-movie-unrealscript
 * Link: http://forums.epicgames.com/threads/929660-Texture-Render-Targets-Scaleform-Issue?highlight=Texture+Render+Target
 *
 * You need to create a Material in the package.
 * -Create Material:
 *  -BeskeletonMesh=true
 *  -RenderTextureMode=RTM_AlphaComposite
 *  -add TextureSample
 *   -Parameter Name:Emissive
 *   -set uv texture: UITextureRenderTarget2D// just a placeholder
 *
 */

class SWFMeshActor extends Actor placeable;

var SkeletalMeshComponent Mesh;
var() noclear SwfMovie ScreenMovie; //Name of the swf file to set to.
var GFxMoviePlayer GfxPlayer;  //gfx UI handler
var TextureRenderTarget2D ScreenTexture; //texture 2D render for gfx UI
var MaterialInstanceConstant Materialinstantcon; //material

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();
    AttachComponent(Mesh);//attach to actor Component
    GfxPlayer = new class'GFxMoviePlayer'; // Gfx flash UI object
    GfxPlayer.SetMovieInfo(ScreenMovie); // set swf file to open
    
    ScreenTexture = class'TextureRenderTarget2D'.static.Create(512, 512);
    GfxPlayer.RenderTextureMode = RTM_AlphaComposite;
    GfxPlayer.RenderTexture = ScreenTexture;
    
    Materialinstantcon = new(None) class'MaterialInstanceConstant';
    Materialinstantcon.SetParent(Material'CustomHUD.AS3MatParms');
    Materialinstantcon.SetTextureParameterValue('Emissive',ScreenTexture); //
    Mesh.SetMaterial(0, Materialinstantcon); // set mesh to index 0 of the material list.
    
    GfxPlayer.Advance(0);
    GfxPlayer.Init();
    GfxPlayer.Start();
}

defaultproperties
{
    //ScreenMovie=SwfMovie'CustomHUD.papervision3d21'
    ScreenMovie=SwfMovie'CustomHUD.papervision3d21'
    Begin Object class=SkeletalMeshComponent Name=MeshFrame
        SkeletalMesh=SkeletalMesh'CustomHUD.Test01'
    End Object
    Mesh=MeshFrame
}