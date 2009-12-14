class UTMObjective_Trigger extends UTMObjectiveAssault;

var class<UTMTriggerObjective> TriggerObject;
var UTMTriggerObjective TriggerObjectActor;

var StaticMeshComponent Mesh;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	TriggerObjectActor = spawn(TriggerObject,,,Location);
	TriggerObjectActor.setobjecttag(self);
}

function finishobjecttive(){
         `log('UTMObjective_Trigger Finish');
}

defaultproperties
{
        ObjectiveNameIn="Trigger This Area"
        HUDOffsetHeight=64
        TriggerObject=class'UTMTriggerObjective'

       Begin Object class=StaticMeshComponent Name=StaticMeshBuilding
                StaticMesh=StaticMesh'UTMEditor.Cube'
                bAcceptsLights=TRUE
       End Object
       CollisionComponent=StaticMeshBuilding
       Mesh=StaticMeshBuilding
       Components.Add(StaticMeshBuilding)
}