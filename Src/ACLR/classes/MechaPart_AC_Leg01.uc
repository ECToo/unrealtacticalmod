/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 * Walk code is base on the timer code. To deal with the delay code for animatin when finish.

 SetTimer(1, true, 'StartCount');//this count to seconds.
 ClearTimer('StartCount');//clear timer
 function StartCount(){}

 */

class MechaPart_AC_Leg01 extends MechaPart_Leg;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
}

defaultproperties
{
     bodytype="leg"

      Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VH_ACLR.ac_01_leg'
		PhysicsAsset=PhysicsAsset'VH_ACLR.ac_01_leg_Physics'
		AnimTreeTemplate=AnimTree'VH_ACLR.ac_01_leg_animtree'
		AnimSets(0)=AnimSet'VH_ACLR.ac_01_leg_animset'
	End Object
	

}