/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */
 
 /*
  * This deal with pre build mech default
 */

class VehicleMechaPart_BMech04_Content extends VehicleMechaPart;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	/*
	//RHThruster.BoneOffset=(X=-50.0,Y=100.0,Z=-300.0);
	RHThruster.BoneOffset.X = -50;
        RHThruster.BoneOffset.Y = 100;
        RHThruster.BoneOffset.Z = -300;
      RHThruster.SuspensionTravel=400;

      //LHThruster.BoneOffset=(X=-50.0,Y=-100.0,Z=-300.0);
      LHThruster.BoneOffset.X = -50;
      LHThruster.BoneOffset.Y = -100;
      LHThruster.BoneOffset.Z = -300;
      LHThruster.SuspensionTravel=400;

      //FHThruster.BoneOffset=(X=80.0,Y=0.0,Z=-300.0);
      FHThruster.BoneOffset.X = 80;
      FHThruster.BoneOffset.Y = 0;
      FHThruster.BoneOffset.Z = -300;
      FHThruster.SuspensionTravel=400;
      */
}

defaultproperties
{

              //HoverHeightBody=2500
         //VehiclePositionString="in an Mech Walker"
         //VehicleNameString="Mech Walker"
         ObjectiveGetOutDist=2000.0
         
         	Begin Object Name=SimObject
         	      MaxThrustForce=2000.0
         	      RandForceInterval=2000.0
	End Object

         Begin Object Name=CollisionCylinder
		CollisionHeight=100.0
		CollisionRadius=140.0
		Translation=(X=0.0,Y=0.0,Z=50.0)
	End Object

         //head
         BodyAttachHeadSocketName=MechHeadSocket
         MechPart_Head=class'MechaPart_Head'
         //leg
         BodyAttachLegSocketName=MechLegSocket
         MechPart_Leg=class'MechaPart_Leg01'
         
         //right arm
         BodyAttachRightArmSocketName=RightHandSocket
         MechPart_RightArm=class'MechaPart_RightArm03'

         //right hand
         BodyAttachRightHandSocketName=RightHandSocket
         MechPart_RightHand=class'MechaPart_RightWeapon'

         //left arm
         BodyAttachLeftArmSocketName=LeftHandSocket
         MechPart_LeftArm=class'MechaPart_LeftArm03'

         //left hand
         BodyAttachLeftHandSocketName=LeftHandSocket
         MechPart_LeftHand=class'MechaPart_LeftWeapon'

	Begin Object Name=SVehicleMesh
		SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mechdrone_body'
		AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechprotype_body_at'
		PhysicsAsset=PhysicsAsset'VHUTM_MechProtypeWalker.mechdrone_body_Physics'
	End Object

	Begin Object  Name=RThruster
		BoneName="BodyRoot" //need to the bone name else it will crash
		BoneOffset=(X=-50.0,Y=100.0,Z=-300.0)
		WheelRadius=10
		//SuspensionTravel=145
		SuspensionTravel=400
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
		BoneOffset=(X=-50.0,Y=-100.0,Z=-300.0)
		WheelRadius=10
		//SuspensionTravel=145
		SuspensionTravel=400
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
		BoneOffset=(X=80.0,Y=0.0,Z=-300.0)
		WheelRadius=10
		//SuspensionTravel=145
		SuspensionTravel=400
		bPoweredWheel=false
		LongSlipFactor=0.0
		LatSlipFactor=0.0
		HandbrakeLongSlipFactor=0.0
		HandbrakeLatSlipFactor=0.0
		SteerFactor=1.0
		bHoverWheel=true
	End Object
        
//	FlagBone=Head
}
