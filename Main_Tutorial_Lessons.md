**Note: On Going work being done to rework my wiki page a bit to sort out the cleaner version of my wiki pages. As well my mod builds.**

**UT3 and UDK has made some changes upon their beta release.**
**This wiki may be out date.**

# Introduction #
It will be hard to tell you if you don't read or do lesson about Blender. Please do not rush when your learning blender. It is base on blender term language for blender interface. This section will give you the basic information about making game mod still working some area for a bit to update this section of the wiki page. Each part of this section is where I am currently working on. Some of the information can be missing working hard to debug my script to be free of error. Updating the wiki page will take time to complete.

There are example files in the svn that you can use to test out your current blender files if your files are working right.
http://unrealtacticalmod.googlecode.com/svn/trunk/Blender/

Those who are new at blender you can look into this link:
  * http://en.wikibooks.org/wiki/Blender_3D:_Noob_to_Pro
  * http://en.wikibooks.org/wiki/Blender_3D:_Noob_to_Pro/Beginner_Tutorials/Print_version
  * -Look up Armature those are for bone if you want animatoin.

# Blender Version #
You have get Blender 2.45 the current or newer version of Blender.

Here Blender Video:
http://www.blender.org/education-help/video-tutorials/

# Blender Bone Format For Unreal #
To make unreal bones work in blender you need to look in the svn files that follow the format. Just use unreal format bones to make it clean and free of bugs. To get unreal format do not connect the bones. Parent them by linking the bone to the parent name.

It depend what type bone builds to export to unreal. It is your chose to create your own bones or use unreal format bone. Test out a simple animation to make sure the animation is working correctly. Create one Armature bone for the unreal to work.

## Export Script for blender Information: ##
[Blender\_Export\_PS\_A\_K\_Version](Blender_Export_PS_A_K_Version.md)

## Blender to Unreal Unit Size ##
(Blender) 1:1 (Unreal)

[Video Demos/Video Lessons](Video_Tutorial_Lesson.md)

## Blender Export: ##
  * [Blender\_Export\_PSK](Blender_Export_PSK.md) -Skeleton Mesh -(Download Tab)
  * [Blender\_Export\_PSA](Blender_Export_PSA.md) -AnimSet(Unreal) = Action Editor(Blender) -(Download Tab)
  * [Blender\_Export\_ASE](Blender_Export_ASE.md) -Static Mesh
  * [Blender\_Export\_DAE](Blender_Export_DAE.md) -Static Mesh/Skeleton Mesh/Animation Set (OUT DATE VERSION 1.4.0)

## Vehicle Build: ##
http://www.youtube.com/watch?v=-QtpNjMMssY -Hellbender Mod (vehicle)

[Blender\_Vehicle\_Design](Blender_Vehicle_Design.md) -READ ME FOR VEHICLE DESIGN AND HOW THINGS ARE SETUP.

### Land Vehicle: ###
[Blender\_Land\_Vehicle\_Modeling](Blender_Land_Vehicle_Modeling.md) - Blender Modeling Idea Work Out first.

[Blender\_Land\_Vehicle\_UV](Blender_Land_Vehicle_UV.md) - working with UV textures from blender

[.md](.md) - Working with textures with Blender.

[.md](.md) - Working with animation from blender.

[Blender\_Land\_Vehicle\_Export](Blender_Land_Vehicle_Export.md) - Exporting to files to unreal format.

[UC\_Land\_Vehicle\_SkeletalMesh](UC_Land_Vehicle_SkeletalMesh.md) - Importing Skeletal Mesh

[UC\_Land\_Vehicle\_AnimSet](UC_Land_Vehicle_AnimSet.md) - Creating animation.

[UC\_Land\_Vehicle\_AnimTree](UC_Land_Vehicle_AnimTree.md) - This Control your vehicle does.And other things.
  * MorphTargetSet
  * AnimSet
  * Setup Code For Unreal Setup For Bone.

[UC\_Land\_Vehicle\_PhysicsAsset](UC_Land_Vehicle_PhysicsAsset.md) -

[UC\_Land\_Vehicle\_PhysicalMaterial](UC_Land_Vehicle_PhysicalMaterial.md) -

[UC\_Land\_Vehicle\_MorphTargetSet](UC_Land_Vehicle_MorphTargetSet.md) - This is where the vehicle are damage.

[UC\_Land\_Vehicle\_UnrealScript](UC_Land_Vehicle_UnrealScript.md) - Three Files. No weapon yet.

## Weapon Build ##
### Shockrifle Mod ###
This weapon will be base of Shockrifle. The rotation of the weapon is effect by unreal script that is code in.

  * http://www.youtube.com/watch?v=E7ZrVDUFtrI -ShockRifle Mod No Animation (weapon)
  * http://www.youtube.com/watch?v=R9GPHxqZbGE -ShockRifle Mod With Animatoin (weapon)
[Blender\_Weapon\_Model](Blender_Weapon_Model.md) -Read before you do your Action Editor(Blender) to Animation Set(Unreal)).

[Blender\_Weapon\_UV](Blender_Weapon_UV.md) - UV Layout Texture

Video Lesson Model\_1P:

[Blender\_Weapon\_Model\_1P](Blender_Weapon_Model_1P.md) - Working on the First Person (1P)View Weapon with action.

[Blender\_Weapon\_Action\_Editor](Blender_Weapon_Action_Editor.md) - Create a one set of animation.

[Blender\_Weapon\_Model\_3P](Blender_Weapon_Model_3P.md) - Simple Third Person (3P) View holding the mod weapon.

[Blender\_Weapon\_Export](Blender_Weapon_Export.md) - Read Before it save you time.

Video Lesson Model\_1P:

[Unreal\_Weapon\_SkeletalMesh](Unreal_Weapon_SkeletalMesh.md) - Socket Manager And Importing Your Model.

[Unreal\_Weapon\_AnimSet](Unreal_Weapon_AnimSet.md) - Animation Set.

[Unreal\_Weapon\_Script](Unreal_Weapon_Script.md) - Unreal Script. Three simple File.

## Character Build ##
(On Hold Can't find any format for the bones or how to create for blender.)

# [TroubleShooting](TroubleShooting.md) #

# Simple Tips #
  * http://wiki.blender.org/index.php/Manual/Undo_and_Redo
  * http://wiki.beyondunreal.com/wiki/New_UnrealScript_In_UT3