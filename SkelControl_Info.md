# Introduction #
> I will keep the information simple as I can be. It took a while to get the code working for once. Although it quite straight forward. For noob in coding it quite easy a bit.

> For couple of things needed to to do is to place a skeleton mesh in the map editor. Then tell it to rotate one part of the bone. That is the simple explain for this part.

> To create this simple rotate from the skeleton bone. We need to do is to create a class for this. But this will be explain how the code works. The full code will be shown.

```
class SkeletonFrame extends Actor
	placeable;
```

This is quite simple that first part of the code. Next we next to create a variables for this class.

```
var SkeletalMeshComponent mesh;// skeleton mesh
var SkelControlSingleBone BoneTurnControl;//This is the animtree SkelControlSingleBone
var rotator setrotate; //we use a counter to rotate it
var float size; // this will deal with bone scale with counter //note I comment it out for testing the rotation.
```

# SkelControlSingleBone Class: #
> You have two options to make the settings works. One you can do AnimTree or Unreal Script just for settings. But remember you need to set up the name of the animtree skelcontrol to match unreal script that you created. It either it will crash or error on none found.

```
BoneTurnControl = SkelControlSingleBone(mesh.FindSkelControl('PointYaw')); //this will look for animtree name PointYaw skelcontrol

```

![http://unrealtacticalmod.googlecode.com/svn/trunk/image/animtree_skelcontrolsinglebone_pawnpoint.jpg](http://unrealtacticalmod.googlecode.com/svn/trunk/image/animtree_skelcontrolsinglebone_pawnpoint.jpg)

# SkelControlSingleBone Comparing #

![http://unrealtacticalmod.googlecode.com/svn/trunk/image/animtree_skelcontrolsinglebone_pawnpoint_prop.jpg](http://unrealtacticalmod.googlecode.com/svn/trunk/image/animtree_skelcontrolsinglebone_pawnpoint_prop.jpg)

```
//those are the setting to able to rotate the bone
BoneTurnControl.bApplyRotation = true;
BoneTurnControl.bAddRotation = true;
BoneTurnControl.BoneRotationSpace = BCS_BoneSpace;//var Name

BoneTurnControl.BoneRotation = setrotate;//this set and get bone rotation
```
> For noob and pro just use the setting for animtree skelcontrol. That it is quite simple to work with. But it up to you how you want to build it.

**Note this will over ride your current setting from AnimTree if code all the setting in unreal script.**

# SkeletonFrame.uc #
```
/**
  Animtree: There is some basic config that is just the controller name.

 [SkelControlSingleBone]

  Adjustments
  Apply Rotation > [check]

  Rotation
  Add Rotation > [check]
  Bone Rotation Space > [bcs_bonespace]
  
  Note you can as well code it too. Just few you need to name the skelcontrol for it.
  Here the sample of the code.

*/

class SkeletonFrame extends Actor
	placeable;

var SkeletalMeshComponent mesh;
var SkelControlSingleBone BoneTurnControl;
var rotator setrotate;
var float size;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
}

simulated event Tick( float DeltaTime )
{
	super.Tick(DeltaTime);

	setrotate.Yaw += 100;
	if(setrotate.Yaw > 18000){
		setrotate.Yaw = 0;
	}

	size += 0.01f;
	if(size > 1){
		size = 0;
	}
	BoneTurnControl = SkelControlSingleBone(mesh.FindSkelControl('PointYaw'));
	//those are the setting to able to rotate the bone
	BoneTurnControl.bApplyRotation = true;
	BoneTurnControl.bAddRotation = true;
	BoneTurnControl.BoneRotationSpace = BCS_BoneSpace;//var Name

	BoneTurnControl.BoneRotation = setrotate;

	//Scale 0 to 1 //
	//BoneTurnControl.BoneScale = size; //scale works
}

defaultproperties
{

 Begin Object Class=SkeletalMeshComponent Name=MeshFrame
      SkeletalMesh=SkeletalMesh'UTMTest.PawnPoint'
      PhysicsAsset=PhysicsAsset'UTMTest.PawnPoint_Physics'
      AnimTreeTemplate=AnimTree'UTMTest.PointPawn_animtree'
 End Object
 CollisionComponent=MeshFrame
 mesh=MeshFrame
 Components.Add(MeshFrame)
}
```

# Tips #
  * Use unreal wiki pages that found in search engine.
  * Double check your work that it some time miss something from AnimTree skeleton control settings.