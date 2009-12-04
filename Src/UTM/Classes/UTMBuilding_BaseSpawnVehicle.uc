Class UTMBuilding_BaseSpawnVehicle extends UTMBuilding;

var class<UTMTriggerBuildVehicle> VehicleUse;
var UTMTriggerBuildVehicle VehicleUseActor;

var class<UTVehicle> UTMVehicle;
var UTVehicle UTMVehicleActor;
var Vector spawnoffset;
var Vector buildcontroloffset;


simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	if(VehicleUse != None){
	//VehicleUseActor = Spawn(VehicleUse,self,, Location+spawnoffset);
	VehicleUseActor = Spawn(VehicleUse,,, Location+buildcontroloffset);
	 Attach(VehicleUseActor);
	 VehicleUseActor.SetBuildingData(self);
	 `log('spawn');
	}

	//spawnvehicle();
}


function spawnvehicle(){
         //VehicleUseActor = Spawn(UTMVehicle, self,, Location);
         Spawn(UTMVehicle,,, Location+spawnoffset);
}

defaultproperties
{
    //x= -(back surface)/+(front surface)
    //y= -(left side surface)/+(right side surface)
    //z= -(down to the ground)/+(up world sky)
    spawnoffset=(x=0,y=0,z=128)
    buildcontroloffset=(x=-512,y=0,z=64)
    Begin Object Name=StaticMeshBuilding
                StaticMesh=StaticMesh'UTMBuildingFactory.factoryvehicle_flat'
                bAcceptsLights=TRUE
    End Object
    VehicleUse=class'UTMTriggerBuildVehicle'
    UTMVehicle=class'UTVehicle_Scorpion_Content'

}