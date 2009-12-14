Class UTM_IconHUD extends Actor
      placeable;

var String ObjectiveNameIn;

var StaticMeshComponent Mesh;

state NormalTickProcess
{
  simulated event Tick( float DeltaTime )
  {
      `log('test');
  }
}

simulated event PostRenderFor(PlayerController PC, Canvas Canvas, vector CameraPosition, vector CameraDir)
{
  //bPRF = True;
  Canvas.SetDrawColor(255,0,0);
  Canvas.SetPos(20,20);
  Canvas.DrawText("Hello", FALSE);
  `log('render test');
}



defaultproperties
{
    bPostRenderIfNotVisible=True

    ObjectiveNameIn="TEST BASE"
    Begin Object class=StaticMeshComponent Name=StaticMeshBuilding
                StaticMesh=StaticMesh'UTMEditor.boxstation'
                bAcceptsLights=TRUE
    End Object
    CollisionComponent=StaticMeshBuilding
    Mesh=StaticMeshBuilding
    Components.Add(StaticMeshBuilding)
}