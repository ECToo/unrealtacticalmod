[HOME](Main_Tutorial_Lessons.md) [Next](Blender_Weapon_Model_1P.md)
# Plan before Modeling #
When you’re designing your weapon you need know before you model your weapon. There are two weapons design one is first person (1P) view where the entire moveable parts where lot of bones are moving. For the third person (3P) view there are no moving parts just the simple animation for weapon fire and other weapon state. Some time there is no animation or not at all in 3P unless showing something realist.  Some weapons are crop in first person view to reduce polygons that you don’t see the whole weapon.

We will be using shook rifle. The simplest one to mod off form shockrilfe weapon firing.

When you are building your mesh object, you have to merge your mesh into one single mesh object. So the export will read one mesh object. When you are modeling your mesh there are two directions that you have to face your weapon fire. More detail later on. When you are exporting two weapons for 1P and 3P. Base on what weapon you mod from on the direction are facing. The mesh object must face that direction or it depends on unreal script.

# Armature Bones For 1P and 3P #
Just read this information about the armature bones, so don't add your armature yet that will be in create a copy for 1P (1st Person View) and 3P (3rd Person View). When you are building your Armature bones are sure you have one Armature in your blender file. When you have the mesh and armature built, you need to parent them. That will be explaining later on.

There are two modeling that has to support two different animations in First Person View and the Third Person View. They will have animation, but the bones are building little differently from the 1P and 3P.

# Blender Modeling #
For now make your 3D model into parts for First Person View. Remember you have to do your textures when you’re creating two set of file for your first person and your third person view. The Third Person view will not have some moving parts with animation or without animation depend if you want animation in the third person view. Since we will be modeling off from shockrilfe there is no animation for third person view.

# Blender Size for Unreal Model and Direction #
> Since we don't know the size of the weapon to be in unreal. The easy way to get the size of the weapon is to load the unreal editor. Add the skeleton weapon to be mod off from weapon class were doing into the map. Add the simple bone to custom weapon in blender and adjust the size of the mesh blender to unreal while importing the test. Once you get some idea of how big is the weapon. The next part you might not know that where the weapon pointing direction to fire at. You do that when your building your first person and third person views.

# Weapon Modeling Sample #
This is just a weapon with out 1P and 3P. http://unrealtacticalmod.googlecode.com/svn/trunk/Blender/custom_weapon_gun/custom_weapon_gun.blend

# Next Step Creating 1st and 3rd Player View #

  * [Blender\_Weapon\_Model\_1P](Blender_Weapon_Model_1P.md)
  * [Blender\_Weapon\_Model\_3P](Blender_Weapon_Model_3P.md)

There are files in the svn are update for quick demo build and source code to test out the weapon test.

# SVN: #
http://unrealtacticalmod.googlecode.com/svn/trunk/Blender/custom_weapon_gun/

This is just a weapon with out 1P and 3P. http://unrealtacticalmod.googlecode.com/svn/trunk/Blender/custom_weapon_gun/custom_weapon_gun.blend

This weapon is in First Person (1P) Model with Armature Bone: http://unrealtacticalmod.googlecode.com/svn/trunk/Blender/custom_weapon_gun/custom_weapon_gun_1P.blend

This weapon is for First Person (1P) View With Animation: http://unrealtacticalmod.googlecode.com/svn/trunk/Blender/custom_weapon_gun/custom_weapon_gun_1P_animset.blend

This weapon is in Third Person (3P) Model with Armature Bone: http://unrealtacticalmod.googlecode.com/svn/trunk/Blender/custom_weapon_gun/custom_weapon_gun_3P.blend

# Video Demo: #
This is with out the animation:
http://www.youtube.com/watch?v=E7ZrVDUFtrI

This is with animation:
http://www.youtube.com/watch?v=R9GPHxqZbGE

[HOME](Main_Tutorial_Lessons.md) [Next](Blender_Weapon_Model_1P.md)