/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */
 
 /*
 *
 * Build Type: Two leg
 */

class UTMVMech_ProtypeWalker extends UTMVMech_Walker;

/** radius to allow players under this darkwalker to gain entry */
var float CustomEntryRadius;

/** When asleep, monitor distance below darkwalker to make sure it isn't in the air. */
var float LastSleepCheckDistance;

/** Disable aggressive sleeping behaviour. */
var bool bSkipAggresiveSleep;

var float CustomGravityScaling;

/** @hack: replicated copy of bHoldingDuck for clients */
var bool bIsDucking;

var SkeletalMeshComponent AntennaMesh;
var SkeletalMeshComponent AntennaMesh2;

//var UTMMechWalkerBody_MechProtypeLeg Mesh2;

var class <UTMMechPart> MechPart;
var UTMMechPart MechPartActor;
//Head
var() protected const Name BodyAttachHeadSocketName;
var class <UTMMechPart> MechPart_Head;
var UTMMechPart MechPartActor_Head;
//Back
var() protected const Name BodyAttachBackSocketName;
var class <UTMMechPart> MechPart_Back;
var UTMMechPart MechPartActor_Back;
//Leg
var() protected const Name BodyAttachLegSocketName;
var class <UTMMechPart> MechPart_Leg;
var UTMMechPart MechPartActor_Leg;
//Right Arm
var() protected const Name BodyAttachRightArmSocketName;
var class <UTMMechPart> MechPart_RightArm;
var UTMMechPart MechPartActor_RightArm;
//right weapon
var() protected const Name BodyAttachRightHandSocketName;
var class <UTMMechPart> MechPart_RightHand;
var UTMMechPart MechPartActor_RightHand;
//Left Arm
var() protected const Name BodyAttachLeftArmSocketName;
var class <UTMMechPart> MechPart_LeftArm;
var UTMMechPart MechPartActor_LeftArm;
//left weapon
var() protected const Name BodyAttachLeftHandSocketName;
var class <UTMMechPart> MechPart_LeftHand;
var UTMMechPart MechPartActor_LeftHand;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	SetTimer(1.0, TRUE, 'SleepCheckGroundDistance');
	// no spider body on server
	if ( WorldInfo.NetMode != NM_DedicatedServer )
	{
		//GetAxes(Rotation, X,Y,Z);
		//`log('            x'@ X);


		//MechPartActor = Spawn(class'MechProtypeWalker.UTMMechPart_Leg', self,, Location);

		//MechPartActor = Spawn(MechPart, self,, Location);
		//Mesh.AttachComponentToSocket(MechPartActor.Mesh,'LeftHandSocket');
		//Mesh.AttachComponentToSocket(MechPartActor.Mesh,'RightHandSocket');
		
                //head
                if(MechPart_Head != None){
                      MechPartActor_Head = Spawn(MechPart_Head, self,, Location);
                      Mesh.AttachComponentToSocket(MechPartActor_Head.Mesh,BodyAttachHeadSocketName);//'MechHeadSocket'
                      MechPartActor_Head.SetMechVehicle(self);
                }

                //leg
                if(MechPart_Leg != None){
                   MechPartActor_Leg = Spawn(MechPart_Leg, self,, Location);
                   Mesh.AttachComponentToSocket(MechPartActor_Leg.Mesh,BodyAttachLegSocketName);//'MechLegSocket'
                   MechPartActor_Leg.SetMechVehicle(self);
                }
                //right arm
                if(MechPart_RightArm != None){
                MechPartActor_RightArm = Spawn(MechPart_RightArm, self,, Location);
                Mesh.AttachComponentToSocket(MechPartActor_RightArm.Mesh,BodyAttachRightHandSocketName);//'RightHandSocket'
                MechPartActor_RightArm.SetMechVehicle(self);
                   //right hand weapon
                   if(MechPart_RightHand != None){
                      MechPartActor_RightHand = Spawn(MechPart_RightHand, self,, Location);
                      Mesh.AttachComponentToSocket(MechPartActor_RightHand.Mesh,BodyAttachRightHandSocketName);//'RightHandSocket'
                      MechPartActor_RightHand.SetMechVehicle(self);
                   }
                }

                //left arm
                if(MechPart_LeftArm != None){
                MechPartActor_LeftArm = Spawn(MechPart_LeftArm, self,, Location);
                Mesh.AttachComponentToSocket(MechPartActor_LeftArm.Mesh,BodyAttachLeftHandSocketName);//'RightHandSocket'
                MechPartActor_LeftArm.SetMechVehicle(self);
                   //left hand weapon
                   if(MechPart_LeftHand != None){
                      MechPartActor_LeftHand = Spawn(MechPart_LeftHand, self,, Location);
                      MechPartActor_LeftArm.Mesh.AttachComponentToSocket(MechPartActor_LeftHand.Mesh,BodyAttachLeftHandSocketName);//'LeftHandSocket'
                      MechPartActor_LeftHand.SetMechVehicle(self);
                   }
                }

	}
}
/*
simulated function int PartialTurn(int original, int desired, float PctTurn)
{
	local float result;
        super.PartialTurn(original,desired,PctTurn);
	original = original & 65535;
	desired = desired & 65535;

	if ( abs(original - desired) > 32768 )
	{
		if ( desired > original )
		{
			original += 65536;
			MechPartActor_Leg.playanimationtest();
			`log('TURN DIR MODE');
		}
		else
		{
			desired += 65536;
			MechPartActor_Leg.playanimationtest();
			`log('TURN DIR MODE');
		}
	}
	result = original*(1-PctTurn) + desired*PctTurn;
	return (int(result) & 65535);
}
*/

