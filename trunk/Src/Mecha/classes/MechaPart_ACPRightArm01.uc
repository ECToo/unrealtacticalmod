/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class MechaPart_ACPRightArm01 extends MechaPartRightArm;

defaultproperties
{
     bodytype="rightarm"
	Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VH_Mecha.mechplain_Rarm'
		PhysicsAsset=PhysicsAsset'VH_Mecha.mechplain_Rarm_Physics'
		AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechrighthand02_animtree'
	End Object
}