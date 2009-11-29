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
var bool bWeaponFire;
var bool BAltWeaponFire;
var int firerate;
var int fireinterval;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
}

simulated function Tick(float DeltaTime)
{
          super.Tick(DeltaTime);
          fireweaponprojtile();

}

function weaponfire()
{
	super.weaponfire();
	`log('Right Weapon Fire');
	fireweaponprojtile();
}

simulated function fireweaponprojtile(){
	//Spawn(class'UTProj_LinkPlasma', Self, , Location + Vect(8, 2, 0), Rotation, ,);//working code but not set movement

	local UTProjectile SpawnedProjectile;

	if (bWeaponFire){
           fireinterval++;
              if (fireinterval > firerate){
                 fireinterval = 0;
	              if (WeaponProjectiles != None){
		         //SpawnedProjectile = Spawn(WeaponProjectiles,,,MechVehicle.Location,MechVehicle.Rotation);
		         Mesh.ForceSkelUpdate();
		         GetBarrelLocationAndRotation(SocketName,SocketLocation,SocketRotation);
		         //SpawnedProjectile = Spawn(WeaponProjectiles,MechVehicle,,MechVehicle.Location,MechVehicle.Rotation);
		         SpawnedProjectile = Spawn(WeaponProjectiles,MechVehicle,,SocketLocation);
		         if (SpawnedProjectile != none)
		            {
			    //SpawnedProjectile.Init(MechVehicle.Location+Location);
			    SpawnedProjectile.Init(SocketLocation+Vector(MechVehicle.Rotation));
		           }
                        }
             }
	}
}

function BeginFire(){
   super.BeginFire();
   bWeaponFire = True;
}

function EndFire(){
   super.EndFire();
   bWeaponFire = False;
}

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