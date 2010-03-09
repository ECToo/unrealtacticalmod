class MechaProtypeLeg5 extends MechaPartLeg
      placeable;

var() protected const Name FootBackSocketName;
var() vector GroundMaxLine;
var() vector GroundMinLine;
var Name AnimSetName;

// 3 legged walkers, by default
const NUM_WALKER_LEGS = 3;

var protected transient SkelControlLookat ShoulderSkelControl[NUM_WALKER_LEGS];
var protected const Name ShoulderSkelControlName[NUM_WALKER_LEGS];
var() byte IgnoreFoot[NUM_WALKER_LEGS];
var() const array<float> StepStageTimes;
var protected int StepStage[NUM_WALKER_LEGS];


/** Min dist trigger to make foot a possible candidate for next step */
var() float MinStepDist;

/** Max leg extension */
var() float MaxLegReach;

/** Factor in range [0..1].  0 means no leg spread, 1 means legs are spread as far as possible. */
var() float LegSpreadFactor;
var() float	CustomGravityScale;
var() float LandedFootDistSq;

/** How far foot should embed into ground. */
var() protected const float FootEmbedDistance;


/** Bone names for this walker */
var const name FootBoneName[NUM_WALKER_LEGS];
var const name ShoulderBoneName[NUM_WALKER_LEGS];
var const name BodyBoneName;

/** Where the feet are right now */
var vector CurrentFootPosition[NUM_WALKER_LEGS];


/** Names of the anim nodes for playing the step anim for a leg.  Used to fill in FootStepAnimNode array. */
var protected const Name	FootStepAnimNodeName[NUM_WALKER_LEGS];
/** Refs to AnimNodes used for playing step animations */
var protected AnimNode		FootStepAnimNode[NUM_WALKER_LEGS];


/** How far above the current foot position to begin interpolating towards. */
var() protected const float FootStepStartLift;
/** How far above the desired foot position to end the foot step interpolation */
var() protected const float FootStepEndLift;

/** keeps track of previous leg locations */
var protected vector PreviousTraceSeedLocation[NUM_WALKER_LEGS];


simulated function PostBeginPlay()
{
        local int Idx;
	Super.PostBeginPlay();
	AnimPlay = AnimNodeSequence( Mesh.Animations.FindAnimNode('AnimPlayer') );
	PlayAnimation();
	//SetTimer(10, true, 'PlayAnimation'); //play every 2 sec then execute function
	//SetTimer(0.5, true, 'checkdistanceground');

	//PlayLeg1();
	for (Idx=0; Idx<NUM_WALKER_LEGS; ++Idx)
	{
		// cache refs to footstep anims
		FootStepAnimNode[Idx] = Mesh.FindAnimNode(FootStepAnimNodeName[Idx]);

		// cache refs to skel controls
		//ShoulderSkelControl[Idx] = SkelControlLookAt(Mesh.FindSkelControl(ShoulderSkelControlName[Idx]));
		//if (ShoulderSkelControl[Idx] != None)
		//{
			// turn it on
		//	ShoulderSkelControl[Idx].SetSkelControlActive(TRUE);
		//}
	}
	//PlayLeg1();
	SetTimer(3, true, 'PlayLeg1');
}

function PlayLeg1(){
     //if (FootStepAnimNode[1] !=none){
    FootStepAnimNode[1].FindAnimNode('Leg0 Step');
    //FootStepAnimNode[1].SetAnim('ActionDown');
        FootStepAnimNode[1].PlayAnim(false,0.1,0.0);
        //FootStepAnimNode[1].Anim.PlayAnim(FALSE, 1.0f);
        `log("play leg 1");
     //}
     //`log("play");
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
		SkeletalMesh=SkeletalMesh'VH_Mecha.protypeleg2'
		PhysicsAsset=PhysicsAsset'VH_Mecha.protypeleg2_Physics'
		AnimTreeTemplate=AnimTree'VH_Mecha.protypeleg2_animtree'
		AnimSets(0)=AnimSet'VH_Mecha.protypeleg2_animset'
	End Object
     FootBoneName(0)=Leg1_End
	FootBoneName(1)=Leg2_End
	FootBoneName(2)=Leg3_End
	ShoulderBoneName(0)=Leg1_Shoulder
	ShoulderBoneName(1)=Leg2_Shoulder
	ShoulderBoneName(2)=Leg3_Shoulder
	ShoulderSkelControlName[0]="Shoulder1"
	ShoulderSkelControlName[1]="Shoulder2"
	ShoulderSkelControlName[2]="Shoulder3"
	FootStepAnimNodeName[0]="Leg0 Step"
	FootStepAnimNodeName[1]="Leg1 Step"
	FootStepAnimNodeName[2]="Leg2 Step"


}


