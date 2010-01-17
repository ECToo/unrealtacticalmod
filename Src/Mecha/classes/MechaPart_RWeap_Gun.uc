/**
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class MechaPart_RWeap_Gun extends MechaPartWeapon;

defaultproperties
{
        WeaponProjectiles=class'UTProj_LinkPlasma'
        SocketName=FlashPointSocket01
        firerate=0.2

	Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VH_Mecha.RMechaWeaponA01_gun'
	End Object
}