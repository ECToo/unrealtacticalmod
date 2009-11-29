/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */
 
 /*
  * This deal with pre build mech default
 */

class UTMVehicle_MechProtypeWalker_Content extends UTMVehicle_MechProtypeWalker;

var SkeletalMeshComponent MeshMechTMP;

simulated function PostBeginPlay()
{
	//local vector X, Y, Z;

	Super.PostBeginPlay();
}

replication
{
	//if (!bNetOwner)
	//	bSpeakerReady;
}

function DriverLeft()
{
	Super.DriverLeft();

}

/*
simulated function SetInputs(float InForward, float InStrafe, float InUp)
{
	super.SetInputs(InForward,InStrafe,InUp);

	if(bPressingAltFire)
	{

		Rise = 1.0f;

	}

}

simulated function bool OverrideBeginFire(byte FireModeNum)
{
        super.OverrideBeginFire(FireModeNum);
	if (FireModeNum == 1)
	{
	`log('ALT FIRE MODE');

		bPressingAltFire = true;
		Rise=1.0f;

		return true;
	}
	
	if (FireModeNum == 0)
	{
	`log('FIRE MODE');

		bPressingAltFire = true;
		Rise=1.0f;

		return true;
	}

	return false;
}

simulated function bool OverrideEndFire(byte FireModeNum)
{
        super.OverrideEndFire(FireModeNum);
	//local PlayerController PC;
	if (FireModeNum == 1)
	{

		Rise=0.0f;
		if(bSelfDestructReady)
		{
			DriverLeave(true);
		}
		else
		{
			PC=PlayerController(Seats[0].SeatPawn.Controller);
			if(PC != none)
			{
				PC.ReceiveLocalizedMessage(class'UTVehicleMessage', 0);
			}
		}

		//bPressingAltFire = false;
		return true;

	}

	return false;
}

//
//  Play an animation with an optional total time
//
simulated function PlayAnim(name AnimName, optional float AnimDuration = 0.0f)
{
	local float AnimRate;
	if (AnimPlay != none && AnimName != '')
	{
		AnimRate = 1.0f;
		AnimPlay.SetAnim(AnimName);
		if(AnimPlay.AnimSeq != none)
		{
			if (AnimDuration > 0.0f)
			{
				AnimRate = AnimPlay.AnimSeq.SequenceLength / AnimDuration;
			}
			AnimPlay.PlayAnim(false, AnimRate, 0.0);
		}
	}
}

simulated function StopAnim()
{
	if (AnimPlay != none)
	{
		AnimPlay.StopAnim();
	}
}
*/


simulated event Destroyed()
{
	Super.Destroyed();
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
	        //Scavenger
	        //SkeletalMesh=SkeletalMesh'VH_Scavenger.Mesh.SK_VH_Scavenger_Torso'
		//AnimSets(0)=AnimSet'VH_Scavenger.Anim.K_VH_Scavenger'
		//AnimTreeTemplate=AnimTree'VH_Scavenger.Anim.AT_VH_Scavenger_Body'
		//PhysicsAsset=PhysicsAsset'VH_Scavenger.Mesh.SK_VH_Scavenger_Torso_Physics_Final'

                //Dark walker
	        //SkeletalMesh=SkeletalMesh'VH_DarkWalker.Mesh.SK_VH_DarkWalker_Torso'
		//AnimSets(0)=AnimSet'VH_DarkWalker.Anims.K_VH_DarkWalker'
		//AnimTreeTemplate=AnimTree'VH_DarkWalker.Anims.AT_VH_DarkWalker'
		//PhysicsAsset=PhysicsAsset'VH_DarkWalker.Mesh.SK_VH_DarkWalker_Torso_Physics'
		//MorphSets[0]=MorphTargetSet'VH_DarkWalker.Mesh.SK_VH_DarkWalker_Torso_MorphTargets'

		//SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mechprotype'
		//AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechprotype_at'
		//PhysicsAsset=PhysicsAsset'VHUTM_MechProtypeWalker.mechprotype_Physics'

                //Export error need to fixed
                //SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mechdrone_body'
                //PhysicsAsset=PhysicsAsset'VHUTM_MechProtypeWalker.mechdrone_body_Physics'


		SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mechprotype_body'
		AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechprotype_body_at'
		PhysicsAsset=PhysicsAsset'VHUTM_MechProtypeWalker.mechprotype_body_Physics'
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
