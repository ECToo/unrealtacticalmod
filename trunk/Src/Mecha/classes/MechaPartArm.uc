/**
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt

   Information: This code handle the skeleton control for the turret controls from UTVehicle functions.
   This function will be add on and not over ride for UTVehicle Turrets.
   This part is still under testing out some area.

   //To DO List:
   -Weapon Animation
   -Walk Animation
   -Arm Type
*/

class MechaPartArm extends MechaPart;

var class<UTProjectile> WeaponProjectiles;

var Name SocketName;
var vector SocketLocation;
var rotator SocketRotation;
var bool bWeaponFire;
var bool BAltWeaponFire;
var float FireRate;
var int fireinterval;
var vector weapondirection;

var vector FireOffset;
var vector ProjectileSpawnOffset;
var bool bWeaponPress;

//var SkelControlSingleBone ArmBoneControl; //default for basic test
var UTSkelControl_TurretConstrained ArmBoneControl;
var name ArmNameControl1;

//var SkelControlSingleBone ArmBoneControl; //default for basic test
var UTSkelControl_TurretConstrained ArmBoneControl2;
var name ArmNameControl2;
var name ActionName;

//deal with the update
var bool bElbowControl; // joint when moving to aim
var bool bShoulderControl; // joint when moving to aim

var() protected const Name ShoulderSocketName;
var() protected const Name ElbowSocketName;
var() protected const Name HandSocketName;

var() protected const Name ShoulderBoneName;
var() protected const Name ElbowBoneName;
var() protected const Name HandBoneName;


//===============================================
//unreal setting that need to be else another config can mess some part up
//===============================================


/** Range of Weapon, used for Traces (InstantFire, ProjectileFire, AdjustAim...) */
var() float	WeaponRange;

/** This value is used to cap the maximum amount of "automatic" adjustment that will be made to a shot
    so that it will travel at the crosshair.  If the angle between the barrel aim and the player aim is
    less than this angle, it will be adjusted to fire at the crosshair.  The value is in radians */
var float MaxFinalAimAdjustment;

//===============================================
//===============================================

simulated function PostBeginPlay()
{
   //	local float AnimRate;
   super.PostBeginPlay();
   //ArmBoneControl = UTSkelControl_TurretConstrained(mesh.FindSkelControl('HandControl'));
   ArmBoneControl = UTSkelControl_TurretConstrained(mesh.FindSkelControl(ArmNameControl1));
   if (ArmBoneControl != None){
       ArmBoneControl.AssociatedSeatIndex = 0;
   }
   //ArmBoneControl.bApplyRotation = true;
   //ArmBoneControl.bAddRotation = true;
   //ArmBoneControl.BoneRotationSpace = BCS_BoneSpace;//var Name

   ArmBoneControl2 = UTSkelControl_TurretConstrained(mesh.FindSkelControl(ArmNameControl2));
   if (ArmBoneControl2 != None){
       ArmBoneControl2.AssociatedSeatIndex = 0;
   }

   PlayAnim(ActionName);
   if (AnimPlay != none ){
   //Mesh.PlayAnim('Idle', 1, true, true);//working code for animation
   Mesh.PlayAnim('Idle', 1, false, false);//working code for animation
   }
   //`log("testing animeiosnt");
}




function AdjustArmAim(){
 local rotator adjustrot;
 super.AdjustArmAim();

 if(ArmBoneControl2 == None){
   //if there no skeleton control for this animtree use this
   ArmBoneControl.DesiredBoneRotation = UpDateArmControl(SocketName);
 }else{
   //if there is control for the second go here
   adjustrot = UpDateArmControl(SocketName);
   ArmBoneControl.DesiredBoneRotation.Yaw = adjustrot.Yaw;
   
   ArmBoneControl2.DesiredBoneRotation.Pitch = adjustrot.Pitch;
 }
}

function rotator UpDateArmControl(name SocketNameTag){
	local vector SocketLocation1, CameraLocation, DesiredAimPoint, HitLocation, HitRotation;
	local rotator CameraRotation, SocketRotation1, AimRotation;
	local PlayerController PC;
	local Controller C;
	if (MechVehicle != None){//make sure it has a vehicle
		C = MechVehicle.Controller;
		PC = PlayerController(C);
		if (PC != None){
			PC.GetPlayerViewPoint(CameraLocation, CameraRotation);
			DesiredAimPoint = CameraLocation + Vector(CameraRotation) * 10000;
			if (Trace(HitLocation, HitRotation, DesiredAimPoint, CameraLocation) != None){
				DesiredAimPoint = HitLocation;
			}
		}else if (C != None){
			DesiredAimPoint = C.GetFocalPoint();
		}
		
		if ( MechVehicle.Seats[0].GunSocket.Length>0 ){
			GetBarrelLocationAndRotation(SocketNameTag, SocketLocation1, SocketRotation1);
		}else{
			SocketLocation1 = Location;
			SocketRotation1 = Rotator(DesiredAimPoint - Location);
		}
		
		SocketLocation1 = GetElbowLocation();
		AimRotation = rotator(DesiredAimPoint - SocketLocation1);
	}else{
		AimRotation = Rotation;
	}
	return AimRotation;
}

