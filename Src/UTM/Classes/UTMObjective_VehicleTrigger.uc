class UTMObjective_VehicleTrigger extends UTMObjectiveAssault;

var class<UTMTriggerVehicleObjective> TriggerObject;
var UTMTriggerVehicleObjective TriggerObjectActor;
var() UTVehicle VehicleID;

var StaticMeshComponent Mesh;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	TriggerObjectActor = spawn(TriggerObject,,,Location);
	TriggerObjectActor.setobjecttag(self);
}

function finishobjecttive(){
         `log('UTMObjective_UsedTrigger Finish');
}


defaultproperties
{
        ObjectiveNameIn="Trigger Vehicle Objective"
        HUDOffsetHeight=64
        TriggerObject=class'UTMTriggerVehicleObjective'
        //VehicleID='UTVehicle_Scorpion_Content'
        CylinderComponent=CollisionCylinder
        Components.Add(CollisionCylinder)
       
        Begin Object class=StaticMeshComponent Name=StaticMeshBuilding
                StaticMesh=StaticMesh'UTMEditor.Cube'
                bAcceptsLights=TRUE
    End Object
    CollisionComponent=StaticMeshBuilding
    Mesh=StaticMeshBuilding
    Components.Add(StaticMeshBuilding)
}