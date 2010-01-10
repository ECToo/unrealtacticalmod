/**
 * Created by: Darknet
 * Link src:http://unrealtacticalmod.googlecode.com/svn/trunk/Src/MechProtypeWalker/classes/
 * license:  -> Check readme.txt

   Information: This code handle the skeleton control for animtree by using UTVehicle functions.
*/

class MechaPartArm extends MechaPart;

var SkelControlSingleBone ArmBoneControl;


simulated function PostBeginPlay()
{
   super.PostBeginPlay();
   ArmBoneControl = SkelControlSingleBone(mesh.FindSkelControl('HandControl'));
   ArmBoneControl.bApplyRotation = true;
   ArmBoneControl.bAddRotation = true;
   ArmBoneControl.BoneRotationSpace = BCS_BoneSpace;//var Name
}

defaultproperties
{


}