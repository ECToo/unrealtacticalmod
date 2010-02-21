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

//var SkelControlSingleBone ArmBoneControl; //default for basic test
var UTSkelControl_TurretConstrained ArmBoneControl;

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
var()			float	WeaponRange;

/** This value is used to cap the maximum amount of "automatic" adjustment that will be made to a shot
    so that it will travel at the crosshair.  If the angle between the barrel aim and the player aim is
    less than this angle, it will be adjusted to fire at the crosshair.  The value is in radians */
var float MaxFinalAimAdjustment;

//===============================================
//===============================================

simulated function PostBeginPlay()
{
   super.PostBeginPlay();
   ArmBoneControl = UTSkelControl_TurretConstrained(mesh.FindSkelControl('HandControl'));
   ArmBoneControl.AssociatedSeatIndex = 0;
   //ArmBoneControl.bApplyRotation = true;
   //ArmBoneControl.bAddRotation = true;
   //ArmBoneControl.BoneRotationSpace = BCS_BoneSpace;//var Name
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

simulated event GetBarrelLocationAndRotation(Name SocketName, out vector SocketLocation, optional out rotator SocketRotation)
{
	//if (SocketName != None)
	//{
		Mesh.GetSocketWorldLocationAndRotation(SocketName, SocketLocation, SocketRotation);
	//}
	//else
	//{
		//SocketLocation = Location;
		//SocketRotation = Rotation;
	//}
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





//===============================================
    //unreal settings
    WeaponRange=16384
    // ~ 5 Degrees
    MaxFinalAimAdjustment=0.995;
//===============================================

}