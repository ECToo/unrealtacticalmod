/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class UTMVehicle_MechProtypeWalker_Content extends UTMVehicle_MechProtypeWalker;

var UTMMechWalkerBody BodyActor_Leg;
var class<UTMMechWalkerBody> BodyType_Leg;

var SkeletalMeshComponent MeshMechTMP;

var class <UTMMechPart> MechPart;
var UTMMechPart MechPartActor;
//Head
var() protected const Name BodyAttachHeadSocketName;
var class <UTMMechPart> MechPart_Head;
var UTMMechPart MechPartActor_Head;
//Back
var() protected const Name BodyAttachBackSocketName;
var class <UTMMechPart> MechPart_Back;
var UTMMechPart MechPartActor_Back;
//Leg
var() protected const Name BodyAttachLegSocketName;
var class <UTMMechPart> MechPart_Leg;
var UTMMechPart MechPartActor_Leg;
//Right Arm
var() protected const Name BodyAttachRightArmSocketName;
var class <UTMMechPart> MechPart_RightArm;
var UTMMechPart MechPartActor_RightArm;
//right weapon
var() protected const Name BodyAttachRightHandSocketName;
var class <UTMMechPart> MechPart_RightHand;
var UTMMechPart MechPartActor_RightHand;
//Left Arm
var() protected const Name BodyAttachLeftArmSocketName;
var class <UTMMechPart> MechPart_LeftArm;
var UTMMechPart MechPartActor_LeftArm;
//left weapon
var() protected const Name BodyAttachLeftHandSocketName;
var class <UTMMechPart> MechPart_LeftHand;
var UTMMechPart MechPartActor_LeftHand;


simulated function PostBeginPlay()
{
	//local vector X, Y, Z;

	Super.PostBeginPlay();

	// no spider body on server
	if ( WorldInfo.NetMode != NM_DedicatedServer )
	{
		//GetAxes(Rotation, X,Y,Z);
		//`log('            x'@ X);


		//MechPartActor = Spawn(class'MechProtypeWalker.UTMMechPart_Leg', self,, Location);

		//MechPartActor = Spawn(MechPart, self,, Location);
		//Mesh.AttachComponentToSocket(MechPartActor.Mesh,'LeftHandSocket');
		//Mesh.AttachComponentToSocket(MechPartActor.Mesh,'RightHandSocket');
		
                //head
                MechPartActor_Head = Spawn(MechPart_Head, self,, Location);
                Mesh.AttachComponentToSocket(MechPartActor_Head.Mesh,BodyAttachHeadSocketName);//'MechHeadSocket'

                //leg
                MechPartActor_Leg = Spawn(MechPart_Leg, self,, Location);
                Mesh.AttachComponentToSocket(MechPartActor_Leg.Mesh,BodyAttachLegSocketName);//'MechLegSocket'

                //right arm
                MechPartActor_RightArm = Spawn(MechPart_RightArm, self,, Location);
                Mesh.AttachComponentToSocket(MechPartActor_RightArm.Mesh,BodyAttachRightHandSocketName);//'RightHandSocket'

                //right hand weapon
                MechPartActor_RightHand = Spawn(MechPart_RightHand, self,, Location);
                Mesh.AttachComponentToSocket(MechPartActor_RightHand.Mesh,BodyAttachRightHandSocketName);//'RightHandSocket'

                //left arm
                MechPartActor_LeftArm = Spawn(MechPart_LeftArm, self,, Location);
                Mesh.AttachComponentToSocket(MechPartActor_LeftArm.Mesh,BodyAttachLeftHandSocketName);//'RightHandSocket'

                //left hand weapon
                //MechPartActor_LeftHand = Spawn(MechPart_LeftHand, self,, Location);
                //Mesh.AttachComponentToSocket(MechPartActor_LeftHand.Mesh,BodyAttachLeftHandSocketName);//'LeftHandSocket'
                
                MechPartActor_LeftHand = Spawn(MechPart_LeftHand, self,, Location);
                MechPartActor_LeftArm.Mesh.AttachComponentToSocket(MechPartActor_LeftHand.Mesh,BodyAttachLeftHandSocketName);//'LeftHandSocket'

	}
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

simulated function bool OverrideBeginFire(byte FireModeNum)
{
        super.OverrideBeginFire(FireModeNum);
	if (FireModeNum == 1)
	{
	`log('ALT FIRE MODE');

		//bPressingAltFire = true;
		//Rise=1.0f;
		//return true;
	}

	if (FireModeNum == 0)
	{
	`log('FIRE MODE');
		//bPressingAltFire = true;
		//Rise=1.0f;
		//return true;
	}
	return false;
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
**/


simulated event Destroyed()
{
	Super.Destroyed();

	//if (BeamLight != None)
	//{
	//	BeamLight.Destroy();
	//}
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


        BodyType=class'UTMMechWalkerBody_MechProtypeLeg'
        //BodyType=class'UTMechWalkerBody_MechProtypeLeg'
        BodyType_Leg=class'UTMMechWalkerBody_MechProtypeLeg'

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

		SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mechprotype_body'
		AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechprotype_body_at'
		PhysicsAsset=PhysicsAsset'VHUTM_MechProtypeWalker.mechprotype_body_Physics'
	End Object


	Seats(0)={( GunClass=class'UTVWeap_GoliathMachineGun',
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
				MuzzleFlashLightClass=class'UTDarkWalkerMuzzleFlashLight',
				WeaponEffects=((SocketName=MainGun_00,Offset=(X=-35,Y=-3),Scale3D=(X=8.0,Y=10.0,Z=10.0)),(SocketName=MainGun_01,Offset=(X=-35,Y=-3),Scale3D=(X=8.0,Y=10.0,Z=10.0)))
				)}

//	FlagBone=Head
}
