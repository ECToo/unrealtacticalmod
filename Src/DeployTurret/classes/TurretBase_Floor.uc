/**
 *  Created by: Darknet
 *  svn:https://unrealtacticalmod.googlecode.com/svn/trunk/Src/DeployTurret
 *  This is for base rotation turns. This will only rotate yaw axis.
 */

class TurretBase_Floor extends Turret;



defaultproperties
{
	Begin Object Name=MeshPart
		SkeletalMesh=SkeletalMesh'UTMTurret.TurretBase'
		PhysicsAsset=PhysicsAsset'UTMTurret.TurretBase_Physics'
		Translation=(X=0.0,Y=0.0,Z=-28.0)
   End Object
}