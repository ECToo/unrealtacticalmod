class PawnTurret extends Pawn
      placeable;
      
var class<Turret> TurretGunBaseClass;
var Turret TurretGunBase;

var class<Turret> TurretBaseClass;
var Turret TurretBase;


/** What this Sentinel is currently interested in. */
var Actor Target;
/** Target.GetHumanReadableName, stored for replication. */
var string TargetName;
/** True when Sentinel has a target and is tracking it. */
var bool bTracking;

/** Maximum rotation speed. */
var() Rotator MaxRotationSpeed;
/** Rotation will slow down when closer than this to the desired rotation. */
var() float RotationDampingThreshold;
/** Speed that Sentinel will rotate when it has no target. */
var() int AutoRotateRate;
/** Auto rotate direction will reverse when AutoRotateYaw exceeds this value in either direction. */
var() int AutoRotateHalfRange;
/** Offset applied to AutoRotateHalfRange so the Sentinel can look in a particular direction when idle. */
var() int AutoRotateCentre;
/** Limits for field of fire. */
var() int MaxPitch, MinPitch;

/** Rotation that Sentinel is trying to attain. */
var Rotator DesiredAim;
/** Rotation that Sentinel is currently pointing in. */
var Rotator CurrentAim;
/** Holds the value of the last change in rotation. */
var Rotator DeltaRotation;
/** Holds rotation of aim relative to base rotation after last rotation calculation. */
var Rotator BoneSpaceLastAim;

/** Controller of owning player. */
var Controller InstigatorController;

/** Just to avoid repetetive casting when accessing controller. */
var AITurretController TurretController;
var  int  counttime;

/** Proportion of target's velocity to take into account when predicting where to fire. */
var() float AimAhead;
/** Whether this Sentinel is capable of detecting invisible pawns. */
var() bool bSeeInvisible;
/** Fraction of SightRadius that invisible pawns must be closer than to be seen. */
var() float SeeInvisibleRange;

/** Rotation of base when Sentinel landed on it. */
var Rotator OriginalBaseRotation;
/** Rotation of Sentinel when it landed. */
var Rotator OriginalRotation;
/** Keeps track of yaw when idle. Stored as a float to avoid rounding errors from adding small increments to a Rotator. */
var float AutoRotateYaw;
/** Set to true if AutoRotateRate should be subtracted instead of added. */
var bool bAutoRotateYawReversed;

/** Set to true if this Sentinel is invisible. */
var bool bIsInvisible;


var class<UTProjectile> WeapProj;

//var SkeletalMeshComponent MeshGun;

var rotator rot;
var Rotator TurretYaw;

//init or begin lanuch game setup
simulated function PostBeginPlay()
{
super.PostBeginPlay();
   if ( TurretGunBaseClass != None ){
      TurretGunBase = Spawn(TurretGunBaseClass, Self,, Location, OriginalRotation);
      Attach(TurretGunBase);//attach to actor Component
      `log('Spawn Turret Gun');
   }

   if ( TurretBaseClass != None ){
      TurretBase = Spawn(TurretBaseClass, Self,, Location, OriginalRotation);
      Attach(TurretBase);//attach to actor Component
      `log('Spawn Turret Gun');
   }
   
   //AwakeTurret();
}

/* awake sleeping AwakeTurret */
function AwakeTurret()
{
	TurretController = AITurretController(Controller);
}


simulated function Tick(float DeltaTime)
{
 local UTProjectile WeapPro;
          super.Tick(DeltaTime);
          /*
          rot.Yaw += 100;
          OriginalRotation = rot;
          TurretYaw = rot;
          TurretBase.Mesh.SetRotation(rot);
          TurretGunBase.Mesh.SetRotation(rot);
          */

          counttime++;
          if(counttime > 30){
            WeapPro = Spawn(WeapProj, Self,, Location, OriginalRotation);
            WeapPro.init(Vector(TurretGunBase.Mesh.Rotation));
            //Vector(Rotation)


            counttime = 0;
          }

          //`log('tick');
          //TurretPitch.Pitch += 100;
          //SetRotation(TurretPitch);
}

/**
 * Plays spawning effects.
 */
simulated function PlaySpawnEffect()
{
	if(TurretController != none)
	{
		//TurretController.CannonSpawning();
	}

	//AutoRotateRate = 0; //Don't start rotating until finished spawning.

	//BaseComponent.PlaySpawnEffect();
	//RotatorComponent.PlaySpawnEffect();
	//WeaponComponent.PlaySpawnEffect();
}

/**
 * Called when BaseComponent finished spawning
 */
simulated function BaseSpawned()
{
	//AutoRotateRate = default.AutoRotateRate; //Start rotating.

	if(TurretController != none)
	{
		//TurretController.CannonSpawned();
	}
}


/**
 * Sets up Sentinel to start working for a new owner, and spawns the controller if one does not already exist.
 *
 * @param	Placer		new owner
 */
function InitializeFor(Pawn Placer)
{
 `log('get controlers');
	if(Placer == none || Placer.Controller == none || Placer.Controller.PlayerReplicationInfo == none)
	{
		`warn("Sentinel created with no or invalid owner:"@Placer);
		Destroy();
		return;
	}

	InstigatorController = Placer.Controller;

	//So many places to find a team colour, many of them broken in some way. At least this one works in both team and non-team games.
	//TeamColour = ColorToLinearColor(UTPlayerReplicationInfo(Placer.PlayerReplicationInfo).GetHUDColor());

	if(Controller == none)
	{
		SpawnDefaultController();
	}
	else
	{
		Controller.Possess(self, false);
	}

	TurretController = AITurretController(Controller); // this defaultproperties <- ControllerClass=class'AITurretController'

	NotifyTeamChanged();
	bForceNetUpdate = true;
}