simulated function Tick(float DeltaTime)
{
	super.Tick(DeltaTime);
	if(bWeaponPress){
		InitFireWeapon();
	}
}

function ToggleDisableWeapon(){
	local bool OldWeaponDisable;
	OldWeaponDisable = bWeaponDisable;
	if(OldWeaponDisable == true){
		bWeaponDisable = false;
	}else if(OldWeaponDisable == false){
		bWeaponDisable= true;
	}
	`log('bWeaponDisable' @ bWeaponDisable);
}

simulated function FireWeaponProjectile(){
	//Spawn(class'UTProj_LinkPlasma', Self, , Location + Vect(8, 2, 0), Rotation, ,);//working code but not set movement

	local UTProjectile SpawnedProjectile;
	//local vector RealStartLoc;

	if ((bWeaponFire == true)&&(bWeaponDisable == false)){
		if (WeaponProjectiles != None){
			//MechVehicle.Mesh.ForceSkelUpdate();
			//Mesh.ForceSkelUpdate();
			GetBarrelLocationAndRotation(SocketName,SocketLocation,SocketRotation);
			SpawnedProjectile = Spawn(WeaponProjectiles,MechVehicle,,SocketLocation);
			// this is the location where the projectile is spawned.
			//RealStartLoc = GetPhysicalFireStartLoc();
			//SpawnedProjectile = Spawn(WeaponProjectiles,,, RealStartLoc);
			if (SpawnedProjectile != none){
				SpawnedProjectile.Init(Vector(SocketRotation));
			}
		}
	}
}

//===============================================
//
//===============================================

//this is for the timer for animation control finish
function FireTime(){
 bWeaponFire = false;
 //`log("Fire Trigger Time");
}

function InitFireWeapon(){
	if(bWeaponFire == false){
                if (Mesh.Animations != None){
		//animation play goes here just need to build one to get it working
                Mesh.PlayAnim('fire', 1, false, false);
                }
                //PlayAnim (name AnimName, optional float Duration, optional bool bLoop, optional bool bRestartIfAlreadyPlaying)
                if(AnimPlay != None){
                //AnimPlay.SetAnim('fire');
                //  AnimPlay.PlayAnim(false,1, 0);
                //`log("PLay ANIMATION");
                }
		bWeaponFire=true;//this make sure the fire doesn't loop when firing time
		FireWeaponProjectile();
		SetTimer(FireRate, false, 'FireTime');
		//`log('FireRate ' $ FireRate);
	}
}

function BeginFire(){//key press function not a loop trigger
   super.BeginFire();
   bWeaponPress=true;
}

function EndFire(){ //key release function not a loop trigger
   super.EndFire();
   bWeaponPress=false;
}

simulated event GetBarrelLocationAndRotation(Name TagSocketName, out vector TagSocketLocation, optional out rotator TagSocketRotation)
{
       if ( Mesh.GetSocketByName(TagSocketName) != None)
	{
		Mesh.GetSocketWorldLocationAndRotation(TagSocketName, TagSocketLocation, TagSocketRotation);
	}else{
	    `log('no socket');
	    //if(MechVehicle != None){
            //   SocketLocation = MechVehicle.Location;
            //   SocketRotation = MechVehicle.Rotation;
	    //}else{
		SocketLocation = Location;
		SocketRotation = Rotation;
	    //}
	}
}


//===============================================
//
//===============================================

/**
 * Range of weapon
 * Used for Traces (CalcWeaponFire, InstantFire, ProjectileFire, AdjustAim...)
 * State scoped accessor function. Override in proper state
 *
 * @return	range of weapon, to be used mainly for traces.
 */

simulated event float GetTraceRange()
{
	return WeaponRange;
}

simulated function float GetMaxFinalAimAdjustment()
{
	return MaxFinalAimAdjustment;
}

/**
 * This code deal with look for the bone location for return vector 
 * since we create a skelelton mesh class
*/
function vector GetBoneLocation(Name BoneName)
{	
	local vector boneposition;
	//if there is a skeleton mesh
	if (Mesh != None){
		//find bone location
		boneposition = Mesh.GetBoneLocation(BoneName);
	}
	return boneposition;
}

function rotator GetBoneRotation(Name BoneName)
{	
	local rotator bonerotation;
	//if there is a skeleton mesh
	if (Mesh != None){
		//find bone location
		//bonerotation = Mesh.GetBoneAxis(BoneName,3);
	}
	return bonerotation;
}

function vector GetElbowLocation(){
   return GetBoneLocation(ElbowBoneName);
}

//===============================================
//
//===============================================

defaultproperties
{
    //skeleton control for animtree
    //Yaw  //default all rotation
    ArmNameControl1=HandControl
    //Pitch
    ArmNameControl2=HandControl2
    
    ActionName=Idle

    weapondirection=(x=1,y=0,z=0)
    bWeaponPress=false
    bWeaponFire=false
    FireRate=1.0
    WeaponProjectiles=class'UTProj_LinkPlasma'
    SocketName=FlashPointSocket01
    BInternalWeapon=false
//===============================================
    //unreal settings
    WeaponRange=16384
    // ~ 5 Degrees
    MaxFinalAimAdjustment=0.995;
//===============================================

}