/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */
 
 /*
  * This deal with pre build mech default
 */

class VehicleMechaPart_MR1_Content extends VehicleMechaPart;

var SkeletalMeshComponent MeshMechTMP;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
}

defaultproperties
{

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
         MechPart_Head=class'MechaPart_MR1_Head'
         //leg
         //BodyAttachLegSocketName=MechLegSocket
         MechPart_Leg=class'MechaPart_MR1_Leg'

         //right arm
         BodyAttachRightArmSocketName=RightArmSocket01
         MechPart_RightArm=class'MechaPart_MR1_RightArm'

         //right hand
         BodyAttachRightHandSocketName=HandSocket01
         //MechPart_RightHand=class'MechaPart_MR1_RWeap_Gun'
         MechPart_RightHand=class'MechaPart_MR1_RWeap_Missile'

         //left arm
         BodyAttachLeftArmSocketName=LeftArmSocket01
         MechPart_LeftArm=class'MechaPart_MR1_LeftArm'

         //left hand
         BodyAttachLeftHandSocketName=HandSocket01
         MechPart_LeftHand=class'MechaPart_LeftWeapon'

	Begin Object Name=SVehicleMesh
		SkeletalMesh=SkeletalMesh'VH_Mecha.mecha_r1_body'
		//AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechprotype_body_at'
		PhysicsAsset=PhysicsAsset'VH_Mecha.mecha_r1_body_Physics'
	End Object


//	FlagBone=Head

          Begin Object  Name=RThruster
		BoneName="BodyRoot" //need to the bone name else it will crash
		BoneOffset=(X=-50.0,Y=100.0,Z=-700.0)
		WheelRadius=10
		//SuspensionTravel=145
		SuspensionTravel=650
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
		BoneOffset=(X=-50.0,Y=-100.0,Z=-700.0)
		WheelRadius=10
		//SuspensionTravel=145
		SuspensionTravel=650
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
		BoneOffset=(X=80.0,Y=0.0,Z=-700.0)
		WheelRadius=10
		//SuspensionTravel=145
		SuspensionTravel=650
		bPoweredWheel=false
		LongSlipFactor=0.0
		LatSlipFactor=0.0
		HandbrakeLongSlipFactor=0.0
		HandbrakeLatSlipFactor=0.0
		SteerFactor=1.0
		bHoverWheel=true
	End Object
	
	BaseEyeheight=100
	Eyeheight=200
}
