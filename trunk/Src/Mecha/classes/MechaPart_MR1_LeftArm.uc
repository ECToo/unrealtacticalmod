/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class MechaPart_MR1_LeftArm extends MechaPartLeftArm;

defaultproperties
{
     bodytype="leftarm"
     ElbowBoneName=Arm2
	Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VH_Mecha.mecha_r1_larm'
		PhysicsAsset=PhysicsAsset'VH_Mecha.mecha_r1_larm_Physics'
		AnimTreeTemplate=AnimTree'VH_Mecha.mecha_r1_arm_animtree'
	End Object
}