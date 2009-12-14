class UTMObjective_ReceivePackage extends UTMObjectiveAssault;

var StaticMeshComponent Mesh;
var() int PackageID;
var vector RestPosition; //reset object if the world is out of bounds
var class<UTMTriggerReceivePackageObjective> ObjTrigger;
var UTMTriggerReceivePackageObjective ObjTriggerActor;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	RestPosition = Location;
	ObjTriggerActor = spawn(ObjTrigger,,,Location);
	ObjTriggerActor.setobjecttag(self);
	Attach(ObjTriggerActor);
}



defaultproperties
{
    ObjectiveNameIn="Get Object"

    HUDOffsetHeight=128
    ObjTrigger=class'UTMTriggerReceivePackageObjective'
    Begin Object class=StaticMeshComponent Name=StaticMeshBuilding
                StaticMesh=StaticMesh'UTMEditor.Cube'
                bAcceptsLights=TRUE
    End Object
    CollisionComponent=StaticMeshBuilding
    Mesh=StaticMeshBuilding
    Components.Add(StaticMeshBuilding)
}