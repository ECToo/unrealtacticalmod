class TurretC1 extends PawnTurret;

defaultproperties
{
	TurretGunBaseClass=class'TurretC1_Gun'
	TurretBaseClass=class'TurretC1_BaseFloor'
	WeapProj=class'UTProj_LinkPlasma'
   
	Begin Object Name=STurretMesh
		SkeletalMesh=SkeletalMesh'UTMTurret.turretc1_stand'
		PhysicsAsset=PhysicsAsset'UTMTurret.turretc1_stand_Physics'
		Translation=(X=0.0,Y=0.0,Z=-78.0)
	End Object
}