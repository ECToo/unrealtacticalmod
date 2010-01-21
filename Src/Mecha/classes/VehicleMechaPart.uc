/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
   Information: This deal with parts build. Meaning each part is changable.
   
   Note: The code are copy and paste so it is mess up for testing purpose.
   
   Get the vehicle to crouch or sit function into to make the hover ground  close to the floor.
 */

 /*
 *
 * Build Type: Two leg
 */

class VehicleMechaPart extends VehicleMecha;

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

//var class <MechaPart> MechPart;
//var MechaPart MechPartActor;
//Head
var() protected const Name BodyAttachHeadSocketName;
var class <MechaPart> MechPart_Head;
var MechaPart MechPartActor_Head;
//Back
var() protected const Name BodyAttachBackSocketName;
var() class <MechaPart> MechPart_Back;
var MechaPart MechPartActor_Back;
//Leg
var() protected const Name BodyAttachLegSocketName;
var() class <MechaPart> MechPart_Leg;
var MechaPart MechPartActor_Leg;
//Right Arm
var() protected const Name BodyAttachRightArmSocketName;
var() class <MechaPartArm> MechPart_RightArm;
var MechaPartArm MechPartActor_RightArm;
//right weapon
var() protected const Name BodyAttachRightHandSocketName;
var() class <MechaPart> MechPart_RightHand;
var MechaPart MechPartActor_RightHand;
//Left Arm
var() protected const Name BodyAttachLeftArmSocketName;
var() class <MechaPartArm> MechPart_LeftArm;
var MechaPartArm MechPartActor_LeftArm;
//left weapon
var() protected const Name BodyAttachLeftHandSocketName;
var() class <MechaPart> MechPart_LeftHand;
var MechaPart MechPartActor_LeftHand;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	SetTimer(1.0, TRUE, 'SleepCheckGroundDistance');
	// no spider body on server
	if ( WorldInfo.NetMode != NM_DedicatedServer ){
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
			Mesh.AttachComponentToSocket(MechPartActor_RightArm.Mesh,BodyAttachRightArmSocketName);//'RightHandSocket'
			MechPartActor_RightArm.SetMechVehicle(self);
			//right hand weapon
			if(MechPart_RightHand != None){
				MechPartActor_RightHand = Spawn(MechPart_RightHand, self,, Location);
				MechPartActor_RightArm.Mesh.AttachComponentToSocket(MechPartActor_RightHand.Mesh,BodyAttachRightHandSocketName);//'RightHandSocket'
				MechPartActor_RightHand.SetMechVehicle(self);
			}
		}else{
			//This deal with if no arm that will attack to this mech code. For prebuild mech stuff.
			if(MechPart_RightHand != None){
				MechPartActor_RightHand = Spawn(MechPart_RightHand, self,, Location);
				Mesh.AttachComponentToSocket(MechPartActor_RightHand.Mesh,BodyAttachRightArmSocketName);//'RightHandSocket'
				MechPartActor_RightHand.SetMechVehicle(self);
			}
		}

		//left arm
		if(MechPart_LeftArm != None){
			MechPartActor_LeftArm = Spawn(MechPart_LeftArm, self,, Location);
			Mesh.AttachComponentToSocket(MechPartActor_LeftArm.Mesh,BodyAttachLeftArmSocketName);//'LeftHandSocket'
			MechPartActor_LeftArm.SetMechVehicle(self);
			//left hand weapon
			if(MechPart_LeftHand != None){
				MechPartActor_LeftHand = Spawn(MechPart_LeftHand, self,, Location);
				MechPartActor_LeftArm.Mesh.AttachComponentToSocket(MechPartActor_LeftHand.Mesh,BodyAttachLeftHandSocketName);//'LeftHandSocket'
				MechPartActor_LeftHand.SetMechVehicle(self);
			}
		}else{
			if(MechPart_LeftHand != None){
				MechPartActor_LeftHand = Spawn(MechPart_LeftHand, self,, Location);
				Mesh.AttachComponentToSocket(MechPartActor_LeftHand.Mesh,BodyAttachLeftArmSocketName);//'LeftHandSocket'
				MechPartActor_LeftHand.SetMechVehicle(self);
			}
		}
	}

	InitArmTurret();
}

function InitArmTurret(){
      if(MechPartActor_RightArm != none){
        // Initialize turrets to vehicle rotation.
          MechPartActor_RightArm.ArmBoneControl.InitTurret(Rotation, Mesh);
      }

      if(MechPartActor_LeftArm != none){
        // Initialize turrets to vehicle rotation.
          MechPartActor_LeftArm.ArmBoneControl.InitTurret(Rotation, Mesh);
      }
}

