//class UTMObjectiveBuilding extends UTMObjective;
class UTMBuilding extends NavigationPoint
      placeable;

var localized string FriendlyName;
var localized string Description;

var StaticMeshComponent Mesh;
var int Health;
var int MaxHealth;
var int Armor;

//var float Cost;
var float BuildTime;

var int TeamIndex;

var bool BSpawnVehicle;//Check what ever if this has spawners
var bool BSpawnPawn;//Check what ever if this has spawners

var bool bCapture;//if this building can be capture
var bool bLocked;//this cant be capture sxample main base

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

simulated function Destroyed(){
      super.Destroyed();
      //`log('destory');

}

defaultproperties
{
    TeamIndex=0

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