simulated function bool OverrideBeginFire(byte FireModeNum)
{
        //super.OverrideBeginFire(FireModeNum);
	if (FireModeNum == 1)
	{
	`log('ALT FIRE MODE');

		//bPressingAltFire = true;
		//Rise=1.0f;
		//return true;
		//MechPartActor_LeftHand.weaponfire();
		MechPartActor_LeftHand.BeginFire();
	}

	if (FireModeNum == 0)
	{
	`log('FIRE MODE');
		//bPressingAltFire = true;
		//Rise=1.0f;
		//return true;
		//////////////////////////////MechPartActor_Leg.playanimationtest();

		//MechPartActor_RightHand.weaponfire();
		MechPartActor_RightHand.BeginFire();
	}
	return false;
}

simulated function bool OverrideEndFire(byte FireModeNum){
        //super.OverrideEndFire(FireModeNum);
	if (FireModeNum == 1)
	{
	`log('ALT FIRE MODE');

		//bPressingAltFire = true;
		//Rise=1.0f;
		//return true;
		MechPartActor_LeftHand.EndFire();
	}

	if (FireModeNum == 0)
	{
	`log('FIRE MODE');
		//bPressingAltFire = true;
		//Rise=1.0f;
		//return true;
		//////////////////////////////MechPartActor_Leg.playanimationtest();

		MechPartActor_RightHand.EndFire();
	}
	return false;
}


simulated function SwitchWeapon(byte NewGroup)
{
      //super.SwitchWeapon(NewGroup);
     `log('Swtich Weapon MODE'); //when press on the number key from 0-9 not the num lock keys
        /*
	if ( (DeployedState == EDS_Deployed) || (DeployedState == EDS_Deploying) )
	{
		ServerChangeSeat(NewGroup-1);
	}
	*/
}

//need to fixed looping since this has tick or loop
simulated function SetInputs(float InForward, float InStrafe, float InUp)
{
      super.SetInputs(InForward,InStrafe,InUp);
      ///`log('Forward'@InForward);

      if(InForward > 0){
          MechPartActor_Leg.playanimationtest(); //play animation walk front
      }else if(InForward < 0){
          MechPartActor_Leg.playanimationtest();//play animation walk backward
      }else{

      }
}

