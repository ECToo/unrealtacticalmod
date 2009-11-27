/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */
 
 /*
  *
  */

class UTMVehicle_MechWalker extends UTVehicle
      abstract;

var() RB_Handle BodyHandle;

//socket for attaching parts
var() protected const Name BodyAttachSocketName;


var()	vector	BaseBodyOffset;


simulated function PostBeginPlay()
{
	//local vector X, Y, Z;

	Super.PostBeginPlay();

	// no spider body on server
	if ( WorldInfo.NetMode != NM_DedicatedServer )
	{
		//GetAxes(Rotation, X,Y,Z);
		//`log('            x'@ X);
		//BodyActor = Spawn(BodyType, self,, Location+BaseBodyOffset.X*X+BaseBodyOffset.Y*Y+BaseBodyOffset.Z*Z);
		//BodyActor.SetWalkerVehicle(self);

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