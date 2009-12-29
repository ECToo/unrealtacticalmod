/**
  Created by: Darknet
  Information: This deal with stand alone turret or sentinel code for basic AI code need for a simple game build.
  This will build from scrape code and other people works. Working on smoothing it out.

  This will requited other script like custom pawn class to able to use it.

Flow Chart:

Look for pawn
check for pawn is player distance
-check if pawn is same team else attack the player
check for vehicle distance
-check is vehicle is on the same team else attack the vehicle

Target
-Start Aim
-Start Fire
-Check Death

If death go to find more pawn or Idle find.
*/


class AITurretController extends AIController;

var float PauseTime;
var NavigationPoint OldMoveTarget;

/** Sentinel being controlled. */
var PawnTurret Cannon;

/** Set to true to force the Sentinel to target an actor that it does not considered its best target. */
var bool bForceTarget;

var vector FocalPoint;
var vector AdjustLoc;

var rotator pointrotation;


simulated function PostBeginPlay()
{
          super.PostBeginPlay();
          `log('INIT AI TURRET CODE FUNCTION THINKING');
          
          //Not entirely sure what this does, but Controller.uc suggests it's a good idea.
	SightCounter = 0.2 * FRand();
}


// This code use direction where bot or player see
event SeePlayer(Pawn seen)//works
{
      local vector aimpoint;
      local vector AimSpot;
      local vector Origin;
      local Rotator AimRotation;
`log(seen.GetHumanReadableName());
//`log('seen player');
//MoveToward(seen);
                  AimSpot =  seen.Location;
                  Origin =  Cannon.Location;
                  AimRotation = Rotator(AimSpot - Origin);
                  Cannon.TurretBase.Mesh.SetRotation(AimRotation);
                  Cannon.TurretGunBase.Mesh.SetRotation(AimRotation);
}

function Tick(float DeltaTime)
{
        //super.Tick(DeltaTime);
	//CurrentBehaviour.ComponentTick();
	//pointrotation.Yaw += 100;
	//Cannon.TurretBase.Mesh.SetRotation(pointrotation);
        //Cannon.TurretGunBase.Mesh.SetRotation(pointrotation);
}

function Possess(Pawn inPawn, bool bVehicleTransition)
{
	Cannon = PawnTurret(inPawn);
	InitPlayerReplicationInfo();

	if(inPawn.Controller != none && inPawn.Controller != self)
	{
		inPawn.Controller.UnPossess();
	}

	inPawn.PossessedBy(self, bVehicleTransition);
	Pawn = inPawn;

	FocalPoint = Pawn.Location + 512*vector(Pawn.Rotation);
	Restart(bVehicleTransition);
}

simulated function String GetHumanReadableName()
{
	return (Pawn != none ? Pawn.GetHumanReadableName() : super.GetHumanReadableName());
}

function PawnDied(Pawn P)
{
	Destroy();
}

/**
 * Forces the Sentinel to aim at the given actor even if it is not its current target. Call with 'none' to revert to normal behaviour.
 */
function ForceTarget(Actor ForcedTarget)
{
        `log('ForceTarget');
	bForceTarget = ForcedTarget != none;
	Focus = ForcedTarget;
}

/**
 * Determines the best place to shoot at to hit the target.
 */
function FindAimToHit(Actor A, out Vector AimSpot, out Rotator AimRotation)
{
	local vector Origin;

	Origin = Cannon.GetPawnViewLocation();
	`log('FindAimToHit');

	//If the enemy is not visible, point at where they were last detected.
	/*
	if(!bEnemyIsVisible && !bForceTarget)
	{
		AimSpot = LastDetectedLocation;
	}
	*/
	//If using an instant-hit weapon or the target doesn't move, just aim straight at it.
	/*
	else if(Cannon.SWeapon.GetProjectileClass() == none || A.IsStationary())
	{
		AimSpot = A.GetTargetLocation();
		TraceCheckAim(A, Origin, AimSpot);
	}

	//For moving targets, try to aim where they will be when the shot reaches them.
	else
	{
		PredictTargetLocation(A, Origin, AimSpot);

		if(!TraceCheckAim(A, Origin, AimSpot))
		{
			//If the predicted location cannot be shot at, try half way.
			AimSpot = AimSpot - ((AimSpot - A.GetTargetLocation()) / 2.0);

			if(!TraceCheckAim(A, Origin, AimSpot))
			{
				//Still can't hit? Try not aiming ahead at all.
				AimSpot = A.GetTargetLocation();
				TraceCheckAim(A, Origin, AimSpot);
			}
		}
	}
	*/

	AimRotation = Rotator(AimSpot - Origin);
	Cannon.TurretBase.Mesh.SetRotation(AimRotation);
        Cannon.TurretGunBase.Mesh.SetRotation(AimRotation);
	//Cannon.SWeapon.AdjustAimToHit(A, AimSpot, AimRotation);
}


