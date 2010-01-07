/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class MechaPart_Leg extends MechaPart;

/*
simulated function PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
	Super.PostInitAnimTree(SkelComp);

	if(SkelComp == Mesh)
	{
		RightLegAdjustControl = SkelControlSingleBone( mesh.FindSkelControl('RightLegAdjust') );
		LeftLegAdjustControl = SkelControlSingleBone( mesh.FindSkelControl('LeftLegAdjust') );
		RightFootControl = SkelControlSingleBone( mesh.FindSkelControl('RightFoot') );
		LeftFootControl = SkelControlSingleBone( mesh.FindSkelControl('LeftFoot') );
	}
}
*/

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
}

//===============================================
// Action Walk Code
//===============================================

//This code deal with will loop animation that is already in running.
function BeginActionWalk(){
      super.BeginActionWalk();
      //PlayAnim( 'Walk' );
      Mesh.PlayAnim('Walk', 1, true, false);//working code for animation
      //`log('move');
}
//this will pause the animation and resume animation.
function EndActionWalk(){
      super.EndActionWalk();
      //`log('Stop Animation');
      //`log('stop');
      Mesh.StopAnim();
}

function DirectionWalk(String dirname ){
//`log(dirname);
}

//===============================================
// Test Code
//===============================================

function playanimationtest(){
      super.playanimationtest();
}

defaultproperties
{
      Begin Object Name=MeshFrame
		SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mechprotype_leg'
		AnimTreeTemplate=AnimTree'VHUTM_MechProtypeWalker.mechprotype_leg_at'
		AnimSets(0)=AnimSet'VHUTM_MechProtypeWalker.mechprotype_leg_animation'
		//VHUTM_MechProtypeWalker.mechprotype_leg_animation
	End Object
	//Mesh=MeshFrame
}