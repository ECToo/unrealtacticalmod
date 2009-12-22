Class UTMBuilding_OneUnit extends UTMBuilding;

var vector Size;
var vector SizeMax;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	
}


simulated event PostRenderFor(PlayerController PC, Canvas Canvas, vector CameraPosition, vector CameraDir){
 super.PostRenderFor(PC,Canvas,CameraPosition,CameraDir);
  `log('render');
}

simulated function Tick(float DeltaTime)
{
  Size.X += 1;
  if(Size.X > SizeMax.X){
    Size.X = 1;
  }
  //DrawScale3D.X = Size.X;

  //SetDrawScale3D(Size);
  Size.Y += 1;
  if(Size.Y > SizeMax.Y){
    Size.Y = 0;
  }
  //Mesh.StaticMesh.Scale.Y = Size.Y;
  //`log('TEST TICK');
}

event Timer(){
 super.Timer();
`log('Timer');
}


defaultproperties
{
    SizeMax=(X= 128,Y=128)
    
    bPostRenderIfNotVisible=true
    bTickIsDisabled=false
    bStatic=false
    bNoDelete=false
    Begin Object Name=StaticMeshBuilding
                StaticMesh=StaticMesh'UTMEditor.Cube'
                AlwaysLoadOnClient=true
                CollideActors=true
                CastShadow=FALSE
		bCastDynamicShadow=TRUE
		bAcceptsLights=TRUE
		bForceDirectLightMap=TRUE
		LightingChannels=(BSP=TRUE,Dynamic=TRUE,Static=TRUE,CompositeDynamic=TRUE)
    End Object
    Mesh=StaticMeshBuilding
}