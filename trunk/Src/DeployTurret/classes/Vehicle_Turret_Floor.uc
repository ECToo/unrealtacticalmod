class Vehicle_Turret_Floor extends Vehicle_Turret
      placeable;

simulated function PostBeginPlay()
{
  super.PostBeginPlay();

}

defaultproperties
{
   TurretGunBaseClass=class'Turret_Gun'
   TurretBaseClass=class'Turret_Base'
   Begin Object Name=STurretMesh
         SkeletalMesh=SkeletalMesh'UTMTurret.TurretStand'
         PhysicsAsset=PhysicsAsset'UTMTurret.TurretStand_Physics'
         Translation=(X=0.0,Y=0.0,Z=-78.0)
   End Object
}