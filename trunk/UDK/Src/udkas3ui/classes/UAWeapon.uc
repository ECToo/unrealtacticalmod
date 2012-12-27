/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 * 
 */

class UAWeapon extends UDKWeapon;

var float ProjectileSpawnOffset;


/**
 * Initialize the weapon
 */
simulated function PostBeginPlay()
{	
	
	//local UTGameReplicationInfo GRI;

	Super.PostBeginPlay();
	`log("INIT WEAPONS.....................................");
	/*
	CalcInventoryWeight();

	// tweak firing/reload/putdown/bringup rate if on console
	GRI = UTGameReplicationInfo(WorldInfo.GRI);
	if (GRI != None && GRI.bConsoleServer)
	{
		AdjustWeaponTimingForConsole();
	}
	*/
	if ( Mesh != None )
	{
		Mesh.CastShadow = class'UTPlayerController'.default.bFirstPersonWeaponsSelfShadow;
	}

	bConsiderProjectileAcceleration = bConsiderProjectileAcceleration
										&& (((WeaponProjectiles[0] != None) && (class<UTProjectile>(WeaponProjectiles[0]).Default.AccelRate > 0))
											|| ((WeaponProjectiles[1] != None) && (class<UTProjectile>(WeaponProjectiles[1]).Default.AccelRate > 0)) );

	// make sure small weapons matches config
	// this is needed because if the UI modifies UTWeapon's defaults at runtime, it won't propagate to the child classes
	//bSmallWeapons = class'UTWeapon'.default.bSmallWeapons;
	/*
	if ( bUseCustomCoordinates )
	{
		SimpleCrosshairCoordinates = CustomCrosshairCoordinates;
	}
	*/
}

simulated function float GetFireInterval( byte FireModeNum )
{
	`log("FIRE ME");
	return FireInterval[FireModeNum] * ((UTPawn(Owner)!= None) ? UTPawn(Owner).FireRateMultiplier : 1.0);
}


/**
 * return false if out of range, can't see target, etc.
 */
