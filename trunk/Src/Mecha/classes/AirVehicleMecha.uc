/**
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

class AirVehicleMecha extends UTAirVehicle
        placeable;

//var(Movement)   float   DuckForceMag;

var() RB_Handle BodyHandle;
var Color textcolor;
var() int count;
var() int maxcount;

/** When asleep, monitor distance below darkwalker to make sure it isn't in the air. */
var float LastSleepCheckDistance;

/** Disable aggressive sleeping behaviour. */
var bool bSkipAggresiveSleep;

//socket for attaching parts
var() protected const Name BodyAttachSocketName;

var()	vector	BaseBodyOffset;

var float HoverHeightBody;//deal with hovering

simulated function PostBeginPlay()
{
	//local vector X, Y, Z;

	Super.PostBeginPlay();
	//SetTimer(1.0, TRUE, 'SleepCheckGroundDistance');
}

simulated function Tick(float DeltaTime)
{
	super.Tick(DeltaTime);
        //`log('Movement' $ DuckForceMag);
}

simulated function DisplayHud(UTHud Hud, Canvas Canvas, vector2D HudPOS, optional int SeatIndex)
{

	super.DisplayHud(HUD, Canvas, HudPOS, SeatIndex);

	//Canvas.DrawColor = textcolor;
	Canvas.DrawColor = class'HUD'.default.GreenColor;
}

//walk up the mesh
simulated function SleepCheckGroundDistance()
{
	local vector HitLocation, HitNormal;
	local actor HitActor;
	local float SleepCheckDistance;

	bSkipAggresiveSleep = FALSE;

	if(!bDriving && !Mesh.RigidBodyIsAwake())
	{
		HitActor = Trace(HitLocation, HitNormal, Location - vect(0,0,1000), Location, TRUE);

		SleepCheckDistance = 1000;
		if(HitActor != None)
		{
			SleepCheckDistance = VSize(HitLocation - Location);
		}

		// If distance has changed, wake it
		if(Abs(SleepCheckDistance - LastSleepCheckDistance) > 10.0)
		{
			Mesh.WakeRigidBody();
			bSkipAggresiveSleep = TRUE;
			LastSleepCheckDistance = SleepCheckDistance;
			//`log('dis check');
		}
	}
}

exec function testkey()
{
   `log('testkey from vehicle');
}


//this deal with missile
exec function SecondFirePress()
{
   `log('SecondFirePress');
}
exec function SecondFireRelease()
{
   `log('SecondFireRelease');
}

//this deal with counter measure
exec function ThirdFirePress()
{
   `log('ThirdFirePress');
}
exec function ThirdFireRelease()
{
   `log('ThirdFireRelease');
}

exec function MidMousePress()
{
   `log('MidMousePress');
}

exec function MidMouseRelease()
{
   `log('MidMouseRelease');
}

exec function MidMouseScrollDown()
{
   `log('MidMouseScrollDown');
}

exec function MidMouseScrollUp()
{
   `log('MidMouseScrollUp');
}

exec function BoosterPress()
{
   `log('BossterPress');
}

exec function BoosterRelease()
{
   `log('BossterPress');
}

exec function JetPackPress()
{
   `log('JetPackPress');
}

exec function JetPackRelease()
{
   `log('JetPackRelease');
}

exec function CrouchPress()
{
   `log('JetPackPress');
}

exec function CrouchRelease()
{
   `log('JetPackRelease');
}

/*
Input.ini

Bindings=(Name="SpaceBar",Command="JetPackPress | OnRelease JetPackRelease")
Bindings=(Name="LeftShift",Command="BoosterPress | OnRelease BoosterRelease")
Bindings=(Name="MouseScrollUp",Command="MidMouseScrollUp")
Bindings=(Name="MouseScrollDown",Command="MidMouseScrollDown")
Bindings=(Name="Q",Command="SecondFirePress | OnRelease SecondFireRelease")
Bindings=(Name="R",Command="ThirdFirePress | OnRelease ThirdFireRelease")
Bindings=(Name="MiddleMouseButton",Command="MidMousePress | OnRelease MidMouseRelease")
//MiddleMouseButton
*/


simulated event Destroyed()
{
	super.Destroyed();
	ClearTimer('SleepCheckGroundDistance');
}

simulated event RigidBodyCollision( PrimitiveComponent HitComponent, PrimitiveComponent OtherComponent,
					const out CollisionImpactData RigidCollisionData, int ContactIndex )
{
	Super.RigidBodyCollision(HitComponent, OtherComponent, RigidCollisionData, ContactIndex);
	if(!IsTimerActive('ResetTurningSpeed'))
	{
		SetTimer(0.7f,false,'ResetTurningSpeed');
		MaxSpeed = default.MaxSpeed/2.0;
		MaxAngularVelocity = default.MaxAngularVelocity/4.0;
		if( UTVehicleSimChopper(SimObj) != none)
			UTVehicleSimChopper(SimObj).bRecentlyHit = true;
		//UTVehicleSimChopper(SimObj).TurnDamping = 0.8;
	}
}

simulated function ResetTurningSpeed()
{ // this is safe since this only gets called above after checking SimObj is a chopper.
	MaxSpeed = default.MaxSpeed;
	MaxAngularVelocity = default.MaxAngularVelocity;
	if( UTVehicleSimChopper(SimObj) != none)
		UTVehicleSimChopper(SimObj).bRecentlyHit = false;

	//UTVehicleSimChopper(SimObj).TurnDamping = UTVehicleSimChopper(default.SimObj).TurnDamping;
}

simulated function bool ShouldClamp()
{
	return false;
}

function bool RecommendLongRangedAttack()
{
	return true;
}

// AI hint
/*
function bool ImportantVehicle()
{
	return !bFreelanceStart;
}
*/

defaultproperties
{      
    HoverHeightBody=5000

         maxcount = 10000;
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

	Health=200
	MeleeRange=-100.0
	ExitRadius=160.0
	
		Seats(0)={( GunClass=class'MechaVehicleWeapon',
				GunSocket=(MainGun_Fire),
                                GunPivotPoints=(Body),
				TurretVarPrefix="",
				CameraTag=DriverViewSocket,
				CameraOffset=-280,
				CameraSafeOffset=(Z=200),
				DriverDamageMult=0.0,
				SeatIconPos=(X=0.46,Y=0.2),
				TurretControls=(MainRotateGun,MainPitchGun,),
				CameraBaseOffset=(X=40,Y=0,Z=0),
				//MuzzleFlashLightClass=class'UTDarkWalkerMuzzleFlashLight',
				MuzzleFlashLightClass=None,
				WeaponEffects=((SocketName=MainGun_00,Offset=(X=-35,Y=-3),Scale3D=(X=8.0,Y=10.0,Z=10.0)),(SocketName=MainGun_01,Offset=(X=-35,Y=-3),Scale3D=(X=8.0,Y=10.0,Z=10.0)))
				)}
}