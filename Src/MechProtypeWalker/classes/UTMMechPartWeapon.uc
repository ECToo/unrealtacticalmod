/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */
 
 /*
 * Information: This code will deal with custom build fire and drop able and pickup weapon.
 */

class UTMMechPartWeapon extends UTMMechPart;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
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