/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class MechaPart_ACPLeftArm01 extends MechaPartLeftArm;

defaultproperties
{
     bodytype="leftarm"
	Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VH_Mecha.mechplain_Larm'
		PhysicsAsset=PhysicsAsset'VH_Mecha.mechplain_Larm_Physics'
		AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechlefthand02_animtree'
	End Object
}