/*
 // Console specific input modification

simulated function SetInputs(float InForward, float InStrafe, float InUp)
{
	local bool bReverseThrottle;
	local UTConsolePlayerController ConsolePC;
	local rotator SteerRot, VehicleRot;
	local vector SteerDir, VehicleDir, AngVel;
	local float VehicleHeading, SteerHeading, DeltaTargetHeading, Deflection;

	Throttle = InForward;
	Steering = InStrafe;
	Rise = InUp;

	ConsolePC = UTConsolePlayerController(Controller);
	if (ConsolePC != None)
	{
		Steering = FClamp(Steering * ConsoleSteerScale, -1.0, 1.0);

		UpdateLookSteerStatus();

		// tank, wheeled / heavy vehicles will use this

		// If we desire 'look steering' on this vehicle, do it here.
		if (bUsingLookSteer && IsHumanControlled())
		{
			// If there is a deflection, look at the angle that its point in.
			Deflection = Sqrt(Throttle*Throttle + Steering*Steering);

			if(bStickDeflectionThrottle)
			{
				// The region we consider 'reverse' is anything below DeflectionReverseThresh, or anything withing the triangle below the center position.
				bReverseThrottle = ((Throttle < DeflectionReverseThresh) || (Throttle < 0.0 && Abs(Steering) < -Throttle));
				Throttle = Deflection;

				if (bReverseThrottle)
				{
					Throttle *= -1;
				}
			}

			VehicleRot.Yaw = Rotation.Yaw;
			VehicleDir = vector(VehicleRot);

			SteerRot.Yaw = DriverViewYaw;
			SteerDir = vector(SteerRot);

			VehicleHeading = GetHeadingAngle(VehicleDir);
			SteerHeading = GetHeadingAngle(SteerDir);
			DeltaTargetHeading = FindDeltaAngle(SteerHeading, VehicleHeading);

			if (DeltaTargetHeading > LookSteerDeadZone)
			{
				Steering = FMin((DeltaTargetHeading - LookSteerDeadZone) * LookSteerSensitivity, 1.0);
			}
			else if (DeltaTargetHeading < -LookSteerDeadZone)
			{
				Steering = FMax((DeltaTargetHeading + LookSteerDeadZone) * LookSteerSensitivity, -1.0);
			}
			else
			{
				Steering = 0.0;
			}

			AngVel = Mesh.BodyInstance.GetUnrealWorldAngularVelocity();

			Steering = FClamp(Steering + (AngVel.Z * LookSteerDamping), -1.0, 1.0);

			// Reverse steering when reversing
			if (Throttle < 0.0 && ForwardVel < 0.0)
			{
				Steering = -1.0 * Steering;
			}
		}
		// flying hovering vehicles will use this
		else
		{
			//`log( " flying hovering vehicle" );
			if (bStickDeflectionThrottle)
			{
				// The region we consider 'reverse' is anything below DeflectionReverseThresh, or anything withing the triangle below the center position.
				bReverseThrottle = ((Throttle < DeflectionReverseThresh) || (Throttle < 0.0 && Abs(Steering) < -Throttle));

				Deflection = Sqrt(Throttle*Throttle + Steering*Steering);
				Throttle = Deflection;

				if (bReverseThrottle)
				{
					Throttle *= -1;
				}
			}
		}

		//`log( "Throttle: " $ Throttle $ " Steering: " $ Steering );
	}
}

*/

/*
simulated function SpawnImpactEmitter(vector HitLocation, vector HitNormal, const out MaterialImpactEffect ImpactEffect, int SeatIndex)
{
	Super.SpawnImpactEmitter(HitLocation, HitNormal, ImpactEffect, SeatIndex);

	if ( SeatIndex == 0 )
	{
		if (BeamLight == None || BeamLight.bDeleteMe)
		{
			BeamLight = Spawn(class'UTDarkWalkerBeamLight');
			BeamLight.AmbientSound.Play();
		}
		BeamLight.SetLocation(HitLocation + HitNormal*128);
	}
}

// Overloaded so we can attach the muzzle flash light to a custom socket /
simulated function CauseMuzzleFlashLight(int SeatIndex)
{
	Super.CauseMuzzleFlashLight(SeatIndex);

	if ( (SeatIndex == 0) && Seats[SeatIndex].MuzzleFlashLight != none )
	{
		Mesh.DetachComponent(Seats[SeatIndex].MuzzleFlashLight);
		Mesh.AttachComponentToSocket(Seats[SeatIndex].MuzzleFlashLight, 'PrimaryMuzzleFlash');
	}
}
*/

simulated event Destroyed()
{
	super.Destroyed();
	//KillBeamEmitter();
	ClearTimer('SleepCheckGroundDistance');
}

