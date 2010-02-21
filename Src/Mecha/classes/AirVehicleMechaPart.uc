/**
 *
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
   Information: This deal with parts build. Meaning each part is changable.
   
   Note: The code are copy and paste so it is mess up for testing purpose.
   
   Get the vehicle to crouch or sit function into to make the hover ground  close to the floor.
 */

class AirVehicleMechaPart extends AirVehicleMecha;

/** radius to allow players under this darkwalker to gain entry */
var float CustomEntryRadius;

//var float CustomGravityScaling;

/** @hack: replicated copy of bHoldingDuck for clients */
var bool bIsDucking;

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
	//SetTimer(1.0, TRUE, 'SleepCheckGroundDistance');
	// no spider body on server
	if ( WorldInfo.NetMode != NM_DedicatedServer ){
		//head
		if(MechPart_Head != None){
			MechPartActor_Head = Spawn(MechPart_Head, self,, Location);
			Mesh.AttachComponentToSocket(MechPartActor_Head.Mesh,BodyAttachHeadSocketName);//'MechHeadSocket'
			//MechPartActor_Head.SetMechVehicle(self);
		}

		//leg
		if(MechPart_Leg != None){
			MechPartActor_Leg = Spawn(MechPart_Leg, self,, Location);
			Mesh.AttachComponentToSocket(MechPartActor_Leg.Mesh,BodyAttachLegSocketName);//'MechLegSocket'
			//MechPartActor_Leg.SetMechVehicle(self);
		}

		//right arm
		if(MechPart_RightArm != None){
			MechPartActor_RightArm = Spawn(MechPart_RightArm, self,, Location);
			Mesh.AttachComponentToSocket(MechPartActor_RightArm.Mesh,BodyAttachRightArmSocketName);//'RightHandSocket'
			//MechPartActor_RightArm.SetMechVehicle(self);
			//right hand weapon
			if(MechPart_RightHand != None){
				MechPartActor_RightHand = Spawn(MechPart_RightHand, self,, Location);
				MechPartActor_RightArm.Mesh.AttachComponentToSocket(MechPartActor_RightHand.Mesh,BodyAttachRightHandSocketName);//'RightHandSocket'
				//MechPartActor_RightHand.SetMechVehicle(self);
			}
		}else{
			//This deal with if no arm that will attack to this mech code. For prebuild mech stuff.
			if(MechPart_RightHand != None){
				MechPartActor_RightHand = Spawn(MechPart_RightHand, self,, Location);
				Mesh.AttachComponentToSocket(MechPartActor_RightHand.Mesh,BodyAttachRightArmSocketName);//'RightHandSocket'
				//MechPartActor_RightHand.SetMechVehicle(self);
			}
		}

		//left arm
		if(MechPart_LeftArm != None){
			MechPartActor_LeftArm = Spawn(MechPart_LeftArm, self,, Location);
			Mesh.AttachComponentToSocket(MechPartActor_LeftArm.Mesh,BodyAttachLeftArmSocketName);//'LeftHandSocket'
			//MechPartActor_LeftArm.SetMechVehicle(self);
			//left hand weapon
			if(MechPart_LeftHand != None){
				MechPartActor_LeftHand = Spawn(MechPart_LeftHand, self,, Location);
				MechPartActor_LeftArm.Mesh.AttachComponentToSocket(MechPartActor_LeftHand.Mesh,BodyAttachLeftHandSocketName);//'LeftHandSocket'
				//MechPartActor_LeftHand.SetMechVehicle(self);
			}
		}else{
			if(MechPart_LeftHand != None){
				MechPartActor_LeftHand = Spawn(MechPart_LeftHand, self,, Location);
				Mesh.AttachComponentToSocket(MechPartActor_LeftHand.Mesh,BodyAttachLeftArmSocketName);//'LeftHandSocket'
				//MechPartActor_LeftHand.SetMechVehicle(self);
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

/*
* This code deal this class switching skeleton mesh
*/
function changeparts(class<MechaPart> part){
         //need to setup some var for changes in the parts
        //local rotator armrotation;
	if(part != None){
		if (part.default.bodytype == "leg"){ //class base by using the packagename'default' to get the variables
			`log("LEGGING");
			MechPartActor_Leg.Destroyed();
			MechPartActor_Leg.Mesh.SetHidden(True);
			MechPartActor_Leg.SetHidden(True);
			MechPartActor_Leg = None;

			MechPartActor_Leg = Spawn(part,self,,Location);
			Mesh.AttachComponentToSocket(MechPartActor_Leg.Mesh,BodyAttachLegSocketName);
			//MechPartActor_Leg.SetMechVehicle(self);
		}
		
		if(part.default.bodytype == "head"){
			`log("HEAD");
			MechPartActor_Head.Destroyed();
			MechPartActor_Head.Mesh.SetHidden(True);
			MechPartActor_Head.SetHidden(True);
			MechPartActor_Head = None;
		
			MechPartActor_Head = Spawn(part, self,, Location);
			Mesh.AttachComponentToSocket(MechPartActor_Head.Mesh,BodyAttachHeadSocketName);//'MechHeadSocket'
			//MechPartActor_Head.SetMechVehicle(self);
		}
		
		if(part.default.bodytype == "rightarm"){
			`log("Right Arm");
			
			//if(MechPartActor_RightArm.ArmBoneControl !=none){
			//   armrotation = MechPartActor_RightArm.ArmBoneControl.DesiredBoneRotation;
			//}

			MechPartActor_RightArm.Destroyed();
			MechPartActor_RightArm.Mesh.SetHidden(True);
			MechPartActor_RightArm.SetHidden(True);
			MechPartActor_RightArm = None;

			MechPartActor_RightArm = Spawn(class<MechaPartArm>(part), self,, Location);//note this different class that support some functions
			Mesh.AttachComponentToSocket(MechPartActor_RightArm.Mesh,BodyAttachRightArmSocketName);//'MechHeadSocket'
			//MechPartActor_RightArm.SetMechVehicle(self);

			if(MechPartActor_RightHand != None){
				MechPartActor_RightArm.Mesh.AttachComponentToSocket(MechPartActor_RightHand.Mesh,BodyAttachRightHandSocketName);//'LeftHandSocket'
			}

                        //if(MechPartActor_RightArm.ArmBoneControl !=none){
                        //        MechPartActor_RightArm.ArmBoneControl.DesiredBoneRotation = armrotation;
                        //}

		}

		if(part.default.bodytype == "rightweaponhand"){
			`log("Right Hand Weapon");
			MechPartActor_RightHand.Destroyed();
			MechPartActor_RightHand.Mesh.SetHidden(True);
			MechPartActor_RightHand.SetHidden(True);
			MechPartActor_RightHand = None;
			if(MechPartActor_RightArm != None){//with arm
				MechPartActor_RightHand = Spawn(part, self,, Location);
				MechPartActor_RightArm.Mesh.AttachComponentToSocket(MechPartActor_RightHand.Mesh,BodyAttachRightHandSocketName);//'MechHeadSocket'
				//MechPartActor_RightHand.SetMechVehicle(self);
			}else{//without arm
				MechPartActor_RightHand = Spawn(part, self,, Location);
				Mesh.AttachComponentToSocket(MechPartActor_RightHand.Mesh,BodyAttachRightHandSocketName);//'MechHeadSocket'
				//MechPartActor_RightHand.SetMechVehicle(self);
			}
		}
		
		if(part.default.bodytype == "leftarm"){
			`log("Left Arm");
			
			//if(MechPartActor_RightArm.ArmBoneControl !=none){
			//   armrotation = MechPartActor_LeftArm.ArmBoneControl.DesiredBoneRotation;
			//}

			MechPartActor_LeftArm.Destroyed();
			MechPartActor_LeftArm.Mesh.SetHidden(True);
			MechPartActor_LeftArm.SetHidden(True);
			MechPartActor_LeftArm = None;


			MechPartActor_LeftArm = Spawn(class<MechaPartArm>(part), self,, Location);
			Mesh.AttachComponentToSocket(MechPartActor_LeftArm.Mesh,BodyAttachLeftArmSocketName);//'MechHeadSocket'
			//MechPartActor_LeftArm.SetMechVehicle(self);

			if(MechPartActor_LeftArm != None){
				MechPartActor_LeftArm.Mesh.AttachComponentToSocket(MechPartActor_LeftHand.Mesh,BodyAttachLeftHandSocketName);//'LeftHandSocket'
			}

			//if(MechPartActor_RightArm.ArmBoneControl !=none){
			//    MechPartActor_LeftArm.ArmBoneControl.DesiredBoneRotation = armrotation;
			//}

		}
		
		if(part.default.bodytype == "leftweaponhand"){
			`log("Left Hand Weapon");
			MechPartActor_LeftHand.Destroyed();
			MechPartActor_LeftHand.Mesh.SetHidden(True);
			MechPartActor_LeftHand.SetHidden(True);
			MechPartActor_LeftHand = None;
			if (MechPartActor_LeftArm != None){//with arm
				MechPartActor_LeftHand = Spawn(part, self,, Location);
				MechPartActor_LeftArm.Mesh.AttachComponentToSocket(MechPartActor_LeftHand.Mesh,BodyAttachLeftHandSocketName);//'MechHeadSocket'
				//MechPartActor_LeftHand.SetMechVehicle(self);
			}else{//without arm
				MechPartActor_LeftHand = Spawn(MechPart_LeftHand, self,, Location);
				Mesh.AttachComponentToSocket(MechPartActor_LeftHand.Mesh,BodyAttachLeftArmSocketName);//'LeftHandSocket'
				//MechPartActor_LeftHand.SetMechVehicle(self);
			}
		}
	}else{
		`log('Error class is not set');
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

/*
function rotator GetAimDirectionArm(MechaPartArm ArmDir)
{
         local vector SocketLocation, CameraLocation, RealAimPoint, DesiredAimPoint, HitLocation, HitRotation, DirA, DirB;
	local rotator CameraRotation, SocketRotation, ControllerAim, AdjustedAim;
	local float DiffAngle, MaxAdjust;
	local Controller C;
	local PlayerController PC;
	local Quat Q;
	
	if(ArmDir != None){
	   C = Controller;
	   PC = PlayerController(C);
	   if (PC != None)
		{
			PC.GetPlayerViewPoint(CameraLocation, CameraRotation);
			DesiredAimPoint = CameraLocation + Vector(CameraRotation);// * ArmDir.GetTraceRange();
			if (Trace(HitLocation, HitRotation, DesiredAimPoint, CameraLocation) != None)
			{
				DesiredAimPoint = HitLocation;
			}
		}else if (C != None)
		{
			DesiredAimPoint = C.GetFocalPoint();
		}

	}

}
*/



/**
 * This function returns the aim for the weapon
 */
/*
function rotator GetWeaponAim(UTVehicleWeapon VWeapon)
{
	local vector SocketLocation, CameraLocation, RealAimPoint, DesiredAimPoint, HitLocation, HitRotation, DirA, DirB;
	local rotator CameraRotation, SocketRotation, ControllerAim, AdjustedAim;
	local float DiffAngle, MaxAdjust;
	local Controller C;
	local PlayerController PC;
	local Quat Q;

	if ( VWeapon != none )
	{
		C = Seats[VWeapon.SeatIndex].SeatPawn.Controller;

		PC = PlayerController(C);
		if (PC != None)
		{
			PC.GetPlayerViewPoint(CameraLocation, CameraRotation);
			DesiredAimPoint = CameraLocation + Vector(CameraRotation) * VWeapon.GetTraceRange();
			if (Trace(HitLocation, HitRotation, DesiredAimPoint, CameraLocation) != None)
			{
				DesiredAimPoint = HitLocation;
			}
		}
		else if (C != None)
		{
			DesiredAimPoint = C.GetFocalPoint();
		}

		if ( Seats[VWeapon.SeatIndex].GunSocket.Length>0 )
		{
			GetBarrelLocationAndRotation(VWeapon.SeatIndex, SocketLocation, SocketRotation);
			if(VWeapon.bIgnoreSocketPitchRotation || ((DesiredAimPoint.Z - Location.Z)<0 && VWeapon.bIgnoreDownwardPitch))
			{
				SocketRotation.Pitch = Rotator(DesiredAimPoint - Location).Pitch;
			}
		}
		else
		{
			SocketLocation = Location;
			SocketRotation = Rotator(DesiredAimPoint - Location);
		}

		RealAimPoint = SocketLocation + Vector(SocketRotation) * VWeapon.GetTraceRange();
		DirA = normal(DesiredAimPoint - SocketLocation);
		DirB = normal(RealAimPoint - SocketLocation);
		DiffAngle = ( DirA dot DirB );
		MaxAdjust = VWeapon.GetMaxFinalAimAdjustment();
		if ( DiffAngle >= MaxAdjust )
		{
			// bit of a hack here to make bot aiming and single player autoaim work
			ControllerAim = (C != None) ? C.Rotation : Rotation;
			AdjustedAim = VWeapon.GetAdjustedAim(SocketLocation);
			if (AdjustedAim == VWeapon.Instigator.GetBaseAimRotation() || AdjustedAim == ControllerAim)
			{
				// no adjustment
				return rotator(DesiredAimPoint - SocketLocation);
			}
			else
			{
				// FIXME: AdjustedAim.Pitch = Instigator.LimitPitch(AdjustedAim.Pitch);
				return AdjustedAim;
			}
		}
		else
		{
			Q = QuatFromAxisAndAngle(Normal(DirB cross DirA), ACos(MaxAdjust));
			return Rotator( QuatRotateVector(Q,DirB));
		}
	}
	else
	{
		return Rotation;
	}
}
*/

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
//key L for play horn
function PlayHorn()
{
 super.PlayHorn();
 `log('PLAY SOUND HORN');

}

function ShouldCrouch( bool bCrouch )
{
 super.ShouldCrouch(bCrouch);
 `log('crouch' @ bCrouch);
	bWantsToCrouch = bCrouch;
}

//doesn't work
function bool Dodge(eDoubleClickDir DoubleClickMove)
{
 super.Dodge(DoubleClickMove);
	Rise = 1;
	`log('Dodge');
	return true;
}
//doesn't work
function ThrowActiveWeapon() {
super.ThrowActiveWeapon();
`log('ThrowActiveWeapon');
}

/**
 * Makes sure a Pawn is not crouching, telling it to stand if necessary.
 */
simulated function UnCrouch()
{         
          super.UnCrouch();
          `log('UnCrouch');
	if( bIsCrouched || bWantsToCrouch )
	{
		ShouldCrouch( false );
	}
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
   `log('jump' @ bUpdating);
   if (bJumpCapable && !bIsCrouched && !bWantsToCrouch && (Physics == PHYS_Walking || Physics == PHYS_Ladder || Physics == PHYS_Spider))
	{
		if ( Physics == PHYS_Spider )
			Velocity = JumpZ * Floor;
		else if ( Physics == PHYS_Ladder )
			Velocity.Z = 0;
		else if ( bIsWalking )
			Velocity.Z = Default.JumpZ;
		else
			Velocity.Z = JumpZ;
		if (Base != None && !Base.bWorldGeometry && Base.Velocity.Z > 0.f)
		{
			Velocity.Z += Base.Velocity.Z;
		}
		SetPhysics(PHYS_Falling);
		return true;
	}
	return false;
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
	//ClearTimer('SleepCheckGroundDistance');
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

	Begin Object Name=RB_BodyHandle
		LinearDamping=100.0
		LinearStiffness=99000.0
		AngularDamping=100.0
		AngularStiffness=99000.0
	End Object

	Health=1000
	MeleeRange=-100.0

	Begin Object Class=UDKVehicleSimChopper Name=SimObject

		MaxThrustForce=700.0
		MaxReverseForce=700.0
		LongDamping=0.6
		MaxStrafeForce=680.0
		LatDamping=0.7
		MaxRiseForce=1000.0
		UpDamping=0.7
		TurnTorqueFactor=7000.0
		TurnTorqueMax=10000.0
		TurnDamping=1.2
		MaxYawRate=1.8
		PitchTorqueFactor=450.0
		PitchTorqueMax=60.0
		PitchDamping=0.3
		RollTorqueTurnFactor=700.0
		RollTorqueStrafeFactor=100.0
		RollTorqueMax=300.0
		RollDamping=0.1
		MaxRandForce=30.0
		RandForceInterval=0.5
		StopThreshold=100
		bShouldCutThrustMaxOnImpact=true
	End Object
	SimObj=SimObject
	Components.Add(SimObject)

	COMOffset=(X=-40,Z=-50.0)

        BaseEyeheight=30
	Eyeheight=30
	bRotateCameraUnderVehicle=false
	CameraLag=0.05
	LookForwardDist=290.0
	bLimitCameraZLookingUp=true

	AirSpeed=2000.0
	GroundSpeed=1600.0

	UprightLiftStrength=30.0
	UprightTorqueStrength=30.0

	bStayUpright=true
	StayUprightRollResistAngle=5.0
	StayUprightPitchResistAngle=5.0
	StayUprightStiffness=1200
	StayUprightDamping=20

	SpawnRadius=180.0
	RespawnTime=45.0

	bOverrideAVRiLLocks=true

	PushForce=50000.0
	HUDExtent=140.0

	HornIndex=0

}
