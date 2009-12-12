Class UTMBuildingBlock extends Actor
      placeable
      //native
      ;

var localized string FriendlyName;
var localized string Description;

var StaticMeshComponent Mesh;
var int Health;
var int MaxHealth;
var int Armor;

var bool BSpawnVehicle;//Check what ever if this has spawners
var bool BSpawnPawn;//Check what ever if this has spawners

var bool bCapture;//if this building can be capture
var bool bLocked;//this cant be capture sxample main base

struct CheckpointRecord
{
    var bool bCollideActors;
};

/** Base cylinder component for collision */
var() editconst const CylinderComponent	CylinderComponent;
/** for AI, true if we have been recently triggered (so AI doesn't try to trigger it again) */
var bool bRecentlyTriggered;
/** how long bRecentlyTriggered should stay set after each triggering */
var() float AITriggerDelay;

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
	if (FindEventsOfClass(class'SeqEvent_Touch'))
	{
		bRecentlyTriggered = true;
		SetTimer(AITriggerDelay, false, 'UnTrigger');
		`log('trigger');
	}
}

function UnTrigger()
{
	bRecentlyTriggered = false;
}

simulated function bool StopsProjectile(Projectile P)
{
	return bBlockActors;
}

function CreateCheckpointRecord(out CheckpointRecord Record)
{
    // actor collision is the primary method of toggling triggers apparentlyttttttttttttt
    Record.bCollideActors = bCollideActors;
    `log('trigger rec');
}

function ApplyCheckpointRecord(const out CheckpointRecord Record)
{
    SetCollision(Record.bCollideActors,bBlockActors,bIgnoreEncroachers);
    `log('trigger applay recx');
}

simulated event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	Super.TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);

	if (Role == ROLE_Authority)
	{
           `log('damage taken'@Damage);
           Health= Health-Damage;
           if (Health < 0){
              //`log('Death');
              Destroy();
              Mesh.SetHidden(true);
           }
	}
}

event Destroyed(){
      super.Destroyed();
      //`log('destory');

}

defaultproperties
{
   Health=500
   MaxHealth=500
   /*
   Begin Object Class=CylinderComponent NAME=CollisionCylinder LegacyClassName=Trigger_TriggerCylinderComponent_Class
         CollideActors=true
         CollisionRadius=+0512.000000
         CollisionHeight=+00128.000000
   End Object
       //CollisionComponent=CollisionCylinder
       CylinderComponent=CollisionCylinder
       Components.Add(CollisionCylinder)
   */
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
   //BlockRigidBody=true

   CollisionComponent=StaticMeshBuilding
   Mesh=StaticMeshBuilding
   Components.Add(StaticMeshBuilding)

   bBlockActors=True
   bCollideActors=true
   bStatic=false
   bNoDelete=False
   
   /*
   bStatic=False
   bAlwaysRelevant=True
   
   bNotBased=True
   bCollideActors=True
   bCollideWorld=True
   bIgnoreEncroachers=True
   bBlockActors=True
   bProjTarget=True
   bHidden=False
   */

}