/**
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */
 
 /*
 * Information: This code will deal with custom build fire and drop able and pickup weapon.
 * THis will deal with override fire a bit to deal with indepent part that can fire.
 */

class UTMMechPartWeapon extends UTMMechPart;

var class<UTProjectile> WeaponProjectiles;

var Name SocketName;
var vector SocketLocation;
var rotator SocketRotation;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
}

function weaponfire()
{
	super.weaponfire();
	`log('Right Weapon Fire');
	fireweaponprojtile();
}

function fireweaponprojtile(){
	//Spawn(class'UTProj_LinkPlasma', Self, , Location + Vect(8, 2, 0), Rotation, ,);//working code but not set movement

	local UTProjectile SpawnedProjectile;
	if (WeaponProjectiles != None){
		//SpawnedProjectile = Spawn(WeaponProjectiles,,,MechVehicle.Location,MechVehicle.Rotation);
		
		GetBarrelLocationAndRotation(SocketName,SocketLocation,SocketRotation);
		//SpawnedProjectile = Spawn(WeaponProjectiles,MechVehicle,,MechVehicle.Location,MechVehicle.Rotation);
		SpawnedProjectile = Spawn(WeaponProjectiles,MechVehicle,,SocketLocation,SocketRotation);
		if(SpawnedProjectile != none)
		{
			SpawnedProjectile.Init(Location);
		}
	}
}

/*
simulated event GetBarrelLocationAndRotation(int SeatIndex, out vector SocketLocation, optional out rotator SocketRotation)
{
	if (Seats[SeatIndex].GunSocket.Length>0)
	{
		Mesh.GetSocketWorldLocationAndRotation(Seats[SeatIndex].GunSocket[GetBarrelIndex(SeatIndex)], SocketLocation, SocketRotation);
	}
	else
	{
		SocketLocation = Location;
		SocketRotation = Rotation;
	}
}
*/

simulated event GetBarrelLocationAndRotation(Name TagSocketName, out vector TagSocketLocation, optional out rotator TagSocketRotation)
{
       if ( Mesh.GetSocketByName(TagSocketName) != None)
	{
		Mesh.GetSocketWorldLocationAndRotation(TagSocketName, TagSocketLocation, TagSocketRotation);
	}else{
	    `log('no socket');
	    //if(MechVehicle != None){
            //   SocketLocation = MechVehicle.Location;
            //   SocketRotation = MechVehicle.Rotation;
	    //}else{
		SocketLocation = Location;
		SocketRotation = Rotation;
	    //}
	}
}



defaultproperties
{


}