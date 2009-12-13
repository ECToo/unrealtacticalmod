Class BaseSpawnVehicle extends NavigationPoint
      placeable;

var class<UsedTriggerBuildVehicle> VehicleUse;
var UsedTriggerBuildVehicle VehicleUseActor;

var class<UTVehicle> Vehicle;
var UTVehicle VehicleActor;

var Vector spawnoffset;
var Vector buildcontroloffset;

var StaticMeshComponent Mesh;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	if(VehicleUse != None){
	VehicleUseActor = Spawn(VehicleUse,,, Location+buildcontroloffset);
	 Attach(VehicleUseActor);
	 VehicleUseActor.SetBuildingData(self);
	 `log('spawn');
	}
	//spawnvehicle();
}

simulated event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	Super.TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);

	if (Role == ROLE_Authority)
	{

	}
}

function spawnvehicle(){
         local UTVehicle TMPVehicleActor;
         TMPVehicleActor = Spawn(Vehicle,,, Location+spawnoffset);
         TMPVehicleActor.mesh.WakeRigidBody(); //this deal with physic to be turn on else it will float in the air
}

function SetVehicleName(String vehiclename){
         if(vehiclename == "Scorpion"){
            Vehicle=class'UTVehicle_Scorpion_Content';
         }
         if(vehiclename == "Manta"){
            Vehicle=class'UTVehicle_Manta_Content';
         }
         if(vehiclename == "Cicada"){
            Vehicle=class'UTVehicle_Cicada_Content';
         }
         `log('Set Vehicle ' @ vehiclename);
}

defaultproperties
{
    bBlockActors=True
    bCollideActors=true
    bStatic=false
    bNoDelete=False

    //x= -(back surface)/+(front surface)
    //y= -(left side surface)/+(right side surface)
    //z= -(down to the ground)/+(up world sky)
    spawnoffset=(x=0,y=0,z=128)
    buildcontroloffset=(x=-512,y=0,z=64)
    Begin Object Class=StaticMeshComponent Name=StaticMeshBuilding
                StaticMesh=StaticMesh'BuildingSpawnVehicle.factoryvehicle_flat'
                AlwaysLoadOnClient=true

                CastShadow=FALSE
		bCastDynamicShadow=TRUE
		bAcceptsLights=TRUE
		bForceDirectLightMap=TRUE
		LightingChannels=(BSP=TRUE,Dynamic=TRUE,Static=TRUE,CompositeDynamic=TRUE)
                Translation=(X=0.0,Y=0.0,Z=-64.0)
	 MaxDrawDistance=8000
	 bUseAsOccluder=TRUE
    End Object
    Mesh=StaticMeshBuilding
    Components.Add(StaticMeshBuilding)
    VehicleUse=class'UsedTriggerBuildVehicle'
    Vehicle=class'UTVehicle_Scorpion_Content'

}