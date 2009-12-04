Class BaseSpawnVehicle extends BuildingBlock;

var class<UsedTriggerBuildVehicle> VehicleUse;
var UsedTriggerBuildVehicle VehicleUseActor;

var class<UTVehicle> Vehicle;
var UTVehicle VehicleActor;
var Vector spawnoffset;
var Vector buildcontroloffset;

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

function spawnvehicle(){
         local UTVehicle TMPVehicleActor;
         TMPVehicleActor = Spawn(Vehicle,,, Location+spawnoffset);
         TMPVehicleActor.mesh.WakeRigidBody(); //this deal with physic to be turn on else it will float in the air
}

defaultproperties
{
    //x= -(back surface)/+(front surface)
    //y= -(left side surface)/+(right side surface)
    //z= -(down to the ground)/+(up world sky)
    spawnoffset=(x=0,y=0,z=128)
    buildcontroloffset=(x=-512,y=0,z=64)
    Begin Object Name=StaticMeshBuilding
                StaticMesh=StaticMesh'BuildingSpawnVehicle.factoryvehicle_flat'
                AlwaysLoadOnClient=true

                CastShadow=FALSE
		bCastDynamicShadow=TRUE
		bAcceptsLights=TRUE
		bForceDirectLightMap=TRUE
		LightingChannels=(BSP=TRUE,Dynamic=TRUE,Static=TRUE,CompositeDynamic=TRUE)

	 MaxDrawDistance=8000
	 bUseAsOccluder=TRUE
    End Object
    VehicleUse=class'UsedTriggerBuildVehicle'
    Vehicle=class'UTVehicle_Scorpion_Content'

}