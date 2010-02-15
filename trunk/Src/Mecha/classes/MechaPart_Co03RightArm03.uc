/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class MechaPart_Co03RightArm03 extends MechaPartArm;

defaultproperties
{
     bodytype="rightarm"
     ElbowBoneName=RightArm2
      Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VH_Mecha.mechabuildco03_RArm03'
		PhysicsAsset=PhysicsAsset'VH_Mecha.mechabuildco03_RArm03_Physics'
		AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechrighthand02_animtree'
	End Object

	//Mesh=MeshFrame
}