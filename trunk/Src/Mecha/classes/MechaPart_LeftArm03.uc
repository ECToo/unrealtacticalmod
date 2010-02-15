/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class MechaPart_LeftArm03 extends MechaPartArm;

defaultproperties
{
     bodytype="leftarm"
     ElbowBoneName=LeftArm2
	Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VH_Mecha.mecha_arm03_left'
		PhysicsAsset=PhysicsAsset'VH_Mecha.mecha_arm03_left_Physics'
		AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechlefthand02_animtree'
	End Object
}