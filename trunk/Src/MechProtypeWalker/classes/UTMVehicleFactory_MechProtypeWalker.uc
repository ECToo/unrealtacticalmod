/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class UTMVehicleFactory_MechProtypeWalker extends UTVehicleFactory;

defaultproperties
{
	Begin Object Name=SVehicleMesh
		//SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mechprotype'
		SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mechprotype_body'
	End Object

	Components.Remove(Sprite)

	Begin Object Name=CollisionCylinder
		CollisionHeight=+100.0
		CollisionRadius=+100.0
	End Object

	VehicleClassPath="MechProtypeWalker.UTMVehicle_MechProtypeWalker_Content"
}