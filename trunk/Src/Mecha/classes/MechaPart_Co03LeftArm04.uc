/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class MechaPart_Co03LeftArm04 extends MechaPartArm;

defaultproperties
{
     bodytype="leftarm"
	Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VH_Mecha.mechabuildco03_LArm04'
		PhysicsAsset=PhysicsAsset'VH_Mecha.mechabuildco03_LArm04_Physics'
		AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechlefthand02_animtree'
	End Object
}