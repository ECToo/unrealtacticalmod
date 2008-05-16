/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTVehicleFactory_Air extends UTVehicleFactory;

defaultproperties
{
	Begin Object Name=SVehicleMesh
		SkeletalMesh=SkeletalMesh'air_vehicle.air_vehicle'
	End Object

	Components.Remove(Sprite)

	Begin Object Name=CollisionCylinder
		CollisionHeight=+80.0
		CollisionRadius=+100.0
	End Object

	VehicleClassPath="mymod.UTVehicle_Air_Content"
	DrawScale=1.3
}
