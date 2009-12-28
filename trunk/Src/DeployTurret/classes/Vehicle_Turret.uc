class Vehicle_Turret extends Pawn
      placeable;
      
var class<Turret> TurretGunBaseClass;
var Turret TurretGunBase;

var class<Turret> TurretBaseClass;
var Turret TurretBase;


var AITurretController TurretController;
var  int  counttime;


var class<UTProjectile> WeapProj;

//var SkeletalMeshComponent MeshGun;

var rotator rot;

var		Rotator		OriginalRotation;
var		Rotator		TurretYaw;

//init or begin lanuch game setup
simulated function PostBeginPlay()
{
super.PostBeginPlay();
   if ( TurretGunBaseClass != None ){
      TurretGunBase = Spawn(TurretGunBaseClass, Self,, Location, OriginalRotation);
      Attach(TurretGunBase);//attach to actor Component
      `log('Spawn Turret Gun');
   }

   if ( TurretBaseClass != None ){
      TurretBase = Spawn(TurretBaseClass, Self,, Location, OriginalRotation);
      Attach(TurretBase);//attach to actor Component
      `log('Spawn Turret Gun');
   }
   
   AwakeTurret();
}

/* awake sleeping AwakeTurret */
function AwakeTurret()
{
	TurretController = AITurretController(Controller);
}


simulated function Tick(float DeltaTime)
{
 local UTProjectile WeapPro;
          super.Tick(DeltaTime);
          rot.Yaw += 100;
          OriginalRotation = rot;
          TurretYaw = rot;
          TurretBase.Mesh.SetRotation(rot);
          TurretGunBase.Mesh.SetRotation(rot);

          counttime++;
          if(counttime > 30){
            WeapPro = Spawn(WeapProj, Self,, Location, OriginalRotation);
            WeapPro.init(Vector(TurretGunBase.Mesh.Rotation));
            //Vector(Rotation)


            counttime = 0;
          }

          //`log('tick');
          //TurretPitch.Pitch += 100;
          //SetRotation(TurretPitch);
}

defaultproperties
{
   //TurretController=class'AITurretController'
   TurretGunBaseClass=class'Turret_Gun'
   TurretBaseClass=class'Turret_Base'
   WeapProj=class'UTProj_LinkPlasma'

   Begin Object class=SkeletalMeshComponent Name=STurretMesh
         SkeletalMesh=SkeletalMesh'UTMTurret.TurretStand'
         PhysicsAsset=PhysicsAsset'UTMTurret.TurretStand_Physics'
         Translation=(X=0.0,Y=0.0,Z=-78.0)
   End Object
   Mesh=STurretMesh
   Components.Add(STurretMesh)

   //Begin Object Name=SVehicleMesh
         //floor or ceiling skeleton mesh
   //End Object
}