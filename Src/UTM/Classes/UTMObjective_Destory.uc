class UTMObjective_Destory extends UTMObjectiveAssault;

var() StaticMeshComponent Mesh;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	DamageCapacity = Health;//set max health

}

simulated event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	Super.TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);

	if (Role == ROLE_Authority)
	{
	   if (OffenceTeamIndex == EventInstigator.GetTeamNum()){
              `log('damage taken'@Damage);
              Health -= Damage;
              `log('Health' @ Health $ ' DamageCapacity ' @ DamageCapacity);
              `log('TEAM INDEX ' @ EventInstigator.GetTeamNum());
              if (Health < 0){
                 //do something
              }
           }else{
            worldinfo.game.broadcast (self,"You Are Protecting This Object!");
           }
	}
}

defaultproperties
{
    ObjectiveNameIn="Destory Object"
    HUDOffsetHeight=128
    Health=500
    bHealthBar=true

    bBlockActors=True
    bCollideActors=true
    Begin Object class=StaticMeshComponent Name=StaticMeshBuilding
                StaticMesh=StaticMesh'UTMEditor.Cube'
                bAcceptsLights=TRUE
    End Object
    CollisionComponent=StaticMeshBuilding
    Mesh=StaticMeshBuilding
    Components.Add(StaticMeshBuilding)
}