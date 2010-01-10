/**
This code handle the skeleton control for animtree by using the class to over ride or replace it.
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