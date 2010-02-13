/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */
 
 /*
  * This deal with pre build mech default
 */

class VehicleMechaPart_BCo03_01_Content extends VehicleMechaPart;

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
         MechPart_Head=class'MechaPart_Co03Head02'
         //leg
         //BodyAttachLegSocketName=MechLegSocket
         MechPart_Leg=class'MechaPart_Co03Leg02'

         //right arm
         //BodyAttachRightArmSocketName=RightHandSocket
         MechPart_RightArm=class'MechaPart_Co03RightArm03'

         //right hand
         //BodyAttachRightHandSocketName=RightHandSocket
         MechPart_RightHand=class'MechaPart_RightWeapon'

         //left arm
         //BodyAttachLeftArmSocketName=LeftHandSocket
         MechPart_LeftArm=class'MechaPart_Co03LeftArm03'

         //left hand
         //BodyAttachLeftHandSocketName=LeftHandSocket
         MechPart_LeftHand=class'MechaPart_LeftWeapon'

	Begin Object Name=SVehicleMesh
		SkeletalMesh=SkeletalMesh'VH_Mecha.mechabuildco03_body03'
		AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechprotype_body_at'
		PhysicsAsset=PhysicsAsset'VH_Mecha.mechabuildco03_body03_Physics'
	End Object


	Seats(0)={( GunClass=class'MechaVehicleWeapon',
				GunSocket=(MainGun_Fire),
                                GunPivotPoints=(Body),
				TurretVarPrefix="",
				CameraTag=DriverViewSocket,
				CameraOffset=-280,
				CameraSafeOffset=(Z=200),
				DriverDamageMult=0.0,
				SeatIconPos=(X=0.46,Y=0.2),
				TurretControls=(MainRotateGun,MainPitchGun,),
				CameraBaseOffset=(X=40,Y=0,Z=0),
				//MuzzleFlashLightClass=class'UTDarkWalkerMuzzleFlashLight',
				MuzzleFlashLightClass=None,
				WeaponEffects=((SocketName=MainGun_00,Offset=(X=-35,Y=-3),Scale3D=(X=8.0,Y=10.0,Z=10.0)),(SocketName=MainGun_01,Offset=(X=-35,Y=-3),Scale3D=(X=8.0,Y=10.0,Z=10.0)))
				)}

//	FlagBone=Head

    Begin Object  Name=RThruster
		BoneName="BodyRoot" //need to the bone name else it will crash
		BoneOffset=(X=-50.0,Y=100.0,Z=-400.0)
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
		BoneOffset=(X=-50.0,Y=-100.0,Z=-400.0)
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
}
