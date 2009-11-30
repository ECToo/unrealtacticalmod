/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */
 
 /*
  * This deal with pre build mech default
 */

class UTMVMech_DroneWalker_Content extends UTMVMech_ProtypeWalker;

var SkeletalMeshComponent MeshMechTMP;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
}


defaultproperties
{

         VehiclePositionString="in an Mech Walker"
         VehicleNameString="Mech Walker"
         
         MechPart=class'MechProtypeWalker.UTMMechPart_Leg'
         //head
         BodyAttachHeadSocketName=MechHeadSocket
         MechPart_Head=class'MechProtypeWalker.UTMMechPart_Head'
         //leg
         BodyAttachLegSocketName=MechLegSocket
         MechPart_Leg=class'MechProtypeWalker.UTMMechPart_Leg'
         
         //right arm
         BodyAttachRightArmSocketName=RightHandSocket
         MechPart_RightArm=class'MechProtypeWalker.UTMMechPart_RightArm'

         //right hand
         BodyAttachRightHandSocketName=RightHandSocket
         MechPart_RightHand=class'MechProtypeWalker.UTMMechPart_RightWeapon'

         //left arm
         BodyAttachLeftArmSocketName=LeftHandSocket
         MechPart_LeftArm=class'MechProtypeWalker.UTMMechPart_LeftArm'

         //left hand
         BodyAttachLeftHandSocketName=LeftHandSocket
         MechPart_LeftHand=class'MechProtypeWalker.UTMMechPart_LeftWeapon'


	Begin Object Class=SkeletalMeshComponent Name=SAntennaMesh
		SkeletalMesh=SkeletalMesh'VH_Goliath.Mesh.SK_VH_Goliath_Antenna'
		AnimTreeTemplate=AnimTree'VH_Goliath.Anims.AT_VH_Goliath_Antenna'
		ShadowParent = SVehicleMesh
		BlockRigidBody=false
		LightEnvironment=MyLightEnvironment
		PhysicsWeight=0.0
		TickGroup=TG_PostASyncWork
		bUseAsOccluder=FALSE
		CullDistance=1300.0
		CollideActors=false
		bUpdateSkelWhenNotRendered=false
		bIgnoreControllersWhenNotRendered=true
		bAcceptsDecals=false
	End Object
        AntennaMesh=SAntennaMesh

	Begin Object Name=CollisionCylinder
		CollisionHeight=100.0
		CollisionRadius=140.0
		Translation=(X=0.0,Y=0.0,Z=50.0)
	End Object

	Begin Object Name=SVehicleMesh
		SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mechdrone_body'
		AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechprotype_body_at'
		PhysicsAsset=PhysicsAsset'VHUTM_MechProtypeWalker.mechdrone_body_Physics'
	End Object


	Seats(0)={( GunClass=class'UTMVWeapon',
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
}
