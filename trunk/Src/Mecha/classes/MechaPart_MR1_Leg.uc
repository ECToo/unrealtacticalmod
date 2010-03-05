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

class MechaPart_MR1_Leg extends MechaPart_Leg;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
}

defaultproperties
{
     bodytype = "leg"
      Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VH_Mecha.mecha_r1_leg'
		PhysicsAsset=PhysicsAsset'VH_Mecha.mecha_r1_leg_Physics'
		//AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechprotype_leg_at'
		//AnimSets(0)=AnimSet'VHUTM_MechProtypeWalker.mechprotype_leg_animation'
	End Object

}