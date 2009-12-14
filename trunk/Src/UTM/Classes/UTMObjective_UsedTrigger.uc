class UTMObjective_UsedTrigger extends UTMObjectiveAssault;

var class<UTMTriggerUsedObjective> TriggerObject;
var UTMTriggerUsedObjective TriggerObjectActor;

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
        ObjectiveNameIn="Use Objective"
        HUDOffsetHeight=64
        TriggerObject=class'UTMTriggerUsedObjective'
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