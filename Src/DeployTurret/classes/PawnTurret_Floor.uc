/**
 *  Created by: Darknet
 *  svn:https://unrealtacticalmod.googlecode.com/svn/trunk/Src/DeployTurret
 */

class PawnTurret_Floor extends PawnTurret
	placeable;

simulated function PostBeginPlay()
{
  super.PostBeginPlay();
}

defaultproperties
{
	TurretGunBaseClass=class'Turret_Gun'
	TurretBaseClass=class'TurretBase_Floor'

	Begin Object Name=STurretMesh
		SkeletalMesh=SkeletalMesh'UTMTurret.sentry_flloor'
		PhysicsAsset=PhysicsAsset'UTMTurret.sentry_flloor_Physics'
		Translation=(X=0.0,Y=0.0,Z=-78.0)
	End Object
}