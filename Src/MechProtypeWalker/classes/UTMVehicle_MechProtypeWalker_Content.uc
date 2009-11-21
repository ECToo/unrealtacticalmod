/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTMVehicle_MechProtypeWalker_Content extends UTMVehicle_MechProtypeWalker;

var UTMMechWalkerBody BodyActor_Leg;
var class<UTMMechWalkerBody> BodyType_Leg;

var UTMMechWalkerBody_MechProtypeLeg BodyType_LegClass;
var UTMMechWalkerBody_MechProtypeLeg BodyActor_LegClass;


var SkeletalMeshComponent MeshMechTMP;

var class <UTMMechPart> MechPart;
//class<UTMechWalkerBody>
var UTMMechPart MechPartActor;

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

		MechPartActor = Spawn(MechPart, self,, Location);
		//Mesh.AttachComponentToSocket(MechPartActor.Mesh,'LeftHandSocket');
		Mesh.AttachComponentToSocket(MechPartActor.Mesh,'RightHandSocket');

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

         Begin Object Class=SkeletalMeshComponent Name=MeshHead
		SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mechprotype_head'
		//AnimTreeTemplate=AnimTree'VH_Goliath.Anims.AT_VH_Goliath_Antenna'
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
	MeshMechHead=MeshHead

	Begin Object Class=SkeletalMeshComponent Name=MeshRightWeapon
		SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mecharm_minigun'
		//AnimTreeTemplate=AnimTree'VH_Goliath.Anims.AT_VH_Goliath_Antenna'
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
        MeshMechRightWeapon=MeshRightWeapon
        
        Begin Object Class=SkeletalMeshComponent Name=MeshLeftWeapon
		SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mecharm_minigun'
		//AnimTreeTemplate=AnimTree'VH_Goliath.Anims.AT_VH_Goliath_Antenna'
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
        MeshMechLeftWeapon=MeshLeftWeapon

         Begin Object Class=SkeletalMeshComponent Name=MeshLeg
		SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mechprotype_leg'
		//AnimTreeTemplate=AnimTree'VH_Goliath.Anims.AT_VH_Goliath_Antenna'
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
	MeshMechLeg=MeshLeg
	
	
	Begin Object Class=SkeletalMeshComponent Name=testmesh
		SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mechprotype_leg'
		//AnimTreeTemplate=AnimTree'VH_Goliath.Anims.AT_VH_Goliath_Antenna'
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
	//MeshMechTMP=testmesh
	


         Begin Object Class=SkeletalMeshComponent Name=SAntennaMesh2
		SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.MechProtypeLeg'
		//AnimTreeTemplate=AnimTree'VH_Goliath.Anims.AT_VH_Goliath_Antenna'
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
	AntennaMesh2=SAntennaMesh2

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

        BodyAttachSocketName=PowerBallSocket
        

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
