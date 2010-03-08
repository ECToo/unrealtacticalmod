class MechaProtypeLeg extends MechaPartLeg
      placeable;

var() protected const Name FootBackSocketName;
var() vector GroundMaxLine;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	AnimPlay = AnimNodeSequence( Mesh.Animations.FindAnimNode('AnimPlayer') );
	SetTimer(2, true, 'PlayAnimation'); //play every 2 sec then execute function
	SetTimer(0.01, true, 'checkdistanceground');
}

function PlayAnimation(){
     Mesh.PlayAnim('ActionDown', 2, false, false);//play animation name, play frame speed,play loop,if loop in play do not restart it
     //Mesh.PlayAnim('ActionDown', 1, false, true);//play animation name, play frame speed,play loop,if loop in play do not restart it
     //Mesh.PlayAnim('ActionDown');
     `log("play");
     //checkdistanceground();
}

function checkdistanceground(){
        local vector TagSocketLocation,HitLocation,HitNormal,GroundLine;
        local rotator TagSocketRotation;
         if(Mesh !=none){
              Mesh.GetSocketWorldLocationAndRotation(FootBackSocketName, TagSocketLocation, TagSocketRotation);
              //`log("LOCATION BONE:" $ TagSocketLocation);

              GroundLine = TagSocketLocation + GroundMaxLine;
              Trace(HitLocation, HitNormal, GroundLine, TagSocketLocation);//trace to return value
              //`log("HIT LCOAL BONE:" $ HitLocation);

              if (HitLocation == TagSocketLocation){//if trace is not within the line it will stop
                    Mesh.StopAnim();
                    Mesh.PlayAnim('ActionDown',2);
                    //Mesh.StopAnim();
              }
         }
}

simulated event Tick( float DeltaTime )
{
    super.Tick(DeltaTime);
}
//AnimPlay

defaultproperties
{
   bodytype="legspider"
   //socket=FeetSocket01
   GroundMaxLine=(X=0.0,Y=1000.00,Z=0.0)
   FootBackSocketName=FeetSocket01
   Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VH_Mecha.protypeleg1'
		PhysicsAsset=PhysicsAsset'VH_Mecha.protypeleg1_Physics'
		AnimTreeTemplate=AnimTree'VH_Mecha.protypeleg1_animtree'
		AnimSets(0)=AnimSet'VH_Mecha.protypeleg1_anim'
	End Object
}


