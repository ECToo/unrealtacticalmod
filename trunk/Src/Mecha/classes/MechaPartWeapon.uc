/**
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt
 */

 /*
 * Information: This code will deal with custom build fire and drop able and pickup weapon.
 * THis will deal with override fire a bit to deal with indepent part that can fire.
 TO DO LIST:
 check if fire control or animation control for firing
 */

class MechaPartWeapon extends MechaPart;

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

//===============================================
// Unreal settings Start
//===============================================

/** Range of Weapon, used for Traces (InstantFire, ProjectileFire, AdjustAim...) */
var()			float	WeaponRange;

/** This value is used to cap the maximum amount of "automatic" adjustment that will be made to a shot
    so that it will travel at the crosshair.  If the angle between the barrel aim and the player aim is
    less than this angle, it will be adjusted to fire at the crosshair.  The value is in radians */
var float MaxFinalAimAdjustment;

/** When true, this weapon is locked on target */
var bool 				bLockedOnTarget;

/** What "target" is this weapon locked on to */
var Actor 				LockedTarget;

var PlayerReplicationInfo LockedTargetPRI;

/** What "target" is current pending to be locked on to */
var Actor				PendingLockedTarget;

/** How long since the Lock Target has been valid */
var float  				LastLockedOnTime;

/** When did the pending Target become valid */
var float				PendingLockedTargetTime;

/** When was the last time we had a valid target */
var float				LastValidTargetTime;

/** angle for locking for lock targets */
var float 				LockAim;

/** angle for locking for lock targets when on Console */
var float 				ConsoleLockAim;



//var SkelControlSingleBone ArmBoneControl; //default for basic test
var UTSkelControl_TurretConstrained ArmBoneControl;
var name ArmNameControl1;

//var SkelControlSingleBone ArmBoneControl; //default for basic test
var UTSkelControl_TurretConstrained ArmBoneControl2;
var name ArmNameControl2;



//===============================================
//unreal settings End
//===============================================

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
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
                                //check if actor is not none and projectile type is a seeker
				if ((TargetActor != None)&&(UTProj_SeekingRocket(SpawnedProjectile) != None)){
				      `log("TargetActor:" @ TargetActor.Name);
				      UTProj_SeekingRocket(SpawnedProjectile).SeekTarget = TargetActor;
                                      `log("locked on!");
				}
				//AttachMuzzleFlash();
				CauseMuzzleFlash();
				CauseMuzzleFlashLight();
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

//===============================================
//
//===============================================

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

simulated function vector GetPhysicalFireStartLoc(optional vector AimDir)
{
	local UTPlayerController PC;
	local vector FireStartLoc, HitLocation, HitNormal, FireDir, FireEnd, ProjBox;
	local Actor HitActor;
	local rotator FireRot;
	local class<Projectile> FiredProjectileClass;
	local int TraceFlags;

	if( Instigator != none )
	{
		PC = UTPlayerController(Instigator.Controller);

		FireRot = Instigator.GetViewRotation();
		FireDir = vector(FireRot);
		if (PC == none || PC.bCenteredWeaponFire || PC.WeaponHand == HAND_Centered || PC.WeaponHand == HAND_Hidden)
		{
			FireStartLoc = Instigator.GetPawnViewLocation() + (FireDir * FireOffset.X);
		}
		else if (PC.WeaponHand == HAND_Left)
		{
			FireStartLoc = Instigator.GetPawnViewLocation() + ((FireOffset * vect(1,-1,1)) >> FireRot);
		}
		else
		{
			FireStartLoc = Instigator.GetPawnViewLocation() + (FireOffset >> FireRot);
		}

		if ( (PC != None) || (CustomTimeDilation < 1.0) )
		{
			//FiredProjectileClass = GetProjectileClass();
			FiredProjectileClass = WeaponProjectiles;
			if ( FiredProjectileClass != None )
			{
				FireEnd = FireStartLoc + FireDir * ProjectileSpawnOffset;
				TraceFlags = bCollideComplex ? TRACEFLAG_Bullet : 0;
				if ( FiredProjectileClass.default.CylinderComponent.CollisionRadius > 0 )
				{
					FireEnd += FireDir * FiredProjectileClass.default.CylinderComponent.Translation.X;
					ProjBox = FiredProjectileClass.default.CylinderComponent.CollisionRadius * vect(1,1,0);
					ProjBox.Z = FiredProjectileClass.default.CylinderComponent.CollisionHeight;
					HitActor = Trace(HitLocation, HitNormal, FireEnd, Instigator.Location, true, ProjBox,,TraceFlags);
					if ( HitActor == None )
					{
						HitActor = Trace(HitLocation, HitNormal, FireEnd, FireStartLoc, true, ProjBox,,TraceFlags);
					}
					else
					{
						FireStartLoc = Instigator.Location - FireDir*FiredProjectileClass.default.CylinderComponent.Translation.X;
						FireStartLoc.Z = FireStartLoc.Z + FMin(Instigator.EyeHeight, Instigator.CylinderComponent.CollisionHeight - FiredProjectileClass.default.CylinderComponent.CollisionHeight - 1.0);
						return FireStartLoc;
					}
				}
				else
				{
					HitActor = Trace(HitLocation, HitNormal, FireEnd, FireStartLoc, true, vect(0,0,0),,TraceFlags);
				}
				return (HitActor == None) ? FireEnd : HitLocation - 3*FireDir;
			}
		}
		return FireStartLoc;
	}

	return Location;
}


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

defaultproperties
{
    //skeleton control for animtree
    //Yaw  //default all rotation
    ArmNameControl1=HandControl
    //Pitch
    ArmNameControl2=HandControl2


    SocketName=FlashPointSocket01   
    //x= -(back surface)/+(front surface)
    //y= -(left side surface)/+(right side surface)
    //z= -(down to the ground)/+(up world sky)
    weapondirection=(x=1,y=0,z=0)
    bWeaponPress=false
    bWeaponFire=false
    FireRate=1.0

    WeaponRange=16384
    // ~ 5 Degrees
    MaxFinalAimAdjustment=0.995;
}