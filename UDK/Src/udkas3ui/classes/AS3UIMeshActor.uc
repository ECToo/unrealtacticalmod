/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 *
 */

class AS3UIMeshActor extends Actor placeable;

var PointUIMoviePlayer PlayerBeacon;
var SkeletalMeshComponent Mesh;
var MaterialInterface defaultMaterial0;
var MaterialInterface mat;
//var GFxTexture2DOpenMovie Gfx2D;

var() noclear SwfMovie ScreenMovie;
var GfxUDKMapSpawnNode ESP; 
var TextureRenderTarget2D ScreenTexture;
var MaterialInstanceConstant EMIC;

simulated function PostBeginPlay()
{
    
    //local GFxMoviePlayer Movie;
    Super.PostBeginPlay();
    AttachComponent(Mesh);//attach to actor Component
    ESP = new class'GfxUDKMapSpawnNode';
    ESP.SetMovieInfo(ScreenMovie);
    
    //ScreenTexture = new(None) class'TextureRenderTarget2D';
    ScreenTexture = class'TextureRenderTarget2D'.static.Create(512, 512);
    //ScreenTexture.Create( 1024, 1024,,,true);
    //ScreenTexture.Create( 256, 256,,,true);
    //ScreenTexture.Create( 256, 256,,,false);
    //ScreenTexture.Create( 1024, 1024);
    ESP.RenderTextureMode = RTM_AlphaComposite;
    ESP.RenderTexture = ScreenTexture;
    
    
    EMIC = new(None) class'MaterialInstanceConstant';
    //EMIC.SetTextureParameterValue('Emissive', ScreenTexture);
    //EMIC.SetTextureParameterValue('Texture', ScreenTexture);
    //EMIC.SetParent(Material'CustomHUD.away3d_mat');
    //EMIC.SetTextureParameterValue('Texture',Texture2D'EngineMaterials.HeatmapGradient');
    //EMIC.SetTextureParameterValue('Texture',Texture2D'CustomHUD.Basic_SceneCube3_ourtex');
    //EMIC.SetParent(Material'EngineMaterials.EmissiveTexturedMaterial');
    //EMIC.SetTextureParameterValue('Texture',Texture2D'enginedebugmaterials.HeatmapGradient');
    //EMIC.SetTextureParameterValue('Texture',Texture2D'enginedebugmaterials.HeatmapGradient');
    
    //EMIC.SetParent(Mesh.GetMaterial(0));
    EMIC.SetParent(Material'CustomHUD.AS3MatParms');
    //EMIC.SetTextureParameterValue('Texture',ScreenTexture);
    //EMIC.SetTextureParameterValue('Texture',Texture2D'enginedebugmaterials.HeatmapGradient');
    //EMIC.SetTextureParameterValue('Emissive', ScreenTexture);
    //EMIC.SetTextureParameterValue('Emissive',Texture2D'enginedebugmaterials.HeatmapGradient');
    EMIC.SetTextureParameterValue('Emissive',ScreenTexture);
    //EMIC.SetTextureParameterValue('Emissive',Texture2D'CustomHUD.icon_buttonred_circle');
    Mesh.SetMaterial(0, EMIC);
    
    ESP.Advance(0);
    ESP.Init();
    ESP.Start();
}

defaultproperties
{
    ScreenMovie=SwfMovie'CustomHUD.papervision3d21'
    //ScreenMovie=SwfMovie'CustomHUD.away3dcfp9'
    defaultMaterial0=Material'CustomHUD.AS3_Mat3'
    Begin Object class=SkeletalMeshComponent Name=MeshFrame
        SkeletalMesh=SkeletalMesh'CustomHUD.Test01'
    End Object
    Mesh=MeshFrame
}