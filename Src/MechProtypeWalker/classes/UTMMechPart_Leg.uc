/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class UTMMechPart_Leg extends UTMMechPart;


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

function playanimationtest(){
      super.playanimationtest();
      `log('Play Animation test leg');
      PlayAnim( 'Walk' );
      //Mesh.Animations.PlayAnim(false,1.0f,0.0f);
      //PlayVehicleAnimation('Walk');
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