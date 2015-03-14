# Introduction #
> This is an update for Blender Version 2.46.

> This the most simple vehicle design but it hand on and looking around for errors. There are couple of stages to get to. We will be modding off from hellbender vehicle class to make it easy.

# Learn and Build #
> Before you can start modeling your vehicle. You should have to know little bit about object Mesh and Armature (bone and Action Editor(Animation Set for Unreal) for blender. Don't use the modifier for Armature bone. I will explain later on in this part later on. To learn go search "blender noob to pro".

# Vehicle Mesh Design #
> For making a simple model mesh. When your adding a model into the scene it has to be mesh object. Add a cube by pressing space bar key -> Mesh -> Cube and then press tab key to go into edit mode. Then add four circles for the wheel. While your on top view select your cube mesh and not select your circle mesh. Make it rectangle on the x axis.

Vehicle face direction is the east on top view. Next part is fix your wheels where the vehicle will face.

# Armature Bone And Parenting #
> Since we are going to test out Skeleton mesh and comparing from hellbender. You have to be in object mode to add Armature. And then by pressing space bar key. Add > Armature. By default the there is one bone created. While in object mode select your mesh object first and then the second is your Armature by holding down the shift key and then right on it. Then press crtl+p to parent them together.

Armature>Create Bone From Heat.

> More detail will be explain about Armature bone later.

# Skeleton Mesh Test Size #
> Since we don't know the size of the vehicle for hellbender. We will open unreal editor. This part create a simple map with four walls and one light. Then add a spawn class for hellbender. The next part is add a skeleton mesh from hellbender in the Generic browser. You will notice the different in their size. That is from unreal script draw scale for vehicle spawn. Once you setup that part up import your vehicle mesh and then adjusting your size to fit the scale from hellbender skeleton mesh and not from hellbender spawn vehicle class. Do not adjust your Armature bone scale. Adjust your mesh in edit mode. Once you get the right size of your vehicle for hellbender. If you get the got the right direction for facing your vehicle is a good chance to do that.

# Creating Bones For Armature #
> If you skip 'Armature Bone And Parenting' that where we will continue working on it. This part is important for making a vehicle bones to work. For those who are new at this read about or search about.

> There are two of way to parenting the bones. One is linking the bone to the parent and second way is to connect the bone to the parent. Second method doesn't fit the unreal bone format. The Reason there are two points one is the head and the tail of the bone position and rotation. The tail is part of the rotation and direction.

> To Add a bone while you still selecting your Armature Object. Once your select your Armature object press tab key to go into edit mode.

Press space bar key and Add > bone.

If you notice there just one bone and nothing happen in case your wonder about it. Notice there is a center look like a circle white and red and a plus black symbol that is the curser where the bone place every time your add the bone. There are three way to select your bone. The way you select your end point bone and mid point of the bone. Select the mid of the bone and move it out to four wheels.

Naming the bones is important for unreal script and unreal packages.

Before we could start place the bones. The tail should be facing north in top view and on the side view it should be flat for all the bones. Let start out name the bones if your place all the wheel in correct way. In top view go the top right bone. Name the bone Lt\_Front\_Tire. The rest will be list:

  * Lt = Left Tire
  * Rt = Right Tire

  * Lt\_Front\_Tire
  * Rt\_Front\_Tire
  * Lt\_Rear\_Tire
  * Rt\_Rear\_Tire

The next part will be little easy. Select all the four wheels. Press Shift + D > Esc key to copy the same bones. We will rename the bone for Suspension.

  * Rt\_Rear\_Tire.001 > Rt\_Rear\_Suspension

Do the same bone that was copy. And should have the at least 9 bones. In the center of the bone rename the "bone" as "Base".

Next part is to link the bone to the "Base" for all the wheels and the suspension. Select all the bones. To do that you need to look at the bottom panel under "Armature Bones" panel. Right beside the name of BO:name\_Tire. There is a "Child of" there is selection of the bones. Select Base as their root bone. You will notice the doted line connecting the bones. Meaning it is link to the parent bone. If you don't see the other bone, deselect them and select the other bones that are not link to them.

# Re-Apply Parenting Armature and Mesh #
> How come re-apply the parenting them? Since they do not detect a new bones add from the mesh properties in the vertex group. Once your finish re-applying your mesh and armature. We got to remove the suspension prefix name from their influence to 0. Why remove it? It will effect the other bones and the conflict each other. Select your mesh vehicle and go into edited mode. The bottom left there the vertex that we are going to use to remove suspension. Select the suspension tire name. Select all vertex point that we are using so it more easy to remove bit faster. Once your done that, go the vertex group and select the suspension name prefix and click on the button "remove" and repeat it.

If you don't know what I am saying. Here the file for blender.
http://code.google.com/p/unrealtacticalmod/source/browse/trunk/Blender/custom_vehicle/vehicle_heavy_armor.blend