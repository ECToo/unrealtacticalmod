# Plan ahead First #
If you are read this. You made a wise chose.

> Before you can start modeling your vehicle. You should have to know little bit about object Mesh and Armature bone and Action Editor(Animation Set for Unreal) for blender. Don�t use the modifier for Armature bone. I will explain later on in this part later on.

> You have to plan out on paper. Either your write, draw, and scribble to get your vehicle design build correctly to make it work. The model should fit right type of game play and game style. Vehicle design might be the hard work. You have to deal with designing a vehicle and create a destroyable vehicle with two or more type of materials.

> Those who are new to blender and trying to export a working vehicle model. It involve in using the unreal editor and unreal script. To run a playable vehicle in the game.

# Plan Before You Model #
The basic building block and layout knowing how each area effect can effect your model in game play. There are couple thing you need to know:
  * Art and Theme
  * 3D Model
  * Model Damage
  * Model Textures -(Red / Blue team color)
  * Model Animation
  * Model Textures Damage
  * Model Size
  * Bone Position And Rotation For Unreal Default
  * Unreal Script

# Art Concept #
> This is where all ideas and creative goes into a vehicle mod. Layout and design is a key part to make good style of the art work. To keep the model with in the same style in the same area is the key good modeling. Going out side of the art style could break or make good work out it as long people agree with your forums, etc. Building different theme of the game layout and how it work can make the game work in many different ways. In some ways make it bad.

# Modeling with Theme style #
> Creating the theme with the game flow to match part of the game concept. Modeling can be a challenge if goes out of the theme style and does not fit the game well. The color texture got to match the theme too that could effect your game play and design.

# Before You Model In Blender #
> Think about how your mesh are build and render. When your are building your mesh vehicle.  Build your mesh vehicle into part like wheels, door, hood, fender, bumper, wings, and etc. Those are some moving parts and some not moving. For those reason is that making into part are for vehicle damage parts. Like fender gets twisted, hood bend, door get smashed. You can add more textures.

# Adjusting Vehicle Size Class And Direction #
> Then how do I size my vehicle to fit the vehicle class then? Easy question, open up in the unreal editor. This is a test that we are not skipping any thing that we are testing out the model of our size to fit prefectly or limit the mesh we are building upon on.

> Add a vehicle class spawn that your modding off from and add a skeleton mesh with the same class beside spawn vehicle. Just a skeleton mesh that is not a class, just a body frame that we be using to adjust our skeleton mesh vehicle. You will notice some different in their size. It partly been written in unreal script to adjusting the size.

> Next part if you notice that your vehicle is facing in some direction. If your vehicle is facing the same direction as hellbender that would be in the right position for spawning your vehicle in the right direction. You have to adjust the your skeleton mesh in blender not in unreal. It part of debuging you mesh in unreal.

> In this lesson add hellbender class spawn and add hellbender skeleton mesh right beside each other. The next easy part is adding your own custom vehicle that your current working on and add temperately bone to size your mesh. Don't size your armature bone, just your mesh size. Trying to guess the size of the skeleton mesh vehicle to base from hellbender skeleton mesh.

# Damage Model #
> All Texture material must have the same original mesh with out damage to the vehicle. Because of the morph set when you are importing the same mesh with damage parts with same textures and the vertices's change little differently parts where are damage. The bones are to be kept the same. You can add bones but not change the original bones. If you made some changes in the bones it can effect the rest of your files. It will behave little differently when game is play.

> To keep the file small for mod download. File must be export into psk format with the same texture material ratio of the original mesh in unreal that it will be sharing the same textures. For the damage texture that will be coded in unreal script. The model must have damage with some prefix damage model name.

# Textures #
> This is the last part that I kind left out. I have not yet learn more about the blender or unreal stuff. I am not good at textures. For unreal there are layer of texture to make look real. You kind of look for it.

Blender What I know about. List For Blender that has:
  * Normal Mapping
  * UV
  * UV Paint

Read More here:
http://www.blender.org/features-gallery/features/

I am not sure that it all almost same material build in unreal and blender.