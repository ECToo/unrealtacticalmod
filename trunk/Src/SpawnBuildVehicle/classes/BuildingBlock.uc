Class BuildingBlock extends Actor
      placeable;

var localized string FriendlyName;
var localized string Description;

var StaticMeshComponent Mesh;
var int Health;
var int MaxHealth;
var int Armor;

struct CheckpointRecord
{
    var bool bCollideActors;
};

/** Base cylinder component for collision */
var() editconst const CylinderComponent	CylinderComponent;

simulated function bool StopsProjectile(Projectile P)
{
	return bBlockActors;
}

simulated event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	Super.TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);

	if (Role == ROLE_Authority)
	{
           `log('damage taken'@Damage);
           Health= Health-Damage;
           if (Health < 0){
              `log('Death');
              Destroy();
              Mesh.SetHidden(true);
           }
	}
}

defaultproperties
{
   Health=500
   MaxHealth=500

   Begin Object Class=CylinderComponent NAME=CollisionCylinder LegacyClassName=Trigger_TriggerCylinderComponent_Class
         CollideActors=true
         CollisionRadius=+0512.000000
         CollisionHeight=+00128.000000
   End Object
       CollisionComponent=CollisionCylinder
       CylinderComponent=CollisionCylinder
       Components.Add(CollisionCylinder)

   Begin Object Class=StaticMeshComponent Name=StaticMeshBuilding
         AlwaysLoadOnClient=true
         AlwaysLoadOnServer=true
	 bAcceptsLights=TRUE
	 bForceDirectLightMap=TRUE
	 bCastDynamicShadow=True
	 CollideActors=true
	 MaxDrawDistance=8000
	 bUseAsOccluder=TRUE
   End Object
   Mesh=StaticMeshBuilding
   Components.Add(StaticMeshBuilding)

   bCollideActors=true
   //bProjTarget=true
   bStatic=false
   bNoDelete=False
}