/**
 * Makes any needed changes to conform to the current team.
 */
simulated function NotifyTeamChanged()
{
	//BaseComponent.SetTeamColour();
	//RotatorComponent.SetTeamColour();
	//WeaponComponent.SetTeamColour();

	//if(SWeapon != none)
	//{
	//	SWeapon.NotifyTeamChanged();
	//}

	//PlaySpawnEffect();
}




simulated function bool CanBeBaseForPawn(Pawn APawn)
{
	//Never allow Sentinels to stack.
	if(PawnTurret(APawn) != none)
		return false;

	return bCanBeBaseForPawns;
}

function JumpOffPawn()
{
	//Don't jump off vehicles.
	if(Vehicle(Base) != none)
		return;

	Velocity += (100 + CylinderComponent.CollisionRadius) * VRand();
	Velocity.Z = 200 + CylinderComponent.CollisionHeight;
	SetPhysics(PHYS_Falling);
}

function PhysicsVolumeChange(PhysicsVolume NewVolume)
{
	//Sentinels and water do not mix.
	if(NewVolume.bWaterVolume)
	{
		//PlaySound(SplashSound);

		//If no controller, destroy immediately (happens if initially spawned in water).
		if(Controller == none)
			Destroy();
		else
			Died(none, none, Location);
	}
}



//No movement physics
function SetMovementPhysics(){}

simulated function Rotator GetViewRotation()
{
	return CurrentAim;
}

//Find camera location and rotation for when viewing this Sentinel.
simulated function bool CalcCamera(float DeltaTime, out Vector CamLoc, out Rotator CamRot, out float FOV)
{
	local Vector DesiredCamLoc;
	local Rotator DesiredCamRot;
	local Vector HitLocation, HitNormal;
	local bool bResult;

	//WeaponComponent.GetSocketWorldLocationAndRotation(SWeapon.CameraSocketName, CamLoc, CamRot);
	DesiredCamLoc = CamLoc;
	DesiredCamRot = CamRot;

	if(Trace(HitLocation, HitNormal, DesiredCamLoc, CamLoc, false, vect(12.0, 12.0, 12.0)) != none)
	{
		DesiredCamLoc = HitLocation;
		bResult = false;
	}
	else
	{
		bResult = true;
	}

	CamLoc = DesiredCamLoc;
	CamRot = DesiredCamRot;

	return bResult;
}


/** Return false because... I can't remember, lol. */
simulated function bool IsPlayerPawn()
{
	return false;
}

//Includes not only pawns on the same team, but also this Sentinel's owner and their other Sentinels, and unnocupied UTVehicles assigned to the same team.
simulated function bool IsSameTeam(Pawn Other)
{
	local bool bSameTeam;
	local PawnTurret S;
	local UTVehicle UTV;

	bSameTeam = super.IsSameTeam(Other);

	if(!bSameTeam)
	{
		bSameTeam = Other.Controller == InstigatorController;

		if(!bSameTeam)
		{
			S = PawnTurret(Other);

			if(S != none)
			{
				bSameTeam = S.InstigatorController == InstigatorController;
			}
			else
			{
				UTV = UTVehicle(Other);

				if(UTV != none && UTV.Team != 255)
				{
					bSameTeam = UTV.Team == GetTeamNum();
				}
			}
		}
	}

	return bSameTeam;
}



//Return false otherwise bots always aim at origin, which is on the floor or ceiling.
function bool IsStationary()
{
	return false;
}

function bool IsInvisible()
{
	return bIsInvisible;
}

/**
 * Sets AutoRotateYaw to whatever value is needed to yaw the current aim.
 */
simulated function InitializeAutoRotateYaw()
{
	//local Vector BoneSpaceLocation; //Dummy variable, don't use.
	local Rotator AutoRotateRotation;

	//BaseComponent.TransformToBoneSpace(BaseComponent.RootBone, vect(0.0, 0.0, 0.0), DesiredAim, BoneSpaceLocation, AutoRotateRotation);
	AutoRotateYaw = AutoRotateRotation.Yaw;
}


/**
 * Determines yaw while idle. By default it just rotates clockwise continuously, but limits can be set so it pans back and forth across a specific range.
 */
simulated function CalculateAutoRotateYaw(float DeltaTime)
{
	AutoRotateYaw += (bAutoRotateYawReversed ? -AutoRotateRate : AutoRotateRate) * DeltaTime;

	if(NormalizeRotAxis(AutoRotateYaw - AutoRotateCentre) < -AutoRotateHalfRange)
	{
		AutoRotateYaw = -AutoRotateHalfRange + AutoRotateCentre;
		bAutoRotateYawReversed = false;
	}
	else if(NormalizeRotAxis(AutoRotateYaw - AutoRotateCentre) > AutoRotateHalfRange)
	{
		AutoRotateYaw = AutoRotateHalfRange + AutoRotateCentre;
		bAutoRotateYawReversed = true;
	}
}



defaultproperties
{
   //TurretController=class'AITurretController'
   ControllerClass=class'AITurretController'

   TurretGunBaseClass=class'Turret_Gun'
   TurretBaseClass=class'TurretBase_Floor'
   WeapProj=class'UTProj_LinkPlasma'

   Begin Object class=SkeletalMeshComponent Name=STurretMesh
         SkeletalMesh=SkeletalMesh'UTMTurret.TurretStand'
         PhysicsAsset=PhysicsAsset'UTMTurret.TurretStand_Physics'
         Translation=(X=0.0,Y=0.0,Z=-78.0)
   End Object
   Mesh=STurretMesh
   Components.Add(STurretMesh)

   //Begin Object Name=SVehicleMesh
         //floor or ceiling skeleton mesh
   //End Object
}