class MyActor extends Actor;

// Expose to Unrealscript and Unreal Editor
var() StaticMeshComponent StaticMesh;

defaultproperties
{
  // Declare sub object
  Begin Object Class=StaticMeshComponent Name=MyStaticMeshComponent
    StaticMesh=StaticMesh'EditorMeshes.TexPropPlane'
  End Object
  StaticMesh=MyStaticMeshComponent
  Components.Add(MyStaticMeshComponent)
}