/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */
 
 /*
  *
  */

class UTMVMech_Walker extends UTVehicle
      //abstract
      ;

var() RB_Handle BodyHandle;
var Color textcolor;
var() int count;
var() int maxcount;


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

simulated function DisplayHud(UTHud Hud, Canvas Canvas, vector2D HudPOS, optional int SeatIndex)
{
	//local PlayerController PC;
	//local UTVWeap_SPMACannon Gun;

	super.DisplayHud(HUD, Canvas, HudPOS, SeatIndex);

	//PC = PlayerController(Seats[0].SeatPawn.Controller);
	//Gun = UTVWeap_SPMACannon(Seats[0].Gun);
	//if ( PC != none && Gun != None )
	//{
		//if ( Gun.RemoteCamera == None )
		//{
			//Hud.DrawToolTip(Canvas, PC, "GBA_Fire", Canvas.ClipX * 0.5, Canvas.ClipY * 0.92, CameraFireToolTipIconCoords.U, CameraFireToolTipIconCoords.V, CameraFireToolTipIconCoords.UL, CameraFireToolTipIconCoords.VL, Canvas.ClipY / 768);
		//}
	//}
	Canvas.DrawColor = textcolor;

	count = count + 1;
	if(count > maxcount){
	count = 0;
	}
	Canvas.SetPos(20,128);
	Canvas.DrawText("No. Weapon: " @ count);
	`log('HUD' @ count); //render loop
}



defaultproperties
{       maxcount = 10000;
	bCanBeBaseForPawns=false
	CollisionDamageMult=0.0
        textcolor=(R=0,G=0,B=0,A=1)
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