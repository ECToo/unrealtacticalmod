/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTVF_SpaceShip extends UTVehicleFactory;

defaultproperties
{
//This show your ship in the unreal editer
	Begin Object Name=SVehicleMesh
		SkeletalMesh=SkeletalMesh'shipdae.Anims.spaceship_B03_dae_m'
	End Object

	Components.Remove(Sprite)

	Begin Object Name=CollisionCylinder
		CollisionHeight=+80.0
		CollisionRadius=+100.0
	End Object

	VehicleClassPath="mymod.UTV_SpaceShip_C"

	DrawScale=1.3
	//DrawScale=8
}