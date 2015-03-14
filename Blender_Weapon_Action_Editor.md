[Prev](Blender_Weapon_Model_1P.md) [Next](Blender_Weapon_Model_3P.md)


# Armature Bone Vs. Bone Pose #
There the current export will tranlate the bone rotation to rotation for animation.

# Blender Action Editor #
This is where all your weapon animation is render in Action Editor(Blender) to Animatin Set(Unreal Edditor). Please not not Bake your Action in Action Editor that it is already in there when your exporting to blender script format default. You will have the same copy of your action.

EAXMPLE:

```
Blender:
Action Editor:
Action
Action.BAKED
I do not know how to delete your action yet if you made your mistake.

Unreal Editor:
AnimSet:
Action[]
Action.BAKED[]
You can delete your action in unreal under animset.
You can reset them but it will delete all your animation.
```

# Action Editor Name #
The name of the weapon will have to right name when input.
```
WeaponAltFire
WeaponEquip
WeaponFire
WeaponFireInstiGib
WeaponIdle
WeaponPutDown
```
Will start simple animation just a couple before doing all the action before getting error in game.

# SVN: #
This weapon is in First Person (1P) Model with Armature Bone: http://unrealtacticalmod.googlecode.com/svn/trunk/Blender/custom_weapon_gun/custom_weapon_gun_1P.blend

This weapon is for First Person (1P) View With Animation: http://unrealtacticalmod.googlecode.com/svn/trunk/Blender/custom_weapon_gun/custom_weapon_gun_1P_animset.blend

# How To Delete Your Actions #
http://blenderartists.org/forum/showpost.php?p=647216&postcount=1

# Action Editor #
Refer to Note below. They are out date. Build every key frame. Just the basic setup. In unreal just use normal armature. Do not add a modifier that it will not work. Just learn how to setup the bone marker for the key frame every time to set in the time line.
  * http://en.wikibooks.org/wiki/Blender_3D:_Noob_to_Pro/Advanced_Tutorials/Advanced_Animation/Guided_tour/Armature/pose
  * http://wiki.blender.org/index.php/Manual/The_Action_Editor
  * http://blenderartists.org/forum/showthread.php?t=73723
  * http://www.blender.org/development/release-logs/blender-240/action-and-nla-editor/
  * http://en.wikibooks.org/wiki/Blender_3D:_Noob_to_Pro/Advanced_Tutorials/Advanced_Animation/Guided_tour/NLA/index
  * http://en.wikibooks.org/wiki/Blender_3D:_Noob_to_Pro/Advanced_Tutorials/Advanced_Animation/Guided_tour/NLA/intro
  * http://www.telusplanet.net/public/kugyelka/blender/tutorials/stride/stride.html

[Prev](Blender_Weapon_Model_1P.md) [Next](Blender_Weapon_Model_3P.md)