function bool CanAttack(Actor Other)
{
    local float Dist, CheckDist, OtherHeight;
    local vector HitLocation, HitNormal, projStart, TargetLoc;
    local Actor HitActor, TestActor;
    local class<Projectile> ProjClass;
    local int i;
    local UTBot B;

    if (Instigator == None || Instigator.Controller == None)
    {
        return false;
    }

    // check that target is within range
    Dist = VSize(Instigator.Location - Other.Location);
    if (Dist > MaxRange())
    {
        return false;
    }

    projStart = bInstantHit ? InstantFireStartTrace() : GetPhysicalFireStartLoc();

    // check that can see target
    B = UTBot(Instigator.Controller);
    if (Instigator.Controller.LineOfSightTo(Other, projStart))
    {
        if (B != None && B.Focus == Other)
        {
            B.bTargetAlternateLoc = false;
        }
    }
    else
    {
        if (!Other.bHasAlternateTargetLocation || !Instigator.Controller.LineOfSightTo(Other, projStart, true))
        {
            return false;
        }

        if (B != None && B.Focus == Other)
        {
            B.bTargetAlternateLoc = true;
        }
    }

    if ( !bInstantHit )
    {
        ProjClass = GetProjectileClass();
        if ( ProjClass == None )
        {
            for (i = 0; i < WeaponProjectiles.length; i++)
            {
                ProjClass = WeaponProjectiles[i];
                if (ProjClass != None)
                {
                    break;
                }
            }
        }
        if (ProjClass == None)
        {
            `warn("No projectile class for "$self);
            CheckDist = 300;
        }
        else
        {
            CheckDist = FMax(CheckDist, 0.5 * ProjClass.default.Speed);
            CheckDist = FMax(CheckDist, 300);
            CheckDist = FMin(CheckDist, VSize(Other.Location - Location));
        }
    }

    // check that would hit target, and not a friendly
    TargetLoc = Other.GetTargetLocation(Instigator);
    if ( Pawn(Other) != None )
    {
        OtherHeight = Pawn(Other).GetCollisionHeight();
        TargetLoc.Z += 0.9 * OtherHeight;
    }

    // perform the trace
    if ( bInstantHit )
    {
        HitActor = GetTraceOwner().Trace(HitLocation, HitNormal, TargetLoc, projStart, true,,, TRACEFLAG_Bullet);
    }
    else
    {
        // for non-instant hit, ignore actors beyond a small distance that may move out of the way
        foreach GetTraceOwner().TraceActors( class'Actor', TestActor, HitLocation, HitNormal,
                            TargetLoc, projStart,,, TRACEFLAG_Bullet )
        {
            if ( (TestActor.bBlockActors || TestActor.bProjTarget) &&
                (VSize(HitLocation - projStart) <= CheckDist || TestActor.IsStationary()) )
            {
                HitActor = TestActor;
                break;
            }
        }
    }

    if ( HitActor == None || HitActor == Other || (!HitActor.IsA('Pawn') && !HitActor.IsA('UTGameObjective'))
        || !WorldInfo.GRI.OnSameTeam(Instigator, HitActor) )
    {
        return true;
    }

    return false;
}

/**
* @returns position of trace start for instantfire()
*/
simulated function vector InstantFireStartTrace()
{
    return Instigator.GetWeaponStartTraceLocation();
}

simulated function vector GetPhysicalFireStartLoc(optional vector AimDir)
{
    local UTPlayerController PC;
    local vector FireStartLoc, HitLocation, HitNormal, FireDir, FireEnd, ProjBox;
    local Actor HitActor;
    local rotator FireRot;
    local class<Projectile> FiredProjectileClass;
    local int TraceFlags;

    if( Instigator != none )
    {
        PC = UTPlayerController(Instigator.Controller);

        FireRot = Instigator.GetViewRotation();
        FireDir = vector(FireRot);
        if (PC == none || PC.bCenteredWeaponFire || PC.WeaponHand == HAND_Centered || PC.WeaponHand == HAND_Hidden)
        {
            FireStartLoc = Instigator.GetPawnViewLocation() + (FireDir * FireOffset.X);
        }
        else if (PC.WeaponHand == HAND_Left)
        {
            FireStartLoc = Instigator.GetPawnViewLocation() + ((FireOffset * vect(1,-1,1)) >> FireRot);
        }
        else
        {
            FireStartLoc = Instigator.GetPawnViewLocation() + (FireOffset >> FireRot);
        }

        if ( (PC != None) || (CustomTimeDilation < 1.0) )
        {
            FiredProjectileClass = GetProjectileClass();
            if ( FiredProjectileClass != None )
            {
                FireEnd = FireStartLoc + FireDir * ProjectileSpawnOffset;
                TraceFlags = bCollideComplex ? TRACEFLAG_Bullet : 0;
                if ( FiredProjectileClass.default.CylinderComponent.CollisionRadius > 0 )
                {
                    FireEnd += FireDir * FiredProjectileClass.default.CylinderComponent.Translation.X;
                    ProjBox = FiredProjectileClass.default.CylinderComponent.CollisionRadius * vect(1,1,0);
                    ProjBox.Z = FiredProjectileClass.default.CylinderComponent.CollisionHeight;
                    HitActor = Trace(HitLocation, HitNormal, FireEnd, Instigator.Location, true, ProjBox,,TraceFlags);
                    if ( HitActor == None )
                    {
                        HitActor = Trace(HitLocation, HitNormal, FireEnd, FireStartLoc, true, ProjBox,,TraceFlags);
                    }
                    else
                    {
                        FireStartLoc = Instigator.Location - FireDir*FiredProjectileClass.default.CylinderComponent.Translation.X;
                        FireStartLoc.Z = FireStartLoc.Z + FMin(Instigator.EyeHeight, Instigator.CylinderComponent.CollisionHeight - FiredProjectileClass.default.CylinderComponent.CollisionHeight - 1.0);
                        return FireStartLoc;
                    }
                }
                else
                {
                    HitActor = Trace(HitLocation, HitNormal, FireEnd, FireStartLoc, true, vect(0,0,0),,TraceFlags);
                }
                return (HitActor == None) ? FireEnd : HitLocation - 3*FireDir;
            }
        }
        return FireStartLoc;
    }

    return Location;
}

/**
 * Returns the DamageRadius of projectiles being shot
 */
function float GetDamageRadius()
{
    local class<Projectile> CurrentProjectileClass;

    CurrentProjectileClass = GetProjectileClass();
    if( CurrentProjectileClass == None )
    {
        return 0;
    }
    return CurrentProjectileClass.default.DamageRadius;
}

/**
 * CanHeal()
 * used by bot AI should return true if this weapon is able to heal Other
 */
function bool CanHeal(Actor Other)
{
    return false;
}



defaultproperties
{

}