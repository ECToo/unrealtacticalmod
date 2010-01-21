/**
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class MechaPart_LWeap_Minigun4 extends MechaPartWeapon;

defaultproperties
{
        WeaponProjectiles=class'UTProj_LinkPlasma'
        SocketName=FlashPointSocket01
        firerate=0.2

	Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VH_Mecha.RMechaWeaponA01_Cannon'
		PhysicsAsset=PhysicsAsset'VH_Mecha.RMechaWeaponA01_minigun4_Physics'
		//Rotation=(Yaw=-16384)
		Rotation=(Roll=32768)
		//Rotation=(Yaw=-16384)
	End Object
}