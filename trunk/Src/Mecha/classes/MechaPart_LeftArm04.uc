/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class MechaPart_LeftArm04 extends MechaPartLeftArm;

defaultproperties
{
     bodytype="leftarm"
     ElbowBoneName=LeftArm2
     SocketName=FlashPointSocket01
     BInternalWeapon=true
     firerate=0.2
	Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VH_Mecha.mecha_arm03_left'
		PhysicsAsset=PhysicsAsset'VH_Mecha.mecha_arm03_left_Physics'
		AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechlefthand02_animtree'
	End Object
}