simulated function SleepCheckGroundDistance()
{
	local vector HitLocation, HitNormal;
	local actor HitActor;
	local float SleepCheckDistance;

	bSkipAggresiveSleep = FALSE;

	if(!bDriving && !Mesh.RigidBodyIsAwake())
	{
		HitActor = Trace(HitLocation, HitNormal, Location - vect(0,0,1000), Location, TRUE);

		SleepCheckDistance = 1000.0;
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
		}
	}
}

function PassengerLeave(int SeatIndex)
{
	Super.PassengerLeave(SeatIndex);

	SetDriving(NumPassengers() > 0);
}

function bool PassengerEnter(Pawn P, int SeatIndex)
{
	local bool b;

	b = Super.PassengerEnter(P, SeatIndex);
	SetDriving(NumPassengers() > 0);
	return b;
}

simulated function VehicleCalcCamera(float DeltaTime, int SeatIndex, out vector out_CamLoc, out rotator out_CamRot, out vector CamStart, optional bool bPivotOnly)
{
	local UTPawn P;

	if (SeatIndex == 1)
	{
		// Handle the fixed view
		P = UTPawn(Seats[SeatIndex].SeatPawn.Driver);
		if (P != None && P.bFixedView)
		{
			out_CamLoc = P.FixedViewLoc;
			out_CamRot = P.FixedViewRot;
			return;
		}

		out_CamLoc = GetCameraStart(SeatIndex);
		CamStart = out_CamLoc;
		out_CamRot = Seats[SeatIndex].SeatPawn.GetViewRotation();
		return;
	}

	Super.VehicleCalcCamera(DeltaTime, SeatIndex, out_CamLoc, out_CamRot, CamStart, bPivotOnly);
}


/**
*  Overloading this from SVehicle to avoid torquing the walker head.
*/
function AddVelocity( vector NewVelocity, vector HitLocation, class<DamageType> DamageType, optional TraceHitInfo HitInfo )
{
	// apply hit at location, not hitlocation
	Super.AddVelocity(NewVelocity, Location, DamageType, HitInfo);
}

/**
  * Let pawns standing under me get in, if I have a driver.
  */
function bool InCustomEntryRadius(Pawn P)
{
	return ( (P.Location.Z < Location.Z) && (VSize2D(P.Location - Location) < CustomEntryRadius)
		&& FastTrace(P.Location, Location) );
}

event WalkerDuckEffect();

simulated function BlowupVehicle()
{
	local vector Impulse;
	Super.BlowupVehicle();
	Impulse = Velocity; //LastTakeHitInfo;
	Impulse.Z = 0;
	if(IsZero(Impulse))
	{
		Impulse = vector(Rotation); // forward if no velocity.
	}
	Impulse *= 4000/VSize(Impulse);
	Mesh.SetRBLinearVelocity(Impulse);
	Mesh.SetRBAngularVelocity(VRand()*5, true);
	bStayUpright = false;
	bCanFlip=true;
}

simulated function bool ShouldClamp()
{
	return false;
}

//=================================
// AI Interface

function bool ImportantVehicle()
{
	return true;
}

function bool RecommendLongRangedAttack()
{
	return true;
}