/**
 * This event is triggered when a repnotify variable is received
 *
 * @param	VarName		The name of the variable replicated
 */
// kismet ?
simulated event ReplicatedEvent(name VarName)
{
        super.ReplicatedEvent(VarName);
}

//note this update or loop to run this
//need to fixed two type of controling the arms
simulated function ProcessViewRotation(float DeltaTime, out rotator out_ViewRotation, out rotator out_DeltaRot)
{
    //local rotator BoneRotation;
    //local vector DummyVector; //Not used.
    //bones name::BodyRoot,RightArm2

        Super.ProcessViewRotation(DeltaTime, out_ViewRotation, out_DeltaRot);

        if(MechPartActor_RightArm.ArmBoneControl !=none){           //MaxDeltaDegrees = FMax(MaxDeltaDegrees, MechPartActor_RightArm.ArmBoneControl.LagDegreesPerSecond);          //MechPartActor_RightArm.ArmBoneControl.BoneRotation.Pitch = GetClampedViewRotation().Pitch + Rotation.Pitch;          //MechPartActor_RightArm.ArmBoneControl.BoneRotation.Yaw = GetClampedViewRotation().Yaw;          //`log("pitch " $ GetClampedViewRotation().Pitch);//all plus rotation//MechPartActor_RightArm.ArmBoneControl.BoneRotation.Yaw = Rotation.Yaw + 8000;
            //MechPartActor_RightArm.Mesh.TransformToBoneSpace('BodyRoot', DummyVector, out_ViewRotation, DummyVector, BoneRotation);
            //MechPartActor_RightArm.Mesh.TransformToBoneSpace('RightArm2', DummyVector, SeatWeaponRotation(0,,true), DummyVector, BoneRotation);
            //MechPartActor_RightArm.Mesh.TransformToBoneSpace('RightArm2', DummyVector, out_ViewRotation, DummyVector, BoneRotation);
            //MechPartActor_RightArm.Mesh.TransformToBoneSpace('BodyRoot', DummyVector, out_ViewRotation, DummyVector, BoneRotation);
            //MechPartActor_RightArm.ArmBoneControl.DesiredBoneRotation = BoneRotation;
          // doesn't do limit rotations //SeatWeaponRotation(0,,true); built in function for UTVehicle class
          //this set the rotation
          /*
          MechPartActor_RightArm.ArmBoneControl.DesiredBoneRotation = SeatWeaponRotation(0,,true);
          if(MechPartActor_RightArm.ArmBoneControl.DesiredBoneRotation.Pitch == 0){
            MechPartActor_RightArm.ArmBoneControl.DesiredBoneRotation.Pitch = out_ViewRotation.Pitch + 5000;
          }
          */
          //NeededPitch = rotator(Other.GetTargetLocation(self) - Weapon.GetPhysicalFireStartLoc()).Pitch & 65535;          //MechPartActor_RightArm.ArmBoneControl.DesiredBoneRotation.Pitch = rotator(Weapon.GetPhysicalFireStartLoc()).Pitch;

          //MechPartActor_RightArm.ArmBoneControl.DesiredBoneRotation = SeatWeaponRotation(0,,true);
          //MechPartActor_RightArm.ArmBoneControl.DesiredBoneRotation = out_ViewRotation;
          //MechPartActor_RightArm.ArmBoneControl.DesiredBoneRotation = GetClampedViewRotation();
         //MechPartActor_RightArm.ArmBoneControl.DesiredBoneRotation = Controller.Rotation;//partly works
           //MechPartActor_RightArm.Mesh.TransformToBoneSpace('RightArm2', DummyVector, Controller.Rotation, DummyVector, BoneRotation);
           //MechPartActor_RightArm.ArmBoneControl.DesiredBoneRotation = BoneRotation;//partly works
             MechPartActor_RightArm.ArmBoneControl.DesiredBoneRotation = Controller.Rotation;
        }else{
              //`log("none");
        }

        if(MechPartActor_LeftArm.ArmBoneControl !=none){
          // doesn't do limit rotations //SeatWeaponRotation(0,,true); built in function for UTVehicle class
          //this set the rotation
          //MechPartActor_LeftArm.ArmBoneControl.DesiredBoneRotation = SeatWeaponRotation(0,,true);
          //MechPartActor_LeftArm.ArmBoneControl.DesiredBoneRotation = SeatWeaponRotation(0,,true);
           //if(MechPartActor_LeftArm.ArmBoneControl.DesiredBoneRotation.Pitch == 0){
            //MechPartActor_LeftArm.ArmBoneControl.DesiredBoneRotation.Pitch = out_ViewRotation.Pitch + 5000;
            //MechPartActor_RightArm.ArmBoneControl.DesiredBoneRotation = GetClampedViewRotation();
          //}
          //`log(MechPartActor_LeftArm.ArmBoneControl.DesiredBoneRotation.Pitch);
           MechPartActor_LeftArm.ArmBoneControl.DesiredBoneRotation = Controller.Rotation;
        }

}


