/**
This will be base code for spawn for pawn and vehicles if enble.
*/
Class UTMBuildingNode_BaseSpawn extends UTMBuildingNode;

var bool bForSpawnPawn;
var bool bForMapTeleport;
var bool bForMap;
var bool bForSpawnVehicle;
//vehicle spawn and control
var class<UTMUsedTriggerScene> PawnUsed;
var UTMUsedTriggerScene PawnUsedActor;
var Vector buildcontroloffset;
var class<UTVehicle> UTMVehicle;
var Vector spawnoffset;

var array<PlayerStart> PlayerStarts;
var class<UTMTeamPlayerStart> PlayerStartClass;
var array<vector> spawnpoint;


//map control for spawn and teleport
var class<UTMUsedTriggerScene_MapSpawn> MapPanel;
var UTMUsedTriggerScene_MapSpawn MapPanelActor;
var Vector mapcontroloffset;

var UTM_UISceneBuildVehicle SceneBuildVehicle; //UI Scene

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	initspawnpawn();
	initspawnvehicle();
}

//setup control panel for map for pawn
function initspawnpawn()
{
        local int i;
        local UTMTeamPlayerStart UTMTeamActor;

	if(MapPanel != None)
	{
		MapPanelActor = Spawn(MapPanel,,, Location+mapcontroloffset);
		Attach(MapPanelActor);//attach to actor Component
	}
	
	 for(i = 0;i < spawnpoint.length;i++){
              `log('UTM SPAWNERS');
              UTMTeamActor = spawn(PlayerStartClass,,,Location + spawnpoint[i]);
              PlayerStarts.AddItem(UTMTeamActor);
        }
	

}

//setup vehicle
//setup control panel
function initspawnvehicle(){
	if(PawnUsed != None){
		//VehicleUseActor = Spawn(PawnUsed,self,, Location+spawnoffset);
		PawnUsedActor = Spawn(PawnUsed,,, Location+buildcontroloffset);
		PawnUsedActor.SetDisableUsed(true);
		PawnUsedActor.SetBuildingData(self);
		Attach(PawnUsedActor);//attach to actor Component
	}
}

function SetVehicleName(String vehiclename)
{
        super.SetVehicleName(vehiclename);
	if(vehiclename == "Scorpion")
	{
		UTMVehicle=class'UTVehicle_Scorpion_Content';
	}
	if(vehiclename == "Manta")
	{
	UTMVehicle=class'UTVehicle_Manta_Content';
	}
	if(vehiclename == "Cicada"){
		UTMVehicle=class'UTVehicle_Cicada_Content';
	}
	`log('Vehicle name ' @ vehiclename);
}

function spawnvehicle(){
         local UTVehicle TMPVehicle;
         super.spawnvehicle();
	//VehicleUseActor = Spawn(UTMVehicle, self,, Location);

	TMPVehicle = Spawn(UTMVehicle,,, Location+spawnoffset);
	TMPVehicle.Mesh.WakeRigidBody();
	`log('spawn vehicle' @ TMPVehicle.Name);
}

simulated function Destroyed(){
	super.Destroyed();
	PawnUsedActor.SetHidden(true);
	PawnUsedActor.bDisableUsed = false;
	
	MapPanelActor.SetHidden(true);
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
    mapcontroloffset=(x=480,y=-64,z=32)
    PlayerStartClass=class'UTMTeamPlayerStart'
    spawnpoint(0)=(x=-480,y=-64,z=64)
    spawnpoint(1)=(x=-480,y=64,z=64)

    Begin Object Name=StaticMeshBuilding
                StaticMesh=StaticMesh'UTMBuildingFactory.factoryvehicle_flat'
                bAcceptsLights=TRUE
                Translation=(X=0.0,Y=0.0,Z=-40.0)
    End Object
	
    MapPanel=class'UTMUsedTriggerScene_MapSpawn'
    PawnUsed=class'UTMUsedTriggerScene'
    UTMVehicle=class'UTVehicle_Scorpion_Content'
}