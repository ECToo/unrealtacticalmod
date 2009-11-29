/**
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class UTMMechPart_RightWeapon extends UTMMechPartWeapon;
/*
var class<UTProjectile> WeaponProjectiles;

function weaponfire()
{
      super.weaponfire();
      `log('Right Weapon Fire');
      fireweaponprojtile();
}

function fireweaponprojtile(){
  //Spawn(class'UTProj_LinkPlasma', Self, , Location + Vect(8, 2, 0), Rotation, ,);//working code but not set movement

  local UTProjectile SpawnedProjectile;
  SpawnedProjectile = Spawn(WeaponProjectiles,,,MechVehicle.Location,MechVehicle.Rotation);

  if(SpawnedProjectile != none)
  {
     SpawnedProjectile.Init(Location);
  }

}
*/

defaultproperties
{
        WeaponProjectiles=class'UTProj_LinkPlasma'
        SocketName=FlashPointSocket01
        firerate=10

	Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mecharm_minigun'
		//AnimTreeTemplate=AnimTree''
	End Object
}