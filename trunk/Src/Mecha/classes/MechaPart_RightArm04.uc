/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class MechaPart_RightArm04 extends MechaPartRightArm;

defaultproperties
{
     bodytype="rightarm"
     SocketName=FlashPointSocket01
     BInternalWeapon=true
     firerate=0.2
      Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VH_Mecha.mecha_arm03_right'
		PhysicsAsset=PhysicsAsset'VH_Mecha.mecha_arm03_right_Physics'
		AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechrighthand02_animtree'
	End Object

	//Mesh=MeshFrame
}