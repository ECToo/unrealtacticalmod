class MechaProtypeLeg3 extends MechaPartLeg
      placeable;

var() protected const Name FootBackSocketName;
var() vector GroundMaxLine;
var() vector GroundMinLine;
var Name AnimSetName;


simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	AnimPlay = AnimNodeSequence( Mesh.Animations.FindAnimNode('AnimPlayer') );
	PlayAnimation();
	//SetTimer(10, true, 'PlayAnimation'); //play every 2 sec then execute function
	SetTimer(0.5, true, 'checkdistanceground');
}

function PlayAnimation(){
     AnimPlay.SetAnim(AnimSetName);
     AnimPlay.PlayAnim(false,0.1,0);
     //`log("play");
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
                 AnimPlay.StopAnim();
                 `log("time:" $ AnimPlay.PreviousTime);
                 AnimPlay.PlayAnim(false,-0.1,AnimPlay.PreviousTime);
              }else{
                 //GroundLine = TagSocketLocation + GroundMinLine;
                 //Trace(HitLocation, HitNormal, GroundLine, TagSocketLocation);//trace to return value
                 //if (HitLocation != TagSocketLocation){
                     AnimPlay.PlayAnim(false,0.1,AnimPlay.PreviousTime);
                 //}
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
   AnimSetName=ActionDown
   GroundMaxLine=(X=0.0,Y=1000.00,Z=0.0)//from ground down
   GroundMinLine=(X=0.0,Y=-1000.00,Z=0.0)//from leg up to check any collision for it
   FootBackSocketName=FeetSocket01
   Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VH_Mecha.protypeleg1'
		PhysicsAsset=PhysicsAsset'VH_Mecha.protypeleg1_Physics'
		AnimTreeTemplate=AnimTree'VH_Mecha.protypeleg1_animtree'
		AnimSets(0)=AnimSet'VH_Mecha.protypeleg1_anim'
	End Object
}


