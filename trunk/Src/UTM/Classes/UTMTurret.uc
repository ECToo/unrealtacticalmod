class UTMTurret extends Pawn;

//StaticMesh'UTMTurret.Turret'
//StaticMesh'UTMTurret.TurretBase'
//SkeletalMesh'UTMTurret.TurretBase'
//SkeletalMesh'UTMTurret.TurretStand'
//SkeletalMesh'UTMTurret.TurretGun'

var SkeletalMeshComponent GunMesh;
var SkeletalMeshComponent BaseMesh;
var SkeletalMeshComponent StationMesh;


var rotator TurretYaw;
var rotator TurretYawCurrent;
var rotator TurretPitch;
var rotator TurretPitchCurrent;
var rotator TurretRoll;
var rotator TurretRollCurrent;


//simulated function Tick(float DeltaTime)
simulated event Tick( float DeltaTime )
{
          super.Tick(DeltaTime);

          //TurretYaw.Yaw += 1;
          //`log('----' $ TurretYaw);
          //SetRotation(TurretYaw);
}

defaultproperties
{

   Begin Object Class=SkeletalMeshComponent Name=PartGun
         SkeletalMesh=SkeletalMesh'UTMTurret.TurretGun'
         Translation=(X=0.0,Y=0.0,Z=0.0)
   End Object
   GunMesh=PartGun
   Components.Add(PartGun)

   Begin Object Class=SkeletalMeshComponent Name=PartBase
         SkeletalMesh=SkeletalMesh'UTMTurret.TurretBase'
         Translation=(X=0.0,Y=0.0,Z=-28.0)
   End Object
   BaseMesh=PartBase
   Components.Add(PartBase)

   Begin Object Class=SkeletalMeshComponent Name=PartStation
         SkeletalMesh=SkeletalMesh'UTMTurret.TurretStand'
         Translation=(X=0.0,Y=0.0,Z=-78.0)
   End Object
   StationMesh=PartStation
   Components.Add(PartStation)

}