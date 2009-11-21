class UTMMechPart extends Actor
      placeable
      ;
      
var SkeletalMeshComponent Mesh;


defaultproperties
{
      Begin Object Class=SkeletalMeshComponent Name=MeshFrame
		//SkeletalMesh=SkeletalMesh'VHUTM_MechProtypeWalker.mechprotype_leg'
		//AnimTreeTemplate=AnimTree'VH_Goliath.Anims.AT_VH_Goliath_Antenna'
		//ShadowParent = SVehicleMesh
		//BlockRigidBody=false
		//LightEnvironment=MyLightEnvironment
		//PhysicsWeight=0.0
		//TickGroup=TG_PostASyncWork
		//bUseAsOccluder=FALSE
		//CullDistance=1300.0
		//CollideActors=false
		//bUpdateSkelWhenNotRendered=false
		//bIgnoreControllersWhenNotRendered=true
		//bAcceptsDecals=false
	End Object
	
	CollisionComponent=MeshFrame
	Mesh=MeshFrame
	Components.Add(MeshFrame)
}