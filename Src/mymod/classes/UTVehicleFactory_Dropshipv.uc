/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTVehicleFactory_Dropshipv extends UTVehicleFactory;

defaultproperties
{
	Begin Object Name=SVehicleMesh
		SkeletalMesh=SkeletalMesh'VH_Dropshipv.Mesh.dropship_vehicle'
	End Object

	//Components.Remove(Sprite)

	//Begin Object Name=CollisionCylinder
	//	CollisionHeight=+80.0
	//	CollisionRadius=+100.0
	//End Object

	VehicleClassPath="mymod.UTVehicle_Dropshipv_Content"
	//DrawScale=1.3
	DrawScale=4
}