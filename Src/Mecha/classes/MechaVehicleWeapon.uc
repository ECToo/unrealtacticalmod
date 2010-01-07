/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/Mecha/classes/
 * license: CC (Give Credit -> Check readme.txt)
 * This code deal with null or None Fire from seat weapon fire. So custom code for this ill be build for it.
 */

class MechaVehicleWeapon extends UTVehicleWeapon
	HideDropDown;
	
/*
simulated function bool SelectWeapon(int WeaponNumber)
{
	super.SelectWeapon(WeaponNumber);
	`log('SelectWeapon');
	return false;
}
*/

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