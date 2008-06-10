
  //Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 
class UTVehicleFactory_Car extends UTVehicleFactory;

defaultproperties
{
	Begin Object Name=SVehicleMesh
		SkeletalMesh=SkeletalMesh'customvehicle.Anims.vehicle_test'
		Translation=(X=40.0,Y=0.0,Z=-50.0)
	End Object

	Components.Remove(Sprite)

	Begin Object Name=CollisionCylinder
		CollisionHeight=100.0
		CollisionRadius=140.0
		Translation=(X=20.0,Y=0.0,Z=25.0)
	End Object

	VehicleClassPath="mymod.UTVehicle_Car_Content"
	//DrawScale=1.2
        DrawScale=6
}