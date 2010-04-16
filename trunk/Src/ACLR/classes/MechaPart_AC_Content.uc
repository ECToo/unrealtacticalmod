/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */
 
 /*
  * This deal with pre build mech default
 */

class MechaPart_AC_Content extends VehicleMechaPart;

var SkeletalMeshComponent MeshMechTMP;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
}

defaultproperties
{
          offsetleg=(X=0,Y=0,Z=1000)
         //VehiclePositionString="in an Mech Walker"
         //VehicleNameString="Mech Walker"
         
         Begin Object Name=CollisionCylinder
		CollisionHeight=100.0
		CollisionRadius=140.0
		Translation=(X=0.0,Y=0.0,Z=50.0)
	End Object
         //MechPart=class'MechaPart_Leg'
         //head
         //BodyAttachHeadSocketName=MechHeadSocket
         MechPart_Head=class'MechaPart_AC_Head01'
         //leg
         //BodyAttachLegSocketName=MechLegSocket
         MechPart_Leg=class'MechaPart_AC_Leg01'

         //right arm
         //BodyAttachRightArmSocketName=RightHandSocket
         MechPart_RightArm=class'MechaPart_AC_RightArm01'

         //right hand
         BodyAttachRightHandSocketName=HandSocket
         MechPart_RightHand=class'MechaPart_RWeap_Karasawa'

         //left arm
         //BodyAttachLeftArmSocketName=LeftHandSocket
         MechPart_LeftArm=class'MechaPart_AC_LeftArm01'

         //left hand
         BodyAttachLeftHandSocketName=HandSocket
         //MechPart_LeftHand=class'MechaPart_LeftWeapon'

	Begin Object Name=SVehicleMesh
		SkeletalMesh=SkeletalMesh'VH_ACLR.ac_01_body'
		PhysicsAsset=PhysicsAsset'VH_ACLR.ac_01_body_Physics'
		AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechprotype_body_at'
	End Object


//	FlagBone=Head

    Begin Object  Name=RThruster
		BoneName="BodyRoot" //need to the bone name else it will crash
		BoneOffset=(X=-50.0,Y=100.0,Z=-1200.0)
		WheelRadius=10
		//SuspensionTravel=145
		SuspensionTravel=1100
		bPoweredWheel=false
		LongSlipFactor=0.0
		LatSlipFactor=0.0
		HandbrakeLongSlipFactor=0.0
		HandbrakeLatSlipFactor=0.0
		SteerFactor=1.0
		bHoverWheel=true
	End Object

	Begin Object Name=LThruster
		BoneName="BodyRoot"   //need to the bone name else it will crash
		//BoneOffset=(X=-50.0,Y=-100.0,Z=-200.0)
		BoneOffset=(X=-50.0,Y=-100.0,Z=-1200.0)
		WheelRadius=10
		//SuspensionTravel=145
		SuspensionTravel=1100
		bPoweredWheel=false
		LongSlipFactor=0.0
		LatSlipFactor=0.0
		HandbrakeLongSlipFactor=0.0
		HandbrakeLatSlipFactor=0.0
		SteerFactor=1.0
		bHoverWheel=true
	End Object

	Begin Object  Name=FThruster
		BoneName="BodyRoot"  //need to the bone name else it will crash
		BoneOffset=(X=80.0,Y=0.0,Z=-1200.0)
		WheelRadius=10
		//SuspensionTravel=145
		SuspensionTravel=1100
		bPoweredWheel=false
		LongSlipFactor=0.0
		LatSlipFactor=0.0
		HandbrakeLongSlipFactor=0.0
		HandbrakeLatSlipFactor=0.0
		SteerFactor=1.0
		bHoverWheel=true
	End Object

	//BaseEyeheight=50
	//Eyeheight=1000
	BaseEyeheight=500
	Eyeheight=2000
	
	bTakeWaterDamageWhileDriving=false
	ViewPitchMin=-13000
}
