/*
 * Created By: Lightnet
 *
 * Links:https://bitbucket.org/Lightnet/udkas3ui
 * 
 */


//class PhysicsFalling extends GamePawn placeable;
class PhysicsFalling extends Actor placeable;

simulated event PostBeginPlay()
{

	super.PostBeginPlay();
	//SetMovementPhysics();
	//SetPhysics(PHYS_Falling);
	SetPhysics(PHYS_Flying);
}
/*
Simulated Event Tick(Float DT)
{
    local float BodyMass;
    local vector MyForce;

    super.Tick(DT);
	
    BodyMass = CollisionComponent.BodyInstance.GetBodyMass();
    MyForce.X = 0.0;
    MyForce.Y = 0.0;
    MyForce.Z = 20.8 * BodyMass;

    `log(Velocity.Z);

    CollisionComponent.AddForce(MyForce);
	
	
}
*/
defaultproperties
{
    bCollideActors=true;

    Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
        bEnabled = true
    End Object
    Components.Add(MyLightEnvironment)

    Begin Object Class=StaticMeshComponent Name=MyMesh
        StaticMesh=StaticMesh'UN_SimpleMeshes.TexPropCube_Dup'
        Materials(0)=Material'EditorMaterials.WidgetMaterial_Y'
        LightEnvironment=MyLightEnvironment
        Scale3D=(X=0.5,Y=0.25,Z=0.125)
    End Object
    CollisionComponent=MyMesh
    Components.Add(MyMesh)

    Physics=PHYS_RigidBody
}