class UTMTurret_Floor extends UTMTurret;
//StaticMesh'UTMTurret.Turret'
//StaticMesh'UTMTurret.TurretBase'
//SkeletalMesh'UTMTurret.TurretBase'
//SkeletalMesh'UTMTurret.TurretStand'
//SkeletalMesh'UTMTurret.TurretGun'

defaultproperties
{
    Begin Object Name=PartGun
         SkeletalMesh=SkeletalMesh'UTMTurret.TurretGun'
   End Object
   
   Begin Object Name=PartBase
         SkeletalMesh=SkeletalMesh'UTMTurret.TurretBase'
   End Object
   
   Begin Object Name=PartStation
         SkeletalMesh=SkeletalMesh'UTMTurret.TurretStand'
   End Object
}