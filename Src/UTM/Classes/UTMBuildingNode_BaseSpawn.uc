Class UTMBuildingNode_BaseSpawn extends UTMBuildingNode;

var class<UTMUsedTriggerScene> VehicleUse;
var UTMUsedTriggerScene VehicleUseActor;

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
	 //VehicleUseActor.SetBuildingData(self);
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

simulated function Destroyed(){
      super.Destroyed();
      VehicleUseActor.SetHidden(true);
      VehicleUseActor.bDisableUsed = false;
      `log('destory');
}

function bool UsedBy(Pawn P)
{
         super.UsedBy(P);
         `log('CLASS OBJECT USED');
	return false;
}

defaultproperties
{
    bMustTouchToReach=false
    bMustBeReachable=false
    //bFirstObjective=false
    bStatic=false
    //Components.remove(PathRenderer)

    //x= -(back surface)/+(front surface)
    //y= -(left side surface)/+(right side surface)
    //z= -(down to the ground)/+(up world sky)
    spawnoffset=(x=23,y=64,z=128)
    //buildcontroloffset=(x=480,y=64,z=0)
    buildcontroloffset=(x=480,y=64,z=32)

    Begin Object Name=StaticMeshBuilding
                StaticMesh=StaticMesh'UTMBuildingFactory.factoryvehicle_flat'
                bAcceptsLights=TRUE
                Translation=(X=0.0,Y=0.0,Z=-40.0)
    End Object

    //VehicleUse=class'UTMUsedTriggerScene_BuildVehicle'
    VehicleUse=class'UTMUsedTriggerScene'
    UTMVehicle=class'UTVehicle_Scorpion_Content'
}