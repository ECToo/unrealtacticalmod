/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class MechaPart_Co03LeftArm03 extends MechaPartArm;

defaultproperties
{
     bodytype="leftarm"
	Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VH_Mecha.mechabuildco03_LArm03'
		PhysicsAsset=PhysicsAsset'VH_Mecha.mechabuildco03_LArm03_Physics'
		AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechlefthand02_animtree'
	End Object
}