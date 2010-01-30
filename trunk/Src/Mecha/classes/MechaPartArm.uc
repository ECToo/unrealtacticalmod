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

simulated function PostBeginPlay()
{
   super.PostBeginPlay();
   ArmBoneControl = UTSkelControl_TurretConstrained(mesh.FindSkelControl('HandControl'));
   ArmBoneControl.AssociatedSeatIndex = 0;
   //ArmBoneControl.bApplyRotation = true;
   //ArmBoneControl.bAddRotation = true;
   //ArmBoneControl.BoneRotationSpace = BCS_BoneSpace;//var Name
}

defaultproperties
{


}