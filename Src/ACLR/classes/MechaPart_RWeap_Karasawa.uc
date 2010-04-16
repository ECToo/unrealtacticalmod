/**
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class MechaPart_RWeap_Karasawa extends MechaPart_RightWeapon;

defaultproperties
{
        WeaponProjectiles=class'UTProj_LinkPlasma'
        firerate=0.2
        //ElbowBoneName=Arm2
        //SocketName=FlashPointSocket01
        //BInternalWeapon=false

	Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'WP_ACLR.karasawa_gun'
		PhysicsAsset=PhysicsAsset'WP_ACLR.karasawa_gun_Physics'

	End Object
}