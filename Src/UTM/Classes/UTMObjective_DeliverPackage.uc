class UTMObjective_DeliverPackage extends UTMObjectiveAssault;

var StaticMeshComponent Mesh;
var() int PackageID;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
}

defaultproperties
{
    ObjectiveNameIn="Deliver Object"
    HUDOffsetHeight=128

    Begin Object class=StaticMeshComponent Name=StaticMeshBuilding
                StaticMesh=StaticMesh'UTMEditor.Cube'
                bAcceptsLights=TRUE
    End Object
    CollisionComponent=StaticMeshBuilding
    Mesh=StaticMeshBuilding
    Components.Add(StaticMeshBuilding)
}