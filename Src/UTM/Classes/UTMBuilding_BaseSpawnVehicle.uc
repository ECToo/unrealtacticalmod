Class UTMBuilding_BaseSpawnVehicle extends UTMBuilding;

var class<UTMTriggerBuildVehicle> VehicleUse;
var UTMTriggerBuildVehicle VehicleUseActor;

var class<UTVehicle> UTMVehicle;
var UTVehicle UTMVehicleActor;
var Vector spawnoffset;
var Vector buildcontroloffset;

var UTM_UISceneBuildVehicle SceneBuildVehicle; //UI Scene

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	if(VehicleUse != None){
	//VehicleUseActor = Spawn(VehicleUse,self,, Location+spawnoffset);
	VehicleUseActor = Spawn(VehicleUse,,, Location+buildcontroloffset);
	VehicleUseActor.bDisableUsed = true;
	 Attach(VehicleUseActor);
	 VehicleUseActor.SetBuildingData(self);
	 //`log('spawn');
	}
}

function SetVehicleName(String vehiclename){
         if(vehiclename == "Scorpion"){
            UTMVehicle=class'UTVehicle_Scorpion_Content';
         }
         if(vehiclename == "Manta"){
            UTMVehicle=class'UTVehicle_Manta_Content';
         }
         if(vehiclename == "Cicada"){
            UTMVehicle=class'UTVehicle_Cicada_Content';
         }
         `log('Vehicle name ' @ vehiclename);
}

function spawnvehicle(){
         //VehicleUseActor = Spawn(UTMVehicle, self,, Location);
         local UTVehicle TMPVehicle;
         TMPVehicle = Spawn(UTMVehicle,,, Location+spawnoffset);
         TMPVehicle.Mesh.WakeRigidBody();
         `log('spawn vehicle');
}

event Destroyed(){
      super.Destroyed();
      VehicleUseActor.SetHidden(true);
      VehicleUseActor.bDisableUsed = false;
      `log('destory');

}

defaultproperties
{
    //x= -(back surface)/+(front surface)
    //y= -(left side surface)/+(right side surface)
    //z= -(down to the ground)/+(up world sky)
    spawnoffset=(x=23,y=64,z=128)
    buildcontroloffset=(x=480,y=64,z=64)
    Begin Object Name=StaticMeshBuilding
                StaticMesh=StaticMesh'UTMBuildingFactory.factoryvehicle_flat'
                bAcceptsLights=TRUE
    End Object
    VehicleUse=class'UTMTriggerBuildVehicle'
    UTMVehicle=class'UTVehicle_Scorpion_Content'

}