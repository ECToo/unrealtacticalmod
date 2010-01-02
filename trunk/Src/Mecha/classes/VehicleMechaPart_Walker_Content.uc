/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */
 
 /*
  * This deal with pre build mech default
 */

class VehicleMechaPart_Walker_Content extends VehicleMechaPart;

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

         //VehiclePositionString="in an Mech Walker"
         //VehicleNameString="Mech Walker"
         
         Begin Object Name=CollisionCylinder
		CollisionHeight=100.0
		CollisionRadius=140.0
		Translation=(X=0.0,Y=0.0,Z=50.0)
	End Object


         MechPart=class'MechaPart_Leg'
         //head
         BodyAttachHeadSocketName=MechHeadSocket
         MechPart_Head=class'MechaPart_Head'
         //leg
         BodyAttachLegSocketName=MechLegSocket
         MechPart_Leg=class'MechaPart_Leg'
         
         //right arm
         BodyAttachRightArmSocketName=RightHandSocket
         MechPart_RightArm=class'MechaPart_RightArm'

         //right hand
         BodyAttachRightHandSocketName=RightHandSocket
         MechPart_RightHand=class'MechaPart_RightWeapon'

         //left arm
         BodyAttachLeftArmSocketName=LeftHandSocket
         MechPart_LeftArm=class'MechaPart_LeftArm'

         //left hand
         BodyAttachLeftHandSocketName=LeftHandSocket
         MechPart_LeftHand=class'MechaPart_LeftWeapon'

	Begin Object Name=SVehicleMesh
		SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mechprotype_body'
		AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechprotype_body_at'
		PhysicsAsset=PhysicsAsset'VHUTM_MechProtypeWalker.mechprotype_body_Physics'
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
}
