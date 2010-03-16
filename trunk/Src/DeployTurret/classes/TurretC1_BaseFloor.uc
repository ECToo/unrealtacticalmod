/**
 *  Created by: Darknet
 *  svn:https://unrealtacticalmod.googlecode.com/svn/trunk/Src/DeployTurret
 *  This is for base rotation turns. This will only rotate yaw axis.
 */

class TurretC1_BaseFloor extends Turret;

defaultproperties
{
	Begin Object Name=MeshPart
	SkeletalMesh=SkeletalMesh'UTMTurret.turretc1_base'
		PhysicsAsset=PhysicsAsset'UTMTurret.turretc1_base_Physics'
		Translation=(X=0.0,Y=0.0,Z=-28.0)
	End Object
}