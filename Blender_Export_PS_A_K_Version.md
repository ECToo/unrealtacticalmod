# Information: #
I am currently making vehicles, weapons and other mods to make good game.

# Working Area #
  * Character builds for male, female, and the krall.(On Hold)
  * Work on Animation Selected Export(Not yet work on).

# Features: #
  * This script can covert mesh into triangular mesh when exporting to unreal.
  * When the export is finish it will execute pop up that it has done exporting.
  * Mesh and Bone information display basic information.
  * When script is execute it will show how long the script was execute time.
  * More than one Materials are working. (Assign Materials in Blender)

# Game Support: #
  * UT3 -Working
  * UT2004 -It does work but there an error in bone!=index. I have not yet fully tested out the vehicles class.
  * UTXXXX -Unknown

### Errors ###
  * Unreal Editor crash while importing your psk, check your bone weights(skin weight, paint weight) to be sure it use all your vertex point for that bone.

### Solve ###
  * Manta vehicle class may not work becuase of bone index error. NOTE: I am not sure if it the binary format, the way the export scripted, and the unreal script.
  * It seem the code error on the preview for bone!=index error show up again.(Not working for Manta class)
  * Error found some reason I tested out the bone index output and it given me zero for each bone is outputed.
  * Animation work needs to fix the off set in unreal.
  * Different bone rotation when armature is build with animation will not work. Same bone rotation when the armature is build will work for that type of bone rotation and the animation works.
  * There is error and for the bone offset when trying to make a custom skeleton mesh. That I am not too sure just did a quick test.
  * Bone position set type is now this one ARMATURESPACE not BONESPACE It might change later.
  * Animation Fix Rotation it was on the make\_fquat() function rotate in other direction
  * Just the main bone is difficult to fix a bit and trying to learn how are the export work in order of the bone and the parent index bone for unreal.
  * I know there are some error like offset bone are not fix yet and working out the main bone that crash when I try to work on it. It takes long hours to understand the code bit by bit until I can find a stable code output that will not crash me or other who wants to use free blender.
  * Bone position will be fix some how and working out the script error before I can begin animatoin set.
  * Animation needs work. Last thing on the list. I am trying to deal with the correct way. Rotation and position and transform. And working with simple code need some understanding.
  * Bone position is not fix to bone rotation.
  * Main Bone Fixed
  * Working with inheriting the bone from parent to child. For rotation and position. Branch is need to some understanding of it.
  * Armature bone and Pose bone need to be solve that has it own independent rotation.
  * Seem the animation weapon seem so what work and playable in the game. Just the rotation is bit off for some reason still looking into that later.
  * Main bones are issues to assign and fix the position when off grid to make weapon for first person view.
  * Bone position found error not off blender offset of the main. It only center the origin point need to be fix it.
  * Animation Rotation Need Work on! No Error Detect so far.
  * Note that pose bone have one frame to test out the different when testing rotation.
  * Main Bone Issues Need to be Fix First