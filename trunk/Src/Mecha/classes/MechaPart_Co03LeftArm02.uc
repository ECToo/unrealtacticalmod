/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class MechaPart_Co03LeftArm02 extends MechaPartLeftArm;

defaultproperties
{
     bodytype="leftarm"
     ElbowBoneName=LeftArm2
	Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VH_Mecha.mechabuildco03_LArm02'
		PhysicsAsset=PhysicsAsset'VH_Mecha.mechabuildco03_LArm02_Physics'
		AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechlefthand02_animtree'
	End Object
}