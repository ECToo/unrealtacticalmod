/**
 *  Created by: Darknet
 *  svn:https://unrealtacticalmod.googlecode.com/svn/trunk/Src/DeployTurret
 */

class TurretBase_Floor extends Turret;



defaultproperties
{
   Begin Object Name=MeshPart
         SkeletalMesh=SkeletalMesh'UTMTurret.TurretBase'
         PhysicsAsset=PhysicsAsset'UTMTurret.TurretBase_Physics'
         Translation=(X=0.0,Y=0.0,Z=-28.0)
   End Object

   /*
    Begin Object Name=PartGun
         SkeletalMesh=SkeletalMesh'UTMTurret.TurretGun'
         Translation=(X=0.0,Y=0.0,Z=0.0)
   End Object


   Begin Object Name=PartBase
         SkeletalMesh=SkeletalMesh'UTMTurret.TurretBase'
         Translation=(X=0.0,Y=0.0,Z=-28.0)
   End Object

   Begin Object Name=MeshMain
         SkeletalMesh=SkeletalMesh'UTMTurret.TurretStand'
         Translation=(X=0.0,Y=0.0,Z=-78.0)
   End Object
   */
}