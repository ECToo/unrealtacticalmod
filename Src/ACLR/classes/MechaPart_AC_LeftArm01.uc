/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class MechaPart_AC_LeftArm01 extends MechaPartLeftArm;

defaultproperties
{
     bodytype="leftarm"
     ElbowBoneName=Arm2
     SocketName=FlashPointSocket01
     //BInternalWeapon=true
     firerate=0.2  

	Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VH_ACLR.ac_01_larm'
		PhysicsAsset=PhysicsAsset'VH_ACLR.ac_01_larm_Physics'
		AnimTreeTemplate=AnimTree'VH_ACLR.ac_arm_01_animtree'
		AnimSets(0)=AnimSet'VH_ACLR.ac_01_larm_animset'
	End Object
}