/**
 * Predicts where the target will be based on its velocity. Only call this if the Sentinel is using a projectile weapon.
 */
 /*
function PredictTargetLocation(Actor A, Vector Origin, out Vector AimSpot)
{
	local float PredictionTime;
	local Vector PredictionVelocity;
	local Vector Extent;
	local Vector TraceStart, TraceEnd;
	local Vector HitLocation, HitNormal;

	AimSpot = A.GetTargetLocation();

	//How long it will take for projectile to reach target.
	PredictionTime = Cannon.SWeapon.GetProjectileTimeToLocation(AimSpot, Origin, Cannon.SController);

	//Where the target will probably be by then.
	if(VSize(A.Velocity) > MaxPredictionSpeed)
		PredictionVelocity = Normal(A.Velocity) * MaxPredictionSpeed;
	else
		PredictionVelocity = A.Velocity;

	if(bPredictionUsesTrace)
	{
		//Trace from target's current location to predicted location and assume they will stop if there is an obstacle.
		TraceStart = AimSpot;
		TraceEnd = TraceStart + (PredictionVelocity * PredictionTime * Cannon.AimAhead);
		A.GetBoundingCylinder(Extent.X, Extent.Z);
		Extent.Y = Extent.X;

		if(Trace(HitLocation, HitNormal, TraceEnd, TraceStart, true, Extent,, TRACEFLAG_Blocking) == none)
		{
			AimSpot = TraceEnd;
		}
		else
		{
			AimSpot = HitLocation;
		}
	}
	else
	{
		AimSpot += PredictionVelocity * PredictionTime * Cannon.AimAhead;
	}
}
*/

event bool NotifyBump(Actor Other, Vector HitNormal)
{
	local Pawn P;

	Disable('NotifyBump');
	SetTimer(1.0, false, 'BumpTimer');
        `log('NotifyBump');
	P = Pawn(Other);
	if( P != None){
	`log('PAWN NAME ' @ P.GetHumanReadableName());
	}


	if ( (P == None) || (P.Controller == None) )
		return false;

	AdjustAround(P);
	return false;
}

function AdjustAround(Pawn Other)
{
	local vector VelDir, OtherDir, SideDir;

	if ( !InLatentExecution(LATENT_MOVETOWARD) )
		return;

	VelDir = Normal(MoveTarget.Location - Pawn.Location);
	VelDir.Z = 0;
	OtherDir = Other.Location - Pawn.Location;
	OtherDir.Z = 0;
	OtherDir = Normal(OtherDir);
	if ( (VelDir Dot OtherDir) > 0.7 )
	{
		bAdjusting = true;
		SideDir.X = VelDir.Y;
		SideDir.Y = -1 * VelDir.X;
		if ( (SideDir Dot OtherDir) > 0 )
			SideDir *= -1;
		AdjustLoc = Pawn.Location + 3 * Other.GetCollisionRadius() * (0.5 * VelDir + SideDir);
		`log('LOCATION ' @ AdjustLoc);
	}
}

function BumpTimer()
{
	enable('NotifyBump');
}

// FIXME -- Implement this in Pawn to support ONS weapon system.
function bool IsTurretFiring()
{
        `log('FIRE');
	if ( (Pawn.Weapon != None) && Pawn.Weapon.IsFiring() )
		return true;

	return false;
}

function float GetWaitForTargetTime()
{
	return (3 + 5 * FRand());
}


defaultproperties
{
	RotationRate=(Pitch=32768,Yaw=60000,Roll=0)
	//AcquisitionYawRate=10000
	bSlowerZAcquire=false
}