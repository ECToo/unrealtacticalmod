/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTVehicleFactory_shipcraft extends UTVehicleFactory;

defaultproperties
{
	Begin Object Name=SVehicleMesh
		SkeletalMesh=SkeletalMesh'BetaSpaceCraft.Anims.circle_racer01'
		Translation=(X=0.0,Y=0.0,Z=-70.0)
	End Object

	Components.Remove(Sprite)

	Begin Object Name=CollisionCylinder
		CollisionHeight=+40.0
		CollisionRadius=+100.0
	End Object

	VehicleClassPath="UTGameContent.UTVehicle_shipcraft_Content"
}