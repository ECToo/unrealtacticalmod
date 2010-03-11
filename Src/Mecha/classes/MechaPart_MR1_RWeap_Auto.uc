/**
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class MechaPart_MR1_RWeap_Auto extends MechaPart_RightWeapon;

defaultproperties
{
        WeaponProjectiles=class'UTProj_LinkPlasma'
        firerate=0.2

	Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VH_Mecha.mecha_r1_weapon_auto'
		PhysicsAsset=PhysicsAsset'VH_Mecha.mecha_r1_weapon_auto_Physics'

	End Object
}