/**
 * this function is called when a weapon rotation value has changed.  It sets the DesiredboneRotations for each controller
 * associated with the turret.
 *
 * Network: Remote clients.  All other cases are handled natively
 * FIXME: Look at handling remote clients natively as well
 *
 * @param	SeatIndex		The seat at which the rotation changed
 */

simulated function WeaponRotationChanged(int SeatIndex)
{
	local int i;

	if ( SeatIndex>=0 )
	{
		for (i=0;i<Seats[SeatIndex].TurretControllers.Length;i++)
		{
			Seats[SeatIndex].TurretControllers[i].DesiredBoneRotation = SeatWeaponRotation(SeatIndex,,true);
			`log("WeaponRotationChanged");
		}
		`log("WeaponRotationChanged");
	}

	if ( SeatIndex ==0 ){
	    `log("WeaponRotationChanged");
	    //MechPartActor_RightArm
	}
}

/** checks if the given pitch would be limited by the turret controllers, i.e. we cannot possibly fire in that direction
 * @return whether the pitch would be constrained
 */
function bool CheckTurretPitchLimit(int NeededPitch, int SeatIndex)
{
	local int i;

	if (SeatIndex >= 0)
	{
		if (Seats[SeatIndex].TurretControllers.length > 0)
		{
			for (i = 0; i < Seats[SeatIndex].TurretControllers.Length; i++ )
			{
				if (!Seats[SeatIndex].TurretControllers[i].WouldConstrainPitch(NeededPitch, Mesh))
				{
					return false;
				}
			}

			return true;
		}
		else if (Seats[SeatIndex].Gun != None)
		{
			return (Cos(Abs(NeededPitch - (Rotation.Pitch & 65535)) / 182.0444) > Seats[SeatIndex].Gun.GetMaxFinalAimAdjustment());
		}
	}

	return false;
}

simulated function bool OverrideBeginFire(byte FireModeNum)
{
        //super.OverrideBeginFire(FireModeNum);
	if (FireModeNum == 1)
	{
	//`log('ALT FIRE MODE');
		if(MechPartActor_RightHand != none){
		   MechPartActor_RightHand.BeginFire();
		}
	}

	if (FireModeNum == 0)
	{
	//`log('FIRE MODE');
                if(MechPartActor_LeftHand !=none){
		   MechPartActor_LeftHand.BeginFire();
		}
		//MechPartActor_RightHand.BeginFire();
	}
	return false;
}

simulated function bool OverrideEndFire(byte FireModeNum){
        //super.OverrideEndFire(FireModeNum);
	if (FireModeNum == 1)
	{
	//`log('ALT FIRE MODE');
		if(MechPartActor_RightHand != none){
		    MechPartActor_RightHand.EndFire();
		}
	}

	if (FireModeNum == 0)
	{
	//`log('FIRE MODE');
		if(MechPartActor_LeftHand != None){
                    MechPartActor_LeftHand.EndFire();
		}
	}
	return false;
}


simulated function SwitchWeapon(byte NewGroup)
{
      //super.SwitchWeapon(NewGroup);

     `log('Swtich Weapon MODE' @ NewGroup); //when press on the number key from 0-9 not the num lock keys

     if(NewGroup == 1){
      if(MechPartActor_RightHand != None){
         MechPartActor_RightHand.ToggleDisableWeapon();
      }}
      
      if(NewGroup == 2){
      if(MechPartActor_LeftHand != None){
         MechPartActor_LeftHand.ToggleDisableWeapon();
      }}

        /*
	if ( (DeployedState == EDS_Deployed) || (DeployedState == EDS_Deploying) )
	{
		ServerChangeSeat(NewGroup-1);
	}
	*/
}


simulated function DisplayHud(UTHud Hud, Canvas Canvas, vector2D HudPOS, optional int SeatIndex)
{
	super.DisplayHud(HUD, Canvas, HudPOS, SeatIndex);
	//Canvas.DrawColor = WhiteColor;
	Canvas.DrawColor = class'HUD'.default.GreenColor;

	if(MechPartActor_RightHand != None){
	Canvas.SetPos(25,280);//x,y screen
           Canvas.DrawText("Weapon Slot 1: " @ MechPartActor_RightHand.bWeaponDisable);
	}

	if(MechPartActor_LeftHand != None){
	Canvas.SetPos(25,280+24);//x,y screen
           Canvas.DrawText("Weapon Slot 2: " @ MechPartActor_LeftHand.bWeaponDisable);
	}
	//set postion and draw text
	//Canvas.SetPos(25,280+24);//x,y screen
	//Canvas.DrawText("Slot 2: " @ MechPartActor_LeftHand.bWeaponDisable);
}

//===============================================
// INPUTS
//===============================================
//need to fixed looping since this has tick or loop
simulated function SetInputs(float InForward, float InStrafe, float InUp)
{
      super.SetInputs(InForward,InStrafe,InUp);
      ///`log('Forward'@InForward);

      if(InForward > 0){
          MechPartActor_Leg.BeginActionWalk(); //play animation walk front
          MechPartActor_Leg.DirectionWalk("Forward");
          //MechPartActor_Leg.BeginActionWalk();
      }else if(InForward < 0){
          MechPartActor_Leg.BeginActionWalk();
          MechPartActor_Leg.DirectionWalk("Backward");
          //MechPartActor_Leg.playanimationtest();//play animation walk backward
      }else{
          MechPartActor_Leg.EndActionWalk();
          MechPartActor_Leg.DirectionWalk("Stop");
      }

      //`log("SteerRot " @ Steering); //move to side to side
      //`log("SteerRot " @ bUsingLookSteer);
}

//===============================================
// CONTROL JUMP > Spacebar
//===============================================
function bool DoJump(bool bUpdating){
   super.DoJump(bUpdating);
   `log('jump');
   return true;
}

//===============================================
// CONTROL JUMP > Spacebar
//===============================================
simulated function SetFiringMode(Weapon Weap, byte FiringModeNum)
{
        `log('SetFiringMode');
	SeatFiringMode(0, FiringModeNum, false);
}

simulated event Destroyed()
{
	super.Destroyed();
	//KillBeamEmitter();
	ClearTimer('SleepCheckGroundDistance');
}

//this deal some what hover I think.
simulated function SleepCheckGroundDistance()
{
	local vector HitLocation, HitNormal;
	local actor HitActor;
	local float SleepCheckDistance;

	bSkipAggresiveSleep = FALSE;

	if(!bDriving && !Mesh.RigidBodyIsAwake())
	{
		HitActor = Trace(HitLocation, HitNormal, Location - vect(0,0,1000), Location, TRUE);

		SleepCheckDistance = 2000.0;
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
        //Bone Names
        BodyAttachHeadSocketName=MechHeadSocket
        BodyAttachLegSocketName=MechLegSocket
        BodyAttachRightArmSocketName=RightHandSocket
        BodyAttachRightHandSocketName=RightHandSocket
        BodyAttachLeftArmSocketName=LeftHandSocket
        BodyAttachLeftHandSocketName=LeftHandSocket


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

	Begin Object Class=UTVehicleSimHover Name=SimObject
		WheelSuspensionStiffness=20.0
		WheelSuspensionDamping=1.0
		WheelSuspensionBias=0.0
		MaxThrustForce=600.0
		MaxReverseForce=600.0
		LongDamping=0.3
		MaxStrafeForce=600.0
		LatDamping=0.3
		MaxRiseForce=0.0
		UpDamping=0.0
		TurnTorqueFactor=2000.0
		TurnTorqueMax=10000.0
		TurnDamping=0.25
		MaxYawRate=100000.0
		PitchTorqueMax=200.0
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
		BoneName="BodyRoot" //need to the bone name else it will crash
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
		BoneName="BodyRoot"   //need to the bone name else it will crash
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
		BoneName="BodyRoot"  //need to the bone name else it will crash
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

	RespawnTime=45.0

	//HoverBoardAttachSockets=(HoverAttach00,HoverAttach01)

	bHasCustomEntryRadius=true
	CustomEntryRadius=300.0

	bIgnoreStallZ=TRUE
	HUDExtent=250.0

	//BaseEyeheight=0
	//Eyeheight=0
	
	BaseEyeheight=50
	Eyeheight=200

	bFindGroundExit=false
	bShouldAutoCenterViewPitch=FALSE

	bIsNecrisVehicle=true

	HornIndex=3
	//VehicleIndex=1
	CustomGravityScaling=0.9
}
