/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class MechaPart_Co03RightArm02 extends MechaPartArm;

defaultproperties
{
     bodytype="rightarm"
      Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VH_Mecha.mechabuildco03_RArm02'
		PhysicsAsset=PhysicsAsset'VH_Mecha.mechabuildco03_RArm02_Physics'
		AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechrighthand02_animtree'
	End Object

	//Mesh=MeshFrame
}