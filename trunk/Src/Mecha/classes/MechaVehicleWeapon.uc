/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/Mecha/classes/
 * license: CC (Give Credit -> Check readme.txt)
 * This code deal with null or None Fire from seat weapon fire. So custom code for this ill be build for it.
 */

class MechaVehicleWeapon extends UTVehicleWeapon
	HideDropDown;
	
var Actor LastCurrentTarget;

/** angle for locking for lock targets */
var float 				LockAim;

/** angle for locking for lock targets when on Console */
var float 				ConsoleLockAim;

/** How far out should we be considering actors for a lock */
var float		LockRange;

/** Sound Effects to play when Locking */
var SoundCue 			LockAcquiredSound;

/** Used to show lock symbol on crosshair */
var float LastLockTime;


/**
 * Access to HUD and Canvas.
 * Event always called when the InventoryManager considers this Inventory Item currently "Active"
 * (for example active weapon)
 *
 * @param	HUD			- HUD with canvas to draw on
 */
simulated function ActiveRenderOverlays( HUD H )
{
	local UTPlayerController PC;

	PC = UTPlayerController(Instigator.Controller);
	if ( (PC == None) || PC.bNoCrosshair )
	{
		return;
	}
	DrawWeaponCrosshair( H );
	if (WorldInfo.TimeSeconds - LastLockTime < 0.9 )
	{
		DrawLockedOn( H );
	}
	else
	{
		bWasLocked = false;
	}

}

simulated function Projectile ProjectileFire()
{
	local UTProj_SeekingRocket Rocket;//main seeker code
	local float BestAim, BestDist;
	local UTVehicle AimTarget;
	local UTPlayerController UTPC;

	Rocket = UTProj_SeekingRocket(Super.ProjectileFire());

	if ( Rocket != None )
	{
		UTPC = UTPlayerController(MyVehicle.Controller);
		BestAim	= ((UTPC != None) && UTPC.AimingHelp(true)) ? ConsoleLockAim : LockAim;
		AimTarget = UTVehicle(Instigator.Controller.PickTarget(class'UTHoverVehicle', BestAim, BestDist, Normal(Rocket.Velocity), Rocket.Location, LockRange));
		if (AimTarget != None && AimTarget.bHomingTarget)
		{
		        if(Rocket != None){
			    //Rocket.Seeking = AimTarget;
			    //`log("locked on");
			     ClientSetLock();
			}
			`log("locked on" $ AimTarget.Name);
		}
	}

	return Rocket;
}

unreliable simulated client function ClientSetLock()
{
	LastLockTime = WorldInfo.TimeSeconds;
	if ( PlayerController(Instigator.Controller) != None )
	{
		PlayerController(Instigator.Controller).ClientPlaySound(LockAcquiredSound);
	}
}

simulated function float MaxRange()
{
	local float Range;

	// ignore missles for the range calculation
	if (bInstantHit)
	{
		Range = GetTraceRange();
	}
	if (WeaponProjectiles[0] != None)
	{
		Range = FMax(Range, WeaponProjectiles[0].static.GetRange());
	}
	return Range;
}

/*
function class<Projectile> GetProjectileClass()
{
	if ( CurrentFireMode == 0)
	{
		if( Instigator.GetTeamNum() == 0 )
		{
			return class'UTProj_RaptorBoltRed';
		}
		else
		{
			return class'UTProj_RaptorBolt';
		}
	}
	else
	{
		if( Instigator.GetTeamNum() == 0 )
		{
			return class'UTProj_RaptorRocketRed';
		}
		else
		{
			return class'UTProj_RaptorRocket';
		}
	}
}
*/

function byte BestMode()
{
	local UTBot Bot;

	Bot = UTBot(Instigator.Controller);
	if (Bot != None && UTVehicle(Bot.Enemy) != None && UTVehicle(Bot.Enemy).bHomingTarget && (FRand() < 0.3 + 0.1 * Bot.Skill))
	{
		return 1;
	}
	else
	{
		return 0;
	}
}




defaultproperties
{
	WeaponFireTypes(0)=EWFT_Projectile
	WeaponProjectiles(0)=class'MechaProjectile'
	WeaponFireTypes(1)=EWFT_None

	//WeaponFireSnd[0]=SoundCue'A_Vehicle_Manta.SoundCues.A_Vehicle_Manta_Fire'

	FireInterval(0)=+0.2
	bFastRepeater=true
	ShotCost(0)=0
	ShotCost(1)=0
	FireTriggerTags=(MantaWeapon01,MantaWeapon02)
	//VehicleClass=class'UTVehicle_Manta_Content'
	AimError=750
}