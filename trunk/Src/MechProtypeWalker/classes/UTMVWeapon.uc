class UTMVWeapon extends UTVehicleWeapon
	HideDropDown;
	

defaultproperties
{
	WeaponFireTypes(0)=EWFT_Projectile
	WeaponProjectiles(0)=class'UTMMechPartProjectile'
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