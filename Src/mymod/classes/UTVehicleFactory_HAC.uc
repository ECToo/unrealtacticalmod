
  //Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 
class UTVehicleFactory_HAC extends UTVehicleFactory;

defaultproperties
{
	Begin Object Name=SVehicleMesh
		SkeletalMesh=SkeletalMesh'VH_Custom_Armor_Car.vehicle_heavy_armor'
		Translation=(X=40.0,Y=0.0,Z=-50.0)
	End Object

	Components.Remove(Sprite)

	Begin Object Name=CollisionCylinder
		CollisionHeight=100.0
		CollisionRadius=140.0
		Translation=(X=20.0,Y=0.0,Z=25.0)
	End Object

	VehicleClassPath="mymod.UTVehicle_HAC_Content"
	DrawScale=1.2
        //DrawScale=6
}