/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class MechaPart_LeftWeapon extends MechaPartWeapon;

defaultproperties
{
	bodytype="leftweaponhand"
	WeaponProjectiles=class'UTProj_LinkPlasma'
	SocketName=FlashPointSocket01
	firerate=0.2

	Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mecharm_minigun'
		PhysicsAsset=PhysicsAsset'VHUTM_MechProtypeWalker.mecharm_minigun_Physics'
		AnimSets.Add(AnimSet'VHUTM_MechProtypeWalker.mecharm_minigun_animset')
		AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mecharm_minigun_animtree'
	End Object
}