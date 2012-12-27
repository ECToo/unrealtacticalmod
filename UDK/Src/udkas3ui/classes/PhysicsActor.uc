/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 * 
 */

 class PhysicsActor extends GamePawn placeable;

//var	CylinderComponent		CylinderComponent;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
    SetPhysics(PHYS_RigidBody);
	//SetPhysics(PHYS_None);
}

simulated Event Tick(Float DT)
{
    local vector MyForce;

    super.Tick(DT);
	SetPhysics(PHYS_RigidBody);
    MyForce.X = 10.0;
    MyForce.Y = 0.0;
    MyForce.Z = 0.0;

    CollisionComponent.AddForce(MyForce);
}




//SetPhysics(PHYS_RigidBody);
defaultproperties
{
    bCollideActors=true;

    Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
        bEnabled = true
    End Object
    Components.Add(MyLightEnvironment)
	
	//Begin Object Class=CylinderComponent Name=CollisionCylinder
	Begin Object Name=CollisionCylinder
		CollisionRadius=+0034.000000
		CollisionHeight=+0078.000000
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=true
		CollideActors=true
	End Object
	//CollisionComponent=CollisionCylinder
	//CylinderComponent=CollisionCylinder
	//Components.Add(CollisionCylinder)
	/*
    Begin Object Class=StaticMeshComponent Name=MyMesh
        StaticMesh=StaticMesh'UN_SimpleMeshes.TexPropCube_Dup'
        Materials(0)=Material'EditorMaterials.WidgetMaterial_Y'
        LightEnvironment=MyLightEnvironment
        Scale3D=(X=0.5,Y=0.25,Z=0.125)
    End Object
	*/
	Begin Object Class=StaticMeshComponent Name=StaticMeshComponent0
		//StaticMesh=StaticMesh'BallPuzzlerGame.Actors.PlayerBall'
		StaticMesh=StaticMesh'UN_SimpleMeshes.TexPropCube_Dup'
		bNotifyRigidBodyCollision=false
		CastShadow=true
		BlockRigidBody=true
		bCastDynamicShadow=true
		HiddenGame=false
		LightEnvironment=MyLightEnvironment
	End Object
    Components.Add(StaticMeshComponent0)
	
    //CollisionComponent=MyMesh
    //Components.Add(MyMesh)
	
	
	Physics=PHYS_RigidBody
	bTickIsDisabled = true
}