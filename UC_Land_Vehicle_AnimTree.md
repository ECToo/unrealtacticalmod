[Main\_Tutorial\_Lessons](Main_Tutorial_Lessons.md)

[UC\_Land\_Vehicle\_AnimSet](UC_Land_Vehicle_AnimSet.md) [UC\_Land\_Vehicle\_PhysicsAsset](UC_Land_Vehicle_PhysicsAsset.md)

[Main\_Tutorial\_Lessons](Main_Tutorial_Lessons.md)
# Information #
To get your vehicle working you need wheel control and suspence wheel. Those are need to update each wheel. wheel without them the wheel would not move or act funny way that I test it out.

# Assign SekMesh #
If you import your vehicle follow this step. Create your animtree with the default name of the prefix name for clean build. Once you create your animtree open it. Then select your mesh that you import for your vehicle. Select your AnimTree and go into AnimTree proporties.   Assign the mesh in PreviewSekMesh.

# Assign AnimTree Bone #
Next part assigning your bones. You will only see Animation and Morph that where we add out bones.

Right click on the AnimTree.

Add SkelControl Chain > Add the follow bones listed:
  * Lt\_Front\_Suspension
  * Lt\_Front\_Tire
  * Rt\_Front\_Suspension
  * Rt\_Front\_Tire
  * Rt\_Rear\_Suspension
  * Rt\_Rear\_Tire
  * Lt\_Rear\_Suspension
  * Lt\_Rear\_Tire

# Wheel Control #
Right Next Beside your AnimaTree we will add some function to the car to make wheel spin, turn and have some suspension.

Right Click and go down and look for SkelControlWheel and SkelControlLookAt. Add them in the area.

In SkelControlWheel proporties Change:
  * WheelRollAxis to AXIS\_Y
  * WheelSteerAxis to AXIS\_Z

ControlName:
ControlName -> Lt\_Front\_Control (This will be in unreal script to look for the Bone and control from there)

Once you made some changes for the CheelControl.

Select your SkelControlWheel then "CTRL + W" to make 3 more copy of the WheelControl.
  * ControlName -> RT\_Front\_Control
  * ControlName -> Lt\_Rear\_Control
  * ControlName -> Rt\_Rear\_Control
Once your name them. Connect the wheel to the Tire. Drag the Input to the Respect Tire name to the AnimTree.

# SkelControlLookAt For Suspension #
Next part change some proporties.

TargetLocationSpace -> BCS\_OtherBoneSpace
  * LookAtAxis -> AXIS\_Z
  * UpAxis -> AXIS\_Z
Same thing here for the naming it:
  * TargetSpaceBoneName -> Lt\_Front\_ShockAim
  * TargetSpaceBoneName -> Rt\_Front\_ShockAim
  * TargetSpaceBoneName -> Lt\_Rear\_ShockAim
  * TargetSpaceBoneName -> Rt\_Rear\_ShockAim

Those are the wheel function that make the wheel move and adjust to the Suspension. If you want to learn how I did this look into the Hellbeander AnimTree.

[UC\_Land\_Vehicle\_AnimSet](UC_Land_Vehicle_AnimSet.md) [UC\_Land\_Vehicle\_PhysicsAsset](UC_Land_Vehicle_PhysicsAsset.md)