class UTMVehicle_MechWalker extends UTVehicle
      abstract;


var() RB_Handle BodyHandle;

//var UTMMechWalkerBody BodyActor;
//var class<UTMMechWalkerBody> BodyType;

var UTMechWalkerBody BodyActor;
var class<UTMechWalkerBody> BodyType;

//socket for attaching parts
var() protected const Name BodyAttachSocketName;

//skeleton mesh
//var SkeletalMeshComponent MeshMechHead;
//var SkeletalMeshComponent MeshMechBody;
//var SkeletalMeshComponent MeshMechLeg;
//var SkeletalMeshComponent MeshMechBack; //jet pack or flying or heavy weapon

//var SkeletalMeshComponent MeshMechRightArm;
//var SkeletalMeshComponent MeshMechRightWeapon;
//var SkeletalMeshComponent MeshMechLeftArm;
//var SkeletalMeshComponent MeshMechLeftWeapon;

var()	vector	BaseBodyOffset;


simulated function PostBeginPlay()
{
	local vector X, Y, Z;

	Super.PostBeginPlay();

	// no spider body on server
	if ( WorldInfo.NetMode != NM_DedicatedServer )
	{
		//GetAxes(Rotation, X,Y,Z);
		//`log('            x'@ X);
		BodyActor = Spawn(BodyType, self,, Location+BaseBodyOffset.X*X+BaseBodyOffset.Y*Y+BaseBodyOffset.Z*Z);
		BodyActor.SetWalkerVehicle(self);

	}
}


defaultproperties
{
	bCanBeBaseForPawns=false
	CollisionDamageMult=0.0

	Begin Object Class=RB_Handle Name=RB_BodyHandle
		LinearDamping=100.0
		LinearStiffness=4000.0
		AngularDamping=200.0
		AngularStiffness=4000.0
	End Object
	//BodyHandle=RB_BodyHandle
	//Components.Add(RB_BodyHandle)

	BaseEyeheight=300
	Eyeheight=300

	//BodyHandleOrientInterpSpeed=5.f
}