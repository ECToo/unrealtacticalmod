/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class MechaPart_MR1_RightArm extends MechaPartRightArm;

defaultproperties
{
     bodytype="rightarm"
     elbowBoneName=Arm2
      Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VH_Mecha.mecha_r1_rarm'
		PhysicsAsset=PhysicsAsset'VH_Mecha.mecha_r1_rarm_Physics'
		AnimTreeTemplate=AnimTree'VH_Mecha.mecha_r1_arm_animtree'
	End Object

	//Mesh=MeshFrame
}