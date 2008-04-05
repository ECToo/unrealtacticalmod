#==============================================================================
# README FIRST FOR YOUR FILES MIGHT NOT WORK OR IT CRASH ON YOU IN UNREAL AND THE GAME.
#==============================================================================

-Required Blender 2.45

#==============================================================================
# Features:
#==============================================================================
-When export:
 -It will convert your mesh into Triangular Mesh
 -How much time the script has been execute
 -Tell you about the basic mesh and bone information.
 -It will pop up when finish export.
 -It will show actions output when animation is detected.

#==============================================================================
# Building Skeleton Mesh:
#==============================================================================
-Required One Mesh
-Required One Armature
--Required one main bone to branch off from.
-The Mesh and Armature must center the pivot point together else you will get some offset when the animation is export.

There should be one mesh and one armature object else will cause an error. There is no selecting option yet scripted.

The mesh should be place first and the armature must second to parent the object. 

Then (Ctrl + p) to parent the objects. Armature > Create From Closest Bones

All vertex points weights must be use up for the bones that is assign to else it will crash on you. Meaning all your vertex point use for the bone is assigned to.

You need to convert to triangles (Ctrl + t) -should be in vertex view “Edit Mode“) when your done.

- To make it work for psa you must add the bones in the Unreal Editor from AnimSet under 

#==============================================================================
# Building Animation Set:
#==============================================================================
-Do not bake them that it will export your animation set from your Action Editor.
-UseTranslationBoneNames. Add bones from Animset. If it doesn't update.

-Action Editor :( blender)
Action:WeaponFire
Action: WeaponAltFire

-Animation set :( Unreal)
WeaponFire[]
WeaponAltFire[]

#==============================================================================
# Materials
#==============================================================================
-If you want more then one material. Select your mesh and go into Edit mode and select in face mode not vertex mode.
Select your face to assign the material. Look under vertex groups there a "<0 Mat 0 >". That your material. under the name call "Mat". To assign the material, go where mat and go down and press "Assign" with the big button showing. Hover over the "Assign" button that say "In EditMode, assigns the active index to selected faces".

-Material (1 Material)
 -Texture
  -Image File
-Material (2 Material)
 -Texture
  -Image File

Links:
http://en.wikibooks.org/wiki/Blender_3D:_Noob_to_Pro/Quickie_Material

#==============================================================================
# MOD_Opti_PSK_Dump.py Changes Logs
#==============================================================================
- I double check my work that took long to fix any problem that many come.
- This will work on UT3 and it is a stable version that works with vehicle for testing. 
- Main Bone fixes no dummy needed to be there. Some part of the area may not work when main bone did not detect.
- Fix the bone offset position as head bone that connect to it.
- There are two points which is the head and tail.
- Note I add on to the notes a bit and comments out the other ones that are not need in here.
- Did not work with psk export yet.

- v0.0.3
- Main Bone fixes no dummy needed to be there. Some part of the area may not work when main bone did not detect.
- Fix the bone offset position as head bone that connect to it.
- There are two points which is the head and tail are little different other software programs.
- Note I add on to the notes a bit and comments out the other ones that are not need in here.
- Did not work with psa export yet.

- v0.0.4
- This is an update to fix the bone pose issues position in psa that is off set to the tail and not to the head. That is now fixed to the head.
- To make it work for psa you must add the bones in the Unreal Editor from AnimSet under UseTranslationBoneNames.

- v0.0.5
- Fixed bone offset from head bone that was position off a bit. Part of it needs the tail to fix the rotation.

- v0.0.6
- There was error in make_fquat that the rotation went on the -x,-y-x change to x, y, x with out going to the other way.
- There was a problem with the animation set with blender action editor.
- Trouble shooting while weapon test animation was found.

- v0.0.61 Beta
- This is a test I revert back to the tail part still need to work on the head. Clean build a bit.
- Animation Work here. The rotation are little tricky to deal with.

- v0.0.7
- This update fixes the bone position that was offset by head and tail.
- This will inherit the bone parent to the child to translate the position.

- v0.0.8
- The bone position is party working. Just keep the bone length the same.
- This will inherit the bone parent to the child to translate the position.

- v0.0.9
- Bone position little bit stable when character is test for bone position. 
- Bone off set needs work.

- v0.0.10
- The armature bone position, rotation, and the offset of the bone are fixing. It was to deal with skeleton mesh export for psk.
- Animation is fixing for position, offset, rotation bone. Animation export is working for psa.

- v0.0.11
- It will convert your mesh into triangular when exporting to psk file.

- v0.0.12
- Error in the rotation and position offset from mesh and armature object is fixed.

- v0.0.13
- The animatoin will support different bone rotations when export the animation.

#==============================================================================
# Trouble shooting:
#==============================================================================
Point count: must equal to influence count else it will crash.
Influence count: must equal to point count else it will crash.

I see my object flashing how I fix this?
Update your animtree, animset, etc if you reimport your mesh again to fix some error doesn't update your other mesh some time. Check your log when you’re in game test.
#==============================================================================
# Credits Pythons scripts:
#==============================================================================
#==============================================================================
# Opti_PSK_Dump.py
#==============================================================================
-This work all the wired frame work but the vehicle base does not work.
-This has not built a weight yet in main root bone.
-animation not fixed for the new version for 2.45
-Extra bone adds to the main root.

Main source code for exporter psk/psa:
http://www.p-fat.net/

Blender Python Scripts for PSK/PSA export
These are a couple of hacked together scripts that Bob (active_trash) and I worked on to allow Blender to export the files that Unreal Tournament 2004 requires for Skeletal Meshes (PSK) and Animations (PSA). These are pretty hacked together betas, not cleaned up at all, and use at your own risk. They work for the couple of meshes, skeletons, and animations I've tested with so far, but they haven't been that heavy or complex.

Caveats:

    * You MUST convert all quads to triangles before running these scripts. The scripts require 3 vertexes per face ONLY.
    * You must not SCALE your armature. Scaling the armature after it has been linked to your mesh with parenting will also scale the mesh, but we did not account for this in the script.
    * Multiple Materials aren't supported yet (but should be easy to add when I get around to it)
    * There may be some other stuff we forgot to account for, don’t complain if it doesn't work!
    * Modify and add features to this script as you will, if you can make it better, or add features we've left out, by all means do so, just please, email me a copy!

#==============================================================================
# export_cal3d.py
#==============================================================================
-Help with the armature offset for bone.
-learning from the old and the new version of the script base off it.

Links:
-http://home.gna.org/oomadness/en/soya3d/index.html
-https://gna.org/projects/cal3d/
-http://sourceforge.net/projects/cal3d/

#==============================================================================
# blender2md5.py
#==============================================================================
-Help with the pose translation for the animation format.

Links:
-http://www.doom3world.org

#==============================================================================
# Credits:
#==============================================================================
UT3 Forums:
http://utforums.epicgames.com/forumdisplay.php?f=20

Blender
http://www.blender.org
http://en.wikibooks.org/wiki/Blender_3D:_Blending_Into_Python/Cookbook#Triangulate_NMesh

Blender Artist Forums:
http://blenderartists.org/forum

#==============================================================================
# Copy Rights:
#==============================================================================
Links:http://udn.epicgames.com/Two/BinaryFormatSpecifications.html

Animation file data structures 
Copyright 1997-2003 Epic Games, Inc. All Rights Reserved.

Unreal Vertex Animation data structure details
Copyright 1997-2003 Epic Games, Inc. All Rights Reserved.