defaultproperties
{

        //BodyAttachRightHandWeaponSocketName=RightHandSocket

	Begin Object Name=SVehicleMesh
		RBCollideWithChannels=(Default=TRUE,GameplayPhysics=TRUE,EffectPhysics=TRUE,Vehicle=TRUE,Untitled1=TRUE)
	End Object

	Begin Object Name=RB_BodyHandle
		LinearDamping=100.0
		LinearStiffness=99000.0
		AngularDamping=100.0
		AngularStiffness=99000.0
	End Object

	Health=1000
	MeleeRange=-100.0

	COMOffset=(x=0,y=0.0,z=150)
	bCanFlip=false

	AirSpeed=350.0
	GroundSpeed=350.0

	bFollowLookDir=true
	bCanStrafe=true
	bTurnInPlace=true
	bDuckObstacles=true
	ObjectiveGetOutDist=750.0
	ExtraReachDownThreshold=450.0
	MaxDesireability=1.25
	SpawnRadius=125.0
	bNoZSmoothing=true
	LookForwardDist=40.0
	TeamBeaconOffset=(z=350.0)

	bUseSuspensionAxis=true

	bStayUpright=true
	StayUprightRollResistAngle=0.0			// will be "locked"
	StayUprightPitchResistAngle=0.0
	//StayUprightStiffness=10
	//StayUprightDamping=100

	Begin Object Class=UTVehicleSimHover Name=SimObject
		WheelSuspensionStiffness=100.0
		WheelSuspensionDamping=40.0
		WheelSuspensionBias=0.0
		MaxThrustForce=600.0
		MaxReverseForce=600.0
		LongDamping=0.3
		MaxStrafeForce=600.0
		LatDamping=0.3
		MaxRiseForce=0.0
		UpDamping=0.0
		TurnTorqueFactor=9000.0
		TurnTorqueMax=10000.0
		TurnDamping=3.0
		MaxYawRate=1.6
		PitchTorqueMax=35.0
		PitchDamping=0.1
		RollTorqueMax=50.0
		RollDamping=0.1
		MaxRandForce=0.0
		RandForceInterval=1000.0
		bCanClimbSlopes=true
		PitchTorqueFactor=0.0
		RollTorqueTurnFactor=0.0
		RollTorqueStrafeFactor=0.0
		bAllowZThrust=false
		bStabilizeStops=true
		StabilizationForceMultiplier=1.0
		bFullThrustOnDirectionChange=true
		bDisableWheelsWhenOff=false
		HardLimitAirSpeedScale=1.5
	End Object
	SimObj=SimObject
	Components.Add(SimObject)
	
	Begin Object Class=UTHoverWheel Name=RThruster
		BoneName="BodyRoot"
		BoneOffset=(X=-50.0,Y=100.0,Z=-200.0)
		WheelRadius=10
		SuspensionTravel=145
		bPoweredWheel=false
		LongSlipFactor=0.0
		LatSlipFactor=0.0
		HandbrakeLongSlipFactor=0.0
		HandbrakeLatSlipFactor=0.0
		SteerFactor=1.0
		bHoverWheel=true
	End Object
	Wheels(0)=RThruster

	Begin Object Class=UTHoverWheel Name=LThruster
		BoneName="BodyRoot"
		BoneOffset=(X=-50.0,Y=-100.0,Z=-200.0)
		WheelRadius=10
		SuspensionTravel=145
		bPoweredWheel=false
		LongSlipFactor=0.0
		LatSlipFactor=0.0
		HandbrakeLongSlipFactor=0.0
		HandbrakeLatSlipFactor=0.0
		SteerFactor=1.0
		bHoverWheel=true
	End Object
	Wheels(1)=LThruster
        

	Begin Object Class=UTHoverWheel Name=FThruster
		BoneName="BodyRoot"
		BoneOffset=(X=80.0,Y=0.0,Z=-200.0)
		WheelRadius=10
		SuspensionTravel=145
		bPoweredWheel=false
		LongSlipFactor=0.0
		LatSlipFactor=0.0
		HandbrakeLongSlipFactor=0.0
		HandbrakeLatSlipFactor=0.0
		SteerFactor=1.0
		bHoverWheel=true
	End Object
	Wheels(2)=FThruster


        /*
	Begin Object Class=UTHoverWheel Name=RThruster
		BoneName="BodyRoot"
		//BoneName="Root"
		BoneOffset=(X=0,Y=0,Z=-20)
		WheelRadius=70
		SuspensionTravel=20
		bPoweredWheel=false
		SteerFactor=1.0
		LongSlipFactor=0.0
		LatSlipFactor=0.0
		HandbrakeLongSlipFactor=0.0
		HandbrakeLatSlipFactor=0.0
		bCollidesVehicles=FALSE
	End Object
	Wheels(0)=RThruster

	*/

	RespawnTime=45.0

	//LengthDarkWalkerWarningCone=7500

	//HoverBoardAttachSockets=(HoverAttach00,HoverAttach01)

	bHasCustomEntryRadius=true
	CustomEntryRadius=300.0

	bIgnoreStallZ=TRUE
	HUDExtent=250.0

	BaseEyeheight=0
	Eyeheight=0

	bFindGroundExit=false
	bShouldAutoCenterViewPitch=FALSE

	bIsNecrisVehicle=true

	HornIndex=3
	VehicleIndex=1
	CustomGravityScaling=0.9

	HeroBonus=2.0
	GreedCoinBonus=6

	ChargeBarPosY=4
	ChargeBarPosX=3
}
