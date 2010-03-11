/**
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class MechaPart_MR1_RWeap_Gun extends MechaPart_RightWeapon;

defaultproperties
{
        WeaponProjectiles=class'UTProj_LinkPlasma'
        SocketName=FlashPointSocket01
        firerate=0.2

	Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VH_Mecha.mecha_r1_weapon_gun'
		PhysicsAsset=PhysicsAsset'VH_Mecha.mecha_r1_weapon_gun_Physics'
	End Object
}